require "erb"

content = <<-MYHTML
  <html dir="ltr" lang="en">
    <head>
      <title>Page Title</title>
      <link rel="stylesheet" href="Assets/Styles/base.css"></link>
    </head>
    <body>
      <h1>Hello World - <%= Time.now %></h1>
      <p>Using <code>Rack::Static</code></p>
      <img src="Assets/Images/rack-logo.png">
      <script src="Assets/Scripts/test.js"></script>
    </body>
  </html>
MYHTML

use Rack::Static, :urls => ["/Assets"] # http://www.rubydoc.info/github/rack/rack/Rack/Static

run -> env {
  Rack::Response.new(
    ERB.new(content).result
  ) # automatically handles status, Content-Length and Content-Type
}
