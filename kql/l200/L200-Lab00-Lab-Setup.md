# Lab Setup for Kusto Query

In preparation for the Kusto Query Language lab and Azure Subscription, these steps will allow you to deploy the needed resources in a Resource Group within an Azure Subscription.

## Pre-requisites

For this lab, you will need access to at least one Resource Group within an Azure Subscription with the ability to Create Azure Data Explorer Cluster, Virtual Machine,Virtual Network, and associated sub-resources.


## Tools

For this course, make sure you have these free tools downloaded and available for you during this course:
* [Kusto.Explorer](https://aka.ms/ke) - Desktop tool for Windows for connecting to Kusto clusters and running queries locally.
* [Visual Studio Code (VSCode)](https://code.visualstudio.com/) - Cross-platform, open-source code editor for working with queries and ARM templates

## Steps

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fopsgility%2Flabs-support-public%2Fmaster%2Fkql%2Fcommon%2FKQLSetup.deploy.json)
[![Deploy To Azure US Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fopsgility%2Flabs-support-public%2Fmaster%2Fkql%2Fcommon%2FKQLSetup.deploy.json)
[![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fopsgility%2Flabs-support-public%2Fmaster%2Fkql%2Fcommon%2FKQLSetup.deploy.json)

1. Open [Azure Portal](https://portal.azure.com/)
1. Create a new resource
1. Choose a Template deployment (deploy using custom templates)
1. Choose **Build your own template in the editor**
1. Paste the following code into the editor

    ```json
    {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "databaseNamePrefix": {
                "minLength": 4,
                "maxLength": 18,
                "type": "String",
                "metadata": {
                    "description": "Name of the Azure Data Explorer Cluster. Use only lowercase letters and numbers."
                },
                "defaultValue": "labde"
            },
            "location": {
                "type": "String",
                "metadata": {
                    "description": "The Region of the Azure Data Explorer Cluster."
                },
                "defaultValue": "[resourceGroup().location]"
            },
            "sku": {
                "type": "String",
                "metadata": {
                    "description": "Specifies the Basic sku name"
                },
                "defaultValue": "Dev(No SLA)_Standard_E2a_v4"
            },
            "zones": {
                "type": "Array",
                "metadata": {
                    "description": "The availability zones of the Azure Data Explorer Cluster."
                },
                "defaultValue": [ "1" ]
            },
            "workspaceName": {
                "type": "string",
                "defaultValue": "LabLAWorkspace"
            },
            "virtualNetworkName": {
                "type": "string",
                "defaultValue": "Lab-VNet"
            },
            "addressBase": {
                "type": "string",
                "defaultValue": "10.0.0.0"
            },
            "virtualMachineName": {
                "type": "string",
                "defaultValue": "LabVM"
            },
            "virtualMachineSize": {
                "type": "string",
                "defaultValue": "Standard_B2ms"
            },
            "adminUsername": {
                "type": "string",
                "defaultValue": "labuser"
            },
            "adminPassword": {
                "type": "secureString",
                "defaultValue": "Lab!pass123"
            },
            "autoShutdownStatus": {
                "type": "string",
                "defaultValue": "Enabled"
            },
            "autoShutdownTime": {
                "type": "string",
                "defaultValue": "02:00"
            }
        },
        "variables": {
            "name": "[concat(parameters('databaseNamePrefix'), substring(uniqueString(resourceGroup().id),0,4))]",
            "nsgName": "[concat(parameters('virtualMachineName'),'-nsg')]",
            "nsgId": "[resourceId(resourceGroup().name, 'Microsoft.Network/networkSecurityGroups', variables('nsgName'))]",
            "vnetId": "[resourceId(resourceGroup().name,'Microsoft.Network/virtualNetworks', parameters('virtualNetworkName'))]",
            "subnetRef": "[concat(variables('vnetId'), '/subnets/default')]",
            "nicName": "[concat(parameters('virtualMachineName'),'-nic')]",
            "publicIpName": "[concat(parameters('virtualMachineName'),'-ip')]",
            "domainNameLabel": "[toLower(concat(parameters('virtualMachineName'),substring(uniqueString(resourceGroup().id),0,4)))]"
        },
        "resources": [
            {
                "type": "Microsoft.Kusto/Clusters",
                "apiVersion": "2021-08-27",
                "name": "[variables('name')]",
                "location": "[parameters('location')]",
                "sku":  {
                    "capacity": 1,
                    "name": "[parameters('sku')]",
                    "tier": "Basic"
                },
                "zones": "[parameters('zones')]",
                "identity": {
                    "type": "SystemAssigned"
                },
                "properties": {
                    "enableStreamingIngest": false,
                    "enablePurge": false,
                    "enableDoubleEncryption": false,
                    "trustedExternalTenants": [],
                    "enableAutoStop": true
                }
            },
            {
                "name": "[variables('nicName')]",
                "type": "Microsoft.Network/networkInterfaces",
                "apiVersion": "2021-03-01",
                "location": "[parameters('location')]",
                "dependsOn": [
                    "[concat('Microsoft.Network/networkSecurityGroups/', variables('nsgName'))]",
                    "[concat('Microsoft.Network/virtualNetworks/', parameters('virtualNetworkName'))]",
                    "[concat('Microsoft.Network/publicIpAddresses/', variables('publicIpName'))]"
                ],
                "properties": {
                    "ipConfigurations": [
                        {
                            "name": "ipconfig1",
                            "properties": {
                                "subnet": {
                                    "id": "[variables('subnetRef')]"
                                },
                                "privateIPAllocationMethod": "Dynamic",
                                "publicIpAddress": {
                                    "id": "[resourceId(resourceGroup().name, 'Microsoft.Network/publicIpAddresses', variables('publicIpName'))]"
                                }
                            }
                        }
                    ],
                    "networkSecurityGroup": {
                        "id": "[variables('nsgId')]"
                    }
                }
            },
            {
                "name": "[variables('nsgName')]",
                "type": "Microsoft.Network/networkSecurityGroups",
                "apiVersion": "2019-02-01",
                "location": "[parameters('location')]",
                "properties": {
                    "securityRules": [
                        {
                            "name": "RDP",
                            "properties": {
                                "priority": 300,
                                "protocol": "TCP",
                                "access": "Allow",
                                "direction": "Inbound",
                                "sourceAddressPrefix": "*",
                                "sourcePortRange": "*",
                                "destinationAddressPrefix": "*",
                                "destinationPortRange": "3389"
                            }
                        }
                    ]
                }
            },
            {
                "apiVersion": "2017-03-15-preview",
                "name": "[parameters('workspaceName')]",
                "location": "[parameters('location')]",
                "type": "Microsoft.OperationalInsights/workspaces",
                "properties": {
                    "sku": {
                        "name": "pergb2018"
                    }
                }
            },
            {
                "apiVersion": "2015-11-01-preview",
                "type": "Microsoft.OperationsManagement/solutions",
                "location": "[parameters('location')]",
                "name": "[concat('VMInsights', '(', parameters('workspaceName'), ')')]",
                "properties": {
                    "workspaceResourceId": "[resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspaceName'))]"
                },
                "plan": {
                    "name": "[concat('VMInsights', '(', parameters('workspaceName'), ')')]",
                    "product": "OMSGallery/VMInsights",
                    "promotionCode": "",
                    "publisher": "Microsoft"
                },
                "dependsOn": [
                    "[resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspaceName'))]"
                ]
            },
            {
                "name": "[parameters('virtualNetworkName')]",
                "type": "Microsoft.Network/virtualNetworks",
                "apiVersion": "2020-11-01",
                "location": "[parameters('location')]",
                "properties": {
                    "addressSpace": {
                        "addressPrefixes": [
                            "[concat(parameters('addressBase'), '/20')]"
                        ]
                    },
                    "subnets": [
                        {
                            "name": "default",
                            "properties": {
                                "addressPrefix": "[concat(parameters('addressBase'), '/24')]"
                            }
                        }
                    ]
                }
            },
            {
                "name": "[variables('publicIpName')]",
                "type": "Microsoft.Network/publicIpAddresses",
                "apiVersion": "2019-02-01",
                "location": "[parameters('location')]",
                "properties": {
                    "publicIpAllocationMethod": "Dynamic",
                    "dnsSettings": {
                        "domainNameLabel": "[variables('domainNameLabel')]"
                    }
                },
                "sku": {
                    "name": "Basic"
                }
            },
            {
                "name": "[parameters('virtualMachineName')]",
                "type": "Microsoft.Compute/virtualMachines",
                "apiVersion": "2021-07-01",
                "location": "[parameters('location')]",
                "dependsOn": [
                    "[concat('Microsoft.Network/networkInterfaces/', variables('nicName'))]"
                ],
                "properties": {
                    "hardwareProfile": {
                        "vmSize": "[parameters('virtualMachineSize')]"
                    },
                    "storageProfile": {
                        "osDisk": {
                            "createOption": "fromImage",
                            "managedDisk": {
                                "storageAccountType": "StandardSSD_LRS"
                            }
                        },
                        "imageReference": {
                            "publisher": "MicrosoftWindowsServer",
                            "offer": "WindowsServer",
                            "sku": "2022-datacenter",
                            "version": "latest"
                        }
                    },
                    "networkProfile": {
                        "networkInterfaces": [
                            {
                                "id": "[resourceId('Microsoft.Network/networkInterfaces', variables('nicName'))]"
                            }
                        ]
                    },
                    "osProfile": {
                        "computerName": "[parameters('virtualMachineName')]",
                        "adminUsername": "[parameters('adminUsername')]",
                        "adminPassword": "[parameters('adminPassword')]",
                        "windowsConfiguration": {
                            "enableAutomaticUpdates": true,
                            "provisionVmAgent": true,
                            "patchSettings": {
                                "enableHotpatching": false,
                                "patchMode": "AutomaticByOS"
                            }
                        }
                    },
                    "diagnosticsProfile": {
                        "bootDiagnostics": {
                            "enabled": true
                        }
                    }
                }
            },
            {
                "type": "Microsoft.Compute/virtualMachines/extensions",
                "apiVersion": "2015-06-15",
                "name": "[format('{0}/{1}', parameters('virtualMachineName'), 'OMSExtension')]",
                "location": "[parameters('location')]",
                "properties": {
                    "publisher": "Microsoft.EnterpriseCloud.Monitoring",
                    "type": "MicrosoftMonitoringAgent",
                    "typeHandlerVersion": "1.0",
                    "autoUpgradeMinorVersion": true,
                    "settings": {
                        "workspaceId": "[reference(resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspaceName'))).customerId]"
                    },
                    "protectedSettings": {
                        "workspaceKey": "[listKeys(resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspaceName')),'2015-03-20').primarySharedKey]"
                    }
                },
                "dependsOn": [
                    "[resourceId('Microsoft.Compute/virtualMachines', parameters('virtualMachineName'))]",
                    "[resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspaceName'))]"
                ]
            },
            {
                "type": "Microsoft.Compute/virtualMachines/extensions",
                "apiVersion": "2018-10-01",
                "name": "[format('{0}/{1}', parameters('virtualMachineName'), 'DependencyAgentWindows')]",
                "location": "[parameters('location')]",
                "properties": {
                    "publisher": "Microsoft.Azure.Monitoring.DependencyAgent",
                    "type": "DependencyAgentWindows",
                    "typeHandlerVersion": "9.5",
                    "autoUpgradeMinorVersion": true
                },
                "dependsOn": [
                    "[resourceId('Microsoft.Compute/virtualMachines', parameters('virtualMachineName'))]",
                    "[resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspaceName'))]"
                ]
            },
            {
                "type": "Microsoft.Insights/dataCollectionRules",
                "name": "[concat(parameters('virtualMachineName'),'Microsoft-VMInsights-Health')]",
                "location": "[parameters('location')]",
                "apiVersion": "2019-11-01-preview",
                "properties": {
                    "description": "Data collection rule for VM Insights health.",
                    "dataSources": {
                        "performanceCounters": [
                            {
                                "name": "VMHealthPerfCounters",
                                "streams": [
                                    "Microsoft-Perf"
                                ],
                                "scheduledTransferPeriod": "PT1M",
                                "samplingFrequencyInSeconds": 60,
                                "counterSpecifiers": [
                                    "\\LogicalDisk(*)\\% Free Space",
                                    "\\Memory\\Available Bytes",
                                    "\\Processor(_Total)\\% Processor Time"
                                ]
                            }
                        ],
                        "extensions": [
                            {
                                "name": "Microsoft-VMInsights-Health",
                                "streams": [
                                    "Microsoft-HealthStateChange"
                                ],
                                "extensionName": "HealthExtension",
                                "extensionSettings": {
                                    "schemaVersion": "1.0",
                                    "contentVersion": "",
                                    "healthRuleOverrides": [
                                        {
                                            "scopes": [
                                                "*"
                                            ],
                                            "monitors": [
                                                "root"
                                            ],
                                            "alertConfiguration": {
                                                "isEnabled": true
                                            }
                                        }
                                    ]
                                },
                                "inputDataSources": [
                                    "VMHealthPerfCounters"
                                ]
                            }
                        ]
                    },
                    "destinations": {
                        "logAnalytics": [
                            {
                                "workspaceResourceId": "[resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspaceName'))]",
                                "name": "Microsoft-HealthStateChange-Dest"
                            }
                        ]
                    },
                    "dataFlows": [
                        {
                            "streams": [
                                "Microsoft-HealthStateChange"
                            ],
                            "destinations": [
                                "Microsoft-HealthStateChange-Dest"
                            ]
                        }
                    ]
                }
            },
            {
                "name": "[concat('shutdown-computevm-', parameters('virtualMachineName'))]",
                "type": "Microsoft.DevTestLab/schedules",
                "apiVersion": "2018-09-15",
                "location": "[parameters('location')]",
                "dependsOn": [
                    "[concat('Microsoft.Compute/virtualMachines/', parameters('virtualMachineName'))]"
                ],
                "properties": {
                    "status": "[parameters('autoShutdownStatus')]",
                    "taskType": "ComputeVmShutdownTask",
                    "dailyRecurrence": {
                        "time": "[parameters('autoShutdownTime')]"
                    },
                    "timeZoneId": "UTC",
                    "targetResourceId": "[resourceId('Microsoft.Compute/virtualMachines', parameters('virtualMachineName'))]",
                    "notificationSettings": {
                        "status": "Disabled",
                        "notificationLocale": "en",
                        "timeInMinutes": "30"
                    }
                }
            }
        ],
        "outputs": {
            "adminUsername": {
                "type": "string",
                "value": "[parameters('adminUsername')]"
            },
            "vmDNS": {
                "type": "string",
                "value": "[reference(resourceId('Microsoft.Network/publicIPAddresses', variables('publicIpName'))).dnsSettings.fqdn]"
            }
        }
    }
    ```

1. Press **Save** 
1. Choose your **Resource Group** (or **Create New** if you have permission to)
1. Press **Review + create**
1. Press **Create** to deploy the resources

This will deploy the following resources into the Resource Group to be used in later labs:
* Virtual Machine
* VIrtual Network
* Log Analytics Workspace
* Azure Data Explorer Cluster

### Reference
* [Kusto.Explorer](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/tools/kusto-explorer)
