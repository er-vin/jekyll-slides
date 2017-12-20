# Copyright (c) 2017 Kevin Ottens <ervin@ipsquad.net>
# This file is licensed to you under the MIT license.
# See the LICENSE file in the project root for more information.

module Jekyll
    require 'rdiscount'
    class SlidesConverter < Converter
        safe true
        priority :low

        def matches(ext)
            ext =~ /slides/i
        end

        def output_ext(ext)
            ".html"
        end

        def convert(content)
            @rdiscount_extensions = @config['rdiscount']['extensions'].map { |e| e.to_sym }

            slides = content.split(/\n\*\*\*?\n/)
            html = ""

            slides.each { |slide|
                (content, notes) = slide.split(/\n___?\n/)

                if content == nil then
                    content = slide
                end

                content += "\n"

                properties = content.slice!(/^@.*?\n/)
                if properties != nil then
                    properties.slice!(/^@/)
                    properties.chomp!

                    html << "\n<section " << properties << ">\n"
                else
                    html << "\n<section>\n"
                end

                rd = RDiscount.new(content, *@rdiscount_extensions)
                html << rd.to_html

                if notes != nil then
                    rd = RDiscount.new(notes, *@rdiscount_extensions)
                    html << "\n<aside class=\"notes\">\n"
                    html << rd.to_html
                    html << "\n</aside>"
                end
                html << "\n</section>\n\n"
            }

            return html
        end
    end
end
