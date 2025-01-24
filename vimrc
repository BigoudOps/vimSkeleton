set nu
filetype on
filetype indent on
syntax on

" Charger automatiquement un squelette pour différents types de fichiers
autocmd BufNewFile *.md 0r ~/.vim/templates/markdown.md | call ReplacePlaceholders()
autocmd BufNewFile *.yaml,*.yml 0r ~/.vim/templates/yaml.yaml | call ReplacePlaceholders()
autocmd BufNewFile *.py 0r ~/.vim/templates/python.py | call ReplacePlaceholders()
autocmd BufNewFile *.html 0r ~/.vim/templates/html.html | call ReplacePlaceholders()
autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh | call ReplacePlaceholders()

" Mettre à jour la date de dernière modification à chaque sauvegarde
autocmd BufWritePre *.md,*.yaml,*.yml,*.py,*.html,*.sh call UpdateLastModified()

" Fonction pour remplacer les balises {{DATE_CREATION}} et {{LAST_MODIFIED}}
function! ReplacePlaceholders()
    let l:date = strftime("%Y-%m-%d %H:%M:%S")
    execute "silent! %s/{{DATE_CREATION}}/" . l:date . "/g"
    execute "silent! %s/{{LAST_MODIFIED}}/" . l:date . "/g"
endfunction

" Fonction générique pour ajouter ou mettre à jour la ligne Dernière modification
function! UpdateLastModified()
    let l:date = strftime("%Y-%m-%d %H:%M:%S")
    let l:modified_line = "# Dernière modification : " . l:date

    " Vérifier si une ligne "Dernière modification" existe déjà
    let l:found = 0
    for l:line in range(1, line('$'))
        if getline(l:line) =~ 'Dernière modification'
            " Mettre à jour la ligne existante
            call setline(l:line, l:modified_line)
            let l:found = 1
            break
        endif
    endfor

    " Si non trouvé, ajouter après la deuxième ligne
    if l:found == 0
        call append(2, l:modified_line)
    endif
endfunction

