module ApplicationHelper
  
  def logo
<<<<<<< HEAD
    image_tag("logo.png", :alt => "Arf!", :class => "round")
=======
    image_tag("jackhq-logo.png", :alt => "Arf!", :class => "round")
>>>>>>> comments
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