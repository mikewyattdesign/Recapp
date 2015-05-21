class GeneratePdfJob < Struct.new(:id, :pdf_type)

  # delayed_job automatically looks for a "perform" method
  def perform
    puts 'perform called'
    # create an instance of ActionView, so we can use the render method outside of a controller
    av = ActionView::Base.new()
    av.view_paths = ApplicationController.view_paths

    # need these in case your view constructs any links or references any helper methods.
    av.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
    end

    if pdf_type == 'Event'
        pdf_html = perform_event
    else
        pdf_html = perform_program
    end
  end

  def perform_event
    EventsController.new().render_PDF(id)
  end

  def perform_program
    ProgramsController.new().render_PDF(id)
  end


  # delayed_job's built-in success callback method
  def success(job)
    # event.update_attribute(:status, 'complete')
    puts 'complete'
  end
end