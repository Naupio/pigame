-module(websocket_handler).

-author("Nuapio Z.Y. Huang").

-export([
        init/2
    ,   websocket_init/1
    ,   websocket_handle/2
    ,   websocket_info/2
    ,   terminate/3
    ]).

init(Req, _) ->
    State = #{ws_pid => self(), logined => false, user_pid => none},
    {cowboy_websocket, Req, State}.

websocket_init(#{ws_pid := WsPid} = State) ->
    game_debug:debug(error,"wwwwwww WsPid: ~p, websocket connected   wwwwwww ~n", [WsPid]),
    {ok, State}.

websocket_handle({text, <<"@heart">>}, #{ws_pid := WsPid} = State) ->
    game_debug:debug(error,"wwwwwww WsPid: ~p, text recevie: ~p   wwwwwww ~n", [WsPid, <<"@heart">>]),
    Resp = integer_to_binary(game_util:unixtime()),
    {reply, {text, Resp}, State};

websocket_handle({text, Req}, #{ws_pid := WsPid} = State) ->
    game_debug:debug(error,"wwwwwww WsPid: ~p, text recevie: ~p   wwwwwww ~n", [WsPid, Req]),
    Resp = Req,
    {reply, {text, Resp}, State};

websocket_handle({binary, Req}, #{ws_pid := WsPid, logined := IsLogined} = State) ->
    game_debug:debug(error,"wwwwwww WsPid: ~p, binary recevie: ~p   wwwwwww ~n", [WsPid, Req]),
    <<Cmd:16, Bin/binary>> = Req,
    case IsLogined of
        true ->
            UserPid = maps:get(user_pid, State),
            gen_server:cast(UserPid, {cmd_routing, Cmd, Bin, WsPid}),
            {ok, State};
        false ->
            NewState = game_login:login(Cmd, Bin, State),
            {ok, NewState}
    end;

websocket_handle(_Frame, State) ->
    {ok, State}.

websocket_info({send_binary, Resp}, State) ->
    {reply, {binary, Resp}, State};

websocket_info(_Info, #{ws_pid := WsPid} = State) ->
    game_debug:debug(error,"Wwwwwwww sPid: ~p, websocket unkown info  wwwwwww ~n", [WsPid]),
    {reply, {text, <<"unkown info !">>}, State}.

terminate(_Info, _Req, #{ws_pid := WsPid} = _State) ->
    game_debug:debug(error,"wwwwwww WsPid: ~p, websocket terminated   wwwwwww ~n", [WsPid]),
    ok.