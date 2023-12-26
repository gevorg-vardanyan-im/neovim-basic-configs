
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- ================================================================================
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
-- ================================================================================


keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<Esc><Esc>", ":wincmd p<CR>", opts)
--vim.cmd.set('scrolloff=2')
--vim.cmd.set('colorcolumn=80')
vim.cmd([[
    set scrolloff=2
    set colorcolumn=80
    " command history window height
    set cmdwinheight=12
]])

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Down>",     ":resize -2<CR>", opts)
keymap("n", "<C-Up>",       ":resize +2<CR>", opts)
keymap("n", "<C-Left>",     ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>",    ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

vim.cmd([[
    " line or block movement
    " nnoremap <A-j>  :m .+1<CR>==
    nnoremap <A-h>  :m .+1<CR>==
    " nnoremap <A-k>  :m .-2<CR>==
    nnoremap <A-l>  :m .-2<CR>==

    inoremap <A-j>  <Esc>:m .+1<CR>==gi
    inoremap <A-k>  <Esc>:m .-2<CR>==gi

    vnoremap <A-j>  :m '>+1<CR>gv=gv
    vnoremap <A-k>  :m '<-2<CR>gv=gv
]])

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


vim.cmd([[
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=150 }
]])




-- ========================================================================
-- set VIM script related functionality in lua
-- ========================================================================

vim.cmd([[
    " Define an autogroup to open help in a vertical split on the left
    augroup HelpSplit
    autocmd!
    autocmd BufEnter *.txt if &buftype == 'help' | wincmd H | vertical resize 90 | endif
    " set numbers for help pages
    autocmd BufEnter *.txt if &buftype == 'help' | setlocal number | endif
    augroup END
]])


vim.cmd([[
    " turn on the 'UNDO FILE' feature  
    set undofile
    silent !mkdir -p ~/.vim/undo_nvim
    " directory where the undo files will be stored
    set undodir=$HOME/.vim/undo_nvim


    filetype plugin indent on
    syntax on
    set cursorline
    set backspace=indent,eol,start
    set noswapfile
    set incsearch
]])


-- In Insert mode: Use the appropriate number of spaces to insert a
-- <Tab>.  Spaces are used in indents with the '>' and '<' commands and
-- when 'autoindent' is on.  To insert a real tab when 'expandtab' is
-- on, use CTRL-V<Tab>.
vim.cmd('set expandtab')
-- Number of spaces that a <Tab> in the file counts for.
vim.cmd('set tabstop=4')
-- Number of spaces that a <Tab> counts for while performing editing
-- operations, like inserting a <Tab> or using <BS>.
vim.cmd('set softtabstop=4')
-- Number of spaces to use for each step of (auto)indent.
vim.cmd('set shiftwidth=4')
vim.cmd('set autoindent')
vim.cmd('set foldmethod=indent')
vim.cmd('set foldlevel=99')
vim.cmd('set foldignore=')

vim.cmd([[
    " nnoremap <space> za
    nnoremap zm zR
    " Thus we have the following
    " - zM      - folds all
    " - zm      - unfolds all
    " make visible folding column | + / -
    set foldcolumn=auto:1
]])


-- search | highlight
vim.cmd([[
    " Search
    " highlight search result by default and define a keymap to turn on or off
    set hlsearch
    " Press F4 to toggle highlighting on/off, and show current value.
    " :noremap <F4> :set hlsearch? hlsearch!<CR>
    :nnoremap <silent> <F4> :nohlsearch<Bar>:echo<CR>

    set ignorecase
    set smartcase

    " highlight but not jump to the next match
    " nnoremap * :keepjumps normal! mi*`i<CR>
    :nnoremap * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>


    " substitute all occurrences of the word under the cursor
    " use this mapping so that the final /gc is already entered
    " :nnoremap <Leader>s :%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>
    " :nnoremap <Leader>S :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>


    " in BELOW lines
    :nnoremap <Leader>ss :.,$s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>
    " in ALL lines
    :nnoremap <Leader>sa :%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>

    " above block with EXACT match
    :nnoremap <Leader>sS :.,$s/\<<C-r><C-w>\>//gc<Left><Left><Left>
    :nnoremap <Leader>sA :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

]])


-- tabs
vim.cmd([[
    " nnoremap <leader>1  1gt
    " nnoremap <leader>2  2gt
    " nnoremap <leader>3  3gt
    " nnoremap <leader>4  4gt
    " nnoremap <leader>5  5gt
    " nnoremap <leader>6  6gt
    " nnoremap <leader>7  7gt
    " nnoremap <leader>8  6gt
    " nnoremap <leader>9  :tablast<CR>

    " Tab navigation almost like Firefox.
    " --- WARNING ---
    " TAB key should not be used as
    " it is being used in jump next cursor position function
    " nnoremap <tab>        :tabnext<CR>
    " nnoremap <S-tab>         :tabprevious<CR>

    " nnoremap <S-tab>        :tabnext<CR>
    " nnoremap z<tab>         :tabprevious<CR>
    " nnoremap <C-t>        :tabnew<CR>:e .<CR>
    nnoremap <C-t>          :tabnew<CR>
    nnoremap <Alt><Left>    :tabnew<CR>:e .<CR>
    nnoremap Alt<Left>      :tabnew<CR>:e .<CR>

    " keymapping that starts with 't' will interfere basic key-mappings
    " for t(ill) command
    " nnoremap th  :tabfirst<CR>
    " nnoremap tf  :tabfirst<CR>
    " nnoremap tk  :tabnext<CR>
    " nnoremap ty  :tabnext<CR>
    " nnoremap tj  :tabprev<CR>
    " nnoremap tr  :tabprev<CR>
    " nnoremap tl  :tablast<CR>
    " nnoremap tt  :tabedit<Space>
    " nnoremap tn  :tabnext<Space>
    " nnoremap tm  :tabm<Space>
    " nnoremap td  :tabclose<CR>
    " nnoremap tq  :tabclose<CR>
    " nnoremap to  :tabonly<CR>

    " recently viewed tab
    if !exists('g:lasttab')
        let g:lasttab = 1
    endif
    nmap ^ :exe "tabn ".g:lasttab<CR>
    au TabLeave * let g:lasttab = tabpagenr()


    " Duplicate current tab
    nnoremap zd     :tab split<CR>


    " tab relocation
    " nnoremap <leader>tr :tabmove -1<CR>
    " nnoremap <leader>ty :tabmove +1<CR>

    " nnoremap <leader>tt :tabs<CR>

]])


-- reopen last tab
vim.cmd([[
    let g:reopenbuf = expand('%:p')
    function! ReopenLastTabLeave()
      let g:lastbuf = expand('%:p')
      let g:lasttabcount = tabpagenr('$')
    endfunction
    function! ReopenLastTabEnter()
      if tabpagenr('$') < g:lasttabcount
        let g:reopenbuf = g:lastbuf
      endif
    endfunction
    function! ReopenLastTab()
      tabnew
      execute 'buffer' . g:reopenbuf
    endfunction
    augroup ReopenLastTab
      autocmd!
      autocmd TabLeave * call ReopenLastTabLeave()
      autocmd TabEnter * call ReopenLastTabEnter()
    augroup END
    " Tab Restore | TAB UNDO
    nnoremap <leader>tu :call ReopenLastTab()<CR>
]])


-- Close duplicate tabs
vim.cmd([[
    " Close duplicate tabs
    function CloseDuplicateTabs() 
        let cnt = 0
        let i = 1

        let tpbufflst = []
        let dups = []
        let tabpgbufflst = tabpagebuflist(i)
        while type(tabpagebuflist(i)) == 3
            if index(tpbufflst, tabpagebuflist(i)) >= 0
                call add(dups,i)
            else
                call add(tpbufflst, tabpagebuflist(i))
            endif

            let i += 1
            let cnt += 1
        endwhile

        call reverse(dups)

        for tb in dups
            exec "tabclose ".tb
        endfor

    endfunction

    command CloseDupTabs :call CloseDuplicateTabs()
]])




-- yank
vim.cmd([[ 
    " yank from the cursor to the end of line
    map Y   y$
]])

vim.cmd([[
    " Remove a line under cursor in 'insert' mode
    " inoremap <leader>dd    <Esc>ddi
    " inoremap ,dd    <Esc>ddi

    " add an empty line below or above the current line
    nnoremap ,,     o<Esc>k
    nnoremap ,.     O<Esc>j


    " inoremap ,du    <Esc>yyp<C-o>ji

    " inoremap ,u     <Esc>ui


    " tnoremap <c-b> <c-\><c-n>
    tnoremap <Esc><Esc> <C-\><C-n>
]])

-- duplicate a line BELOW current one
vim.cmd([[
    function DuplicateLineBelow() 
        " get current cursor position
        let row = getcurpos()[1]
        let column = getcurpos()[2]
        " echo getcurpos()
        " echo row
        " echo column
        " yank current line and paste it below
        exec "normal yy"
        exec "normal p"
        " move cursor to desired position
        call cursor(row + 1, column)

    endfunction

    command DuplicateLineBelow :call DuplicateLineBelow()
    nnoremap  du        :call DuplicateLineBelow()<CR>
    " inoremap ,du <Esc>  :call DuplicateLineBelow()<CR> i
]])

-- duplicate a line ABOVE current line
vim.cmd([[
    function DuplicateLineAbove() 
        " get current cursor position
        let row = getcurpos()[1]
        let column = getcurpos()[2]
        " yank current line and paste it above
        exec "normal yy"
        exec "normal P"
        " move cursor to desired position
        call cursor(row, column)

    endfunction

    command DuplicateLineAbove :call DuplicateLineAbove()
    nnoremap  dU        :call DuplicateLineAbove()<CR>
    " inoremap ,du <Esc>  :call DuplicateLineAbove()<CR> i
]])




-- close all buffers except the current one
vim.cmd([[
    command! BufOnly execute '%bdelete|edit #|normal `"'
]])



-- yank: advanced
vim.cmd([[
    " yank file name
    " nnoremap <leader>yfp :let @+ = expand("%")<cr>
    " yank full path of file
    " nnoremap <leader>yff :let @+ = expand("%:p")<cr>
]])



-- project insert mode mappings
vim.cmd([[
    " python specific
    inoremap lll logger.info('\n------\n')<Esc>6hi
    inoremap lif logger.info(f'\n{ = }\n')<Esc>7hi
    inoremap limp from core.settings import logger
    " js specific
    inoremap lll console.log('---  :\n', )<Esc>7hi
]])

