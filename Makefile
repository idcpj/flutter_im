
.PHONY: run_example

# 运行示例应用
run_example:
	flutter run --target packages/client_example/main.dart

# 设置 run 作为 run_example 的别名
run: run_example
