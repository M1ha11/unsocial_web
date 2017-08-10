require "rails_helper"

RSpec.describe EventsMailer, type: :mailer do
  describe "#follower_mail" do
    let(:reciever) { create(:user) }
    let(:transmitter) { create(:user) }
    let(:mail) { described_class.follower_mail(transmitter, reciever) }

    context "headers" do
      before(:each) { mail }
      it "renders the subject" do
        expect(mail.subject).to eq("#{transmitter.display_name} is now following you")
      end

      it "sends to the right email" do
        expect(mail.to).to eq([reciever.email])
      end

      it "renders the from email" do
        expect(mail.from).to eq(["unsocialweb@example.com"])
      end
    end

    context "body" do
      before(:each) { mail }
      let(:mail_body) { mail.body.raw_source }
      it 'contains recipient first name' do
        expect(mail_body).to match(reciever.first_name)
      end

      it 'contains follower full name' do
        expect(mail_body).to match("#{transmitter.display_name}")
      end
    end

    context "queue options" do
      before(:each) { allow_any_instance_of(EventsMailer).to receive_message_chain(:follower_mail, :deliver_later) }
      let(:queue_count) { 10 }

      it "adds the mail to the queue" do
        queue_count.times { mail.deliver_later }
        expect(enqueued_jobs.last[:job]).to eq(ActionMailer::DeliveryJob)
        expect(enqueued_jobs.count).to eq(queue_count)
      end

      it "do not add the mail to the queue" do
        queue_count.times { mail.deliver_now }
        expect(enqueued_jobs.count).to eq(0)
      end
    end
  end
end
