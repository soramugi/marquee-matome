class SitesController < ApplicationController
  before_action :require_site, only: [:show, :destroy]

  def index
    @sites = Site.all
  end

  def show
  end

  def new
  end

  def create
    site = Site.new(site_params.merge(user_id: myid))
    if site.save
      redirect_to url_for(action: :index), notice: '作成しました。'
    else
      render :new
    end
  end

  def destroy
    if myid == @site.user_id && @site.destroy
      redirect_to url_for(action: :index), notice: '削除しました。'
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
    )
  end
end
