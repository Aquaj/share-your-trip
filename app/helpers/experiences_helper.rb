module ExperiencesHelper
  def title_category(category)
    if category.is_root?
      category.title
    else
      "#{category.parent_category.title}<br>(#{category.title})".html_safe
    end
  end
end
