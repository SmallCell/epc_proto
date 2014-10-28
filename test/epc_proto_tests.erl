-module(epc_proto_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("femto_test/include/eunit_fsm.hrl").

initiatingMessage() ->
    [16#00, 16#11, 16#00, 16#2a, 16#00, 16#00, 16#04, 16#00, 16#3b,
     16#00, 16#08, 16#00, 16#02, 16#f8, 16#46, 16#00, 16#00, 16#00, 16#50,
     16#00, 16#3c, 16#40, 16#07, 16#02, 16#00, 16#65, 16#4e, 16#42, 16#30,
     16#35, 16#00, 16#40, 16#00, 16#07, 16#00, 16#00, 16#19, 16#00, 16#02,
     16#f8, 16#46, 16#00, 16#89, 16#40, 16#01, 16#40, 16#00, 16#00].


s1ap_decoder_initiatingMessage_test() ->
    Res = 'S1AP-PDU-Descriptions':decode('S1AP-PDU', initiatingMessage()),
    ?debugFmt("~p~n", [Res]).

s1ap_decoder_test() ->
    Res = 'S1AP-PDU-Descriptions':decode('S1AP-PDU', [32,17,0,23,0,0,2,0,105,0,11,0,0,98,242,33,0,0,195,92,0,51,0,87,64,1,25]),
    ?debugFmt("~p~n", [Res]).


message() ->
    {initiatingMessage,
        {'InitiatingMessage',17,reject,
            {'S1SetupRequest',
                [{'ProtocolIE-Field',59,reject,
                    {'Global-ENB-ID',[98,242,33],
                        {'macroENB-ID',[1,0,1,0,1,0,1,0,1,1,0,1,0,1,1,0,0,0,0,1]},
                        asn1_NOVALUE
                    }
                }, {'ProtocolIE-Field',60,ignore,[66,111,110,107,49,51]},
                {'ProtocolIE-Field',64,reject,
                    [{'SupportedTAs-Item',[0,1],[[98,242,33]],asn1_NOVALUE},
                    {'SupportedTAs-Item',[0,2],[[98,242,33]],asn1_NOVALUE},
                    {'SupportedTAs-Item',[0,3],[[98,242,33]],asn1_NOVALUE},
                    {'SupportedTAs-Item',[2,84],[[98,242,33]],asn1_NOVALUE}]
                }, {'ProtocolIE-Field',137,ignore,v32}]
            }
        }
    }.


s1ap_encode_test() ->
    Res = 'S1AP-PDU-Descriptions':encode('S1AP-PDU', message()),
    ?debugFmt("~p~n", [Res]).
