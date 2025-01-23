set nu
filetype on
filetype indent on
syntax on
autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh | call ReplacePlaceholders()

autocmd BufWritePre *.sh call UpdateLastModified()

function! ReplacePlaceholders()
    let l:date = strftime("%Y-%m-%d %H:%M:%S")
    execute "silent! %s/{{DATE_CREATION}}/" . l:date . "/g"
endfunction

function! UpdateLastModified()
    let l:date = strftime("%Y-%m-%d %H:%M:%S")
    let l:modified_line = "# Dernière modification : " . l:date

    let l:found = 0
    for l:line in range(1, line('$'))
        if getline(l:line) =~ '^# Dernière modification :'
            " Mettre à jour la ligne existante
            call setline(l:line, l:modified_line)
            let l:found = 1
            break
        endif
    endfor

    if l:found == 0
        call append(2, l:modified_line) " Ajouter après la deuxième ligne
    endif
endfunction
