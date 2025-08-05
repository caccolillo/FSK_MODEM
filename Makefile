# Makefile

.PHONY: all run clean

all: run

run:
	@echo "Sourcing prj.sh script..."
	@. ./prj.sh

clean:
	@echo "No clean actions defined."

