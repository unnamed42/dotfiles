" YCM cooperates with neco-vim
function! OmnicompleteVimscript( findstart, base ) abort
   let line_prefix = s:get_input()
   if a:findstart
   let ret = necovim#get_complete_position( line_prefix )
   if ret < 0
    return col( '.' ) " default to current
  endif
   return ret
  else
   return necovim#gather_candidates( line_prefix . a:base, a:base )
  endif
 endfunction

function! StatusLineReadOnly()
  return &readonly && &filetype !~# '\v(help|tagbar|vim-plug)' ? 'O' : ''
endfunction

function! StatusLineFilename()
  let s:filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  return s:filename . (&modified ? '+' : '')
endfunction

function! StatusLineModeName()
  return expand('%:t') ==# '__Tagbar__' ? 'Tagbar' :
       \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
       \ &filetype ==# 'vim-plug' ? 'Plugin' :
       \ lightline#mode()
endfunction

function! StatusLineFugitive()
  if exists('*fugitive#head')
      let branch = fugitive#head()
      return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction
