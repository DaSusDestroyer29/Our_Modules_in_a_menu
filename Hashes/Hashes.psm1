# Función para generar el reporte de hashes
function New-HashReport {
    <#
    .SYNOPSIS
    Genera un reporte de hashes de los archivos en una carpeta especificada.

    .DESCRIPTION
    La función `New-HashReport` genera un reporte que contiene los hashes de todos los archivos en una carpeta especificada por el usuario.

    .PARAMETER AlgoritmoHash
    El algoritmo de hash a utilizar. Los valores por defecto incluyen "SHA256", "SHA1", "MD5", entre otros.

    .PARAMETER RutaReporte
    La ruta donde se guardará el reporte de hashes. Si no se especifica, se guarda en el directorio del script como "HASH_Reporte.txt".

    .EXAMPLE
    New-HashReport
    Esto generará un reporte con los hashes SHA256 de todos los archivos en la carpeta especificada por el usuario, guardando el resultado en el archivo "HASH_Reporte.txt".

    .EXAMPLE
    New-HashReport -AlgoritmoHash "MD5" -RutaReporte "C:\Reportes\Hashes.txt"
    Esto generará un reporte con los hashes MD5 de todos los archivos en la carpeta especificada, guardando el resultado en "C:\Reportes\Hashes.txt".

    .NOTES
    Esta función forma parte del módulo Hashes.
    #>

    param(
        [string]$AlgoritmoHash = "SHA256",
        [string]$RutaReporte = "$PSScriptRoot\HASH_Reporte.txt"
    )
    # Pedir la ruta de la carpeta al usuario
    $RutaCarpeta = Read-Host "Por favor, introduzca la ruta de la carpeta que desea monitorear"
    # Verificar si la carpeta existe
    if (-Not (Test-Path -Path $RutaCarpeta -PathType Container)) {
        Write-Host "La carpeta especificada no existe. Por favor, verifique la ruta." -ForegroundColor Red
        return
    }
    # Obtener los archivos
    $archivos = Get-ChildItem -Path $RutaCarpeta -File
    #reporte
    foreach ($archivo in $archivos) {
        try {
            $hash = Get-FileHash -Path $archivo.FullName -Algorithm $AlgoritmoHash
            "$($archivo.FullName) $($hash.Hash)" | Out-File -Append -FilePath $RutaReporte
        }
        catch {
            # Manejo de errores
            Write-Host "Error al procesar el archivo $($archivo.FullName): $_" -ForegroundColor Red
        }
    }

    Write-Host "Reporte de hashes generado en: $RutaReporte"
}
