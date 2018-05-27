-module(game_ets_sup).

-author("Naupio Z.Y. Huang").

-behaviour(supervisor).

-define(SERVER, ?MODULE).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init(_Args) ->
    SupFlags = #{strategy => simple_one_for_one, intensity => 10, period => 1},
    ChildSpecs = [#{id => game_ets_svr,
                    start => {game_ets_svr, start_link, []},
                    restart => permanent,
                    shutdown => 30000,
                    type => worker,
                    modules => [game_ets_svr]}],
    {ok, {SupFlags, ChildSpecs}}.