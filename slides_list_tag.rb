# Copyright (c) 2017 Kevin Ottens <ervin@ipsquad.net>
# This file is licensed to you under the MIT license.
# See the LICENSE file in the project root for more information.

module Jekyll
  class SlidesListTag < Liquid::Tag
    safe = true

    def initialize(tag_name, type, tokens)
      super
      @type = type.chomp.chomp(' ')
    end

    def render(context)
      pages = context.registers[:site].pages
      base_url = context.registers[:site].config["base_url"]

      html = "\n<ul>\n"
      pages.select{|p| p.path.start_with?("slides/#{@type}/")}
           .sort{|p1, p2| p2.data['date'] <=> p1.data['date']}
           .each do |page|
        html << "\t<li><a href=\"#{base_url}#{page.url}\">#{page.data['title']}</a></li>\n"
      end

      html << "</ul>\n"
      html
    end
  end
end

Liquid::Template.register_tag('slides_list', Jekyll::SlidesListTag)
