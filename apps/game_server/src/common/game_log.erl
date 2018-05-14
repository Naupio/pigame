-module(game_log).

-author("Naupio Z.Y. Huang").

-export([
        info/1, info/2,
        debug/1, debug/2,
        warning/1, warning/2,
        error/1, error/2
    ]).

info(String) ->
    % logger:info(String).
    error_logger:info_msg(String).

info(FormatStr,ArgsList) ->
    % logger:info(FormatStr,ArgsList).
    error_logger:info_msg(FormatStr,ArgsList).

error(String) ->
    % logger:error(String).
    error_logger:error_msg(String).

error(FormatStr,ArgsList) ->
    % logger:error(FormatStr,ArgsList).
    error_logger:error_msg(FormatStr,ArgsList).

warning(String) ->
    % logger:warning(String).
    error_logger:warning_msg(String).

warning(FormatStr,ArgsList) ->
    % logger:warning(FormatStr,ArgsList).
    error_logger:warning_msg(FormatStr,ArgsList).

debug(String) ->
    % logger:debug(String).
    info(String).

debug(FormatStr,ArgsList) ->
    % logger:debug(FormatStr,ArgsList).
    info(FormatStr,ArgsList).