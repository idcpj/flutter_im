
.PHONY: run_example
run_example:
	flutter run --target packages/client_example/main.dart

.PHONY: run_example
build_hap:
	flutter build hap --target packages/client_example/main.dart 


.PHONY: build_runner
build_runner:
	dart run build_runner build   --delete-conflicting-outputs -v  

