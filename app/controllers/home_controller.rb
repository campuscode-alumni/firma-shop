class HomeController < SalesAdsController
  before_action :authenticate_user!
  def index
    @sales_ads = current_user.company.sales_ads
  end
end
