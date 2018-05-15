-module(game_mnesia).

-author("Naupio Z.Y. Huang").

-export([mnesia_start/0]).

mnesia_start() ->
    case mnesia:system_info(use_dir) of
        true ->
            game_debug:debug(error, "~n mnesia schema is exited!!! ~n"),
            mnesia:start(),
            game_debug:debug(error, "~n database mnesia is starting succeed!!! ~n"),
            check_mn_table(),
            ok;
        false ->
            game_debug:debug(error, "~n creating schema!!! ~n"),
            mnesia:stop(),
            ok = mnesia:delete_schema([node()]),
            ok = mnesia:create_schema([node()]),
            mnesia:start(),
            game_debug:debug(error, "~n database mnesia is starting succeed!!! ~n"),
            create_mn_table(),
            ok
    end.

create_mn_table() ->
    todo.

check_mn_table() ->
    todo.