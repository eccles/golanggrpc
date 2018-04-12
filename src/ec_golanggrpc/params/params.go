package params

import (
	"fmt"
	"os"
	"strconv"
	"strings"

	log "github.com/sirupsen/logrus"
)

// ParameterValues  - values of each parameter
type ParameterValues struct {
	Default string
	Desc    string
}

// ParameterMap maps variable to default and description.
type ParameterMap map[string]*ParameterValues

// Parameters contains definitions of application parameters.
type Parameters struct {
	EnvTag     string
	Properties *ParameterMap
}

// defaultBool - get default value of specified boolean field.
func defaultBool(params *Parameters, tag string) (bool, error) {
	param := (*params.Properties)[tag]
	log.Debug("defaultBool ", tag, "(", param.Desc, ")")
	def, err := strconv.ParseBool(param.Default)
	if err != nil {
		return def, fmt.Errorf(
			"Incorrect bool in parameter list \"%s\": %s",
			param.Default,
			err,
		)
	}
	log.Debug("defaultBool ", tag, " = ", def)
	return def, nil
}

// defaultInt - get default value of specified integer field.
func defaultInt(params *Parameters, tag string) (int, error) {
	param := (*params.Properties)[tag]
	log.Debug("defaultInt ", tag, "(", param.Desc, ")")
	def, err := strconv.Atoi(param.Default)
	if err != nil {
		return def, fmt.Errorf(
			"Incorrect int in parameter list \"%s\": %s",
			param.Default,
			err,
		)
	}
	log.Debug("defaultInt ", tag, " = ", def)
	return def, nil
}

// defaultString - get default value of specified String field.
func defaultString(params *Parameters, tag string) (string, error) {
	param := (*params.Properties)[tag]
	log.Debug("defaultString ", tag, "(", param.Desc, ")")
	def := param.Default
	log.Debug("defaultString ", tag, " = ", def)
	return def, nil
}

// env convenience function that reads from environment
func env(params *Parameters, tag string) (string, bool) {

	return os.LookupEnv(
		fmt.Sprintf("%s_%s",
			(*params).EnvTag,
			strings.ToUpper(tag),
		),
	)
}

// EnvBool - get value of specified boolean field from environment.
// If not in environment then get default value.
func EnvBool(params *Parameters, tag string) (bool, error) {
	log.Debug("EnvBool ", tag)

	arg, ok := env(params, tag)
	if !ok {
		return defaultBool(params, tag)
	}

	ret, err := strconv.ParseBool(arg)
	if err != nil {
		return ret, fmt.Errorf(
			"Incorrect bool \"%s\": %s",
			arg,
			err,
		)
	}
	return ret, nil
}

// EnvInt - get value of specified integer field from environment.
// If not in environment then get default value.
func EnvInt(params *Parameters, tag string) (int, error) {
	log.Debug("EnvInt ", tag)

	arg, ok := env(params, tag)
	if !ok {
		return defaultInt(params, tag)
	}

	ret, err := strconv.Atoi(arg)
	if err != nil {
		return ret, fmt.Errorf(
			"Incorrect Int \"%s\": %s",
			arg,
			err,
		)
	}
	return ret, nil
}

// EnvString - get value of specified string field from environment.
// If not in environment then get default value.
func EnvString(params *Parameters, tag string) (string, error) {
	log.Debug("EnvString ", tag)

	arg, ok := env(params, tag)
	if !ok {
		return defaultString(params, tag)
	}
	return arg, nil
}
