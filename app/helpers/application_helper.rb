module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => "Arf!", :class => "round")
  end

  # Return a title on a per-page basis.
  def title
    base_title = "Jennica & Will"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end