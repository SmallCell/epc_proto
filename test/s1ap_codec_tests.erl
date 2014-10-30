-module(s1ap_codec_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("src/S1AP.hrl").

-compile(export_all).

-define(S1InitMsgHex, "00 11 00 2A 00 00 04 00 3B 00 08 00 02 F8 46 00
              00 00 50 00 3C 40 07 02 00 65 4E 42 30 35 00 40
              00 07 00 00 19 00 02 F8 46 00 89 40 01 40").

s1ap_decoder_initiatingMessage_test() ->
    Msg = hex:hexstr_to_bin(hex:trim_whitespace(?S1InitMsgHex)),
    %% ?debugFmt("~p~n", [Msg]),
    {ok, Res} = 'S1AP':decode('S1AP-PDU', Msg),
    %% ?debugFmt("~p~n", [Res]),
    Res.

s1ap_encode_initiatingMessage_test() ->
    Initiatingmessage =
        {initiatingMessage,
         #'InitiatingMessage'{
            procedureCode = 17, criticality = reject,
            value = 
                #'S1SetupRequest'{
                   protocolIEs = 
                       [#'ProtocolIE-Field'{
                           id = ?'id-Global-ENB-ID', criticality = reject,
                           value =
                               #'Global-ENB-ID'{
                                  pLMNidentity = [2,248,70],
                                  'eNB-ID' = 
                                      {'macroENB-ID',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1]}
                                  }},
                        #'ProtocolIE-Field'{
                           id = ?'id-eNBname', criticality = ignore,
                           value = "eNB05"},
                        #'ProtocolIE-Field'{
                           id = ?'id-SupportedTAs', criticality = reject,
                           value = 
                               [#'SupportedTAs-Item'{
                                   tAC = [0,100],
                                   broadcastPLMNs = [[2,248,70]]
                                   }]},
                        #'ProtocolIE-Field'{
                           id = ?'id-DefaultPagingDRX', criticality = ignore,
                           value = v128}]}}},
    {ok, Res} = 'S1AP':encode('S1AP-PDU', Initiatingmessage),
    Msg = hex:hexstr_to_bin(hex:trim_whitespace(?S1InitMsgHex)),
    ?assertEqual(Msg, Res),
    Res.
