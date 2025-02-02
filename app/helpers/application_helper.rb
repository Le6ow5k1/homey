module ApplicationHelper
  def icon(name, options = {})
    options[:class] = Array(options[:class])
    options[:class] << "icon"

    case name.to_s
    when "arrow-left"
      content_tag :svg, options.merge(fill: "none", viewBox: "0 0 24 24", stroke: "currentColor") do
        tag.path stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M10 19l-7-7m0 0l7-7m-7 7h18"
      end
    end
  end
end
