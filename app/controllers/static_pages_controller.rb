class StaticPagesController < ApplicationController
  layout 'dashboard'
  def index
    @messages = Message.where(approval_status: "approved")
    @promo_avail =  Promo.where("taker_id = ? AND expired_date > ? ", 0, Date.today )
  end
end