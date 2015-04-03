# WickedPdf.config = {
#   #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
#   #:layout => "pdf.html",
#   exe_path: ENV['RAILS_ENV'] == 'production' ? "#{Rails.root}/bin/wkhtmltopdf-amd64" : '/opt/boxen/rbenv/versions/2.1.5/bin/wkhtmltopdf'
# }

if Rails.env.production?
  wkhtmltopdf_path = "#{Rails.root}/bin/wkhtmltopdf-amd64"
else
  wkhtmltopdf_path = "#{Rails.root}/bin/wkhtmltopdf-0.9.9-OS-X.i368"
end

WickedPdf.config = { exe_path: wkhtmltopdf_path, wkhtmltopdf: wkhtmltopdf_path }