module ApplicationHelper

  # application_controllerのtitleに関するメソッド
  def full_title(subtitle)
    @base_title = "ActionBooks"
    if !subtitle.empty?
      "#{subtitle} | #{@base_title}"
    else
      @base_title
    end
  end
end
