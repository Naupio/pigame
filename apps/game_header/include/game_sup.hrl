%% game sup hrl file

-author("Nuapio Z.Y. Huang").

-define(SupChildSpecById(Module),
            #{  id => Module,
                start => {Module, start_link, []},
                restart => permanent,
                shudown => 30000,
                type => supervisor,
                modules => [Module]
            }).