param(
    [Parameter(Mandatory=$true)][string]$PdfDirectory,
    [Parameter(Mandatory=$true)][string]$InputFile,
    [Parameter(Mandatory=$true)][string]$OutputFile
)

function Convert-Pdf {
    param (
        [string]$PdfDirectory,
        [string]$InputFile,
        [string]$OutputFile
    )

    # Resolve input file path to an absolute path
    $fullInputFilePath = Resolve-Path -Path $InputFile
    $fullOutputFilePath = Join-Path -Path $PdfDirectory -ChildPath $OutputFile

    # Docker volume mapping requires an absolute path
    if (-not [System.IO.Path]::IsPathRooted($PdfDirectory)) {
        $PdfDirectory = Resolve-Path -Path $PdfDirectory
    }
    
    # Convert directory path to Docker compatible path
    $dockerVolumePath = $PdfDirectory -replace '\\', '/'
    
    # Escape paths for regex
    $escapedPdfDirectory = [regex]::Escape($PdfDirectory)
  
    # Correctly construct Docker-compatible file paths, ensuring the inclusion of a slash between '/data' and the filenames
    $dockerInputFilePath = "/data/" + ($fullInputFilePath -replace $escapedPdfDirectory, '').Replace('\', '/').TrimStart('/')
    $dockerOutputFilePath = "/data/" + ($fullOutputFilePath -replace $escapedPdfDirectory, '').Replace('\', '/').TrimStart('/')

    $dockerCommand = "docker run --rm -v `"$dockerVolumePath`:/data`" my-ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=`"$dockerOutputFilePath`" `"$dockerInputFilePath`""
    Write-Host "Running command: $dockerCommand"
    Invoke-Expression $dockerCommand

    if ($LASTEXITCODE -eq 0) {
        Write-Host "PDF conversion successful. Output file located at: $fullOutputFilePath"
    } else {
        Write-Error "PDF conversion failed."
    }
}

# Execute the function with the provided arguments
Convert-Pdf -PdfDirectory $PdfDirectory -InputFile $InputFile -OutputFile $OutputFile