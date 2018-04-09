-module(websocket_handler).

-author("hzy").

-export([
        init/2
    ,   websocket_init/1
    ,   websocket_handle/2
    ,   websocket_info/2
    ,   terminate/3
    ]).

init(Req, _) ->
    State = #{},
    {cowboy_websocket, Req, State}.

websocket_init(State) ->
    {ok, State}.

websocket_handle({text, Req}, State) ->
    Resp = Req,
    {reply, {text, Resp}, State};

websocket_handle(_Frame, State) ->
    {ok, State}.

websocket_info(_Info, State) ->
    {reply, {text, <<"Hello!">>}, State}.

terminate(_Info, _Req, _State) ->
    ok.