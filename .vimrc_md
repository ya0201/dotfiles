" Get string from start (of row) to cursor
function! GetBeforeStr()
  let prev_pos = col('.') - 1
  let before_str = getline('.')[0:prev_pos]
  return before_str
endfunction

" Judge whether editing list or not
function! IsListElem()
    return GetBeforeStr() =~ '^\s*-\s'
endfunction

" Function that extends Tab
function! MarkDownTab()
  if IsListElem()
    return "\<Left>\<Left>\<Tab>\<Right>\<Right>"
  else
    return "\<Tab>"
  endif
endfunction

" Fuction that extends Shift-Tab
function! MarkDownShiftTab()
  if IsListElem() && strlen(GetBeforeStr()) >= 3
    return "\<Left>\<Left>\<BS>\<Right>\<Right>"
  else
    return ""
  endif
endfunction

" Mapping Tab/Shift-Tab to extended one
inoremap <expr> <Tab> MarkDownTab()
inoremap <expr> <S-Tab> MarkDownShiftTab()
