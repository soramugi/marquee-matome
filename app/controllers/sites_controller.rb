class SitesController < ApplicationController
  before_action :require_site, only: [:show, :destroy]

  def index
    @sites = Site.all
  end

  def show
  end

  def new
    if params[:site].blank?
      @site = Site.new
    else
      @site = Site.new(site_params)
      render @site.valid? ? :confirm : :new
    end
  end

  def create
    site = Site.new(site_params)
    if site.save
      redirect_to url_for(action: :show, id: site.id), notice: '作成しました。'
    else
      render :new
    end
  end

  def destroy
    if @site.destroy
      redirect_to user_path(myname), notice: '削除しました。'
    else
      render :show
    end
  end

  private

  def require_site
    @site = Site.find(params[:id])
  end

  def site_params
    params.require(:site).permit(
      :url,
      :title,
    ).merge(user_id: myid)
  end
end
