class BlogPostsController < ApplicationController
    before_action :authenticate_user!, except: %i[index show] # Authenticate the user before the actions
    before_action :set_blog_post, only: %i[show update destroy edit] # Set the blog post before the show, update, destroy, and edit actions

    def index
        if user_signed_in?
            @blog_posts = BlogPost.sorted
        else
            @blog_posts = BlogPost.published.sorted
        end
    end

    def show
        @blog_post = BlogPost.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path # Redirect to the root path if the record is not found
    end

    def new
        @blog_post = BlogPost.new
    end

    def create
        @blog_post = BlogPost.new(blog_post_params)
        if @blog_post.save
            redirect_to blog_post_path(@blog_post)
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @blog_post.update(blog_post_params)
            redirect_to @blog_post
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @blog_post.destroy
        redirect_to root_path
    end

    private

    def blog_post_params
        params.require(:blog_post).permit(:title, :body, :published_at)
    end

    def set_blog_post
        @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end
end