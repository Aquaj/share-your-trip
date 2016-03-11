module ApplicationHelper

  # Based on Rails Helper content_tag
  # Behaves like content_tag in every way
  # but does not build HTML tags around empty block.
  def flexible_content_tag(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
    if block_given?
      options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
      content = capture(&block)
      content_tag_string(name, content, options, escape) if content.present?
    else
      content_tag_string(name, content_or_options_with_block, options, escape)
    end
  end

end
