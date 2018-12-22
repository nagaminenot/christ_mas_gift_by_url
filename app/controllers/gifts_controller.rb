class GiftsController < ApplicationController
  before_action :set_gift, only: [:show, :edit, :update, :destroy]

  # GET /gifts
  # GET /gifts.json
  # def index
  #   @gifts = Gift.all
  # end

  # GET /gifts/1
  # GET /gifts/1.json
  def show
    gift = Gift.friendly.find(params[:id])
    prepare_meta_tags({
      title: "#{gift.taker_name}さんへだけの、特別なプレゼントが届きました",
      description: "#{gift.giver_name}さんからメッセージ付きのプレゼント",
      og: {
        image: "#{request.protocol}#{request.domain(2)}/uploads/gift_ogp_image/image/#{gift.slug}.png",
        title: "#{gift.taker_name}さんへだけの、特別なプレゼントが届きました",
        description: "#{gift.giver_name}さんからメッセージ付きのプレゼント"
      },
      twitter: {
        title: "#{gift.taker_name}さんへだけの、特別なプレゼントが届きました",
        description: "#{gift.giver_name}さんからメッセージ付きのプレゼント",
        image: "#{request.protocol}#{request.domain(2)}/uploads/gift_ogp_image/image/#{gift.slug}.png",
      }
    })
  end

  def complete
    @gift = Gift.friendly.find(params[:id])
  end

  # GET /gifts/new
  def new
    @gift = Gift.new
  end

  # GET /gifts/1/edit
  def edit
  end

  # POST /gifts
  # POST /gifts.json
  def create
    @gift = Gift.new(gift_params)

    respond_to do |format|
      if @gift.save
        format.html { redirect_to :action => "complete", :id => @gift.slug, notice: 'Gift was successfully created.' }
        format.json { render :complete, status: :created, location: @gift }
      else
        format.html { render :new }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gifts/1
  # PATCH/PUT /gifts/1.json
  def update
    respond_to do |format|
      if @gift.update(gift_params)
        format.html { redirect_to :action => "complete", :id => @gift.slug, notice: 'Gift was successfully  updated.' }
        format.json { render :show, status: :ok, location: @gift }
      else
        format.html { render :edit }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gifts/1
  # DELETE /gifts/1.json
  def destroy
    @gift.destroy
    respond_to do |format|
      format.html { redirect_to gifts_url, notice: 'Gift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift
      @gift = Gift.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_params
      params.require(:gift).permit(:giver_name, :taker_name, :gift_url, :slug, :message)
    end
end
