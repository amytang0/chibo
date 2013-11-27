class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :search]
  skip_before_filter :verify_authenticity_token, :only => [:vote_up, :vote_down]
  load_and_authorize_resource :except => :create

  def new
    @post = Post.new
    @post.user = current_user
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
#Rails.logger.info("debug: " + current_user.inspect)
    # add the search thing
    @search = Post.search(params[:q])
    @post = @search.result[0]
    if @post.nil?
      return
    end
    if !@post.showBudget 
      @search.sorts = ['numberofpeople desc', 'created_at desc'] if @search.sorts.empty?
    else
      @search.sorts = ['budget asc', 'created_at desc'] if @search.sorts.empty?
    end
  @posts = Kaminari.paginate_array(@search.result).page(params[:page]).per(10)
  end

  def destroy
    Rails.logger.info "Called destroy"
    @post = Post.find(params[:id])
    @post.destroy
    @post.comments.destroy

    redirect_to posts_path
  end

  def create
#@post = Post.new(params[:post].permit(:title, :location, :adtext, :costForFifteen, :costForThirty, :costForFifty ))
  @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params[:post].permit(:title, :location, :adtext, :costForFifteen, :costForThirty, :costForFifty ))
      redirect_to @post
    else
      render 'edit'
    end
  end

  def vote_up
    begin
       Rails.logger.info "\n \n blhhh"+ current_user.inspect+" VOyte \n \n "

    if current_user.nil?
      Rails.logger.info "\n \n VOyte \n \n "
    end
     current_user.vote_exclusively_for(@post = Post.find(params[:id]))
      Rails.logger.info "Voted up"
      render partial: 'votecount', locals: {post: @post} 
      flash[:success] = "You have voted successfully"
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "You have already voted"
      render :nothing => true, :status => 404
    end
  end

  def vote_down
    begin
      current_user.vote_exclusively_against(@post = Post.find(params[:id]))
      render partial: 'votecount', locals: {post: @post} 
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end

#This method gets either numberofpeople or budget
  def update_all
    @posts = Post.all
    puts "PARAMS: ", params.inspect
    if !params[:post][:numberofpeople].nil?
      @posts.each do |post|
        post.numberofpeople = params[:post][:numberofpeople]
        post.budget = calculate_budget_from_people(post)
        post.showBudget = true
        post.save
      end
    else
      @posts.each do |post|
        post.budget = params[:post][:budget]
        post.numberofpeople = calculate_people_from_budget(post)
        post.showBudget = false
        post.save
        end
    end
#puts "Back?", request.referer

    @post = Post.find(params[:id])

    render partial: 'cost_stuff', locals: {post: @post}
#    render partial: 'cost_table', locals: {post: @post}
#  render 'show'
#  render @post
#  redirect_to :back
#  render 'show'

#      render :nothing => true
#    if URI(request.referer).path == '/posts/search'
#      redirect_to :action => "index"
#    else
#      redirect_to :back
#    end
  end

  def search
     puts "hey"
  end

  def calculate_budget_from_people(post)
    @post = post
    if @post.numberofpeople <= 15
      return @post.costOfFifteen * @post.numberofpeople
    elif @post.numberofpeople <= 30
      return @post.costOfThirty * @post.numberofpeople
    else
      return @post.costOfFifty * @post.numberofpeople
    end
  end

  def calculate_people_from_budget(post)
    people = (post.budget/post.costOfFifteen).floor
    if people > 15
      people = (post.budget/post.costOfThirty).floor
    end
    if people > 30
      people = (post.budget/post.costOfFifty).floor
    end
    return people
  end

  private
    def post_params
#params.require(:post).permit(:title, :location, :adtext, :costForFifteen, :costForThirty, :costForFifty)
    params.require(:post).permit!
    end

end
