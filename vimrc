set nu
" tab de 4 espaces
set tabstop=4
" indentation auto de 4
set shiftwidth=4
" combien d'espace quand on appuit sur tab
set softtabstop=4
" ne pas remplacer des tabs par des espaces (remplacer par set expandtab si vous voulez des espaces)
set noexpandtab
" indentation auto
set autoindent
" indentation intelligente, ne foncitonne pas avec tous les languages de prog
set smartindent
" indentation pour le c
set cindent
set encoding=utf-8
" applique la conf vim si une ligne de conf pour vim existe
set modelines=1
" ne fait pas de compatibilité entre vi et vim
set nocompatible

" set-up du mode recherche
set ignorecase
set smartcase
set	incsearch
set	showmatch
set	hlsearch
hi	Search ctermbg=White
hi	Search ctermfg=Blue

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

" Indentation des fichiers yaml
autocmd FileType yaml setlocal ai ts=2 sw=2 et

" Nouvelle onglet
function NewTab()
	:tabnew
	:Explore
endfunction

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


" Paramètrage des binding

" resize window
nnoremap <F2> :vertical resize -1<CR>
nnoremap <F3> :vertical resize +1<CR>
nnoremap <F4> :resize +1<CR>
nnoremap <F5> :resize -1<CR>

"	Shift-F5 voir les caractères invisibles
set		listchars=eol:$,tab:→\ ,trail:.,space:·,extends:>,precedes:<,nbsp:_
noremap <S-F5> :set list!<CR>
inoremap <S-F5> <C-o>:set list!<CR>
cnoremap <S-F5> <C-c>:set list!<CR>

nnoremap <F6> :set relativenumber<CR>
" shift F6
nnoremap <S-F6> :set norelativenumber<CR>

" ajouter un nouvel onglet
nnoremap <F9> :call NewTab()<CR>

" F10 pour changer d'onglet vers la droite
nnoremap <F10> gt<CR>
" shift f10 pour changer d'onglet vers la gauche
nnoremap <S-F10> gT<CR>
