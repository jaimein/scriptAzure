# Comprueba si el módulo de Azure PowerShell está instalado
if (-not (Get-Module -ListAvailable -Name Az)) {
    Write-Host "El módulo de Azure PowerShell no está instalado. Iniciando la instalación..."
    
    # Instala el módulo de Azure PowerShell desde el repositorio PSGallery
    try {
        Install-Module -Name Az -AllowClobber -Force -Scope CurrentUser
        Write-Host "El módulo de Azure PowerShell se ha instalado correctamente."
    } catch {
        Write-Host "Error al instalar el módulo de Azure PowerShell: $_"
    }
} else {
    Write-Host "El módulo de Azure PowerShell ya está instalado."
}
