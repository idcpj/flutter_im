
.PHONY: run_example
run_example:
	 melos exec --scope="client_example" -- "flutter run"

.PHONY: build_hap
build_hap:
	 melos exec --scope="client_example" -- "flutter build hap"


# 运行 build_runner, 生成代码
.PHONY: build_runner
build_runner:
	dart run build_runner build   --delete-conflicting-outputs -v  

