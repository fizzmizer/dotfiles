local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end




return {

  s({
    trig="&eq",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \begin{equation}
            <>
        \end{equation}

        <>
      ]],
      { i(1), i(2) }
    )
  ),

   s({
    trig="&enum",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \begin{enumerate}
            \item <>
        \end{enumerate}

        <>
      ]],
      { i(1), i(2) }
    )
  ),

 s({
    trig="&env",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}

        <>
      ]],
      { i(1), i(2), rep(1), i(3) }
    )
  ),



 s({
    trig="&bit",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \begin{itemize}
            \item <>
        \end{itemize}

        <>
      ]],
      { i(1), i(2) }
    )
  ),

 s({
    trig="&qt",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \begin{quote}
            <>
        \end{quote}

        <>
      ]],
      { i(1), i(2) }
    )
  ),

 s({
    trig="&mn",
    snippetType="autosnippet"
    },

    fmta(
      [[
      \begin{minipage}{.48\textwidth}
          <>
      \end{minipage}\hfill
      \begin{minipage}{.48\textwidth}
          <>
      \end{minipage}

      <>
      ]],
      { i(1), i(2), i(3) }
    )
  ),





 s({
    trig="&st",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \vspace{1cm}
        \hfill
        \ding{105}
        \ding{105}
        \ding{105}
        \hfill
        \vspace{1cm}

        <>
      ]],
      { i(1) }
    )
  ),


 s({
    trig="&block",
    snippetType="autosnippet"
    },

    fmta(
      [[

        \begin{exampleblock}{}
          {\large ``<>''}
          \vskip1mm
          \hspace*\fill{\small <>}
        \end{exampleblock}

        <>

      ]],
      { i(1), i(2), i(3) }
    )
  ),




 s({
    trig="&frame",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \begin{frame}
            \frametitle{<>}

            <>


        \end{frame}

        <>
      ]],
      { i(1, 'Title'), i(2), i(3) }
    )
  ),


 s({
    trig="&sec",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \section{<>}


        <>
      ]],
      { i(1, 'Title'), i(2) }
    )
  ),

 s({
    trig="&ssec",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \subsection{<>}


        <>
      ]],
      { i(1, 'Title'), i(2) }
    )
  ),

 s({
    trig="&sssec",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \subsubsection{<>}


        <>
      ]],
      { i(1, 'Title'), i(2) }
    )
  ),

 s({
    trig="&vs",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \vspace{<>}

        <>
      ]],
      { i(1), i(2) }
    )
  ),

 s({
    trig="&v1",
    snippetType="autosnippet"
    },

    fmta(
      [[
        \vspace{1em}

        <>
      ]],
      { i(1) }
    )
  ),




  s({trig="&it", snippetType="autosnippet"},
    fmta(
      "\\textit{<>}<>",
      { d(1, get_visual), i(2) }
    )
  ),

  s({trig="&bf", snippetType="autosnippet"},
    fmta(
      "\\textbf{<>}<>",
      { d(1, get_visual), i(2) }
    )
  ),

  s({trig="&up", snippetType="autosnippet"},
    fmta(
      "\\usepackage{<>}<>",
      { i(1), i(2) }
    )
  ),


  s({trig="&ii", snippetType="autosnippet"},
    fmta(
      "Írisz <>",
      { i(1) }
    )
  ),


  s({trig='&"', snippetType="autosnippet"},
    fmta(
      "«~<>~»<>",
      { d(1, get_visual), i(2) }
    )
  ),


  s({trig="&-", snippetType="autosnippet"},
    fmta(
      "---~<>",
      { i(1) }
    )
  ),


  s({trig="&ac", snippetType="autosnippet"},
    fmta(
      "\\autocite[p.~<>]{<>}<>",
      { d(1, get_visual), i(2), i(3) }
    )
  ),


  s({trig="&tc", snippetType="autosnippet"},
    fmta(
      "\\textcite[p.~<>]{<>}<>",
      { d(1, get_visual), i(2), i(3) }
    )
  ),


}
