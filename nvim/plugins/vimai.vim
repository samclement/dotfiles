Plug 'madox2/vim-ai'

let g:vim_ai_chat = {
\   "options": {
\       "model": "gpt-4o",
\       "temperature": "0.2",
\   },
\}


" This prompt instructs model to work with syntax highlighting
let s:initial_chat_prompt =<< trim END
>>> system
You are a Clean Code expert, I have the following code, please refactor it in a more clean and concise way so that my colleagues can maintain the code more easily. Also, explain why you want to refactor the code so that I can add the explanation to the Pull Request.
If you attach a code block add syntax type after ``` to enable syntax highlighting.
END


" complete text on the current line or in visual selection
nnoremap <leader>a :AI<CR>
xnoremap <leader>a :AI<CR>

" edit text with a custom prompt
xnoremap <leader>s :AIEdit fix grammar and spelling<CR>
nnoremap <leader>s :AIEdit fix grammar and spelling<CR>

" trigger chat
xnoremap <leader>c :AIChat<CR>
nnoremap <leader>c :AIChat<CR>

" redo last AI command
nnoremap <leader>r :AIRedo<CR>

" custom command that provides a code review for selected code block
function! AIPromptCodeReviewFn(range) range
    let l:prompt = "programming syntax is " . &filetype . ", review the code below"
    let l:config = {
    \  "options": {
    \    "initial_prompt": ">>> system\nYou are a Clean Code expert, I have the following code, please refactor it in a more clean and concise way so that my colleagues can maintain the code more easily. Also, explain why you want to refactor the code so that I can add the explanation to the Pull Request.",
    \  },
    \}
    '<,'>call vim_ai#AIChatRun(a:range, l:config, l:prompt)
endfunction
command! -range AIPromptCodeReview <line1>,<line2>call AIPromptCodeReviewFn(<range>)

" custom command that refactors for selected code block
function! AIRefactorFn(range) range
    let l:prompt = "programming syntax is " . &filetype . ", You are a Clean Code expert, refactor the code below in a more clean and concise way so that my colleagues can maintain the code more easily"
    let l:config = {
    \  "options": {
    \    "initial_prompt": ">>> system\nYou are a Clean Code expert, I have the following code, please refactor it in a more clean and concise way so that my colleagues can maintain the code more easily.",
    \  },
    \}
    '<,'>call vim_ai#AIEditRun(a:range, l:config, l:prompt)
endfunction
command! -range AIRefactor <line1>,<line2>call AIRefactorFn(<range>)
