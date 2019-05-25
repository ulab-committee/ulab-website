# frozen_string_literal: true

module PagesHelper #:nodoc:
  def main_navigation(menu_css, link_tag_css, inactive_link_tag_css, request)
    presenter = MenuPresenter.new Spina::Navigation.find_by(name: 'main'), request
    presenter.menu_css = menu_css
    presenter.link_tag_css = link_tag_css
    presenter.inactive_link_tag_css = inactive_link_tag_css
    presenter.to_html
  end

  def footer_navigation(menu_css, link_tag_css, inactive_link_tag_css, request)
    presenter = MenuPresenter.new Spina::Navigation.find_by(name: 'footer'), request
    presenter.menu_css = menu_css
    presenter.link_tag_css = link_tag_css
    presenter.inactive_link_tag_css = inactive_link_tag_css
    presenter.to_html
  end

  def responsive_image_tag(image, options = {})
    options = options.symbolize_keys
    variant_options = options.delete(:variant)
    factors = [2, 3, 4]
    variants = process_variant_options(image, factors, variant_options)
    options[:srcset] = variants.inject(&:merge)
    image_tag main_app.url_for(image.variant(variant_options)), options
  end

  def process_variant_options(image, factors, variant_options)
    methods = %i[resize_to_limit resize_to_fit resize_to_fill resize_and_pad]
    factors.collect do |factor|
      variant_options.keys.each do |key|
        variant_options[key] = multiply_factor(factor, variant_options[key]) if methods.include? key
      end
      { main_app.url_for(image.variant(variant_options)) => "#{factor}x" }
    end
  end

  def multiply_factor(factor, geometry)
    [(geometry[0]&.* factor), (geometry[1]&.* factor)]
  end
end
