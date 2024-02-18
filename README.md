# gs-docker-pdf-compress

A simple Docker approach to compressing PDF files.


Build the docker image 

`docker build -t my-ghostscript .`

Run ghostscript to compress the input file

`docker run --rm -v <absolute path to directory housing input PDF>:/data my-ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=/data/output.pdf /data/<input PDF filename>`

Example:

`docker run --rm -v /home/darrow:/data my-ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=/data/output.pdf /data/eg_website_proof_v2.pdf`
