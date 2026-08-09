.RECIPEPREFIX = >
F ?=
OUT_DIR := output
FLAGS := -FE$(OUT_DIR) -Co -Cr -Miso -gl
TARGET := $(OUT_DIR)/$(F)

.PHONY: run

run:
>@if [ -z "$(F)" ]; then \
>	echo "Error: You must provide a filename."; \
>	echo "Usage: make run F=<filename>"; \
>	exit 1; \
>fi
>@mkdir -p $(OUT_DIR)
>@if fpc $(FLAGS) $(F).pas; then \
>	echo ""; \
>	echo "Running $(F).pas..."; \
>	echo ""; \
>	echo "Output:"; \
>	./$(TARGET); \
>else \
>	echo "Compilation failed." >&2; \
>	exit 1; \
>fi
>@rm -r $(OUT_DIR)
