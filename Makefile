REBAR:='./rebar'

.PHONY: all erl test clean doc protocols


ASN1_CT_OPTS = +asn1config +verbose
PROTOCOLS = protocols
ASN1CT = erlc

all: erl

protocols:
	$(ASN1CT) -o src/ $(ASN1_CT_OPTS) +uper $(PROTOCOLS)/EUTRA-RRC.set.asn
	$(ASN1CT) -o src/ $(ASN1_CT_OPTS) +per  $(PROTOCOLS)/S1AP.set.asn
	$(ASN1CT) -o src/ $(ASN1_CT_OPTS) +per  $(PROTOCOLS)/X2AP.set.asn

erl: 
	$(REBAR) compile

test: all
	@mkdir -p .eunit
	$(REBAR) skip_deps=true eunit

clean:
	$(REBAR) clean
	-rm -rvf deps ebin doc .eunit

doc:
	$(REBAR) doc

##################################################################
ERLANG_PATH=-pa apps/*/ebin -pa deps/*/ebin -pa ebin
ERLANG_INCLUDE=-I include
BINDIR=ebin

shell:
	exec erl ${ERLANG_PATH} -boot start_sasl
