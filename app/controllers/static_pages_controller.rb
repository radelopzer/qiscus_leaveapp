class StaticPagesController < ApplicationController
  layout 'dashboard'
  def index
    @messages = Message.where(approval_status: "approved")
  end
end