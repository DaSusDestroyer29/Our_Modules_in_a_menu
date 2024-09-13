# Importar módulos
Import-Module -Name "C:\Program Files\WindowsPowerShell\Modules\Archivos ocultos\Archivos ocultos.psm1" # Archivos ocultos
Import-Module -Name "C:\Program Files\WindowsPowerShell\Modules\Hashes\Hashes.psm1" # Hashes
Import-Module -Name "C:\Program Files\WindowsPowerShell\Modules\Recursos\Recursos.psm1" # Recursos
Import-Module -Name "C:\Program Files\WindowsPowerShell\Modules\escaneo\escaneo.psm1"  # Escaneo
# Funciones del menú relacionadas a cada módulo
function Menu-NewHashReport {
    Write-Host "Opción seleccionada: Generar reporte de hashes (New-HashReport)"
    New-HashReport
}
function Menu-ArchivosOcultos {
    Write-Host "Opción seleccionada: Obtener archivos en una carpeta (Get-FilesInFolder)"   
    Get-FilesInFolder
}
function Menu-Recursos {
    Write-Host "Uso de recursos; obtiene los procesos del equipo"
    Get-SystemResources
}
function Menu-EscanearWindowsDefender {
    Write-Host "Opción seleccionada: Escanear sistema con Windows Defender (Invoke-WindowsDefenderScan)"
    Invoke-WindowsDefenderScan
}
#Menu
function Mostrar-Menu {
    Clear-Host
    Write-Host "Selecciona una opción:"
    Write-Host "1. Generar reporte de hashes"
    Write-Host "2. Obtener archivos en una carpeta"
    Write-Host "3. Obtener recursos del sistema"
    Write-Host "4. Escanear sistema con Windows Defender"
    Write-Host "5. Salir"
}
#opcion
function Procesar-Opcion {
    param ([int]$opcion)
    switch ($opcion) {
        1 { Menu-NewHashReport }
        2 { Menu-ArchivosOcultos }
        3 { Menu-Recursos }
        4 { Menu-EscanearWindowsDefender }
        5 { Write-Host "Saliendo..." ; exit }
        default { Write-Host "Opción no válida. Intenta de nuevo." }
    }
}
# Ciclo
do {
    Mostrar-Menu
    $opcion = Read-Host "Ingresa tu opción (1-5)"
    Procesar-Opcion -opcion $opcion
    Pause
} while ($true)