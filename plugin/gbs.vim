set shell=/bin/bash\ --init-file\ ~/.vim/.vimbashrc

function! LoadTemplate(extension)
    silent! :execute '0r ~/.vim/templates/'. a:extension. '.tpl'
    silent! execute 'source ~/.vim/templates/'.a:extension.'.patterns.tpl'
endfunction

function! ShellHistoryInsert()
    "$read ~/.vim_bash_history
    let l:new_lst = []
    let line_lst = readfile(expand("~/.vim_bash_history"))
    for line in line_lst
        call add(new_lst, '> '.line)
        call add(new_lst, '')
    endfor
    call writefile(new_lst, expand("~/.vim_bash_history"))
    $read ~/.vim_bash_history
endfunction

function! ShellHistoryDelete()
    call delete(expand("~/.vim_bash_history"))
endfunction

autocmd BufNewFile * silent! call LoadTemplate('%:e')

autocmd VimLeave * silent! call ShellHistoryDelete()
autocmd ShellcmdPost *.gbs  :call ShellHistoryInsert()
