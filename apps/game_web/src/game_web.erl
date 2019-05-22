-module(game_web).

-author("Naupio Z.Y. Huang").

-export([network_start/0]).

network_start() ->
    ok = websocket_start(),
    WsPort = web_data:get_websocket_port(),
    game_debug:debug(error, "~n network websocket with port-~w is starting succeed!!! ~n",[WsPort]),
    ok.

websocket_start() ->
    Dispatch = cowboy_router:compile([
        {'_', [{"/", game_ws_handler, []}]}
    ]),
    WsPort = web_data:get_websocket_port(),
    {ok, _} = cowboy:start_clear(websocket_handler_listener,
        [{port, WsPort}],
        #{env => #{dispatch => Dispatch}}
    ),
    ok.