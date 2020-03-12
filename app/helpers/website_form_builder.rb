class WebsiteFormBuilder < ActionView::Helpers::FormBuilder

  def div_radio_button(method, tag_value, options = {})
    @template.content_tag(:div,
      @template.radio_button(@object_name, method, tag_value, objectify_options(options))
    )
  end

  def block_subunit_validate(method, tag_value)
    objectify_options(options)[:object].subunit == tag_value.to_s
  end

  def website_page_id
    objectify_options(options)[:object].id
  end

  def index_page_validate
    objectify_options(options)[:object].name == '首页' 
  end

  def enclosure_image
    file = objectify_options(options)[:object].file_url
    file.blank? ? 'logo-grey.png' : file
  end

  def logo_image
    file = objectify_options(options)[:object].logo_url
    file.blank? ? 'logo-grey.png' : file
  end
end
