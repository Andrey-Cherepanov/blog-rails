class BlogPostsController < ApplicationController
    before_action :set_blog_post, only: &i[show update destroy edit] # Set the blog post before the show, update, destroy, and edit actions

    def index
        @blog_posts = BlogPost.all
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
    end

    def destroy
    end

    private

    def blog_post_params
        params.require(:blog_post).permit(:title, :body)
    end

    def set_blog_post
        @blog_post = BlogPost.find(params[:id])
    end
end