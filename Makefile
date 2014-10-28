REBAR:='./rebar'

.PHONY: all erl test clean doc 

all: erl

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
