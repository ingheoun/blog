class BlogController < ApplicationController
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
