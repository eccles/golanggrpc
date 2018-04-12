package params

import (
	"fmt"
	"os"
	"testing"
)

const (
	envTag = "TESTING"
)

var parameterMap = ParameterMap{
	"Boolean": {
		Default: "false",
		Desc:    "A boolean",
	},
	"Integer": {
		Default: "9999",
		Desc:    "An integer",
	},
	"String": {
		Default: "default",
		Desc:    "A string",
	},
}

var badParameterMap = ParameterMap{
	"Boolean": {
		Default: "xxxx",
		Desc:    "A boolean",
	},
	"Integer": {
		Default: "yyyy",
		Desc:    "An integer",
	},
	"String": {
		Default: "default",
		Desc:    "A string",
	},
}

type args struct {
	boolean bool
	integer int
	text    string
}

func TestParamsDefaults(t *testing.T) {
	os.Unsetenv(fmt.Sprintf("%s_%s", envTag, "BOOLEAN"))
	os.Unsetenv(fmt.Sprintf("%s_%s", envTag, "INTEGER"))
	os.Unsetenv(fmt.Sprintf("%s_%s", envTag, "STRING"))

	parms := &Parameters{
		EnvTag:     envTag,
		Properties: &parameterMap,
	}

	boolean, err := EnvBool(parms, "Boolean")
	if err != nil {
		t.Logf("FAIL: EnvBoolean raises error %v", err)
		t.Fail()
	}
	integer, err := EnvInt(parms, "Integer")
	if err != nil {
		t.Logf("FAIL: EnvInteger raises error %v", err)
		t.Fail()
	}
	text, err := EnvString(parms, "String")
	if err != nil {
		t.Logf("FAIL: EnvString raises error %v", err)
		t.Fail()
	}

	if boolean {
		t.Logf("FAIL: Boolean should be false")
		t.Fail()
	}
	if integer != 9999 {
		t.Logf("FAIL: Integer should be 9999 but is %d", integer)
		t.Fail()
	}
	if text != "default" {
		t.Logf("FAIL: String should be 'default' but is %s", text)
		t.Fail()
	}
}

func TestParamsBadDefaults(t *testing.T) {
	os.Unsetenv(fmt.Sprintf("%s_%s", envTag, "BOOLEAN"))
	os.Unsetenv(fmt.Sprintf("%s_%s", envTag, "INTEGER"))
	os.Unsetenv(fmt.Sprintf("%s_%s", envTag, "STRING"))

	parms := &Parameters{
		EnvTag:     envTag,
		Properties: &badParameterMap,
	}

	boolean, err := EnvBool(parms, "Boolean")
	if err == nil {
		t.Logf("FAIL: EnvBoolean should raise error")
		t.Fail()
	}
	if err.Error() != "Incorrect bool in parameter list \"xxxx\": "+
		"strconv.ParseBool: parsing \"xxxx\": invalid syntax" {
		t.Logf("FAIL: EnvBoolean error is incorrect")
		t.Fail()
	}
	integer, err := EnvInt(parms, "Integer")
	if err == nil {
		t.Logf("FAIL: EnvInteger should raise error")
		t.Fail()
	}
	if err.Error() != "Incorrect int in parameter list \"yyyy\": "+
		"strconv.Atoi: parsing \"yyyy\": invalid syntax" {
		t.Logf("FAIL: EnvBoolean error is incorrect")
		t.Fail()
	}

	text, err := EnvString(parms, "String")
	if err != nil {
		t.Logf("FAIL: EnvString raises error %v", err)
		t.Fail()
	}

	if boolean {
		t.Logf("FAIL: Boolean should be false")
		t.Fail()
	}
	if integer != 0 {
		t.Logf("FAIL: Integer should be 0 but is %d", integer)
		t.Fail()
	}
	if text != "default" {
		t.Logf("FAIL: String should be 'default' but is %s", text)
		t.Fail()
	}
}

func TestParamsEnvironment(t *testing.T) {
	os.Setenv(fmt.Sprintf("%s_%s", envTag, "BOOLEAN"), "true")
	os.Setenv(fmt.Sprintf("%s_%s", envTag, "INTEGER"), "8888")
	os.Setenv(fmt.Sprintf("%s_%s", envTag, "STRING"), "another string")

	parms := &Parameters{
		EnvTag:     envTag,
		Properties: &parameterMap,
	}

	boolean, err := EnvBool(parms, "Boolean")
	if err != nil {
		t.Logf("FAIL: EnvBoolean raises error %v", err)
		t.Fail()
	}
	integer, err := EnvInt(parms, "Integer")
	if err != nil {
		t.Logf("FAIL: EnvInteger raises error %v", err)
		t.Fail()
	}
	text, err := EnvString(parms, "String")
	if err != nil {
		t.Logf("FAIL: EnvString raises error %v", err)
		t.Fail()
	}

	if !boolean {
		t.Logf("FAIL: Boolean should be true")
		t.Fail()
	}
	if integer != 8888 {
		t.Logf("FAIL: Integer should be 8888 but is %d", integer)
		t.Fail()
	}
	if text != "another string" {
		t.Logf("FAIL: String should be 'another string' but is %s", text)
		t.Fail()
	}
}

func TestParamsErrors(t *testing.T) {
	os.Setenv(fmt.Sprintf("%s_%s", envTag, "BOOLEAN"), "xxxx")
	os.Setenv(fmt.Sprintf("%s_%s", envTag, "INTEGER"), "yyyy")
	os.Setenv(fmt.Sprintf("%s_%s", envTag, "STRING"), "another string")

	parms := &Parameters{
		EnvTag:     envTag,
		Properties: &parameterMap,
	}

	boolean, err := EnvBool(parms, "Boolean")
	if err == nil {
		t.Logf("FAIL: EnvBoolean should raise error")
		t.Fail()
	}

	if err.Error() != "Incorrect bool \"xxxx\": "+
		"strconv.ParseBool: parsing \"xxxx\": invalid syntax" {
		t.Logf("FAIL: EnvBoolean error is incorrect")
		t.Fail()
	}

	integer, err := EnvInt(parms, "Integer")
	if err == nil {
		t.Logf("FAIL: EnvInteger should raise error")
		t.Fail()
	}
	if err.Error() != "Incorrect Int \"yyyy\": "+
		"strconv.Atoi: parsing \"yyyy\": invalid syntax" {
		t.Logf("FAIL: EnvBoolean error is incorrect")
		t.Fail()
	}

	text, err := EnvString(parms, "String")
	if err != nil {
		t.Logf("FAIL: EnvString raises error %v", err)
		t.Fail()
	}

	if boolean {
		t.Logf("FAIL: Boolean should be false")
		t.Fail()
	}
	if integer != 0 {
		t.Logf("FAIL: Integer should be 0 but is %d", integer)
		t.Fail()
	}
	if text != "another string" {
		t.Logf("FAIL: String should be 'another string' but is %s", text)
		t.Fail()
	}
}
