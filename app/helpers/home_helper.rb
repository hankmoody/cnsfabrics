module HomeHelper
  def meta_tag_image
    if @fabrics.empty? || @fabrics.first.image.nil?
      'http://fakeimg.pl/300x250/'
    else
      @fabrics.first.image.url(:thumbnail)
    end
  end
end
