""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" \file      change-insert-normal-command-line-modes-on-mouse.vim
"" \author    SENOO, Ken
"" \copyright CC0
"" \date      Created: 2020-08-30T13:09+09:00
"" \sa        https://senooken.jp/post/2020/09/01/
"" \brief     マウス操作だけで挿入/ノーマル/コマンドラインモードへの遷移方法
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup main
  autocmd!
augroup END

"" mouse
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif has('mouse_urxvt')
    set ttymouse=urxvt
  else
    set ttymouse=xterm2
  endif

  "" Enter insert/normal/Command-line modes from mouse.
  nnoremap <RightMouse><LeftMouse> :
  inoremap <LeftMouse><RightMouse> <ESC>
  autocmd main BufEnter *
    \  if &modifiable
    \|   nnoremap <buffer> <LeftMouse><RightMouse> i
    \| endif
endif
