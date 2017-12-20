Jekyll Slides Plugin
====================
This is a quick and dirty set of plugins for Jekyll allowing to generates slides
with it as I do on my blog. This allow to generate from a single markdown file
things like this: https://ervin.ipsquad.net/slides/talks/ak2015-test-doubles/

In the example above, I'm using Reveal.js as a target but in its current state
the plugin should be able to target any system which uses a list of section tags
as input for the slides.

slides_converter.rb
-------------------
To use it:
 * Add `slides_converter.rb`;
 * Create a file with the `.slides` extension;
 * That's it!

The syntax of the file is Markdown, with a couple of adjustments:
 1. Every time you have a line containing only `***` you are breaking to the
    next slide;
 1. Every time you have a line containing only `___` everything which will
    follow until the slide break will be in the notes of the current slide.

Apart from those two exceptions, the rest of the content is completely Markdown
and will be passed as is to `rdiscount`.

slides_list_tag.rb
------------------
If like me you have a bunch of slide sets, you will want to have them listed
automatically like your blog posts. In that case, you can use this second
plugin. It simply provides a new tag for Liquid named "slides_list".

To use it:
 * Add `slides_list_tag.rb` to your `_plugins` directory;
 * Put your slides in a sub-directory of `/slides` (e.g. `/slides/talks`,
   `/slides/lectures` etc.);
 * Whenever you need to list a subset of slides just use the tag:
   `{% slides_list talks %}`, `{% slides_list lectures %}`.

This way you can for instance produce an index for `/slides` like this:
https://ervin.ipsquad.net/slides

Author
------
Kevin Ottens <ervin@ipsquad.net>
