{
	"$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json",
	"contentVersion": "1.0.0.0",
            {{template "kubernetesagentvars.t" .}}

	"parameters": {
		"_artifactsLocation": {
			"type": "string",
			"metadata": {
				"description": "The base URL where artifacts required by this template are located. When the template is deployed using the accompanying scripts, a private location in the subscription will be used and this value will be automatically generated.",
				"artifactsBaseUrl": ""
			},
			"defaultValue": "https://raw.githubusercontent.com/Microsoft/openshift-origin/master/"
		},
		"osImage": {
			"type": "string",
			"allowedValues": ["centos", "rhel"],
			"defaultValue": "centos",
			"metadata": {
				"description": "OS to use for image - centos or rhel"
			}
		},
		"masterVmSize": {
			"type": "string",
			"defaultValue": "Standard_DS2_v2",
			"allowedValues": [
				"Standard_A4", "Standard_A5", "Standard_A6", "Standard_A7", "Standard_A8", "Standard_A9", "Standard_A10", "Standard_A11",
				"Standard_D1", "Standard_D2", "Standard_D3", "Standard_D4",
				"Standard_D11", "Standard_D12", "Standard_D13", "Standard_D14",
				"Standard_D1_v2", "Standard_D2_v2", "Standard_D3_v2", "Standard_D4_v2", "Standard_D5_v2",
				"Standard_D11_v2", "Standard_D12_v2", "Standard_D13_v2", "Standard_D14_v2",
				"Standard_G1", "Standard_G2", "Standard_G3", "Standard_G4", "Standard_G5",
				"Standard_D1_v2", "Standard_DS2", "Standard_DS3", "Standard_DS4",
				"Standard_DS11", "Standard_DS12", "Standard_DS13", "Standard_DS14",
				"Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2", "Standard_DS4_v2", "Standard_DS5_v2",
				"Standard_DS11_v2", "Standard_DS12_v2", "Standard_DS13_v2", "Standard_DS14_v2",
				"Standard_GS1", "Standard_GS2", "Standard_GS3", "Standard_GS4", "Standard_GS5"
			],
			"metadata": {
				"description": "OpenShift Master VM size"
			}
		},
		"nodeVmSize": {
			"type": "string",
			"defaultValue": "Standard_DS2_v2",
			"allowedValues": [
				"Standard_A4", "Standard_A5", "Standard_A6", "Standard_A7", "Standard_A8", "Standard_A9", "Standard_A10", "Standard_A11",
				"Standard_D1", "Standard_D2", "Standard_D3", "Standard_D4",
				"Standard_D11", "Standard_D12", "Standard_D13", "Standard_D14",
				"Standard_D1_v2", "Standard_D2_v2", "Standard_D3_v2", "Standard_D4_v2", "Standard_D5_v2",
				"Standard_D11_v2", "Standard_D12_v2", "Standard_D13_v2", "Standard_D14_v2",
				"Standard_G1", "Standard_G2", "Standard_G3", "Standard_G4", "Standard_G5",
				"Standard_D1_v2", "Standard_DS2", "Standard_DS3", "Standard_DS4",
				"Standard_DS11", "Standard_DS12", "Standard_DS13", "Standard_DS14",
				"Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2", "Standard_DS4_v2", "Standard_DS5_v2",
				"Standard_DS11_v2", "Standard_DS12_v2", "Standard_DS13_v2", "Standard_DS14_v2",
				"Standard_GS1", "Standard_GS2", "Standard_GS3", "Standard_GS4", "Standard_GS5"
			],
			"metadata": {
				"description": "OpenShift Node VM(s) size"
			}
		},
		"infraVmSize": {
			"type": "string",
			"defaultValue": "Standard_DS2_v2",
			"allowedValues": [
				"Standard_A4", "Standard_A5", "Standard_A6", "Standard_A7", "Standard_A8", "Standard_A9", "Standard_A10", "Standard_A11",
				"Standard_D1", "Standard_D2", "Standard_D3", "Standard_D4",
				"Standard_D11", "Standard_D12", "Standard_D13", "Standard_D14",
				"Standard_D1_v2", "Standard_D2_v2", "Standard_D3_v2", "Standard_D4_v2", "Standard_D5_v2",
				"Standard_D11_v2", "Standard_D12_v2", "Standard_D13_v2", "Standard_D14_v2",
				"Standard_G1", "Standard_G2", "Standard_G3", "Standard_G4", "Standard_G5",
				"Standard_D1_v2", "Standard_DS2", "Standard_DS3", "Standard_DS4",
				"Standard_DS11", "Standard_DS12", "Standard_DS13", "Standard_DS14",
				"Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2", "Standard_DS4_v2", "Standard_DS5_v2",
				"Standard_DS11_v2", "Standard_DS12_v2", "Standard_DS13_v2", "Standard_DS14_v2",
				"Standard_GS1", "Standard_GS2", "Standard_GS3", "Standard_GS4", "Standard_GS5"
			],
			"metadata": {
				"description": "OpenShift Infra Node VM(s) size"
			}
		},
		"openshiftClusterPrefix": {
			"type": "string",
			"defaultValue": "aacl",
			"minLength": 1,
			"maxLength": 20,
			"metadata": {
				"description": "OpenShift cluster prefix.  Used to generate master, infra and node hostnames.  Maximum of 20 characters."
			}
		},
		"openshiftMasterPublicIpDnsLabel": {
			"type": "string",
			"minLength": 1,
			"metadata": {
				"description": "OpenShift Master Load Balancer public IP DNS name (hostname portion). Must be lowercase. It should match with the following regular expression: ^[a-z][a-z0-9-]{1,61}[a-z0-9]$ or it will raise an error."
			}
		},
		"infraLbPublicIpDnsLabel": {
			"type": "string",
			"minLength": 1,
			"metadata": {
				"description": "OpenShift Infra Nodes Load Balancer public IP DNS name (hostname portion). Must be lowercase. It should match with the following regular expression: ^[a-z][a-z0-9-]{1,61}[a-z0-9]$ or it will raise an error."
			}
		},
		"masterInstanceCount": {
			"type": "int",
			"defaultValue": 1,
			"minValue": 1,
			"allowedValues": [1, 2, 3],
			"metadata": {
				"description": "Number of OpenShift masters.  1 is non HA and 3 is for HA"
			}
		},
		"infraInstanceCount": {
			"type": "int",
			"defaultValue": 1,
			"minValue": 1,
			"allowedValues": [1, 2, 3],
			"metadata": {
				"description": "Number of OpenShift infra nodes.  1 is non HA.  Choose 2 or 3 for HA"
			}
		},
		"nodeInstanceCount": {
			"type": "int",
			"defaultValue": 1,
			"minValue": 1,
			"allowedValues": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30],
			"metadata": {
				"description": "Number of OpenShift nodes"
			}
		},
		"dataDiskSize": {
			"type": "int",
			"defaultValue": 128,
			"minValue": 1,
			"allowedValues": [128, 512, 1023],
			"metadata": {
				"description": "Size of Datadisk in GB for Docker volume"
			}
		},
		"adminUsername": {
			"type": "string",
			"defaultValue": "ocpadmin",
			"minLength": 1,
			"metadata": {
				"description": "Administrator username on all VMs and first user created for OpenShift login"
			}
		},
		"openshiftPassword": {
			"type": "securestring",
			"minLength": 1,
			"metadata": {
				"description": "Password for OpenShift user to login to OpenShift Console"
			}
		},
		"sshPublicKey": {
			"type": "securestring",
			"metadata": {
				"description": "SSH public key for all VMs"
			}
		},
		"keyVaultResourceGroup": {
			"type": "string",
			"minLength": 1,
			"metadata": {
				"description": "Resource Group that contains the Key Vault"
			}
		},
		"keyVaultName": {
			"type": "string",
			"minLength": 1,
			"metadata": {
				"description": "Name of the Key Vault"
			}
		},
		"keyVaultSecret": {
			"type": "securestring",
			"minLength": 1,
			"metadata": {
				"description": "Key Vault Secret Name that contains the Private Key"
			}
		},
		"aadClientId": {
			"type": "string",
			"minLength": 1,
			"metadata": {
				"description": "Azure AD Client ID"
			}
		},
		"aadClientSecret": {
			"type": "securestring",
			"minLength": 1,
			"metadata": {
				"description": "Azure AD Client Secret"
			}
		},
		"defaultSubDomainType": {
			"type": "string",
			"defaultValue": "xipio",
			"allowedValues": [
				"xipio", "custom"
			],
			"metadata": {
				"description": "Default Subdomain type - xip.io or custom (defined in next parameter)"
			}
		},
		"defaultSubDomain": {
			"type": "string",
			"defaultValue": "contoso.com",
			"metadata": {
				"description": "Default Subdomain for application routing (Wildcard DNS) - must enter something even if you are using xip.io"
			}
		}
	},
	"variables": {
		"location": "[resourceGroup().location]",
		"resourceGroupName": "[resourceGroup().id]",
		"apiVersionCompute": "2015-06-15",
		"apiVersionNetwork": "2016-03-30",
		"apiVersionStorage": "2015-06-15",
		"apiVersionLinkTemplate": "2015-01-01",
		"namingInfix": "[toLower(parameters('openshiftClusterPrefix'))]",
		"openshiftMasterHostname": "[concat(variables('namingInfix'), '-master')]",
		"openshiftNodeHostname": "[concat(variables('namingInfix'), '-node')]",
		"openshiftInfraHostname": "[concat(variables('namingInfix'), '-infra')]",
		"newStorageAccountMaster": "[concat('master', uniqueString(concat(resourceGroup().id, 'msa')))]",
		"newStorageAccountInfra": "[concat('infra', uniqueString(concat(resourceGroup().id, 'infra')))]",
		"newStorageAccountNodeOs": "[concat('nodeos', uniqueString(concat(resourceGroup().id, 'nodeossa')))]",
		"newStorageAccountNodeData": "[concat('nodedata', uniqueString(concat(resourceGroup().id, 'nodedatasa')))]",
		"newStorageAccountRegistry": "[concat('registry', uniqueString(concat(resourceGroup().id, 'registry')))]",
		"newStorageAccountPersistentVolume1": "[concat('pv1sa', uniqueString(concat(resourceGroup().id, 'persistentvolume1')))]",
		"addressPrefix": "10.0.0.0/8",
		"masterSubnetPrefix": "10.1.0.0/16",
		"nodeSubnetPrefix": "10.2.0.0/16",
		"virtualNetworkName": "openshiftvnet",
		"masterSubnetName": "mastersubnet",
		"nodeSubnetName": "nodesubnet",
		"persistentVolume1Type": "Standard_LRS",

		"masterLoadBalancerName": "[concat(variables('openshiftMasterHostname'), 'lb')]",
		"masterPublicIpAddressId": "[resourceId('Microsoft.Network/publicIPAddresses', parameters('openshiftMasterPublicIpDnsLabel'))]",
		"masterLbId": "[resourceId('Microsoft.Network/loadBalancers', variables('masterLoadBalancerName'))]",
		"masterLbFrontEndConfigId": "[concat(variables('masterLbId'), '/frontendIPConfigurations/loadBalancerFrontEnd')]",
		"masterLbBackendPoolId": "[concat(variables('masterLbId'),'/backendAddressPools/loadBalancerBackend')]",
		"masterLbHttpProbeId": "[concat(variables('masterLbId'),'/probes/httpProbe')]",
		"masterLb8443ProbeId": "[concat(variables('masterLbId'),'/probes/8443Probe')]",

		"infraLoadBalancerName": "[concat(variables('openshiftInfraHostname'), 'lb')]",
		"infraPublicIpAddressId": "[resourceId('Microsoft.Network/publicIPAddresses', parameters('infraLbPublicIpDnsLabel'))]",
		"infraLbId": "[resourceId('Microsoft.Network/loadBalancers', variables('infraLoadBalancerName'))]",
		"infraLbFrontEndConfigId": "[concat(variables('infraLbId'), '/frontendIPConfigurations/loadBalancerFrontEnd')]",
		"infraLbBackendPoolId": "[concat(variables('infraLbId'),'/backendAddressPools/loadBalancerBackend')]",
		"infraLbHttpProbeId": "[concat(variables('infraLbId'),'/probes/httpProbe')]",
		"infraLbHttpsProbeId": "[concat(variables('infraLbId'),'/probes/httpsProbe')]",
		"centos": {
			"publisher": "Openlogic",
			"offer": "CentOS",
			"sku": "7.3",
			"version": "latest"
		},
		"rhel": {
			"publisher": "RedHat",
			"offer": "RHEL",
			"sku": "7.3",
			"version": "latest"
		},
		"singlequote": "'",
		"sshKeyPath": "[concat('/home/', parameters('adminUsername'), '/.ssh/authorized_keys')]",
		"nodePrepScriptUrl": "[concat(parameters('_artifactsLocation'), 'scripts/nodePrep.sh')]",
		"masterPrepScriptUrl": "[concat(parameters('_artifactsLocation'), 'scripts/masterPrep.sh')]",
		"nodePrepScriptFileName": "nodePrep.sh",
		"masterPrepScriptFileName": "masterPrep.sh",
		"clusterNodeDeploymentTemplateUrl": "[concat(parameters('_artifactsLocation'), 'nested/clusternode.json')]",
		"openshiftDeploymentTemplateUrl": "[concat(parameters('_artifactsLocation'), 'nested/openshiftdeploy.json')]",
		"vmSizesMap": {
			"Standard_A4": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_A5": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_A6": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_A7": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_A8": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_A9": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_A10": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_A11": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D1": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D2": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D3": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D4": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D11": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D12": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D13": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D14": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D1_v2": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D2_v2": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D3_v2": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D4_v2": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D5_v2": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D11_v2": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D12_v2": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D13_v2": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_D14_v2": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_G1": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_G2": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_G3": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_G4": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_G5": {
				"storageAccountType": "Standard_LRS"
			},
			"Standard_DS1": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS3": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS4": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS11": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS12": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS13": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS14": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS1_v2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS2_v2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS3_v2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS4_v2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS5_v2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS11_v2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS12_v2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS13_v2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS14_v2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_DS15_v2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_GS1": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_GS2": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_GS3": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_GS4": {
				"storageAccountType": "Premium_LRS"
			},
			"Standard_GS5": {
				"storageAccountType": "Premium_LRS"
			}
		}
	},
	"resources": [
		{
			"apiVersion": "[variables('apiVersionNetwork')]",
			"type": "Microsoft.Network/networkSecurityGroups",
			"name": "[concat(variables('openshiftMasterHostname'), '-nsg')]",
			"location": "[variables('location')]",
			"properties": {
				"securityRules": [{
					"name": "allowSSHin_all",
					"properties": {
						"description": "Allow SSH in from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "22",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 100,
						"direction": "Inbound"
					}
				}, {
					"name": "allowHTTPS_all",
					"properties": {
						"description": "Allow HTTPS connections from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "443",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 200,
						"direction": "Inbound"
					}
				}, {
					"name": "allowOpenShiftConsoleIn_all",
					"properties": {
						"description": "Allow OpenShift Console connections from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "8443",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 300,
						"direction": "Inbound"
					}
				}]
			}
		}, {
			"apiVersion": "[variables('apiVersionNetwork')]",
			"type": "Microsoft.Network/networkSecurityGroups",
			"name": "[concat(variables('openshiftInfraHostname'), '-nsg')]",
			"location": "[variables('location')]",
			"properties": {
				"securityRules": [{
					"name": "allowSSHin_all",
					"properties": {
						"description": "Allow SSH in from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "22",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 100,
						"direction": "Inbound"
					}
				}, {
					"name": "allowHTTPSIn_all",
					"properties": {
						"description": "Allow HTTPS connections from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "443",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 200,
						"direction": "Inbound"
					}
				}, {
					"name": "allowHTTPIn_all",
					"properties": {
						"description": "Allow HTTP connections from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "80",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 300,
						"direction": "Inbound"
					}
				}]
			}
		}, {
			"apiVersion": "[variables('apiVersionNetwork')]",
			"type": "Microsoft.Network/networkSecurityGroups",
			"name": "[concat(variables('openshiftNodeHostname'), '-nsg')]",
			"location": "[variables('location')]",
			"properties": {
				"securityRules": [{
					"name": "allowSSHin_all",
					"properties": {
						"description": "Allow SSH in from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "22",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 100,
						"direction": "Inbound"
					}
				}, {
					"name": "allowHTTPS_all",
					"properties": {
						"description": "Allow HTTPS connections from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "443",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 200,
						"direction": "Inbound"
					}
				}, {
					"name": "allowHTTPIn_all",
					"properties": {
						"description": "Allow HTTP connections from all locations",
						"protocol": "Tcp",
						"sourcePortRange": "*",
						"destinationPortRange": "80",
						"sourceAddressPrefix": "*",
						"destinationAddressPrefix": "*",
						"access": "Allow",
						"priority": 300,
						"direction": "Inbound"
					}
				}]
			}
		}, {
			"type": "Microsoft.Network/virtualNetworks",
			"name": "[variables('virtualNetworkName')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "VirtualNetwork"
			},
			"properties": {
				"addressSpace": {
					"addressPrefixes": [
						"[variables('addressPrefix')]"
					]
				},
				"subnets": [{
					"name": "[variables('masterSubnetName')]",
					"properties": {
						"addressPrefix": "[variables('masterSubnetPrefix')]"
					}
				}, {
					"name": "[variables('nodeSubnetName')]",
					"properties": {
						"addressPrefix": "[variables('nodeSubnetPrefix')]"
					}
				}]
			}
		}, {
			"type": "Microsoft.Storage/storageAccounts",
			"name": "[variables('newStorageAccountMaster')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionStorage')]",
			"tags": {
				"displayName": "MasterStorageAccount"
			},
			"properties": {
				"accountType": "[variables('vmSizesMap')[parameters('masterVmSize')].storageAccountType]"
			}
		}, {
			"type": "Microsoft.Storage/storageAccounts",
			"name": "[variables('newStorageAccountInfra')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionStorage')]",
			"tags": {
				"displayName": "InfraStorageAccount"
			},
			"properties": {
				"accountType": "[variables('vmSizesMap')[parameters('infraVmSize')].storageAccountType]"
			}
		}, {
			"type": "Microsoft.Storage/storageAccounts",
			"name": "[variables('newStorageAccountNodeOs')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionStorage')]",
			"tags": {
				"displayName": "NodeStorageAccount"
			},
			"properties": {
				"accountType": "[variables('vmSizesMap')[parameters('nodeVmSize')].storageAccountType]"
			}
		}, {
			"type": "Microsoft.Storage/storageAccounts",
			"name": "[variables('newStorageAccountNodeData')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionStorage')]",
			"tags": {
				"displayName": "NodeStorageAccount"
			},
			"properties": {
				"accountType": "[variables('vmSizesMap')[parameters('nodeVmSize')].storageAccountType]"
			}
		}, {
			"type": "Microsoft.Storage/storageAccounts",
			"name": "[variables('newStorageAccountRegistry')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionStorage')]",
			"tags": {
				"displayName": "RegistryStorageAccount"
			},
			"properties": {
				"accountType": "Standard_LRS"
			}
		}, {
			"type": "Microsoft.Storage/storageAccounts",
			"name": "[variables('newStorageAccountPersistentVolume1')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionStorage')]",
			"tags": {
				"displayName": "PersistentVolume1StorageAccount"
			},
			"properties": {
				"accountType": "[variables('persistentVolume1Type')]"
			}
		}, {
			"type": "Microsoft.Network/publicIPAddresses",
			"name": "[parameters('infraLbPublicIpDnsLabel')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftInfraLBPublicIP"
			},
			"properties": {
				"publicIPAllocationMethod": "Static",
				"dnsSettings": {
					"domainNameLabel": "[parameters('infraLbPublicIpDnsLabel')]"
				}
			}
		}, {
			"type": "Microsoft.Network/publicIPAddresses",
			"name": "[parameters('openshiftMasterPublicIpDnsLabel')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftMasterPublicIP"
			},
			"properties": {
				"publicIPAllocationMethod": "Static",
				"dnsSettings": {
					"domainNameLabel": "[parameters('openshiftMasterPublicIpDnsLabel')]"
				}
			}
		}, {
			"type": "Microsoft.Compute/availabilitySets",
			"name": "masteravailabilityset",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionCompute')]",
			"properties": {}
		}, {
			"type": "Microsoft.Compute/availabilitySets",
			"name": "infraavailabilityset",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionCompute')]",
			"properties": {}
		}, {
			"type": "Microsoft.Compute/availabilitySets",
			"name": "nodeavailabilityset",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionCompute')]",
			"properties": {}
		}, {
			"type": "Microsoft.Network/loadBalancers",
			"name": "[variables('masterLoadBalancerName')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftMasterLB"
			},
			"dependsOn": [
				"[concat('Microsoft.Network/publicIPAddresses/', parameters('openshiftMasterPublicIpDnsLabel'))]"
			],
			"properties": {
				"frontendIPConfigurations": [{
					"name": "LoadBalancerFrontEnd",
					"properties": {
						"publicIPAddress": {
							"id": "[variables('masterPublicIpAddressId')]"
						}
					}
				}],
				"backendAddressPools": [{
					"name": "loadBalancerBackEnd"
				}],
				"loadBalancingRules": [{
					"name": "OpenShiftAdminConsole",
					"properties": {
						"frontendIPConfiguration": {
							"id": "[variables('masterLbFrontEndConfigId')]"
						},
						"backendAddressPool": {
							"id": "[variables('masterLbBackendPoolId')]"
						},
						"protocol": "Tcp",
						"loadDistribution": "SourceIP",
						"idleTimeoutInMinutes": 30,
						"frontendPort": 8443,
						"backendPort": 8443,
						"probe": {
							"id": "[variables('masterLb8443ProbeId')]"
						}
					}
				}],
				"probes": [{
					"name": "8443Probe",
					"properties": {
						"protocol": "Tcp",
						"port": 8443,
						"intervalInSeconds": 5,
						"numberOfProbes": 2
					}
				}]
			}
		},
		{
			"apiVersion": "[variables('apiVersionNetwork')]",
			"type": "Microsoft.Network/loadBalancers/inboundNatRules",
			"name": "[concat(variables('masterLoadBalancerName'), '/', 'SSH-', variables('openshiftMasterHostname'), copyIndex())]",
			"location": "[variables('location')]",
			"copy": {
				"name": "masterLbLoop",
				"count": "[parameters('masterInstanceCount')]"
			},
			"dependsOn": [
				"[variables('masterLbId')]"
			],
			"properties": {
				"frontendIPConfiguration": {
					"id": "[variables('masterLbFrontEndConfigId')]"
				},
				"protocol": "tcp",
				"frontendPort": "[copyIndex(2200)]",
				"backendPort": 22,
				"enableFloatingIP": false
			}
		},
		{
			"type": "Microsoft.Network/loadBalancers",
			"name": "[variables('infraLoadBalancerName')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftInfraLB"
			},
			"dependsOn": [
				"[concat('Microsoft.Network/publicIPAddresses/', parameters('infraLbPublicIpDnsLabel'))]"
			],
			"properties": {
				"frontendIPConfigurations": [{
					"name": "LoadBalancerFrontEnd",
					"properties": {
						"publicIPAddress": {
							"id": "[variables('infraPublicIpAddressId')]"
						}
					}
				}],
				"backendAddressPools": [{
					"name": "loadBalancerBackEnd"
				}],
				"loadBalancingRules": [{
					"name": "OpenShiftRouterHTTP",
					"properties": {
						"frontendIPConfiguration": {
							"id": "[variables('infraLbFrontEndConfigId')]"
						},
						"backendAddressPool": {
							"id": "[variables('infraLbBackendPoolId')]"
						},
						"protocol": "Tcp",
						"frontendPort": 80,
						"backendPort": 80,
						"probe": {
							"id": "[variables('infraLbHttpProbeId')]"
						}
					}
				}, {
					"name": "OpenShiftRouterHTTPS",
					"properties": {
						"frontendIPConfiguration": {
							"id": "[variables('infraLbFrontEndConfigId')]"
						},
						"backendAddressPool": {
							"id": "[variables('infraLbBackendPoolId')]"
						},
						"protocol": "Tcp",
						"frontendPort": 443,
						"backendPort": 443,
						"probe": {
							"id": "[variables('infraLbHttpsProbeId')]"
						}
					}
				}],
				"probes": [{
					"name": "httpProbe",
					"properties": {
						"protocol": "Tcp",
						"port": 80,
						"intervalInSeconds": 5,
						"numberOfProbes": 2
					}
				}, {
					"name": "httpsProbe",
					"properties": {
						"protocol": "Tcp",
						"port": 443,
						"intervalInSeconds": 5,
						"numberOfProbes": 2
					}
				}]
			}
		}, {
			"type": "Microsoft.Network/networkInterfaces",
			"name": "[concat(variables('openshiftMasterHostname'), '-', copyIndex(), '-nic')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftMasterNetworkInterface"
			},
			"dependsOn": [
				"[concat('Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'))]",
				"[concat('Microsoft.Network/loadBalancers/', variables('masterLoadBalancerName'))]",
				"[concat(variables('masterLbId'), '/inboundNatRules/SSH-', variables('openshiftMasterHostname') ,copyIndex())]",
				"[concat('Microsoft.Network/networkSecurityGroups/', variables('openshiftMasterHostname'), '-nsg')]"
			],
			"copy": {
				"name": "masterNicLoop",
				"count": "[parameters('masterInstanceCount')]"
			},
			"properties": {
				"ipConfigurations": [{
					"name": "[concat(variables('openshiftMasterHostname'), copyIndex(), 'ipconfig')]",
					"properties": {
						"privateIPAllocationMethod": "Dynamic",
						"subnet": {
							"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'), '/subnets/', variables('masterSubnetName'))]"
						},
						"loadBalancerBackendAddressPools": [{
							"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/loadBalancers/', variables('masterLoadBalancerName'), '/backendAddressPools/loadBalancerBackEnd')]"
						}],
						"loadBalancerInboundNatRules": [
							{
								"id": "[concat(variables('masterLbId'),'/inboundNatRules/SSH-', variables('openshiftMasterHostname'), copyIndex())]"
							}
						]
					}
				}],
				"networkSecurityGroup": {
					"id": "[resourceId('Microsoft.Network/networkSecurityGroups', concat(variables('openshiftMasterHostname'), '-nsg'))]"
				}
			}
		}, {
			"type": "Microsoft.Network/networkInterfaces",
			"name": "[concat(variables('openshiftInfraHostname'), '-', copyIndex(), '-nic')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftInfraNetworkInterfaces"
			},
			"dependsOn": [
				"[concat('Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'))]",
				"[concat('Microsoft.Network/loadBalancers/', variables('infraLoadBalancerName'))]",
				"[concat('Microsoft.Network/networkSecurityGroups/', variables('openshiftInfraHostname'), '-nsg')]"
			],
			"copy": {
				"name": "infraNicLoop",
				"count": "[parameters('infraInstanceCount')]"
			},
			"properties": {
				"ipConfigurations": [{
					"name": "[concat(variables('openshiftInfraHostname'), copyIndex(), 'ipconfig')]",
					"properties": {
						"privateIPAllocationMethod": "Dynamic",
						"subnet": {
							"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'), '/subnets/', variables('masterSubnetName'))]"
						},
						"loadBalancerBackendAddressPools": [{
							"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/loadBalancers/', variables('infraLoadBalancerName'), '/backendAddressPools/loadBalancerBackEnd')]"
						}]
					}
				}],
				"networkSecurityGroup": {
					"id": "[resourceId('Microsoft.Network/networkSecurityGroups', concat(variables('openshiftInfraHostname'), '-nsg'))]"
				}
			}
		}, {
			"type": "Microsoft.Network/networkInterfaces",
			"name": "[concat(variables('openshiftNodeHostname'), '-', copyIndex(), '-nic')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionNetwork')]",
			"tags": {
				"displayName": "OpenShiftNodeNetworkInterfaces"
			},
			"dependsOn": [
				"[concat('Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'))]",
				"[concat('Microsoft.Network/networkSecurityGroups/', variables('openshiftNodeHostname'), '-nsg')]"
			],
			"copy": {
				"name": "nodeNicLoop",
				"count": "[parameters('nodeInstanceCount')]"
			},
			"properties": {
				"ipConfigurations": [{
					"name": "[concat(variables('openshiftNodeHostname'), copyIndex(), 'ipconfig')]",
					"properties": {
						"privateIPAllocationMethod": "Dynamic",
						"subnet": {
							"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'), '/subnets/', variables('nodeSubnetName'))]"
						}
					}
				}],
				"networkSecurityGroup": {
					"id": "[resourceId('Microsoft.Network/networkSecurityGroups', concat(variables('openshiftNodeHostname'), '-nsg'))]"
				}
			}
		}, {
			"name": "[concat('masterVmDeployment', copyindex())]",
			"type": "Microsoft.Resources/deployments",
			"apiVersion": "[variables('apiVersionLinkTemplate')]",
			"dependsOn": [
				"[resourceId('Microsoft.Storage/storageAccounts', variables('newStorageAccountMaster'))]",
				"masterNicLoop",
				"masteravailabilityset"
			],
			"copy": {
				"name": "masterVmLoop",
				"count": "[parameters('masterInstanceCount')]"
			},
			"properties": {
				"mode": "Incremental",
				"templateLink": {
					"uri": "[variables('clusterNodeDeploymentTemplateUrl')]",
					"contentVersion": "1.0.0.0"
				},
				"parameters": {
					"location": {
						"value": "[variables('location')]"
					},
					"sshKeyPath": {
						"value": "[variables('sshKeyPath')]"
					},
					"sshPublicKey": {
						"value": "[parameters('sshPublicKey')]"
					},
					"dataDiskSize": {
						"value": "[parameters('dataDiskSize')]"
					},
					"adminUsername": {
						"value": "[parameters('adminUsername')]"
					},
					"vmSize": {
						"value": "[parameters('masterVmSize')]"
					},
					"availabilitySet": {
						"value": "masteravailabilityset"
					},
					"osImage": {
						"value": "[parameters('osImage')]"
					},
					"hostname": {
						"value": "[concat(variables('openshiftMasterHostname'), '-', copyIndex())]"
					},
					"newStorageAccountOs": {
						"value": "[variables('newStorageAccountMaster')]"
					},
					"newStorageAccountData": {
						"value": "[variables('newStorageAccountMaster')]"
					},
					"apiVersionStorage": {
						"value": "[variables('apiVersionStorage')]"
					},
					"apiVersionCompute": {
						"value": "[variables('apiVersionCompute')]"
					}
				}
			}
		}, {
			"name": "[concat('infraVmDeployment', copyindex())]",
			"type": "Microsoft.Resources/deployments",
			"apiVersion": "[variables('apiVersionLinkTemplate')]",
			"dependsOn": [
				"[resourceId('Microsoft.Storage/storageAccounts', variables('newStorageAccountInfra'))]",
				"infraNicLoop",
				"infraavailabilityset"
			],
			"copy": {
				"name": "infraVmLoop",
				"count": "[parameters('infraInstanceCount')]"
			},
			"properties": {
				"mode": "Incremental",
				"templateLink": {
					"uri": "[variables('clusterNodeDeploymentTemplateUrl')]",
					"contentVersion": "1.0.0.0"
				},
				"parameters": {
					"location": {
						"value": "[variables('location')]"
					},
					"sshKeyPath": {
						"value": "[variables('sshKeyPath')]"
					},
					"sshPublicKey": {
						"value": "[parameters('sshPublicKey')]"
					},
					"dataDiskSize": {
						"value": "[parameters('dataDiskSize')]"
					},
					"adminUsername": {
						"value": "[parameters('adminUsername')]"
					},
					"vmSize": {
						"value": "[parameters('infraVmSize')]"
					},
					"availabilitySet": {
						"value": "infraavailabilityset"
					},
					"osImage": {
						"value": "[parameters('osImage')]"
					},
					"hostname": {
						"value": "[concat(variables('openshiftInfraHostname'), '-', copyIndex())]"
					},
					"newStorageAccountOs": {
						"value": "[variables('newStorageAccountInfra')]"
					},
					"newStorageAccountData": {
						"value": "[variables('newStorageAccountInfra')]"
					},
					"apiVersionStorage": {
						"value": "[variables('apiVersionStorage')]"
					},
					"apiVersionCompute": {
						"value": "[variables('apiVersionCompute')]"
					}
				}
			}
		}, {
			"name": "[concat('nodeVmDeployment', copyindex())]",
			"type": "Microsoft.Resources/deployments",
			"apiVersion": "[variables('apiVersionLinkTemplate')]",
			"dependsOn": [
				"[resourceId('Microsoft.Storage/storageAccounts', variables('newStorageAccountNodeOs'))]",
				"[resourceId('Microsoft.Storage/storageAccounts', variables('newStorageAccountNodeData'))]",
				"nodeNicLoop",
				"nodeavailabilityset"
			],
			"copy": {
				"name": "nodeVmLoop",
				"count": "[parameters('nodeInstanceCount')]"
			},
			"properties": {
				"mode": "Incremental",
				"templateLink": {
					"uri": "[variables('clusterNodeDeploymentTemplateUrl')]",
					"contentVersion": "1.0.0.0"
				},
				"parameters": {
					"location": {
						"value": "[variables('location')]"
					},
					"sshKeyPath": {
						"value": "[variables('sshKeyPath')]"
					},
					"sshPublicKey": {
						"value": "[parameters('sshPublicKey')]"
					},
					"dataDiskSize": {
						"value": "[parameters('dataDiskSize')]"
					},
					"adminUsername": {
						"value": "[parameters('adminUsername')]"
					},
					"vmSize": {
						"value": "[parameters('nodeVmSize')]"
					},
					"availabilitySet": {
						"value": "nodeavailabilityset"
					},
					"osImage": {
						"value": "[parameters('osImage')]"
					},
					"hostname": {
						"value": "[concat(variables('openshiftNodeHostname'), '-', copyIndex())]"
					},
					"newStorageAccountOs": {
						"value": "[variables('newStorageAccountNodeOs')]"
					},
					"newStorageAccountData": {
						"value": "[variables('newStorageAccountNodeData')]"
					},
					"apiVersionStorage": {
						"value": "[variables('apiVersionStorage')]"
					},
					"apiVersionCompute": {
						"value": "[variables('apiVersionCompute')]"
					}
				}
			}
		}, {
			"type": "Microsoft.Compute/virtualMachines/extensions",
			"name": "[concat(variables('openshiftMasterHostname'), '-', copyIndex(), '/deployOpenShift')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionCompute')]",
			"tags": {
				"displayName": "PrepMaster"
			},
			"dependsOn": [
				"[concat('masterVmDeployment', copyindex())]"
			],
			"copy": {
				"name": "masterPrepLoop",
				"count": "[parameters('masterInstanceCount')]"
			},
			"properties": {
				"publisher": "Microsoft.Azure.Extensions",
				"type": "CustomScript",
				"typeHandlerVersion": "2.0",
				"autoUpgradeMinorVersion": true,
				"settings": {
					"fileUris": [
						"[variables('masterPrepScriptUrl')]"
					]
				},
				"protectedSettings": {
					"commandToExecute": "[concat('bash ', variables('masterPrepScriptFileName'), ' ', variables('newStorageAccountPersistentVolume1'), ' ', parameters('adminUsername'))]"
				}
			}
		}, {
			"type": "Microsoft.Compute/virtualMachines/extensions",
			"name": "[concat(variables('openshiftInfraHostname'), '-', copyIndex(), '/prepNodes')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionCompute')]",
			"tags": {
				"displayName": "PrepInfra"
			},
			"dependsOn": [
				"[concat('infraVmDeployment', copyindex())]"
			],
			"copy": {
				"name": "infraPrepLoop",
				"count": "[parameters('infraInstanceCount')]"
			},
			"properties": {
				"publisher": "Microsoft.Azure.Extensions",
				"type": "CustomScript",
				"typeHandlerVersion": "2.0",
				"autoUpgradeMinorVersion": true,
				"settings": {
					"fileUris": [
						"[variables('nodePrepScriptUrl')]"
					]
				},
				"protectedSettings": {
					"commandToExecute": "[concat('bash ', variables('nodePrepScriptFileName'))]"
				}
			}
		}, {
			"type": "Microsoft.Compute/virtualMachines/extensions",
			"name": "[concat(variables('openshiftNodeHostname'), '-', copyIndex(), '/prepNodes')]",
			"location": "[variables('location')]",
			"apiVersion": "[variables('apiVersionCompute')]",
			"tags": {
				"displayName": "PrepNodes"
			},
			"dependsOn": [
				"[concat('nodeVmDeployment', copyindex())]"
			],
			"copy": {
				"name": "nodePrepLoop",
				"count": "[parameters('nodeInstanceCount')]"
			},
			"properties": {
				"publisher": "Microsoft.Azure.Extensions",
				"type": "CustomScript",
				"typeHandlerVersion": "2.0",
				"autoUpgradeMinorVersion": true,
				"settings": {
					"fileUris": [
						"[variables('nodePrepScriptUrl')]"
					]
				},
				"protectedSettings": {
					"commandToExecute": "[concat('bash ', variables('nodePrepScriptFileName'))]"
				}
			}
		}, {
			"name": "OpenShiftDeployment",
			"type": "Microsoft.Resources/deployments",
			"apiVersion": "[variables('apiVersionLinkTemplate')]",
			"dependsOn": [
				"[resourceId('Microsoft.Storage/storageAccounts', variables('newStorageAccountPersistentVolume1'))]",
				"[resourceId('Microsoft.Storage/storageAccounts', variables('newStorageAccountRegistry'))]",
				"masterPrepLoop",
				"infraPrepLoop",
				"nodePrepLoop"
			],
			"properties": {
				"mode": "Incremental",
				"templateLink": {
					"uri": "[variables('openshiftDeploymentTemplateUrl')]",
					"contentVersion": "1.0.0.0"
				},
				"parameters": {
					"_artifactsLocation": {
						"value": "[parameters('_artifactsLocation')]"
					},
					"apiVersionCompute": {
						"value": "[variables('apiVersionCompute')]"
					},
					"newStorageAccountRegistry": {
						"value": "[variables('newStorageAccountRegistry')]"
					},
					"newStorageAccountKey": {
						"value": "[listKeys(variables('newStorageAccountRegistry'),'2015-06-15').key1]"
					},
					"newStorageAccountPersistentVolume1": {
						"value": "[variables('newStorageAccountPersistentVolume1')]"
					},
					"newStorageAccountPV1Key": {
						"value": "[listKeys(variables('newStorageAccountPersistentVolume1'),'2015-06-15').key1]"
					},
					"openshiftMasterHostname": {
						"value": "[variables('openshiftMasterHostname')]"
					},
					"openshiftMasterPublicIpFqdn": {
						"value": "[reference(parameters('openshiftMasterPublicIpDnsLabel')).dnsSettings.fqdn]"
					},
					"openshiftMasterPublicIpAddress": {
						"value": "[reference(parameters('openshiftMasterPublicIpDnsLabel')).ipAddress]"
					},
					"openshiftInfraHostname": {
						"value": "[variables('openshiftInfraHostname')]"
					},
					"openshiftNodeHostname": {
						"value": "[variables('openshiftNodeHostname')]"
					},
					"masterInstanceCount": {
						"value": "[parameters('masterInstanceCount')]"
					},
					"infraInstanceCount": {
						"value": "[parameters('infraInstanceCount')]"
					},
					"nodeInstanceCount": {
						"value": "[parameters('nodeInstanceCount')]"
					},
					"adminUsername": {
						"value": "[parameters('adminUsername')]"
					},
					"openshiftPassword": {
						"value": "[parameters('openshiftPassword')]"
					},
					"aadClientId": {
						"value": "[parameters('aadClientId')]"
					},
					"aadClientSecret": {
						"value": "[parameters('aadClientSecret')]"
					},
					"xipioDomain": {
						"value": "[concat(reference(parameters('infraLbPublicIpDnsLabel')).ipAddress, '.xip.io')]"
					},
					"customDomain": {
						"value": "[parameters('defaultSubDomain')]"
					},
					"subDomainChosen": {
						"value": "[concat(parameters('defaultSubDomainType'), 'Domain')]"
					},
					"sshPrivateKey": {
						"reference": {
							"keyvault": {
								"id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', parameters('keyVaultResourceGroup'), '/providers/Microsoft.KeyVault/vaults/', parameters('keyVaultName'))]"
							},
							"secretName": "[parameters('keyVaultSecret')]"
						}
					}
				}
			}
		}
	],
	"outputs": {
		"Openshift Console Url": {
			"type": "string",
			"value": "[concat('https://', reference(parameters('openshiftMasterPublicIpDnsLabel')).dnsSettings.fqdn, ':8443/console')]"
		},
		"Openshift Master SSH": {
			"type": "string",
			"value": "[concat('ssh ', parameters('adminUsername'), '@', reference(parameters('openshiftMasterPublicIpDnsLabel')).dnsSettings.fqdn, ' -p 2200')]"
		},
		"Openshift Infra Load Balancer FQDN": {
			"type": "string",
			"value": "[reference(parameters('infraLbPublicIpDnsLabel')).dnsSettings.fqdn]"
		},
		"Node OS Storage Account Name": {
			"type": "string",
			"value": "[variables('newStorageAccountNodeOs')]"
		},
		"Node Data Storage Account Name": {
			"type": "string",
			"value": "[variables('newStorageAccountNodeData')]"
		},
		"Infra Storage Account Name": {
			"type": "string",
			"value": "[variables('newStorageAccountInfra')]"
		}
	}
}