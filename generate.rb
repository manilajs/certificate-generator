#!/usr/bin/env ruby

def slugify(str, salt)
  require 'digest'
  Digest::SHA1.hexdigest(salt + str)
end

def xhtml2pdf(input, output)
  system "xhtml2pdf #{input} #{output} 1>&2"
end

template = File.read('template/index.html')
output = []
salt = "manila-js-003-"

STDIN.read.split("\n").each do |line|
  lname, fname, email, company = line.split(/[,\t]/)

  name = [fname, lname].join(' ')

  slug = slugify(email, salt)
  html = template.gsub('{{ name }}', name)
  out  = "#{slug}.pdf"
  tmp  = "template/_tmp.html"
  File.open(tmp, 'w') { |f| f.write html }

  output << [lname, fname, email, company, out].join("\t")

  xhtml2pdf "template/_tmp.html", "pdf/#{out}"
  File.unlink tmp
end


puts output.join("\n")
