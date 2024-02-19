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

    # Validate PDF directory
    if (-not (Test-Path -Path $PdfDirectory -PathType Container)) {
        Write-Error "Error: The specified directory does not exist."
        return
    }

    $inputFilePath = Join-Path -Path $PdfDirectory -ChildPath $InputFile
    $outputFilePath = Join-Path -Path $PdfDirectory -ChildPath $OutputFile

    # Validate input file
    if (-not (Test-Path -Path $inputFilePath)) {
        Write-Error "Error: The specified input file does not exist in the given directory."
        return
    }

    # Run Docker command with specified arguments
    $dockerCommand = "docker run --rm -v ${PdfDirectory}:/data my-ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=`"/data/${OutputFile}`" `"/data/${InputFile}`""
    Invoke-Expression $dockerCommand

    if ($LASTEXITCODE -eq 0) {
        Write-Host "PDF conversion successful. Output file located at: $outputFilePath"
    }
    else {
        Write-Error "PDF conversion failed."
    }
}

# Execute the function with passed arguments
Convert-Pdf -PdfDirectory $PdfDirectory -InputFile $InputFile -OutputFile $OutputFile