Jekyll Site Menus
=================

This jekyll plugin enables enables you to define site menues within your
`_config.yml` file.

Installation
------------

Place the `site_menus.rb` file into the `_plugins` directory of your Jekyll
site.  If the directory does not exist, create it.

Usage
-----

In your `_config.yml` file for your jekyll site, you can add something like the
following:

    menus:
        main:
        - Home: /
        - Archives: /archives/
        - About: /about/
        side:
        - Categories: /categories/
        - Tags: /tags/

*Notice that you can create multiple menus.*

Now, in your site's layout you can add the tag `{% menu main %}` to place your
*main* menu and `{% menu side %}` to add your *side* menu to your site.

You can also specify a submenus like so:

    menus:
        main:
        - Home: /
        - Art:
            - /art/
            - Archives: /art/archives/
            - About: /art/about/
        - Technology:
            - /technology/
            - Archives: /technology/archives/
            - About: /technology/about/

Keep in mind you'll probably have to modify your layout's CSS to support
submenus.

Contributing
------------

Feel free to fork this project, send me pull requests, and issues through [the
project's github page][project-page].

[project-page]: https://github.com/MrWerewolf/jekyll-site-menus