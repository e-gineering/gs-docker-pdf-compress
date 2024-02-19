# Check arguments
if ($args.Length -ne 3) {
  Write-Host "Usage: $PSCommandPath <PDF Directory> <Input PDF> <Output PDF>"
  exit 1
}

$pdfDir = $args[0]
$inputFile = $args[1]
$outputFile = $args[2]

# Validate PDF directory
if (!(Test-Path -Path $pdfDir -PathType Container)) {
  Write-Host "Error: The specified directory does not exist."
  exit 1
}

# Validate input file
if (!(Test-Path -Path "$pdfDir/$inputFile" -PathType Leaf)) {
  Write-Host "Error: The specified input file does not exist in the given directory."
  exit 1
}

# Run Docker command
docker run --rm -v "${pdfDir}:/data" my-ghostscript -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="/data/$outputFile" "/data/$inputFile"


# Directly after Docker command
if ($LASTEXITCODE -eq 0) {
  Write-Host "PDF conversion successful. Output file located at: $pdfDir/$outputFile"
} else {
  Write-Host "PDF conversion failed."
  exit 1
}
