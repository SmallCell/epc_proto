-module(s1ap_codec_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("include/S1AP.hrl").

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
    Initiatingmessage1 =
        {initiatingMessage,{'InitiatingMessage',17,reject,
                            {'S1SetupRequest',[{'ProtocolIE-Field',59,reject,
                                                {'Global-ENB-ID',<<2,248,70>>,
                                                 {'macroENB-ID',<<0,0,5:4>>},
                                                 asn1_NOVALUE}},
                                               {'ProtocolIE-Field',60,ignore,"eNB05"},
                                               {'ProtocolIE-Field',64,reject,
                                                [{'SupportedTAs-Item',<<0,100>>,
                                                  [<<2,248,70>>],
                                                  asn1_NOVALUE}]},
                                               {'ProtocolIE-Field',137,ignore,v128}]}}},
       
    Initiatingmessage = {initiatingMessage,
    #'InitiatingMessage'{
        procedureCode = 17,criticality = reject,
        value = 
            #'S1SetupRequest'{
                protocolIEs = 
                    [#'ProtocolIE-Field'{
                         id = 59,criticality = reject,
                         value = 
                             #'Global-ENB-ID'{
                                 pLMNidentity = <<2,248,70>>,
                                 'eNB-ID' = {'macroENB-ID',<<0,0,5:4>>}
                                 }},
                     #'ProtocolIE-Field'{
                         id = 60,criticality = ignore,value = "eNB05"},
                     #'ProtocolIE-Field'{
                         id = 64,criticality = reject,
                         value = 
                             [#'SupportedTAs-Item'{
                                  tAC = <<0,100>>,
                                  broadcastPLMNs = [<<2,248,70>>]
                                  }]},
                     #'ProtocolIE-Field'{
                         id = 137,criticality = ignore,value = v128}]}}},
    ?assertEqual(Initiatingmessage, Initiatingmessage1),

    {ok, Res} = 'S1AP':encode('S1AP-PDU', Initiatingmessage),
    {ok, Res1} = 'S1AP':encode('S1AP-PDU', Initiatingmessage1),
    Msg = hex:hexstr_to_bin(hex:trim_whitespace(?S1InitMsgHex)),
    ?assertEqual(Msg, Res),
    Res.

%% s1ap_encode_values_test() ->
%%     Info = 'S1APValue':info(),
%%     ?debugFmt("~p~n", [Info]).
    
