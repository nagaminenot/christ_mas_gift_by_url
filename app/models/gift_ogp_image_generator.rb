class GiftOgpImageGenerator
  include Magick

  attr_reader :gift

  def initialize(gift)
    @gift = gift
  end

  def generate
    gift_slug = @gift.slug
    giver_name = @gift.giver_name
    taker_name = @gift.taker_name
	
    # 背景をassetsからセット
    background_path = Rails.root.join('app', 'assets', 'images', 'background.png')

    # 1200x630 の大きさのベースを作成
    image = Magick::ImageList.new
    image.new_image(1200, 630) do
      self.background_color = '#ffffff'
    end


    # background
    background_image = Magick::Image.from_blob(open(background_path).read).first
    background_image = background_image.resize(1200, 630)
    image.composite!(background_image, Magick::NorthWestGravity, 0, 0, Magick::OverCompositeOp)

    # 文字の設定
    draw = Magick::Draw.new
    draw.gravity = Magick::NorthWestGravity
    draw.font = Rails.root.join('app', 'assets', 'fonts', 'NotoSansCJKjp-Medium.otf').to_s
    draw.fill = '#910000'

    # 文字の書き込み
    if taker_name.present? && giver_name.present?
      draw.pointsize = 50
      draw.annotate(image, 0, 0, 280, 150, "#{taker_name}さんへ" ) {
        self.fill = '#fff'
      }
      draw.annotate(image, 0, 0, 280, 280, "#{giver_name}さんから" ) {
        self.fill = '#fff'
      }
      draw.annotate(image, 0, 0, 280, 410, "X'masプレゼントが届いてます！" ) {
        self.fill = '#fff'
      }
    end

    dist_dir = "#{Rails.root.join('tmp', 'ogp_image')}"
    Dir.mkdir(dist_dir) unless File.exists?(dist_dir)
    dist_path = "#{dist_dir}/#{gift_slug}.png"
    image.write(dist_path)
    dist_path
  end
end