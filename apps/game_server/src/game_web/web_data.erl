-module(web_data).

-author("Nuapio Z.Y. Huang").

-export([
            get_websocket_port/0
        ]).

get_websocket_port() ->
    % 19910.
    Port = application:get_env(game_config, websocket_port, 19910),
    Port.