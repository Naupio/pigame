%% game user hrl file.

-author("Nuapio Z.Y. Huang").

-record(r_unique, { unique_key, unique_value} ).

-record(r_account, { user_account = ""
                , user_id = 0 } ).

-record(r_user, { user_id = 0
                , user_state = #{} }).

-record(r_online, {
    user_id = 0,
    user_pid = none
}).

-define(default_img_id, rand:uniform(6)).
-define(default_user_state(UserId),
    #{user_id => UserId
    , user_name => integer_to_list(UserId)
    , user_img_id => ?default_img_id
    , user_rank => 0
    , user_gold => 0
    , user_diamond => 0
    , user_account_experience => 0
    , user_hero_experience => 0
    , user_pid => none
    , ws_pid => none
    , check_online_count => 0}
).
