local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end


return {

  s({
    trig="&init",
    snippetType="autosnippet"
    },

    fmta(
      [[
      // &article - LaTeX style basic article
      // &touying - Beamer equivalent
      ]],
      { }
    )
  ),

  s({trig="&article", snippetType="autosnippet"},
    fmta(
      [[
      #import "@preview/rubber-article:0.4.0": *

      #maketitle(
        title: "Title",
        authors: ("Antoine Brandelet",),
        date: datetime.today().display("[day] [month repr:long] [year]"),
      )

      #show: article.with(
        lang:"en",
        eq-numbering:"(1.1)",
        eq-chapterwise:true,
        text-size:10pt,
        page-numbering: "1",
        page-numbering-align: center,
        heading-numbering: "1.1",
        header-display: false,
        fig-caption-width:70%,
      )

      ]],
      { }
    )
  ),

  s({trig="&touying", snippetType="autosnippet"},
    fmta(
      [[
        #import "@preview/touying:0.6.1": *
        #import themes.simple: *

        #show: simple-theme.with(aspect-ratio: "16-9")
      ]],
      { }
    )
  ),

}
