-module(web_data).

-author("Nuapio Z.Y. Huang").

-export([
            get_websocket_port/0
        ]).

get_websocket_port() ->
    % 28821.
    Port = application:get_env(game_server, websocket_port, 28821),
    Port.