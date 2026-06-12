# ProVerif targets — requires `proverif` on PATH (see README.md).
OUT := out

.PHONY: all verify minimal abstract signed clean

all: verify

verify: minimal abstract signed

minimal:
	@mkdir -p $(OUT)
	proverif -in pitype examples/minimal_secrecy.pv | tee $(OUT)/minimal_secrecy.log

abstract:
	@mkdir -p $(OUT)
	proverif -in pitype sdt_abstract.pv | tee $(OUT)/sdt_abstract.log

signed:
	@mkdir -p $(OUT)
	proverif -in pitype sdt_signed_pipeline.pv | tee $(OUT)/sdt_signed_pipeline.log

clean:
	rm -f $(OUT)/*.log
