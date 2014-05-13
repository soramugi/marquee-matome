module ApplicationHelper
  def title text
    content_for :title do
      text + ' - marqueeまとめ'
    end
  end
end
