class BlogController < ApplicationController
	
	before_action :authenticate_user!, only: [:new, :edit, :update, :creation, :destroy]
	before_action :check_admin, except: [:show, :index]
	
	def check_admin
		redirect_to '/blog/index/' if !user_signed_in? || current_user.role != 'admin'
	end
	
	def index
		@msg = "Hello World!"
		@ctgrs = Category.all
		@all_article = Article.all
		
		
		if params[:cat].blank? or params[:cat] == "all"
			@posts = Article.all
		else
			@cat_id = Category.where("name = ?", params[:cat]).first.id
			@posts = Article.where("category_id = ?", @cat_id)
		end
	end
	
	def new
		@ctgrs = Category.all
	end
	
	def create
		@article = Article.new(title: params[:title], content: params[:content])
		@article.save
		
		# update each category's article num 
		@cat_id = params[:category]
		
		# if category is not "all", then increase cat num 1.
		if @cat_id != "0" 
			@cat = Category.find(@cat_id)
			@cat.update(num: @cat.num+1)
		end
		
		redirect_to '/blog/show/' + @article.id.to_s
	end
	
	def show
		@post = Article.find(params[:id])
	end
	
	def edit
		@ctgrs = Category.all
		@post = Article.find(params[:id])
	end
	
	def update
		@post = Article.find(params[:id])
		@post_cat = @post.category_id
		
		# remove article from cat
		if @post_cat != 0
			Category.find(@post_cat).update(num: Category.find(@post_cat).num-1)
		end
		# add article to cat
		if params[:category] != "0"
			Category.find(params[:category]).update(num: Category.find(params[:category]).num+1)
		end
		
		@post.update(title: params[:title], content: params[:content], category_id: params[:category])
		redirect_to '/blog/show/' + @post.id.to_s
	end
	
	def destroy
		@post = Article.find(params[:id])
		@post_cat = @post.category_id
		
		# remove article from cat
		if @post_cat != 0
			Category.find(@post_cat).update(num: Category.find(@post_cat).num-1)
		end
		@post.destroy
		redirect_to '/blog/index/'
	end
	
end
