" vimtex
let g:vimtex_enabled = 1
let g:vimtex_compiler_progname = 'xelatex'
let g:vimtex_compiler_callback_hooks = ['s:StatusHook']
let g:vimtex_mappings_enabled = 0
let g:vimtex_index_hide_line_numbers = 0
let g:vimtex_complete_close_braces = 1
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
" inoremap <silent> __ __<c-r>=UltiSnips#Anon('_{$1}$0', '__', '', 'i')<cr>
" inoremap <silent> ^^ ^^<c-r>=UltiSnips#Anon('^{$1}$0', '^^', '', 'i')<cr>

augroup vimtex_event_1
  au!
  au User VimtexEventQuit     call vimtex#compiler#clean(0)
  au User VimtexEventInitPost call vimtex#compiler#compile()
augroup END

" augroup vimtex_event_2
"     au!
"     au User VimtexEventQuit call CloseViewers()
" augroup END

function! s:StatusHook(status)
  echom a:status
endfunction

" Close viewers on quit
" function! CloseViewers()
"     if executable('xdotool') && exists('b:vimtex')
"                 \ && exists('b:vimtex.viewer') && b:vimtex.viewer.xwin_id > 0
"         call system('xdotool windowclose '. b:vimtex.viewer.xwin_id)
"     endif
" endfunction
