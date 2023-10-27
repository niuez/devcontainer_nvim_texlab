vim.api.nvim_exec([[
let s:paren_hl_on = 0
let s:fth1 = "#87bba5"
hi MatchInnerFunction guifg=s:fth1 guibg=s:bg gui=underline

function Highlight_Matching_Paren()
  if s:paren_hl_on
    match none
    let s:paren_hl_on = 0
  endif
  let pos = getpos('.')
  let [s_lnum, s_col] = searchpairpos('(', '', ')', 'nW', '', 0, 20)
  let [e_lnum, e_col] = searchpairpos('(', '', ')', 'nbW', '', 0, 20)
  call cursor(e_lnum, e_col)
  let [i_lnum, i_col] = searchpos('\i*(', 'cnbW', 0, 20)
  call setpos('.', pos)
  if e_lnum > 0 && e_lnum >= line('w0') && e_lnum <= line('w$')
    if s_lnum > 0 && s_lnum >= line('w0') && s_lnum <= line('w$')
      exe 'match MatchParen /\(\%' . s_lnum . 'l\%' . s_col . 'c'
           \ . '\)\|\(\%>'. (i_lnum - 1) . 'l\%<'. (e_lnum + 1)  . 'l\%>' . (i_col - 1) . 'c.*\%<' . (e_col + 1). 'c\)/'
      let s:paren_hl_on = 1
    else
      exe 'match MatchParen /\(\%>'. (i_lnum - 1) . 'l\%<'. (e_lnum + 1)  . 'l\%>' . (i_col - 1) . 'c.*\%<' . (e_col + 1). 'c\)/'
      let s:paren_hl_on = 1
    endif
  endif
endfunction
]], false)

vim.api.nvim_create_autocmd(
  {'CursorMoved', 'CursorMovedI' },
  {
    pattern = '*',
    command = 'call Highlight_Matching_Paren()',
  }
)
