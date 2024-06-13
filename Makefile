.PHONY: work mbp

work:
	darwin-rebuild switch --flake .#MB-Q5JMWQ5VFD

mbp:
	darwin-rebuild switch --flake .#mbp
