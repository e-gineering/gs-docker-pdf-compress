#!/bin/bash

# Check for correct argument count
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <PDF Directory> <Input PDF> <Output PDF>"
    exit 1
fi

PDF_DIR=$1
INPUT_FILE=$2
OUTPUT_FILE=$3

# Validate PDF directory
if [ ! -d "$PDF_DIR" ]; then
    echo "Error: The specified directory does not exist."
    exit 1
fi

# Validate input file
if [ ! -f "${PDF_DIR}/${INPUT_FILE}" ]; then
    echo "Error: The specified input file does not exist in the given directory."
    exit 1
fi

# Run Docker command with specified arguments
docker run --rm -v "$PDF_DIR:/data" my-ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="/data/${OUTPUT_FILE}" "/data/${INPUT_FILE}"

if [ $? -eq 0 ]; then
    echo "PDF conversion successful. Output file located at: $PDF_DIR/$OUTPUT_FILE"
else
    echo "PDF conversion failed."
    exit 1
fi