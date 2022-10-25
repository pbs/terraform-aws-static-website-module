package test

import (
	"fmt"
	"os"
	"testing"
	"time"

	httpHelper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func testStaticSite(t *testing.T, variant string) {
	t.Parallel()

	expectedName := fmt.Sprintf("example-tf-static-website-%s", variant)

	primaryHostedZone := os.Getenv("TF_VAR_primary_hosted_zone")

	if primaryHostedZone == "" {
		t.Fatal("TF_VAR_primary_hosted_zone must be set to run tests. e.g. 'export TF_VAR_primary_hosted_zone=example.org'")
	}

	terraformDir := fmt.Sprintf("../examples/%s", variant)

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		LockTimeout:  "5m",
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.Init(t, terraformOptions)

	terraform.Apply(t, terraformOptions)

	domainName := terraform.Output(t, terraformOptions, "domain_name")

	expectedDomainName := fmt.Sprintf("%s.%s", expectedName, primaryHostedZone)

	assert.Equal(t, expectedDomainName, domainName)

	indexURL := fmt.Sprintf("https://%s/", domainName)
	expectedIndex, err := getFileAsString("nginx-index.html")

	if err != nil {
		t.Fatal(err)
	}

	httpHelper.HttpGetWithRetry(t, indexURL, nil, 200, expectedIndex, 30, 3*time.Second)
}
