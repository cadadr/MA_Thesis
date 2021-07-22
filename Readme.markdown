# Göktuğ's Master's Thesis

These will be the full sources for my Master's thesis in English Linguistics
at Hacettepe University.

Currently this repository is a stub, I will probably have to wait until
after the defence to publish full sources.

What's already included is the mechanism to build a thesis in PDF form
using

- [hacett-socsci-thesis.cls](https://github.com/cadadr/hacett-socsci-thesis),
- GNU Make,
- Pandoc,
- LaTeXMK,
- LuaLaTeX,
- Perl,
- BibLaTeX,
- Zotero and zotxt.

The basic principle in which this will work is as such:

1. Manuscripts (`$MANUSCRIPTS` in [`Makefile`](./Makefile)) are
   converted to LaTeX with Pandoc;

2. A bibliography file ([`bibliography.bib`](./bibliography.bib)) is
   generated using [`pandoc-zotxt-bib.pl`](./pandoc-zotxt-bib.pl), which
   scans the `*.markdown` manuscripts and prints out a BibTeX database
   (this connects to Zotero through the zotxt extension to fetch BibTeX
   for each key);

2. [`skel.tex`](./skel.tex), which uses `\input` LaTeX command to load
   the `*.tex` files generated from the manuscripts, gets
   built using LaTeXMK, which results in the (re)generation of
   [`manuscript.pdf`](./manuscript.pdf).
