#RELDIR := ../..
#NAME := $(shell cat $(RELDIR)/name )
#PYDIR := $(RELDIR)/python
#PYNAMEDIR := $(PYDIR)/$(NAME)

# PYTARGET := $(PYNAMEDIR)/api_pb2.py

.PHONY: create
create: api/api.pb.go

#compile: protoc_gen_go api.pb.go $(PYTARGET)

api/api.pb.go: api/api.proto
	protoc -I . --go_out=plugins=grpc:. api/api.proto

# $(PYTARGET): api.proto
# 	python3 -m grpc_tools.protoc -I . --python_out=$(PYDIR) --grpc_python_out=$(PYDIR) $<
