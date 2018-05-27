%%%-------------------------------------------------------------------
%% @doc game_server top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(game_server_sup).

-behaviour(supervisor).

-author("Nuapio Z.Y. Huang").

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

-define(SupChildSpecById(Module),
            #{  id => Module,
                start => {Module, start_link, []},
                restart => permanent,
                shudown => 30000,
                type => supervisor,
                modules => [Module]
            }).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    {ok, { {one_for_one, 10, 1}, [
                        ?SupChildSpecById(game_ets_sup),
                        ?SupChildSpecById(game_role_sup)
                    ]}
                }.

%%====================================================================
%% Internal functions
%%====================================================================
