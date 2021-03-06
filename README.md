uPresent
=============

[![Join the chat at https://gitter.im/bobbybee/uPresent](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/bobbybee/uPresent?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

uPresent, pronounced "micro present", is a markdown flavor for writing presentations; uPresent presentations are written in a concise, intuitive syntax and are compiled into beautiful, lightweight HTML.

uPresent compiles [this](https://github.com/bobbybee/uPresent/blob/master/test.up) to [this](http://backtick.town/~alyssa/test.html#slide0).

Usage
=============

uPresent follows standard UNIX philosophy for compiling:

    up [presentation.up] -o [presentation.html]

 where presentation.up is the markdown file and presentation.html is the output file. `-o presentation.html` can be omitted to print to the console.

To install, type `npm install upresent -g`. Prefixing this command with `sudo` may be needed.

Syntax
============
The first line of a uPresent presentation is the name of the presentation, always.

After the title and before the first slide, configuration options can be used. A "+" or "-" symbol will be the first character on the line, and then a configuration option will be specified. At the moment, the only configuration option supported is "bullet transition", although order of the words does not matter. If configuration is being specified, there must be a new line before the list of options and a new line after.

The rest of the presentation consists of a series of slides.

A slide is defined as a slide marker (a bunch of hyphens on their own line), followed by some content.

Within the content, most standard markdown rules apply (single underscores for italics, double asterisks for bold, a pound sign for a header, markdown image syntax, etc.)

Bullet points are created with a single tilde at the beginning of the line, and indented bullet points are created with two tildes.

An example presentation can be found in the `test.up` file.

Publishing
=============

The HTML file generated by `up` will not standalone; by itself, it contains only crudely formatted content. When publishing a uPresent presentation, it is necessary to include the `common.css` and `scripts.js` files in the same directory, and the relevant theme file in the themes/ folder; these files provide themeing and slide navigation features respectively.

However, this layout should only be used for creating the presentation. To actually publish the presentation, use the `-m` flag with the publisher, which will generate a single, standalone HTML file which can be published by itself. In addition, this file is optimized to be smaller and faster than the development layout described in the above paragraph.

Special Thanks
==============

Special thanks to [@hardmath123](http://github.com/hardmath123) for providing a great deal of feedback and design suggestions for the project during its infancy.
