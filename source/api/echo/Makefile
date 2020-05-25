#RELDIR := ../..
#NAME := $(shell cat $(RELDIR)/name )
#PYDIR := $(RELDIR)/python
#PYNAMEDIR := $(PYDIR)/$(NAME)

# PYTARGET := $(PYNAMEDIR)/api_pb2.py

.PHONY: create
create: api.pb.go

#compile: protoc_gen_go api.pb.go $(PYTARGET)

api.pb.go: api.proto
	protoc -I . --go_out=plugins=grpc:. api.proto

# $(PYTARGET): api.proto
# 	python3 -m grpc_tools.protoc -I . --python_out=$(PYDIR) --grpc_python_out=$(PYDIR) $<
