# encoding: utf-8
#
# Jekyll site menus.
# https://github.com/MrWerewolf/jekyll-site-menus
#
# Copyright (c) 2012 Ryan Seto <mr.werewolf@gmail.com>
# Licensed under the MIT license (http://www.opensource.org/licenses/mit-license.php)
#
# Place this script into the _plugins directory of your Jekyll site.
#
require 'uri'

module Jekyll
  class SiteMenus < Liquid::Tag
    def initialize(tag_name, menu_name, tokens)
      super
      @menu_name = menu_name.strip!
    end

    def render(context)
      site = context.registers[:site]
      menu = site.config['menus'][@menu_name]
      level = 1

      renderMenu(context, menu, level)
    end

    def renderMenu(context, menu, level)
      indent = "  " * (level - 1)
      output = "#{indent}<ul"

      # Give this menu an id attribute if we're on the first level.
      if (level == 1)
        output += " id=\"#{@menu_name}-menu\""
      end

      output += " class=\"menu level-#{level}\">\n"

      menu.each do | name, value |
        if (value.kind_of? String)
          # Render the menu item
          output += renderMenuItem(context, name, value, level)
        elsif (value.kind_of? Hash)
          # Render the sub-menu
          output += "#{indent}  <li>\n"
          output += renderMenu(context, value, level + 1)
          output += "#{indent}  </li>\n"
        end
      end

      output += "#{indent}</ul>\n"
    end

    def renderMenuItem(context, name, value, level)
      page_url = context.environments.first["page"]["url"]
      uri = URI(value)

      # Figure out if our menu item is currently selected.
      selected = false
      unless (uri.absolute?)
        base_path= uri.path[-1, 1] == '/' ? uri.path : File.dirname(uri.path)
        path_parts = base_path.split('/')
        if (path_parts.size > 0)
          selected = (/^#{base_path}/ =~ page_url) != nil
        elsif (value == '/' and page_url == '/index.html')
          selected = true
        else
          selected = value == page_url
        end
      end

      indent = "  " * level
      output = "#{indent}<li>\n"
      output += "#{indent}  <a href=\"#{URI.escape(value)}\""
      if (selected)
        output += " class=\"selected\""
      end
      output += ">"
      output += name
      output += "</a>\n"
      output += "#{indent}</li>\n"
    end
  end

  Liquid::Template.register_tag('menu', Jekyll::SiteMenus)
end