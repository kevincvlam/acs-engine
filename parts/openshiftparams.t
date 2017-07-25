{
	"$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
	"contentVersion": "1.0.0.0",
	"parameters": {
		"_artifactsLocation": {
			"value": "https://raw.githubusercontent.com/Microsoft/openshift-origin/master/"
		},
		"osImage": {
			"value": "centos"
		},
		"masterVmSize": {
			"value": "Standard_DS2_v2"
		},
		"infraVmSize": {
			"value": "Standard_DS2_v2"
		},
		"nodeVmSize": {
			"value": "Standard_DS2_v2"
		},
		"openshiftClusterPrefix": {
			"value": "changeme"
		},
		"openshiftMasterPublicIpDnsLabel": {
			"value": "changeme"
		},
		"infraLbPublicIpDnsLabel": {
			"value": "changeme"
		},
		"masterInstanceCount": {
			"value": 1
		},
		"infraInstanceCount": {
			"value": 1
		},
		"nodeInstanceCount": {
			"value": 1
		},
		"dataDiskSize": {
			"value": 128
		},
		"adminUsername": {
			"value": "changeme"
		},
		"openshiftPassword": {
			"value": "changeme"
		},
		"sshPublicKey": {
			"value": "changeme"
		},
		"keyVaultResourceGroup": {
			"value": "changeme"
		},
		"keyVaultName": {
			"value": "changeme"
		},
		"keyVaultSecret": {
			"value": "changeme"
		},
		"aadClientId": {
			"value": "changeme"
		},
		"aadClientSecret": {
			"value": "changeme"
		},
		"defaultSubDomainType": {
			"value": "xipio"
		},
		"defaultSubDomain": {
			"value": "changeme"
		}
	}
}