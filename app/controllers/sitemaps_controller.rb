class SitemapsController < ApplicationController
  def show
    @posts = Article.all #we are generating url's for posts
    respond_to do |format|
     format.xml
    end
  end
end