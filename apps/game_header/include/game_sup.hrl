%% game sup hrl file

-define(SupChildSpecById(Module),
            #{  id => Module,
                start => {Module, start_link, []},
                restart => permanent,
                shudown => 30000,
                type => supervisor,
                modules => [Module]
            }).