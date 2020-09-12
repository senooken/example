""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" \file      insert-line-break-in-normal-mode.vim
"" \author    SENOO, Ken
"" \copyright CC0
"" \date      Created: 2020-08-30T11:50+09:00
"" \sa        https://senooken.jp/post/2020/08/30/
"" \brief     VimのノーマルモードでのEnter押下で改行挿入方法
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup main
  autocmd!
augroup END

"" Insert line break by Enter in normal mode
autocmd main BufWinEnter *
  \  if &modifiable
  \|   nnoremap <buffer> <CR> i<CR><ESC>
  \| else
  \|   nunmap <buffer> <CR>
  \| endif
