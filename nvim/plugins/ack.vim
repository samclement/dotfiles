Plug 'mileszs/ack.vim'

map <leader>g :Ack
map <leader>cc :botright cope<cr>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
