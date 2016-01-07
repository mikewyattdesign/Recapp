require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "notify_approver" do
    let(:mail) { UserMailer.notify_approver }

    it "renders the headers" do
      expect(mail.to).to eq(["michaelliu@group360.com"])
      expect(mail.from).to eq(["group360worldwide@group360.com"])
    end

    # it "renders the body" do
    #   expect(mail.body.encoded).to match("Hi")
    # end
  end

end
