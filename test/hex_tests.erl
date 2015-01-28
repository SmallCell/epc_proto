%%% @author vlad <lib.aca55a@gmail.com>
%%% @copyright (C) 2014, vlad
%%% @doc
%%%
%%% @end
%%% Created : 29 Oct 2014 by vlad <lib.aca55a@gmail.com>

-module(hex_tests).

-include_lib("eunit/include/eunit.hrl").


from_string_test() ->
    Msg = "0011002a000004003b00080002f84600000050003c40070200654e423035004000070000190002f84600894001400000",
    ResList = hex:hexstr_to_list(Msg),
    %% ?debugFmt("~p~n", [ResList]),
    _ResString = hex:list_to_hexstr(ResList),
    %% ?debugFmt("~p~n", [ResString]),
    ok.


from_dump_test() ->
    Hex = "00 11 00 2A 00 00 04 00 3B 00 08 00 02 F8 46 00
00 00 50 00 3C 40 07 02 00 65 4E 42 30 35 00 40
00 07 00 00 19 00 02 F8 46 00 89 40 01 40",
    Msg = hex:trim_whitespace(Hex),
    %% ?debugFmt(">> ~p~n", [Hex]),
    _ResList = hex:hexstr_to_list(Msg),
    %% ?debugFmt(">> ~p~n", [ResList]),
    ok.
    
    
