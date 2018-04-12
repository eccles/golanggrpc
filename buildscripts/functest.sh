#!/bin/sh
#
# Runs functional tests as a package
#
export EC_GOLANGGRPC_HOST="alpineapi"
export EC_GOLANGGRPC_PORT="8080"

CLIENT="bin/ec_golanggrpcclient"

echo "----> Test no arguments"
${CLIENT} 2> /tmp/no_arguments
cat /tmp/no_arguments
if [ $? -ne 0 ]
then
	echo "Show usage failure"
fi

