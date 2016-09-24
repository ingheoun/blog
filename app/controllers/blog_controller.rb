class BlogController < ApplicationController
	
	before_action :authenticate_user!, only: [:new, :edit, :update, :creation, :destroy]
	before_action :check_admin, except: [:show, :index]
	
	def check_admin
		redirect_to '/blog/index/' if !user_signed_in? || current_user.role != 'admin'
	end
	
	def index
		@msg = "Hello World!"
		@posts = Article.all
	end
	def new
		
	end
	
	def create
		@article = Article.new(title: params[:title], content: params[:content])
		@article.save
		redirect_to '/blog/show/' + @article.id.to_s
	end
	
	def show
		@post = Article.find(params[:id])
	end
	
	def edit
		@post = Article.find(params[:id])
	end
	
	def update
		@post = Article.find(params[:id])
		@post.update(title: params[:title], content: params[:content])
		redirect_to '/blog/show/' + @post.id.to_s
	end
	
	def destroy
		@post = Article.find(params[:id])
		@post.destroy
		redirect_to '/blog/index/'
	end
	
end
