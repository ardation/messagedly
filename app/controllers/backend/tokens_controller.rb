class Backend::TokensController < InheritedResources::Base
  protect_from_forgery
  layout "dashboard"

  respond_to :html, :js

  add_breadcrumb "Home", :root_path

  add_breadcrumb "API Tokens", :tokens_path


  def new
    add_breadcrumb "New", :new_token_path
  end

  def create
    create!(:notice => "Nice job creating that token.") { tokens_path }
  end

  def update
    update!(:notice => "Nice job updating that token.") { tokens_path }
  end


  def destroy
    destroy!(:notice => "Nice job deleting that token.") { tokens_path }
  end

  def show
    @token = Token.find params[:id]
    add_breadcrumb "#{@token.name}", token_path(@token)
  end

  protected

  def begin_of_association_chain
    current_user
  end
end
