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

-define(default_gold, 1000000).
-define(default_image, rand:uniform(6)).
-define(default_user_state(UserId),   #{user_id => UserId, user_name => integer_to_list(UserId)
                                , user_pid => none, ws_pid => none, user_image => ?default_image
                                , user_gold => ?default_gold, check_online_count => 0}).
