# Iniciar sesión en Azure
Connect-AzAccount

# Obtener la primera suscripción
$subscription = Get-AzSubscription | Select-Object -First 1

# Obtener la zona regional predeterminada
$region = Get-AzLocation | Select-Object -ExpandProperty Location | Select-Object -First 1

# Resto del script
$resourceGroupName = "contoso-rg"
$adminUsername = "sqladmin"
$adminPassword = "pwd!DP300lab01"

# Set server name - the logical server name has to be unique in the system
# $servername = "dp-300-servername-jin"
$serverName = "server-$(Get-Random)"

# The sample database name
$databaseName = "bd-$(Get-Random)"

# The ip address range that you want to allow to access your server
$startIp = "0.0.0.0"
$endIp = "0.0.0.0"

# Seleccionar la suscripción
Set-AzContext -Subscription $subscription.Id

# Crear grupo de recursos
$resourcegroup = New-AzResourceGroup -Name $resourceGroupName -Location $region

$server = New-AzSqlServer `
-ServerName $servername `
-ResourceGroupName $resourceGroupName `
-Location $region `
-SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminUsername, $(ConvertTo-SecureString -String $adminPassword -AsPlainText -Force))

Write-Host "Info del server" + $server

# Create a server firewall rule that allows access from the specified IP range
$serverFirewallRule = New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -FirewallRuleName "AllowedIPs" -StartIpAddress $startIp -EndIpAddress $endIp

# Create a blank database with an S0 performance level
$database = New-AzSqlDatabase  -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -DatabaseName $databaseName `
    -RequestedServiceObjectiveName "Basic" `
    -SampleName "AdventureWorksLT"

    Write-Host "Info de la base de datos" + $database

    # Mostrar información de la máquina virtual
Write-Host "El server sql '$servername' se ha creado correctamente."
Write-Host "La base de datos '$databaseName' se ha creado correctamente."
Write-Host "Nombre de usuario administrador: $adminUsername"
Write-Host "Contraseña: $adminPassword"