# Conectamos a Azure

Connect-AzAccount

# Obtener la primera suscripción
$subscription = Get-AzSubscription | Select-Object -First 1

Write-Host "Tu subscripcion es la siguiente" + $subscription

# Obtener la zona regional predeterminada
$region = Get-AzLocation | Select-Object -ExpandProperty Location | Select-Object -First 1

Write-Host "Tu zona  regional por defecto es la siguiente" + $region

# Resto del script
$resourceGroupName = "contoso-rg"
$virtualMachineName = "azureSQLServerVM"
# Actualizamos a la ultima versión, difiere de la guia
$size = "Standard_D2s_v3"

$adminUsername = "sqladmin"
$adminPassword = "pwd!DP300lab01"
$inboundPorts = "3389"

# Seleccionar la suscripción
Set-AzContext -Subscription $subscription.Id

# Crear grupo de recursos
New-AzResourceGroup -Name $resourceGroupName -Location $region

# Crear la máquina virtual
New-AzVM `
  -ResourceGroupName $resourceGroupName `
  -Name $virtualMachineName `
  -Location $region `
  -Size $size `
  -Image "MicrosoftSQLServer:SQL2019-WS2019:SQLDEV" `
  -Credential (New-Object PSCredential -ArgumentList $adminUsername, (ConvertTo-SecureString -String $adminPassword -AsPlainText -Force)) `
  -OpenPorts $inboundPorts `


# Obtener la dirección IP pública de la máquina virtual
$publicIp = Get-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Name "$virtualMachineName-ip"
$publicIpAddress = $publicIp.IpAddress

# Mostrar información de la máquina virtual
Write-Host "La máquina virtual '$virtualMachineName' se ha creado correctamente."
Write-Host "Dirección IP pública: $publicIpAddress"
Write-Host "Nombre de usuario administrador: $adminUsername"
Write-Host "Contraseña: $adminPassword"