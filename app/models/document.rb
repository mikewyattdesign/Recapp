class Document < ActiveRecord::Base
  belongs_to :documentable
  has_attached_file :doc
  validates_attachment_content_type :doc, content_type: /\Aapplication\/msword|vnd.openxmlformats-officedocument.wordprocessingml.document|vnd\.ms-excel|vnd\.ms-powerpoint|pdf/
  validates_attachment_presence :doc
end
