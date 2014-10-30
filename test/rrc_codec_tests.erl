-module(rrc_codec_tests).

-include_lib("eunit/include/eunit.hrl").

-include_lib("src/EUTRA-RRC.hrl").

-compile(export_all).

%% value DL-CCCH-Message ::= 
%% {
%%   message c1 : rrcConnectionSetup : 
-define(DL_CCCH_MessageHex, "
70 12 98 0b
7d 92 11 83 81 ba 00 7c 00 08 0c 03 ff 96 5a 10
c3 c0 12 ca d9 c0 00 24 50 90 04 19 05 0d 00 01 10
").

%% Getting record syntax out of shell
%% : R=rrc_codec_tests:rrc_decoder_initiatingMessage_test().
%% : rr("*/*").
%% : rp(R).
-define(DL_CCCH_MessageRec,
        {}
       ).


rrc_decoder_initiatingMessage_test_no() ->
    Msg = hex:hexstr_to_list(hex:trim_whitespace(?DL_CCCH_MessageHex)),
    %% ?debugFmt("~p~n", [Msg]),
    {ok, Res} = 'EUTRA-RRC':decode('DL-CCCH-Message', Msg),
    ?debugFmt("~p~n", [Res]),
    Res.

rrc_encode_initiatingMessage_test_no() ->
    {ok, Res} = 'EUTRA-RRC':encode('DL-CCCH-Message', ?DL_CCCH_MessageRec),
    %% ?debugFmt(">> ~p~n", [Res]),
    Msg = hex:hexstr_to_list(hex:trim_whitespace(?DL_CCCH_MessageHex)),
    %% ?debugFmt(">> ~p~n", [Msg]),
    ?assertEqual(Msg, Res),
    Res.
