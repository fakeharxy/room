module WorkHelper
  def markdown_to_html(text)
    Kramdown::Document.new(text, input: 'markdown').to_html
  end
end
