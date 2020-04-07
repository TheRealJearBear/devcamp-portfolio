class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: [:edit, :show, :update, :destroy]
  skip_before_action :verify_authenticity_token
  layout "portfolio"
  access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit, :sort]}, site_admin: :all

  def index
    @portfolio_items = Portfolio.by_position
    #you could do @portfolio_items = Portfolio.includes(:author, :skill) if Portfolio was a JOIN table.
  end

  def sort
    params[:order].each do |key, value|
      Portfolio.find(value[:id]).update(position: value[:position])
    end

    render nothing: true
    # this above line is simply saying that this sort method doesn't need to render a new view.
  end

  def angular
      @angular_portfolio_items = Portfolio.angular
  end

  def new
    @portfolio_item = Portfolio.new
    3.times { @portfolio_item.technologies.build }
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to portfolios_path, notice: 'Portfolio was successfully created, dawg.' }
        #format.json { render :show, status: :created, location: @portfolio }
      else
        format.html { render :new }
        #format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update


    respond_to do |format|
      if @portfolio_item.update(portfolio_params)
        format.html { redirect_to portfolios_path, notice: 'Portfolio was successfully updated.' }
        #format.json { render :show, status: :ok, location: @portfolio_item }
      else
        format.html { render :edit }
        #format.json { render json: @portfolio_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    #perform the lookup for the record


    #destroy/delete the record
    @portfolio_item.destroy

    #redirect to portfolios_url
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio was removed.' }
      #format.json { head :no_content }
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(
      :title,
      :subtitle,
      :body,
      :main_image,
      :thumb_image,
      technologies_attributes: [:name]
    )
  end

  def set_portfolio_item
    @portfolio_item = Portfolio.find(params[:id])
  end
end
