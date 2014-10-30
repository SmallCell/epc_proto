-module(rrc_codec_tests).

-include_lib("eunit/include/eunit.hrl").

-include_lib("include/EUTRA-RRC.hrl").

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
-define(DL_CCCH_MessageRec1,
{'DL-CCCH-Message',
 {c1,
  {rrcConnectionSetup,
   {'RRCConnectionSetup',2,
    {c1,
     {'rrcConnectionSetup-r8',
      {'RRCConnectionSetup-r8-IEs',
       {'RadioResourceConfigDedicated',
        [{'SRB-ToAddMod',1,
          {explicitValue,
           {am,
            {'RLC-Config_am',
             {'UL-AM-RLC',ms60,p32,kBinfinity,t16},
             {'DL-AM-RLC',ms45,ms10}}}},
          {explicitValue,
           {'LogicalChannelConfig',
            {'LogicalChannelConfig_ul-SpecificParameters',1,infinity,ms50,
             0}}}}],
        asn1_NOVALUE,asn1_NOVALUE,
        {explicitValue,
         {'MAC-MainConfig',
          {'MAC-MainConfig_ul-SCH-Config',n5,sf5,sf320,false},
          asn1_NOVALUE,infinity,
          {setup,{'MAC-MainConfig_phr-Config_setup',sf200,sf0,dB1}}}},
        asn1_NOVALUE,
        {'PhysicalConfigDedicated',
         {'PDSCH-ConfigDedicated',dB0},
         {'PUCCH-ConfigDedicated',{release,'NULL'},multiplexing},
         {'PUSCH-ConfigDedicated',9,6,8},
         {'UplinkPowerControlDedicated',0,en0,true,0,7,fc4},
         {setup,{'TPC-PDCCH-Config_setup',<<0,75>>,{indexOfFormat3,6}}},
         {release,'NULL'},
         {'CQI-ReportConfig',rm30,0,
          {setup,
           {'CQI-ReportPeriodic_setup',0,18,{widebandCQI,'NULL'},322,false}}},
         {setup,
          {'SoundingRS-UL-ConfigDedicated_setup',bw0,hbw0,0,true,25,0,cs0}},
         {explicitValue,
          {'AntennaInfoDedicated',tm3,
           {'n2TxAntenna-tm3',<<3:2>>},
           {release,'NULL'}}},
         {setup,{'SchedulingRequestConfig_setup',0,8,n64}}}},
       asn1_NOVALUE}}}}}}}

       ).

-define(DL_CCCH_MessageRec,
#'DL-CCCH-Message' {
 message = 
  {c1,
   {rrcConnectionSetup,
    #'RRCConnectionSetup'{
     'rrc-TransactionIdentifier' = 2,
     criticalExtensions = 
      {c1,
       {'rrcConnectionSetup-r8',
        #'RRCConnectionSetup-r8-IEs'{
         radioResourceConfigDedicated = 
          #'RadioResourceConfigDedicated'{
           'srb-ToAddModList' = 
            [#'SRB-ToAddMod'{
              'srb-Identity' = 1,
              'rlc-Config' = 
               {explicitValue,
                {am,
                 #'RLC-Config_am'{
                  'ul-AM-RLC' = 
                   #'UL-AM-RLC'{
                    't-PollRetransmit' = ms60,pollPDU = p32,
                    pollByte = kBinfinity,maxRetxThreshold = t16},
                  'dl-AM-RLC' = 
                   #'DL-AM-RLC'{
                    't-Reordering' = ms45,'t-StatusProhibit' = ms10}}}},
              logicalChannelConfig = 
               {explicitValue,
                #'LogicalChannelConfig'{
                 'ul-SpecificParameters' = 
                  #'LogicalChannelConfig_ul-SpecificParameters'{
                   priority = 1,prioritisedBitRate = infinity,
                   bucketSizeDuration = ms50,logicalChannelGroup = 0}}}}],
           'drb-ToAddModList' = asn1_NOVALUE,
           'drb-ToReleaseList' = asn1_NOVALUE,
           'mac-MainConfig' = 
            {explicitValue,
             #'MAC-MainConfig'{
              'ul-SCH-Config' = 
               #'MAC-MainConfig_ul-SCH-Config'{
                'maxHARQ-Tx' = n5,'periodicBSR-Timer' = sf5,
                'retxBSR-Timer' = sf320,ttiBundling = false},
              'drx-Config' = asn1_NOVALUE,
              timeAlignmentTimerDedicated = infinity,
              'phr-Config' = 
               {setup,
                #'MAC-MainConfig_phr-Config_setup'{
                 'periodicPHR-Timer' = sf200,'prohibitPHR-Timer' = sf0,
                 'dl-PathlossChange' = dB1}}}},
           'sps-Config' = asn1_NOVALUE,
           physicalConfigDedicated = 
            #'PhysicalConfigDedicated'{
             'pdsch-ConfigDedicated' = 
              #'PDSCH-ConfigDedicated'{'p-a' = dB0},
             'pucch-ConfigDedicated' = 
              #'PUCCH-ConfigDedicated'{
               ackNackRepetition = {release,'NULL'},
               'tdd-AckNackFeedbackMode' = multiplexing},
             'pusch-ConfigDedicated' = 
              #'PUSCH-ConfigDedicated'{
               'betaOffset-ACK-Index' = 9,'betaOffset-RI-Index' = 6,
               'betaOffset-CQI-Index' = 8},
             uplinkPowerControlDedicated = 
              #'UplinkPowerControlDedicated'{
               'p0-UE-PUSCH' = 0,'deltaMCS-Enabled' = en0,
               accumulationEnabled = true,'p0-UE-PUCCH' = 0,
               'pSRS-Offset' = 7,filterCoefficient = fc4},
             'tpc-PDCCH-ConfigPUCCH' = 
              {setup,
               #'TPC-PDCCH-Config_setup'{
                'tpc-RNTI' = <<0,75>>,
                'tpc-Index' = {indexOfFormat3,6}}},
             'tpc-PDCCH-ConfigPUSCH' = {release,'NULL'},
             'cqi-ReportConfig' = 
              #'CQI-ReportConfig'{
               'cqi-ReportModeAperiodic' = rm30,
               'nomPDSCH-RS-EPRE-Offset' = 0,
               'cqi-ReportPeriodic' = 
                {setup,
                 #'CQI-ReportPeriodic_setup'{
                  'cqi-PUCCH-ResourceIndex' = 0,'cqi-pmi-ConfigIndex' = 18,
                  'cqi-FormatIndicatorPeriodic' = {widebandCQI,'NULL'},
                  'ri-ConfigIndex' = 322,simultaneousAckNackAndCQI = false}}},
             'soundingRS-UL-ConfigDedicated' = 
              {setup,
               #'SoundingRS-UL-ConfigDedicated_setup'{
                'srs-Bandwidth' = bw0,'srs-HoppingBandwidth' = hbw0,
                freqDomainPosition = 0,duration = true,
                'srs-ConfigIndex' = 25,transmissionComb = 0,
                cyclicShift = cs0}},
             antennaInfo = 
              {explicitValue,
               #'AntennaInfoDedicated'{
                transmissionMode = tm3,
                codebookSubsetRestriction = {'n2TxAntenna-tm3',<<3:2>>},
                'ue-TransmitAntennaSelection' = {release,'NULL'}}},
             schedulingRequestConfig = 
              {setup,
               #'SchedulingRequestConfig_setup'{
                'sr-PUCCH-ResourceIndex' = 0,'sr-ConfigIndex' = 8,
                'dsr-TransMax' = n64}}}},
         nonCriticalExtension = asn1_NOVALUE}}}}}}}).

rrc_decoder_initiatingMessage_test() ->
    Msg = hex:hexstr_to_bin(hex:trim_whitespace(?DL_CCCH_MessageHex)),
    %% ?debugFmt("~p~n", [Msg]),
    {ok, Res} = 'EUTRA-RRC':decode('DL-CCCH-Message', Msg),
    %% ?debugFmt("~p~n", [Res]),
    Res.

rrc_encode_initiatingMessage_test() ->    
    {ok, Res} = 'EUTRA-RRC':encode('DL-CCCH-Message', ?DL_CCCH_MessageRec1),
    %% ?debugFmt(">> ~p~n", [Res]),
    Msg = hex:hexstr_to_bin(hex:trim_whitespace(?DL_CCCH_MessageHex)),
    ?debugFmt(">> ~p~n", [Msg]),
    %% ?assertEqual(Msg, Res),
    Res.
