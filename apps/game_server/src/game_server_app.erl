%%%-------------------------------------------------------------------
%% @doc game_server public API
%% @end
%%%-------------------------------------------------------------------

-module(game_server_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    ok = network_start(),
    game_server_sup:start_link().
    

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

network_start() ->
    ok = websocket_start(),
    ok.

websocket_start() ->
    Dispatch = cowboy_router:compile([
        {'_', [{"/", websocket_handler, []}]}
    ]),
    WsPort = config_data:get_websocket_port(),
    {ok, _} = cowboy:start_clear(websocket_handler_listener,
        [{port, WsPort}],
        #{env => #{dispatch => Dispatch}}
    ),
    ok.