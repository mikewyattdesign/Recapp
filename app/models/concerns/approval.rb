module Approval
  extend ActiveSupport::Concern

  def get_approved_events(obj, user)
      (user.present? && user.is_client?) ? obj.events.approved : obj.events
  end
end