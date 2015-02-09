WickedPdf.config = {
  #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
  #:layout => "pdf.html",
  exe_path: ENV['RAILS_ENV'] != 'production' ? '/opt/boxen/rbenv/versions/2.1.5/bin/wkhtmltopdf' : '/usr/local/bin/wkhtmltopdf'
}
