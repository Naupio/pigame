-module(game_mn).

-author("Naupio Z.Y. Huang").

-include("game_user.hrl").

-export([
      get_user_id_by_account/1
    , put_user_id_by_account/2
    , save_user_state/1
    , get_user_state/1
]).

-define(default_id_start, 10000).

get_user_id_by_account(Cookie) ->
    case catch mnesia:dirty_read(r_account, Cookie) of
        [#r_account{user_account = Cookie, user_id = UserId}|_] ->
            UserId;
        _ -> 
            UserId = ?default_id_start + mnesia:dirty_update_counter(r_unique, r_user, 1),  
            put_user_id_by_account(Cookie, UserId),
            UserId
    end.

put_user_id_by_account(Cookie, UserId) ->
    mnesia:dirty_write(r_account, #r_account{user_account = Cookie, user_id = UserId}).


get_user_state(UserId) ->
    case catch mnesia:dirty_read(r_user, UserId) of
            [#r_user{user_id = UserId, user_state = UserState}|_] ->
                UserState;
            _ -> %% first login
                ?default_user_state(UserId)
    end.

save_user_state(#{user_id := UserId} = UserState) ->
    mnesia:dirty_write(r_user, #r_user{user_id= UserId, user_state = UserState}).