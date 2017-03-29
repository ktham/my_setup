" Add syntax coloring
syntax on

" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Enable line numbers
set number

" Use Vim defaults instead of 100% vi compatibility
set nocompatible

" More powerful backspacing
set backspace=2

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup

" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup
