class GeneratePdfJob < Struct.new(:id, :pdf_type)

  # delayed_job automatically looks for a "perform" method
  def perform
    puts 'perform called'
    # create an instance of ActionView, so we can use the render method outside of a controller
    av = ActionView::Base.new()
    av.view_paths = ActionController::Base.view_paths

    # need these in case your view constructs any links or references any helper methods.
    av.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
    end

    if :pdf_type == 'Event'
        pdf_html = perform_event
    else
        pdf_html = perform_program
    end
  end

  def perform_event
    @event = Event.find(:id)
    pdf_html = av.render pdf: "#{@event.id}_#{@event.name}",
                layout: "pdf.html",
                redirect_delay: 200,
                disable_javascript: false,
                show_as_html: params[:debug].present?,
                margin: { top: 65, bottom: 50 },
                header: {
                    html: {template: '/events/header.pdf.erb'}
                },
                footer: {
                    html: {template: "/events/footer.pdf.erb"}
                }

    # use wicked_pdf gem to create PDF from the doc HTML
    doc_pdf = WickedPdf.new.pdf_from_string(pdf_html, :page_size => 'Letter')

    # save PDF to disk
    pdf_path = Rails.root.join('tmp', "#{:id}.pdf")
    File.open(pdf_path, 'wb') do |file|
      file << doc_pdf
    end

    document = Document.create(documentable_type: Event.name, documentable_id: :id)
    document.doc = pdf_path
  end

  def perform_program
    @program = Program.find(:id)
    pdf_html = av.render pdf: "#{@program.id}_#{@program.name}",
                layout: "pdf.html",
                redirect_delay: 200,
                disable_javascript: false,
                show_as_html: params[:debug].present?,
                margin: { top: 65, bottom: 50 },
                header: {
                    html: {template: '/programs/header.pdf.erb'}
                },
                footer: {
                    html: {template: "/programs/footer.pdf.erb"}
                }

    # use wicked_pdf gem to create PDF from the doc HTML
    doc_pdf = WickedPdf.new.pdf_from_string(pdf_html, :page_size => 'Letter')

    # save PDF to disk
    pdf_path = Rails.root.join('tmp', "#{:id}.pdf")
    File.open(pdf_path, 'wb') do |file|
      file << doc_pdf
    end

    document = Document.create(documentable_type: Program.name, documentable_id: :id)
    document.doc = pdf_path
  end


  # delayed_job's built-in success callback method
  def success(job)
    # event.update_attribute(:status, 'complete')
    puts complete
  end
end