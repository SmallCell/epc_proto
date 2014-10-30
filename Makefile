REBAR:='./rebar'

.PHONY: all erl test clean doc protocols


all: erl

protocols:
	erl -noshell -eval 'asn1ct:compile("protocols/EUTRA-RRC.set.asn", [{outdir,"src"}, uper, verbose,  noobj])' -eval 'init:stop()'
	erl -noshell -eval 'asn1ct:compile("protocols/S1AP.set.asn", [{outdir,"src"}, per, verbose,  noobj])' -eval 'init:stop()'
	erl -noshell -eval 'asn1ct:compile("protocols/X2AP.set.asn", [{outdir,"src"}, per, verbose,  noobj])' -eval 'init:stop()'
	-mv src/EUTRA-RRC.hrl  src/S1AP.hrl  src/X2AP.hrl include

val:
	erl -noshell -eval 'asn1ct:compile("test/S1APValue.asn1", [{outdir,"test"}, {i, "protocols/s1ap"}, per])' -eval 'init:stop()'

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
#ERLANG_PATH=-pa apps/*/ebin -pa deps/*/ebin -pa ebin
ERLANG_PATH=-pa .eunit
ERLANG_INCLUDE=-I include
BINDIR=ebin

shell:
	exec erl ${ERLANG_PATH} -boot start_sasl
