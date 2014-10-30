-module(x2ap_codec_tests).

-include_lib("eunit/include/eunit.hrl").

-include_lib("include/X2AP.hrl").

-compile(export_all).

%% Getting hex-dump from PCAP file
%% tshark -x -r x2-ho-canceled.pcap -R frame.number==7 | cut -d' ' -f3-17
-define(X2InitMsgHex, "
      20 06 00 79 00 00 03 00 15 00 08 00 02 f8
46 00 00 06 50 00 14 00 5c 00 48 00 42 00 02 f8
46 00 06 50 00 06 40 02 f8 46 00 4c 77 06 27 33
00 00 00 29 40 01 20 00 03 40 02 f8 46 00 00 10
00 01 64 06 27 00 00 00 4c 40 02 00 64 40 02 f8
46 00 00 10 10 01 65 06 27 00 00 00 4c 40 02 00
64 40 02 f8 46 00 00 10 20 01 66 06 27 00 00 00
4c 40 02 00 64 00 18 00 06 00 02 f8 46 80 02 
").

%% Getting record syntax out of shell
%% : R=x2ap_codec_tests:x2ap_decoder_initiatingMessage_test().
%% : rr("*/*").
%% : rp(R).
-define(X2InitMsgRec,
{successfulOutcome,
    #'SuccessfulOutcome'{
        procedureCode = 6,criticality = reject,
        value = 
            #'X2SetupResponse'{
                protocolIEs = 
                    [#'ProtocolIE-Field'{
                         id = 21,criticality = reject,
                         value = 
                             #'GlobalENB-ID'{
                                 'pLMN-Identity' = <<2,248,70>>,
                                 'eNB-ID' = {'macro-eNB-ID',<<0,6,5:4>>},
                                 'iE-Extensions' = asn1_NOVALUE}},
                     #'ProtocolIE-Field'{
                         id = 20,criticality = reject,
                         value = 
                             [#'ServedCells_SEQOF'{
                                  servedCellInfo = 
                                      #'ServedCell-Information'{
                                          pCI = 66,
                                          cellId = 
                                              #'ECGI'{
                                                  'pLMN-Identity' = <<2,248,70>>,
                                                  eUTRANcellIdentifier = <<0,6,80,0:4>>,
                                                  'iE-Extensions' = asn1_NOVALUE},
                                          tAC = <<0,100>>,
                                          broadcastPLMNs = [<<2,248,70>>],
                                          'eUTRA-Mode-Info' = 
                                              {fDD,
                                                  #'FDD-Info'{
                                                      'uL-EARFCN' = 19575,'dL-EARFCN' = 1575,
                                                      'uL-Transmission-Bandwidth' = bw50,
                                                      'dL-Transmission-Bandwidth' = bw50,
                                                      'iE-Extensions' = asn1_NOVALUE}},
                                          'iE-Extensions' = 
                                              [#'ProtocolExtensionField'{
                                                   id = 41,criticality = ignore,
                                                   extensionValue = {asn1_OPENTYPE,<<" ">>}}]},
                                  'neighbour-Info' = 
                                      [#'Neighbour-Information_SEQOF'{
                                           eCGI = 
                                               #'ECGI'{
                                                   'pLMN-Identity' = <<2,248,70>>,
                                                   eUTRANcellIdentifier = <<0,0,16,0:4>>,
                                                   'iE-Extensions' = asn1_NOVALUE},
                                           pCI = 356,eARFCN = 1575,
                                           'iE-Extensions' = 
                                               [#'ProtocolExtensionField'{
                                                    id = 76,criticality = ignore,
                                                    extensionValue = {asn1_OPENTYPE,<<0,100>>}}]},
                                       #'Neighbour-Information_SEQOF'{
                                           eCGI = 
                                               #'ECGI'{
                                                   'pLMN-Identity' = <<2,248,70>>,
                                                   eUTRANcellIdentifier = <<0,0,16,1:4>>,
                                                   'iE-Extensions' = asn1_NOVALUE},
                                           pCI = 357,eARFCN = 1575,
                                           'iE-Extensions' = 
                                               [#'ProtocolExtensionField'{
                                                    id = 76,criticality = ignore,
                                                    extensionValue = {asn1_OPENTYPE,<<0,100>>}}]},
                                       #'Neighbour-Information_SEQOF'{
                                           eCGI = 
                                               #'ECGI'{
                                                   'pLMN-Identity' = <<2,248,70>>,
                                                   eUTRANcellIdentifier = <<0,0,16,2:4>>,
                                                   'iE-Extensions' = asn1_NOVALUE},
                                           pCI = 358,eARFCN = 1575,
                                           'iE-Extensions' = 
                                               [#'ProtocolExtensionField'{
                                                    id = 76,criticality = ignore,
                                                    extensionValue = {asn1_OPENTYPE,<<0,100>>}}]}],
                                  'iE-Extensions' = asn1_NOVALUE}]},
                     #'ProtocolIE-Field'{
                         id = 24,criticality = reject,
                         value = 
                             [#'GU-Group-ID'{
                                  'pLMN-Identity' = <<2,248,70>>,
                                  'mME-Group-ID' = <<128,2>>,
                                  'iE-Extensions' = asn1_NOVALUE}]}]}}}

       ).


x2ap_decoder_initiatingMessage_test() ->
    Msg = hex:hexstr_to_bin(hex:trim_whitespace(?X2InitMsgHex)),
    %% ?debugFmt("~p~n", [Msg]),
    {ok, Res} = 'X2AP':decode('X2AP-PDU', Msg),
    %% ?debugFmt(">> ~p~n", [Res]),
    Res.

x2ap_encode_initiatingMessage_test() ->
    {ok, Res} = 'X2AP':encode('X2AP-PDU', ?X2InitMsgRec),
    %% ?debugFmt(">> ~p~n", [Res]),
    Msg = hex:hexstr_to_bin(hex:trim_whitespace(?X2InitMsgHex)),
    %% ?debugFmt(">> ~p~n", [Msg]),
    ?assertEqual(Msg, Res),
    Res.
