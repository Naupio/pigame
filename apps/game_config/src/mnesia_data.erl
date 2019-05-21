-module(mnesia_data).

-author("Nuapio Z.Y. Huang").

-include("game_user.hrl").

-export([
            get_init_table_list/0,
            get_all_exit_tables/0
        ]).

get_init_table_list() ->
    [
        {r_unique, [ {type, ordered_set}, {disc_copies, [node()]}, {attributes, record_info(fields, r_unique)} ] },
        {r_account, [ {type, ordered_set}, {disc_copies, [node()]}, {attributes, record_info(fields, r_account)} ] },
        {r_user, [ {type, ordered_set}, {disc_copies, [node()]}, {attributes, record_info(fields, r_user)} ] }
    ].

get_all_exit_tables() ->
    mnesia:system_info(tables).