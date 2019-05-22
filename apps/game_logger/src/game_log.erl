-module(game_log).

-author("Naupio Z.Y. Huang").

-export([
        info/1, info/2,
        debug/1, debug/2,
        warning/1, warning/2,
        error/1, error/2
    ]).

info(String) ->
    lager:info(String).
    % error_logger:info_msg(String).

info(FormatStr,ArgsList) ->
    lager:info(FormatStr,ArgsList).
    % error_logger:info_msg(FormatStr,ArgsList).

error(String) ->
    lager:error(String).
    % error_logger:error_msg(String).

error(FormatStr,ArgsList) ->
    lager:error(FormatStr,ArgsList).
    % error_logger:error_msg(FormatStr,ArgsList).

warning(String) ->
    lager:warning(String).
    % error_logger:warning_msg(String).

warning(FormatStr,ArgsList) ->
    lager:warning(FormatStr,ArgsList).
    % error_logger:warning_msg(FormatStr,ArgsList).

debug(String) ->
    lager:debug(String).
    % info(String).

debug(FormatStr,ArgsList) ->
    lager:debug(FormatStr,ArgsList).
    % info(FormatStr,ArgsList).