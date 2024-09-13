function Invoke-WindowsDefenderScan {
    <#
    .SYNOPSIS
    Realiza un an�lisisde amenazas detectadas.

    .DESCRIPTION
    La funci�n `Invoke-WindowsDefenderScan` inicia un an�lisis r�pido del sistema utilizando Windows Defender y, una vez finalizado, obtiene los resultados de posibles amenazas detectadas. 
    Tambi�n puede usarse para obtener solo los resultados de un an�lisis anterior si se especifica el par�metro `-ScanResultsOnly`.

    .PARAMETER ScanResultsOnly
    Si se proporciona este par�metro, la funci�n no ejecuta un an�lisis, solo obtiene y muestra los resultados de un an�lisis anterior.

    .EXAMPLE
    Invoke-WindowsDefenderScan
    Esto ejecuta un an�lisis r�pido de Windows Defender y muestra los resultados de las amenazas detectadas.

    .EXAMPLE
    Invoke-WindowsDefenderScan -ScanResultsOnly
    Esto muestra �nicamente los resultados del �ltimo an�lisis de Windows Defender, sin realizar un nuevo an�lisis.

    .NOTES
    Esta funci�n requiere que el script sea ejecutado con privilegios de administrador.
    #>

    param (
        [switch]$ScanResultsOnly
    )

    # Verificar permisos de administrador
    If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host "Ejecuta el script como administrador"
        return
    }

    # Funci�n interna para realizar un an�lisis r�pido
    function Run-DefenderScan {
        Write-Host "Iniciando an�lisis r�pido con Windows Defender..."
        Start-MpScan -ScanType QuickScan
        Write-Host "An�lisis completado."
    }

    # Funci�n interna para obtener los �ltimos resultados del an�lisis
    function Get-DefenderScanResults {
        Write-Host "Obteniendo resultados del an�lisis..."
        $scanResults = Get-MpThreatDetection
        if ($scanResults) {
            Write-Host "Se encontraron vulnerabilidades:"
            $scanResults | Format-Table ThreatName, Action, Resources -AutoSize
        } else {
            Write-Host "No se encontraron vulnerabilidades."
        }
    }

    # Si se especifica el par�metro -ScanResultsOnly, solo se obtienen los resultados
    if ($ScanResultsOnly) {
        Get-DefenderScanResults
    } else {
        # Ejecutar el an�lisis
        Run-DefenderScan
        # Obtener los resultados despu�s del an�lisis
        Get-DefenderScanResults
    }
}
