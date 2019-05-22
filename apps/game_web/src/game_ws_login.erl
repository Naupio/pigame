-module(game_ws_login).

-author("Naupio Z.Y. Huang").

-include("common_pb.hrl").
-include("game_user.hrl").

-export([
    login/3
]).

login(Cmd, Bin, #{ws_pid := WsPid} = WsState) ->
    Module = game_massage:decoder_for(Cmd),
    RecordName = game_massage:msg_type(Cmd),
    RecordData = Module:decode_msg(Bin, RecordName),
    game_debug:debug(error,"wwwwwww WsPid : ~p, protobuf recevie: ~p ~n  wwwwwww", [WsPid, RecordData]),
    NewWsState = login_handler(RecordData, WsState),
    NewWsState.

login_handler(#loginReq{cookie = Cookie}, #{ws_pid := WsPid} = WsState) ->
    UserId = game_mn:get_user_id_by_account(Cookie),
    case ets:lookup(ets_user_online, UserId) of
        [#r_online{user_id=UserId, user_pid=UserPid}] ->
            gen_sever:call(UserPid, {reconnect, WsPid}),
            WsState#{logined => true, user_pid => UserPid};
        [] ->
            {ok, UserPid} = supervisor:start_child(game_role_sup, [[UserId, WsPid]]),
            WsState#{logined => true, user_pid => UserPid}
    end.