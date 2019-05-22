-module(game_ws_handler).

-author("Nuapio Z.Y. Huang").

-export([
         init/2
        ,websocket_init/1
        ,websocket_handle/2
        ,websocket_info/2
        ,terminate/3
    ]).

init(Req, _) ->
    State = #{ws_pid => none, logined => false, user_pid => none},
    {cowboy_websocket, Req, State}.

websocket_init(State) ->
    WsPid = self(),
    game_debug:debug(error,"wwwwwww WsPid: ~p, websocket connected   wwwwwww ~n", [WsPid]),
    NewState = State#{ws_pid := WsPid},
    {ok, NewState}.

websocket_handle({text, <<"@heart">>}, #{ws_pid := WsPid} = State) ->
    game_debug:debug(error,"wwwwwww WsPid: ~p, text recevie: ~p   wwwwwww ~n", [WsPid, <<"@heart">>]),
    Resp = integer_to_binary(game_util:unixtime()),
    {reply, {text, Resp}, State};

websocket_handle({text, Req}, #{ws_pid := WsPid} = State) ->
    game_debug:debug(error,"wwwwwww WsPid: ~p, text recevie: ~p   wwwwwww ~n", [WsPid, Req]),
    Resp = Req,
    {reply, {text, Resp}, State};

websocket_handle({binary, Req}, #{logined := IsLogined} = State) ->
    <<Cmd:16, Bin/binary>> = Req,
    case IsLogined of
        true ->
            UserPid = maps:get(user_pid, State),
            gen_server:cast(UserPid, {cmd_routing, Cmd, Bin}),
            {ok, State};
        false ->
            NewState = game_ws_login:login(Cmd, Bin, State),
            {ok, NewState}
    end;

websocket_handle(_Frame, State) ->
    {ok, State}.

websocket_info({send_binary, Resp}, State) ->
    {reply, {binary, Resp}, State};

websocket_info(_Info, #{ws_pid := WsPid} = State) ->
    game_debug:debug(error,"Wwwwwwww WsPid: ~p, websocket unkown info  wwwwwww ~n", [WsPid]),
    {reply, {text, <<"unkown info !">>}, State}.

terminate(_Info, _Req, #{ws_pid := WsPid
        % , user_pid := UserPid, logined := IsLogined
        } = _State) ->
    % case {IsLogined, is_pid(UserPid)} of
    %     {true,true} ->
    %         case is_process_alive(UserPid) of
    %             true -> exit(UserPid, normal);
    %             _ -> notdoing
    %         end;
    %     _ -> notdoing
    % end, 
    game_debug:debug(error,"wwwwwww WsPid: ~p, websocket terminated   wwwwwww ~n", [WsPid]),
    ok.