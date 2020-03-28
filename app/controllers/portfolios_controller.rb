class PortfoliosController < ApplicationController
  def index
    @portfolio_items = Portfolio.all
    #you could do @portfolio_items = Portfolio.includes(:author, :skill) if Portfolio was a JOIN table.
  end

  def angular
      @angular_portfolio_items = Portfolio.angular
  end

  def new
    @portfolio_item = Portfolio.new
    3.times { @portfolio_item.technologies.build }
  end

  def create
    @portfolio = Portfolio.new(params.require(:portfolio).permit(:title, :subtitle, :body, technologies_attributes: [:name]))

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
    @portfolio_item = Portfolio.find(params[:id])
  end

  def update
    @portfolio_item = Portfolio.find(params[:id])

    respond_to do |format|
      if @portfolio_item.update(params.require(:portfolio).permit(:title, :subtitle, :body))
        format.html { redirect_to portfolios_path, notice: 'Portfolio was successfully updated.' }
        #format.json { render :show, status: :ok, location: @portfolio_item }
      else
        format.html { render :edit }
        #format.json { render json: @portfolio_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @portfolio_item = Portfolio.find(params[:id])
  end

  def destroy
    #perform the lookup for the record
    @portfolio_item = Portfolio.find(params[:id])

    #destroy/delete the record
    @portfolio_item.destroy

    #redirect to portfolios_url
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio was removed.' }
      #format.json { head :no_content }
    end
  end
end
