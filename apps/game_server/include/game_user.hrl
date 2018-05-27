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