REBAR:='./rebar'

.PHONY: all erl test clean doc protocols


ASN1_CT_OPTS = +verbose +compact_bit_string +noobj
PROTOCOLS = protocols
ASN1CT = 

all: erl

protocols:
	erl -noshell -eval 'asn1ct:compile("protocols/EUTRA-RRC.set.asn", [{outdir,"src"}, uper, verbose, compact_bit_string, noobj])' -eval 'init:stop()'
	erl -noshell -eval 'asn1ct:compile("protocols/S1AP.set.asn", [{outdir,"src"}, per, verbose, compact_bit_string, noobj])' -eval 'init:stop()'
	erl -noshell -eval 'asn1ct:compile("protocols/X2AP.set.asn", [{outdir,"src"}, per, verbose, compact_bit_string, noobj])' -eval 'init:stop()'

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
