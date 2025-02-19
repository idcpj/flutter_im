
.PHONY: run_example
run_example:
	flutter run --target packages/client_example/main.dart

.PHONY: build_hap
build_hap:
	flutter build hap --target packages/client_example/main.dart 


.PHONY: build_runner
build_runner:
	dart run build_runner build   --delete-conflicting-outputs -v  


# 自动降级包
.PHONY: downgrade
downgrade:
	flutter pub downgrade -v

# 自动降级包
.PHONY: outdated
outdated:
	flutter pub outdated
