%%%-------------------------------------------------------------------
%% @doc game_mnesia public API
%% @end
%%%-------------------------------------------------------------------

-module(game_mnesia_app).

-author("Nuapio Z.Y. Huang").

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    ok = game_mnesia:mnesia_start(),
    game_mnesia_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
