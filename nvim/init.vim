""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                                      " 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: this uses literal ~/$XDG_DATA_HOME dir. fix
call plug#begin('$XDG_DATA_HOME/nvim/plugged')

" nvim lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" coc lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}

" use terminal colors
Plug 'noahfrederick/vim-noctu'

" tim pope plugins
Plug 'tpope/vim-commentary' " gcc
Plug 'tpope/vim-eunuch' " :Rename
Plug 'tpope/vim-fugitive' " :Gread
Plug 'tpope/vim-obsession' " :Obsession
Plug 'tpope/vim-repeat' " .
Plug 'tpope/vim-surround' " ys, ds, cs
Plug 'tpope/vim-vinegar' " - (netrw)
Plug 'tpope/vim-abolish' " :Subvert
Plug 'tpope/vim-projectionist' " :A
Plug 'tpope/vim-dispatch' " :Dispatch

" custom text objects
Plug 'kana/vim-textobj-user' 
Plug 'kana/vim-textobj-line' " [dcy]il, [dcy]al
Plug 'kana/vim-textobj-entire' " [dcy]ie, [dcy]ae
Plug 'michaeljsmith/vim-indent-object' " [dcy]ii, [dcy]ai, [dcy]aI

" sort motion
Plug 'christoomey/vim-sort-motion' " gs[text-obj]

" title case
Plug 'christoomey/vim-titlecase' " gt[text-obj], gT

" replace motions with contents of register
Plug 'vim-scripts/ReplaceWithRegister'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" auto close pairs
Plug 'jiangmiao/auto-pairs'

" close xml tags
Plug 'alvan/vim-closetag'

" for editing tables
Plug 'dhruvasagar/vim-table-mode' " <leader>t[mrt], <leader>tic

" snippets
Plug 'SirVer/ultisnips'

" close buffers without closing window
Plug 'qpkorr/vim-bufkill'

" syntax highligting
Plug 'styled-components/vim-styled-components'
Plug 'jparise/vim-graphql'
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general ux                                                                   " 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fix syntax highlighting issue
autocmd BufEnter * :syntax sync fromstart

" persist undo operations
set undodir=$XDG_DATA_HOME/nvim/undo
set undofile

" place swap files in one place
set directory=$XDG_DATA_HOME/nvim/tmp//

" allow hidden buffers
set nohidden
augroup netrw_buf_hidden_fix
  autocmd!
  autocmd BufWinEnter * if &ft != 'netrw' | set bufhidden=hide | endif
augroup end

" share os clipboard
set clipboard=unnamed

" enable relative line numbering
set number
set relativenumber

" netrw tweaks
let g:netrw_bufsettings='noma nomod nu nobl nowrap ro' " Show line numbers
set wildignore='.DS_Store'

" indentation
filetype plugin indent on
set autoindent
set smartindent
set tabstop=2 " show existing tab with 4 spaces width
set shiftwidth=2 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces

" only display column number in ruler
set rulerformat=%c
set noruler

" used as a delay for swap file writing and some plugins
set updatetime=200

" stop flashes and opening message
set shortmess=atToIOS
set cmdheight=1

" set path operations as recursive
set path+=**
set wildmenu

" search as characters are entered
set incsearch

" highligh searches 
set hlsearch

" <esc> to remove search highlights
nnoremap <silent> <esc> :nohls<return><esc>

" Enable auto close tags with <tag|>
" Skip with <leader>>
let g:closetag_filetypes = 'html,xhtml,typescript.tsx'
let g:closetag_close_shortcut = '<leader>>'

" open :copen window full width
" https://github.com/tpope/vim-dispatch/issues/4#issuecomment-15777035
autocmd filetype qf wincmd J

" configure fzf
set rtp+=/opt/homebrew/opt/fzf
let g:fzf_preview_window = ''

" syntax highligt embedded lua
let g:vimsyn_embed= 'l'

" configure ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" <leader>es edits snippets for current file type
nmap <silent> <leader>es :UltiSnipsEdit<cr>

" <leader>tw toggles wrapping
nmap <silent> <leader>tw :set wrap!<cr>

" <leader>ev edits vimrc
nmap <silent> <leader>ev :e $MYVIMRC<cr>

" gdf deletes fills (from svg)
nmap gdf :%s/fill=".\{-}"\s*<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set up lsp                                                                   " 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <leader>f formats the document
command! -nargs=0 Format :call CocAction('format')
autocmd FileType json,typescript.tsx nmap <silent> <leader>f :Format<cr>

" <s-k> shows hover for word under cursor
nmap <silent> <s-k> :call CocAction('doHover')<cr>

" <c-n> triggers autocomplete
inoremap <silent><expr> <c-n> coc#refresh()

" <c-y> enters first autocomplete
inoremap <expr> <c-y> pumvisible() ? "\<c-y>" : "\<c-x>\<c-o>\<c-y>"

" <space>s lists symbols
nnoremap <silent> <space>s :<c-u>CocFzfList symbols<cr>
let g:coc_fzf_opts=['--layout=reverse']

" function text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" scroll popups with <c-e>, <c-y>
nnoremap <silent><nowait><expr> <c-e> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-e>"
nnoremap <silent><nowait><expr> <c-y> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-y>"

" let g:completion_confirm_key = "\<c-y>"
" nmap <silent> <c-j> <Plug>(coc-diagnostic-next)
" nmap <silent> <c-k> <Plug>(coc-diagnostic-prev)

" typechecking and quickfix nav
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry

nmap <silent><leader>; :Dispatch tsc --noEmit --pretty false<cr>
nmap <silent>]] :Cnext<cr>
nmap <silent>[[ :Cprev<cr>

nmap <silent><leader>' :call ToggleQuickFix()<cr>

" <leader>q fixes current error
nmap <leader>q  <Plug>(coc-fix-current)

lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- require'completion'.on_attach()

  -- vim.api.nvim_set_var('completion_enable_auto_hover', 0)
  -- vim.api.nvim_set_var('completion_enable_auto_signature', 0)
  -- vim.api.nvim_set_var('completion_enable_auto_popup', 0)
  -- vim.api.nvim_set_option('completeopt', 'menuone,noinsert')

  -- buf_set_keymap('i', '<c-n>', '<Plug>(completion_trigger)', { silent=true })

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- mappings
  local opts = { noremap=true, silent=true }
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('i', '<c-o>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts={show_header=false} })<CR>', opts)
  buf_set_keymap('n', '<c-j>', '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts={show_header=false} })<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- and map buffer local keybindings when the language server attaches
local servers = { "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = false,
          signs = false,
          underline = true
        }
      ),
    },
  }
end
EOF


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" theme                                                                        " 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" don't display a character in vertical dividers
set fillchars+=vert:\ 

" enable syntax highlighting
syntax on

" set colorscheme
colorscheme noctu

" theme tweaks
hi CursorLine ctermbg=235 cterm=NONE
hi LineNr ctermfg=240 ctermbg=NONE
hi CursorLineNr ctermfg=8 ctermbg=NONE cterm=NONE
hi StatusLine ctermfg=7 ctermbg=236 cterm=NONE
hi StatusLineNC ctermfg=8 ctermbg=236 cterm=NONE
hi VertSplit ctermfg=5 ctermbg=236 cterm=NONE
hi Type ctermfg=12
hi Search ctermfg=7 ctermbg=236

hi jsxTag ctermbg=NONE 

hi LspDiagnosticsUnderlineError cterm=underline
hi LspDiagnosticsUnderlineWarning cterm=underline
hi LspDiagnosticsUnderlineInformation cterm=underline
hi LspDiagnosticsUnderlineHint cterm=underline

hi LspDiagnosticsFloatingError ctermfg=7 ctermbg=1
hi LspDiagnosticsFloatingWarning ctermfg=0 ctermbg=3
hi LspDiagnosticsFloatingInformation ctermfg=0 ctermbg=3
hi LspDiagnosticsFloatingHint ctermfg=0 ctermbg=3


" Enable highlighting cursor line for active buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" :so $VIMRUNTIME/syntax/hitest.vim

" set filetype=typescript.tsx (required by coc-tsserver)
" set syntax as typescriptreact (for default vim ts syntax)
" set the same for js, jsx, ts, tsx so highlighting is consistent
autocmd BufNewFile,BufRead *.js,*.jsx,*.ts,*.tsx
      \ set filetype=typescript.tsx |
      \ set syntax=typescriptreact


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key bindings                                                                 " 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <leader>lv Reloads vimrc
nnoremap <silent> <leader>lv :source $MYVIMRC<cr>

" [count]<ctrl-h/l> move left/right [count] windows
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" ensure <c-l> works in netrw buffers
augroup netrw_nav_helpers
  autocmd!
  autocmd FileType netrw nnoremap <buffer> <c-l> <c-w>l
augroup END

" close buffer but maintain window layout
nnoremap <c-c> :BD<cr>

" <ctrl-p> shows files in fzf. <ctrl-n> shows open buffers. <alt-p> for rg
let g:AutoPairsShortcutToggle = '' " don't let autopairs take <alt-p>
nnoremap <c-p> :Files<cr>
nnoremap <m-p> :Rg<cr>
nnoremap <c-n> :Buffers<cr>

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! Bdelete call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

nnoremap <leader>b :Bdelete<cr>

" :VG term to vimgrep using rg
command! -nargs=1 VG vimgrep /<args>/gj `rg . -l --hidden`

" <leader>: shows fzf vim command history
nnoremap <leader>: :History:<cr>

" <leader>n to :cnext, <leader>N to :cprev
nnoremap <leader>n :cnext<cr>
nnoremap <leader>N :cprev<cr>

" <leader>v to open a vertical split, select new window
nnoremap <leader>v :vs<cr> <c-w><c-l>

" <leader>A to alternate file in split
nmap <leader>a :A<cr>
nmap <leader>A :vs<cr> <c-w><c-l>:A<cr>

" gp visually selects previously pasted text
nnoremap gp `[v`]

" <leader>\ resets (closes all buffers)
nnoremap <silent> <leader>\ :bufdo bd<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" debug stuff                                                                  " 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" get current syntax stack
function! SynStack()
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
map <leader>S :call SynStack()<CR>

