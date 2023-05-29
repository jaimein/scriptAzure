#bash script to create a new sql db server instance and sql db  

#Disclaimer: this script is a sample script on how to create an Azure database but uses least restrictive firewall settings for lab purposes. Do not use this script  

#defining a name for the resource group
resourcegroup=dp-300-labresourcegroup

#edit the variable below to provide a unique server name
servername=dp-300-servername22669782a

#edit the variable below to provide the location – azure locations can be listed by typing az account list-locations -o table in the shell command interface
location=eastus

adminuser=sqladmin
password=Pa55w.rdPa55w.rd
firewallrule=dp-300-access

#edit the script to provide a unique database name
labdatabase=dp-300-Adventureworks22669782

#creates a resource group
az group create --name $resourcegroup --location $location

#creates a sql db servername
az sql server create --name $servername --resource-group $resourcegroup --admin-user $adminuser --admin-password $password --location $location

#shows current firewall list
az sql server firewall-rule list --resource-group $resourcegroup --server $servername

#creates a server-based firewall – note – you should restrict the start/end ip range based on your environment
az sql server firewall-rule create --resource-group $resourcegroup --server $servername --name $firewallrule --start-ip-address 0.0.0.0 --end-ip-address 255.255.255.255

#creates a general-purpose SQL database
az sql db create --name $labdatabase --resource-group $resourcegroup --server $servername -e GeneralPurpose --sample-name AdventureWorksLT