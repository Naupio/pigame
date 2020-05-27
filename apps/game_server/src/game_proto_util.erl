-module(game_proto_util).

% -include("common_pb.hrl").
% -include("game_user.hrl").
% -include("maininterface_pb.hrl").

-export([proto_cast_change/3]).

proto_cast_change(AnMap, RecordName, Fields) ->
  Values = lists:map(fun(Field) -> maps:get(Field, AnMap, undefined) end, Fields),
  list_to_tuple([RecordName | Values])
  .