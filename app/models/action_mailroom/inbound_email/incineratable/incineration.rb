class ActionMailroom::InboundEmail::Incineratable::Incineration
  def initialize(inbound_email)
    @inbound_email = inbound_email
  end

  def run
    @inbound_email.destroy if due? && processed?
  end

  private
    def due?
      @inbound_email.updated_at < ActionMailroom::InboundEmail::Incineratable::INCINERATABLE_AFTER.ago.end_of_day
    end

    def processed?
      @inbound_email.delivered? || @inbound_email.failed?
    end
end
