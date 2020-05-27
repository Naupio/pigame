-module(game_mnesia).

-author("Naupio Z.Y. Huang").

-export([mnesia_start/0]).

mnesia_start() ->
    case mnesia:system_info(use_dir) of
        true ->
            game_debug:debug(info, "~n mnesia schema is exited!!! ~n"),
            mnesia:start(),
            game_debug:debug(info, "~n database mnesia is starting succeed!!! ~n"),
            check_mn_table(),
            ok;
        false ->
            game_debug:debug(info, "~n creating schema!!! ~n"),
            mnesia:stop(),
            ok = mnesia:delete_schema([node()]),
            ok = mnesia:create_schema([node()]),
            mnesia:start(),
            game_debug:debug(info, "~n database mnesia is starting succeed!!! ~n"),
            create_mn_table(),
            ok
    end.

create_mn_table() ->
    InitTL = mnesia_data:get_init_table_list(),
    lists:foreach(fun({Name, Args}) ->
                    mnesia:create_table(Name, Args)
                  end, InitTL),
    ok.

check_mn_table() ->
    AllExitTables = mnesia_data:get_all_exit_tables(),
    InitTL = mnesia_data:get_init_table_list(),
    lists:foreach(fun({Name, Args}) ->
            case lists:member(Name, AllExitTables) of
                true ->
                    case mnesia:wait_for_tables([Name], 5000) of
                        ok -> ok;
                        Err->
                            game_log:error("~n wait mnesia table ~p error ~p ~n", [Name, Err])
                    end;
                false ->
                    mnesia:create_table(Name, Args)
            end
          end, InitTL),
    ok.