RELDIR := ../..
NAME := $(shell cat $(RELDIR)/name )
PYDIR := $(RELDIR)/python
PYNAMEDIR := $(PYDIR)/$(NAME)

PYTARGET := $(PYNAMEDIR)/api_pb2.py

.PHONY: compile
compile: api.pb.go $(PYTARGET)

api.pb.go: api.proto
	protoc -I . --go_out=plugins=grpc:. $<

$(PYTARGET): api.proto
	python3 -m grpc_tools.protoc -I . --python_out=$(PYDIR) --grpc_python_out=$(PYDIR) $<

.PHONY: clean
clean:
	rm -f api.pb.go
	rm -f $(PYNAMEDIR)/api_pb2*.py
	rm -rf $(PYNAMEDIR)/__pycache__
