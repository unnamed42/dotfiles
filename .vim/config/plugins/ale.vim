" ale
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_set_highlights = 1
let g:ale_set_signs = 0
let g:ale_open_list = 1
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%linter%, %severity%] %code: %%s'
let g:ale_cpp_clang_options = '-std=c++14 -Wall -Wextra'
let g:ale_lint_delay = 2000
let g:ale_fixers = {}
let g:ale_linters = {
\ 'c': ['clang'],
\ 'cpp': ['clang'],
\ 'CUDA': ['nvcc'],
\ 'javascript': ['eslint'],
\ 'java': ['javac'],
\ 'css': ['stylelint'],
\ 'HTML': ['HTMLHint'],
\ 'LaTeX': ['lacheck'],
\ 'Markdown': ['proselint'],
\ 'python': ['mypy', 'flake8'],
\}
let g:ale_pattern_options= {
\ '\.min\.js$': {'ale_enabled': 0},
\ '\.min\.css$': {'ale_enabled': 0},
\}

