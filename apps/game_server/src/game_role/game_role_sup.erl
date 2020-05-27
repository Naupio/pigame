-module(game_role_sup).

-author("Naupio Z.Y. Huang").

-behaviour(supervisor).

-define(SERVER, ?MODULE).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    {ok, SupPid} = supervisor:start_link({local, ?SERVER}, ?MODULE, []),
    game_debug:debug(info, "~n game_role_sup is starting succeed!!! ~n"),
    {ok, SupPid} 
    .

init(_Args) ->
    SupFlags = #{strategy => simple_one_for_one, intensity => 1, period => 5},
    ChildSpecs = [#{id => game_role,
                    start => {game_role, start_link, []},
                    restart => transient,
                    shutdown => 30000,
                    type => worker,
                    modules => [game_role]}],
    {ok, {SupFlags, ChildSpecs}}.