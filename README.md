Certificate of Attendance generator
===================================

    $ brew install xhtml2pdf

Make pdfs in pdf/, and outputs a slugged csv for Mailchimp

    $ ruby generate.rb < file.csv > out.csv

How to use
----------

1. Make .csv of name,email pairs
2. Run the tool
3. Import the output .csv to Mailchimp (to add the slugs)
4. Put PDFs in Dropbox
5. Make a Mailchimp email campaign using the slugs as mergetags
