all:
	emacs -batch -l init.el -f batch-byte-compile *.el */*.el */*/*.el
clean:
	find . -name "*.elc" -exec rm -f "{}" \;
