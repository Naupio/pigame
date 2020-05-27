-module(ets_data).

-author("Nuapio Z.Y. Huang").

-include("game_user.hrl").

-export([
    get_init_ets_list/0
]).

get_init_ets_list() ->
    [
    {ets_user_online
        ,[named_table, ordered_set, public, {keypos, #r_online.user_id}, {write_concurrency,true}, {read_concurrency,true}]}
].

