# gs-docker-pdf-compress

A simple Docker approach to compressing PDF files.


Build the docker image 

`docker build -t my-ghostscript .`


### Docker run method

Run ghostscript to compress the input file

`docker run --rm -v <absolute path to directory housing input PDF>:/data my-ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=/data/output.pdf /data/<input PDF filename>`

Example:

`docker run --rm -v /home/darrow:/data my-ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=/data/output.pdf /data/eg_website_proof_v2.pdf`

### Script method

Run the `compress-pdf.ps1` or `compress-pdf.sh` files if you want a simpler interface.

`./compress-pdf.sh <directory with input file> input.pdf out.pdf`

`.\compress-pdf.ps1 <directory with input file> input.pdf out.pdf`
