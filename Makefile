.PHONY: test

watch:
	mocha --require coffee-script --compilers coffee:coffee-script test --watch --growl

test:
	mocha --require coffee-script --compilers coffee:coffee-script test


