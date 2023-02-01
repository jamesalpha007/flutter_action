.PHONY: macos ios

RUST_DIR := src_rust
RUST_API_PATH := ${RUST_DIR}/src/api.rs
DART_LIB_PATH := lib/bridge_generated.dart 
DART_DECL_PATH := lib/bridge_definitions.dart 


ios:
	flutter_rust_bridge_codegen \
		-r ${RUST_API_PATH} \
		-d ${DART_LIB_PATH} \
		--dart-decl-output ${DART_DECL_PATH} \
		-c ios/Runner/bridge_generated.h;
	cd ${RUST_DIR} && cargo lipo && cp target/universal/debug/libflutter_action.a ../ios/Runner;