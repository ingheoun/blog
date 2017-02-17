class BlogController < ApplicationController
	
	before_action :authenticate_user!, only: [:new, :edit, :update, :creation, :destroy, :write_diary]
	before_action :check_admin, except: [:show, :index, :diary]
	
	def check_admin
		redirect_to '/blog/index/' if !user_signed_in? || current_user.role != 'admin'
	end
	
	def index
		@msg = "Hello World!"
		@ctgrs = Category.order(:id)
		@all_article = Article.order(updated_at: :desc)
		
		
		if params[:cat].blank? or params[:cat] == "all"
			@posts = @all_article.all
		else
			@cat_id = Category.where("name = ?", params[:cat]).first.id
			@posts = @all_article.where("category_id = ?", @cat_id)
		end
	end
	
	def new
		@ctgrs = Category.all
	end
	
	def create
		@article = Article.new(title: params[:title], content: params[:content])
		@article.category_id = params[:category]
		@article.save
		
		# if category is not "all", then increase cat num 1.
		if @article.category_id != "0" 
			@cat = Category.find(@article.category_id)
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
	
	def diary
		if user_signed_in? && current_user.role == 'admin'
			@diaries = Diary.order(date: :desc)
		else
			@diaries =  Diary.where(private: false).order(date: :desc)
		end
	end
	
	def write_diary
		@diary = Diary.new(date: params[:diary][:date], content: params[:diary][:content], private: params[:private])
		@diary.save
		redirect_to '/blog/diary/'
	end
	
		
end
