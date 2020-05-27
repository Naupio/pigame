-module(game_simulation).

-author("Naupio Z.Y. Huang").

-include("common_pb.hrl").
-include("maininterface_pb.hrl").

-export([   
    multi_user_start/1,
    create_login_user/1
]).

multi_user_start(Num) ->
    lists:foreach(fun(Index) -> 
                        spawn(fun() -> create_login_user(integer_to_list(Index)) end) 
                    end
                , lists:seq(1,Num)).

create_login_user(Cookie) ->
    Cmd = 11,
    LoginBin = common_pb:encode_msg(#loginReq{cookie = Cookie}),
    State = #{ws_pid => self()},
    NewState = game_ws_login:login(Cmd, LoginBin, State),

    UserPid = maps:get(user_pid, NewState),
    WsPid = maps:get(ws_pid, NewState),
    erlang:send_after(5000, self(), heartbeat),

    loop_receive(Cookie,UserPid,WsPid).

loop_receive(Cookie,UserPid,WsPid) ->
    receive
        heartbeat ->
            HeartbeatBin = common_pb:encode_msg(#heartbeatReq{}),
            gen_server:cast(UserPid, {cmd_routing, 101, HeartbeatBin}),
            erlang:send_after(5000, self(), heartbeat),
            loop_receive(Cookie,UserPid,WsPid);
        {send_binary, <<Cmd:16/little, _Bin/binary>> = Msg} ->
            case Cmd of
                102 ->
                    notdoing;
                _ ->
                    game_debug:debug(info, "~n !!!!!!!!!!!!!!    user: ~p, receive msg: ~p , time: ~p !!!!!!!!!!!!!! ~n"
                        , [Cookie, Msg, time()])
            end,
            loop_receive(Cookie,UserPid,WsPid);
        Msg ->
            game_debug:debug(info, "~n !!!!!!!!!!!!!!    user: ~p, receive msg: ~p , time: ~p !!!!!!!!!!!!!! ~n"
                        , [Cookie, Msg, time()]),
            loop_receive(Cookie,UserPid,WsPid)
    end.