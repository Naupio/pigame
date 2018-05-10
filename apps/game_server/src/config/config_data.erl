-module(config_data).

-author("hzy").

-export([
            get_websocket_port/0
        ]).

get_websocket_port() ->
    % 28821.
    {ok, Port} = application:get_env(game_server, websocket_port),
    Port.