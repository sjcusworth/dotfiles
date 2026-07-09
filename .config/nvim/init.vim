call plug#begin()

Plug 'preservim/nerdtree'


Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help' "has some functions that will be deprecated in future nvim releases

"Git
Plug 'lewis6991/gitsigns.nvim'

Plug 'dense-analysis/ale' "linting (syntax checking and semantic errors)

"Colourscheme
Plug '~/.config/nvim/plugged/dracula'
" Plug arcticicestudio/nord-vim " If no gui colours
" Plug 'xero/evangelion.nvim', {'branch': 'vim'}

Plug 'vim-airline/vim-airline'  " better statusline
Plug 'lukas-reineke/indent-blankline.nvim' "indentation formatting
" Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neosnippet-snippets'

" Markdown
Plug 'frabjous/knap'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'
Plug 'mzlogin/vim-markdown-toc'

" WebDev
" Plug 'jparise/vim-graphql', {'do': './install.sh', 'for': ['ts']}

" Flutter
Plug 'nvim-lua/plenary.nvim'
Plug 'stevearc/dressing.nvim' " optional for vim.ui.select
Plug 'nvim-flutter/flutter-tools.nvim'

call plug#end()

" filetype plugin on

set termguicolors
" https://realpython.com/vim-and-python-a-match-made-in-heaven/
colorscheme dracula
" colorscheme evangelion
" colorscheme nord " If no gui colours
syntax enable
"syntax on
highlight CmpDocumentation guibg=#1e1e2e guifg=#cdd6f4
highlight CmpDocumentationBorder guibg=#1e1e2e guifg=#89b4f

if system('pgrep -x picom > /dev/null && echo 1 || echo 0') == 1
	highlight Normal guibg=NONE
else
	highlight Normal guibg=#282A36
endif

set guifont=Consolas:h12

set signcolumn=auto:2

set ruler
set colorcolumn=80
set cursorline
highlight ColorColumn guibg=NvimDarkGray3
hi Normal ctermbg=none
set hlsearch
set showmatch
set cmdheight=2

set mouse=a

set encoding=utf-8

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set breakindent

set nu

autocmd StdinReadPre * let s:std_in=1

let g:NERDTreeWinSize=20
autocmd VimEnter * NERDTree

"Autoclose preview window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Enable folding
set foldlevel=99
set foldmethod=manual
set foldcolumn=1 

set backspace=indent,eol,start  " more powerful backspacing

set clipboard+=unnamedplus

" Remove trailing white space
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre *.py :call TrimWhiteSpace()

" See for Zotero setup: https://github.com/odkr/pandoc-zotxt.lua?tab=readme-ov-file
let g:knap_settings = {
    \ "mdoutputext": "pdf", 
	\ "mdtopdf": "pandoc --pdf-engine=xelatex -L pandoc-zotxt.lua -C %docroot% -o %outputfile%",
	\ "mdtopdfviewerlaunch": "sioyek %outputfile%",
	\ "mdtopdfviewerrefresh": "none",
\ }

""""""""""""""""""
" KNAP functions "
""""""""""""""""""
" F5 processes the document once, and refreshes the view "
inoremap <silent> <F5> <C-o>:lua require("knap").process_once()<CR>
vnoremap <silent> <F5> <C-c>:lua require("knap").process_once()<CR>
nnoremap <silent> <F5> :lua require("knap").process_once()<CR>

" F6 closes the viewer application, and allows settings to be reset "
inoremap <silent> <F6> <C-o>:lua require("knap").close_viewer()<CR>
vnoremap <silent> <F6> <C-c>:lua require("knap").close_viewer()<CR>
nnoremap <silent> <F6> :lua require("knap").close_viewer()<CR>

" F7 toggles the auto-processing on and off "
inoremap <silent> <F7> <C-o>:lua require("knap").toggle_autopreviewing()<CR>
vnoremap <silent> <F7> <C-c>:lua require("knap").toggle_autopreviewing()<CR>
nnoremap <silent> <F7> :lua require("knap").toggle_autopreviewing()<CR>

" F8 invokes a SyncTeX forward search, or similar, where appropriate "
inoremap <silent> <F8> <C-o>:lua require("knap").forward_jump()<CR>
vnoremap <silent> <F8> <C-c>:lua require("knap").forward_jump()<CR>
nnoremap <silent> <F8> :lua require("knap").forward_jump()<CR>

au BufNewFile,BufRead *.md
	\ set fileformat=unix |
	\ set foldmethod=indent

au BufNewFile,BufRead *.zsh, *.sh
	\ set fileformat=unix |
	\ set foldmethod=indent


"au BufNewFile,BufRead *.js, *.html, *.css
"    \ set tabstop=2 |
"    \ set softtabstop=2 |
"    \ set shiftwidth=2 | 
"    \ set nu

au BufNewFile,BufRead *.py
	\ set fileformat=unix |
	\ set foldmethod=indent

" Ale
let g:ale_enabled = 1
let g:ale_disable_lsp = 1
let g:ale_python_auto_virtualenv = 1
let g:ale_use_neovim_diagnostics_api = 0
let g:ale_linters_explicit = 1
let g:ale_linters = {'python': ['mypy', 'pylint', 'flake8'], '*': ['all']}
let g:ale_fixers = {'*': []}
"let g:ale_lsp_suggestions = 1
let g:ale_virtualtext_cursor = 'current'
let g:ale_fix_on_save = 0
let g:ale_completion_autoimport = 0
let g:ale_completion_enabled = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
"let g:ale_lsp_show_message_severity = 'error'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_set_highlights = 0
"let g:ale_sign_priority = 30
" Write this in your vimrc file
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1
let g:ale_sign_column_always = 1

let python_highlight_all=1

lua << EOF
	-- Set up nvim-cmp.
	local cmp = require'cmp'

	cmp.setup({
        --snippet = {
        --  -- REQUIRED - you must specify a snippet engine
        --  expand = function(args)
        --	vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        --	-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        --	-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        --	-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        --	-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    --
    --		-- For `mini.snippets` users:
    --		-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
    --		-- insert({ body = args.body }) -- Insert at cursor
    --		-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
    --		-- require("cmp.config").set_onetime({ sources = {} })
    --	  end,
    --	},
        window = {
            completion = cmp.config.window.bordered({
                winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
            }),
            documentation = cmp.config.window.bordered({
                winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
            })
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping(function()
                vim.lsp.buf.signature_help()
            end, { "i", "c" }),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then 
                    cmp.select_next_item() 
                --elseif luasnip.expand_or_jumpable() then 
                --    luasnip.expand_or_jump() 
                --elseif has_words_before() then 
                --    cmp.complete() 
                else 
                    fallback() 
                    end 
            end, { "i", "s" }),
            ["<s-Tab>"] = cmp.mapping(function(fallback) 
                if cmp.visible() then 
                    cmp.select_prev_item()
                --elseif luasnip.jumpable(-1) then 
                 --   luasnip.jump(-1)
                else 
                    fallback() 
                    end 
            end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            -- { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
            { name = 'buffer' },
            { name = 'path' },
            { name = 'nvim_lsp_signature_help' },
        }),
        completion = {
            keyword_length = 2,
            }
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        }),
            matching = { disallow_symbol_nonprefix_matching = false }
	})

	-- Set up lspconfig.
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	vim.lsp.config('jedi', {
		capabilities = capabilities,
		cmd = { 'jedi-language-server' },
	  	filetypes = { 'python' },
	  	root_markers = {
			'pyproject.toml',
			'setup.py',
			'setup.cfg',
			'requirements.txt',
			'Pipfile',
			'.git',
			},
	})
	vim.lsp.enable('jedi')
    
    -- add curren wdir to Python path
    local cwd = vim.fn.getcwd()
    if vim.env.PYTHONPATH and vim.env.PYTHONPATH ~= "" then
      vim.env.PYTHONPATH = cwd .. ":" .. vim.env.PYTHONPATH
    else
      vim.env.PYTHONPATH = cwd
    end

    
    vim.lsp.config('bash', {
		capabilities = capabilities,
        cmd = { 'bash-language-server', 'start' },
        ---@type lspconfig.settings.bashls
        settings = {
            bashIde = {
            -- Glob pattern for finding and parsing shell script files in the workspace.
            -- Used by the background analysis features across files.

            -- Prevent recursive scanning which will cause issues when opening a file
            -- directly in the home directory (e.g. ~/foo.sh).
            --
            -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
            globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
            },
            },
    filetypes = { 'bash', 'sh', 'zsh' },
    root_markers = { '.git' },
    })
	vim.lsp.enable('bash')
EOF

lua << EOF
	require('gitsigns').setup {
	  signs = {
		add          = { text = ' ┃' },
		change       = { text = ' ┃' },
		delete       = { text = ' _' },
		topdelete    = { text = ' ‾' },
		changedelete = { text = ' ~' },
		untracked    = { text = ' ┆' },
	  },
	  signs_staged = {
		add          = { text = ' ┃' },
		change       = { text = ' ┃' },
		delete       = { text = ' _' },
		topdelete    = { text = ' ‾' },
		changedelete = { text = ' ~' },
		untracked    = { text = ' ┆' },
	  },
	  signs_staged_enable = true,
	  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
	  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
	  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
	  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
	  watch_gitdir = {
		follow_files = true
	  },
	  auto_attach = true,
	  attach_to_untracked = false,
	  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	  current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
		use_focus = true,
	  },
	  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
	  sign_priority = 6,
	  update_debounce = 100,
	  status_formatter = nil, -- Use default
	  max_file_length = 40000, -- Disable if file is longer than this (in lines)
	  preview_config = {
		-- Options passed to nvim_open_win
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	  },
	}
EOF

""""""""""""""""""""""""""""""""""""
"" Flutter
lua << EOF
  require("flutter-tools").setup {
		flutter_path = "~/develop/flutter_3.38.4_stable/", -- <-- this takes priority over the lookup
	  } -- use defaults
EOF
