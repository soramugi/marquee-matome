class SitesController < ApplicationController
  before_filter :authenticate!, only: [:new, :create, :destroy]
  before_action :require_site, only: [:show, :destroy]

  def index
    @sites = Site.all.order('id desc').page(params[:page])
  end

  def show
  end

  def new
    if params[:site].blank?
      @site = Site.new
    else
      @site = Site.new(site_params)
      if @site.valid?
        @site.generate_title
        render :confirm
      else
        render :new
      end
    end
  end

  def create
    site = Site.new(site_params)
    site.generate_title
    if site.save
      redirect_to site_path(site), notice: '作成しました。'
    else
      render :new
    end
  end

  def destroy
    if myid == @site.user_id && @site.destroy
      redirect_to user_path(myname), notice: '削除しました。'
    else
      render :show
    end
  end

  private

  def require_site
    @site = Site.friendly.find(params[:id])
  end

  def site_params
    params.require(:site).permit(
      :url,
    ).merge(user_id: myid)
  end
end
