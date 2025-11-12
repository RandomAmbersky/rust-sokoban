# Makefile for building Rust Sokoban projects

# List of project directories
PROJECTS = code/rust-sokoban-c01-01 \
           code/rust-sokoban-c01-03 \
           code/rust-sokoban-c01-04 \
           code/rust-sokoban-c02-01 \
           code/rust-sokoban-c02-02 \
           code/rust-sokoban-c02-03 \
           code/rust-sokoban-c02-04 \
           code/rust-sokoban-c02-05 \
           code/rust-sokoban-c03-01 \
           code/rust-sokoban-c03-02 \
           code/rust-sokoban-c03-03 \
           code/rust-sokoban-c03-04 \
           code/rust-sokoban-c03-05

.PHONY: all build clean help

# Default target
all: build

# Build all projects
build:
	@echo "Building all Rust Sokoban projects..."
	@for dir in $(PROJECTS); do \
		echo "Building $$dir..."; \
		(cd $$dir && cargo build --release) || exit 1; \
	done
	@echo "All projects built successfully."

# Clean all projects
clean:
	@echo "Cleaning all Rust Sokoban projects..."
	@for dir in $(PROJECTS); do \
		echo "Cleaning $$dir..."; \
		(cd $$dir && cargo clean) || exit 1; \
	done
	@echo "All projects cleaned."

# Build a specific project (usage: make build-c01-01)
define build_project
build-$(1):
	@echo "Building $(1)..."
	@cd code/rust-sokoban-$(1) && cargo build --release
	@echo "$(1) built successfully."
endef

# Generate build targets for each project
$(foreach proj,$(PROJECTS),$(eval $(call build_project,$(proj:code/rust-sokoban-%=%))))

# Clean a specific project (usage: make clean-c01-01)
define clean_project
clean-$(1):
	@echo "Cleaning $(1)..."
	@cd code/rust-sokoban-$(1) && cargo clean
	@echo "$(1) cleaned."
endef

# Generate clean targets for each project
$(foreach proj,$(PROJECTS),$(eval $(call clean_project,$(proj:code/rust-sokoban-%=%))))

# Run a specific project (usage: make run-c01-01)
define run_project
run-$(1):
	@echo "Running $(1)..."
	@cd code/rust-sokoban-$(1) && cargo run --release
endef

# Generate run targets for each project
$(foreach proj,$(PROJECTS),$(eval $(call run_project,$(proj:code/rust-sokoban-%=%))))

# Help target
help:
	@echo "Available targets:"
	@echo "  all          - Build all projects (default)"
	@echo "  build        - Build all projects"
	@echo "  clean        - Clean all projects"
	@echo "  build-cXX-XX - Build specific project (e.g., make build-c01-01)"
	@echo "  clean-cXX-XX - Clean specific project (e.g., make clean-c01-01)"
	@echo "  run-cXX-XX   - Run specific project (e.g., make run-c01-01)"
	@echo "  help         - Show this help"
