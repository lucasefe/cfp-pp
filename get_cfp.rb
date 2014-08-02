# encoding: utf-8
require "google_drive"
require 'highline/import'

password = ask("Enter your password:  ") { |q| q.echo = "x" }
session = GoogleDrive.login("lucasefe@gmail.com", password)

id = "13QBUjc4Oh-E5-th5JH4hitsQ6LX4xN7U0iugo4D1Rnw"

file = session.spreadsheet_by_key(id)

header = <<-H
 <!DOCTYPE html lang='es'>
 <html>
 <head>
  <title>CFP</title>
    <style>
      body { font-family: Helvetica; }
    </style>
  </head>
  <body>
    <h1>CFP</h1>
H
footer = '</body></html>'

output = []
toc = []
i = 0


ws = file.worksheets[0]
ws.rows[1..-1].each do |row|

  toc << "<li><a href='#cfp_#{i}'>#{row[8]}</a></li>"

  output << <<-HTML
    <span id='cfp_#{i}'>
    <h2>#{i + 1} - #{row[8]}<h2/>
    <h3>by #{row[1]}<h3/>
    <h3>Biography</h3><p>#{row[6]}<p/>
    <h3>Abstract</h3></p>#{row[9]}<p/>
    <h3>Why?</h3></p>#{row[10]}<p/>
  HTML
  i += 1
end
ws = file.worksheets[1]
ws.rows[1..-1].each do |row|

  toc << "<li><a href='#cfp_#{i}'>#{row[9]}</a></li>"

  output << <<-HTML
    <span id='cfp_#{i}'>
    <h2>#{i + 1} - #{row[9]}<h2/>
    <h3>by #{row[1]}<h3/>
    <h3>Biography</h3><p>#{row[7]}<p/>
    <h3>Abstract</h3></p>#{row[11]}<p/>
    <h3>Why?</h3></p>#{row[12]}<p/>
  HTML
  i += 1
end
toc = "<ol>" + toc.join + "</ol>"

STDOUT.puts header + toc + output.join("<hr />") + footer
