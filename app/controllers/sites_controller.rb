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
    # TODO 作成処理
    redirect_to url_for(action: :index), notice: '作成しました。'
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
end
