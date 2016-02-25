NERDtree for vim
================

[NERDtree](https://github.com/scrooloose/nerdtree)
is a plugin that gives you a file explorer.

Install with Vundle
-------------------

Install it by adding this plugin:

```vim
Plugin 'https://github.com/scrooloose/nerdtree'             " Tree Display for the file system
```

Then restart vim and run:

```
:VundleInstall
```

Configure
---------

Here is how I configured it (add this to the bottom of your ~/.vimrc)

```vim
" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if NERDTree is the only open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Thanks, James!
nmap <C-N> :NERDTreeToggle<CR>
```

How to use it:
--------------

* Now you can switch NERDtree on and off with `C-n`.
* Jump between screens with `C-h` and `C-l` (Assuming you have my dotfiles, `C-w h` and `C-w l` otherwise)
* Normal navigation within NERDtree (hjkl)
* Open a directory by placing the cursor on it and pressing `o`
* Open the file in the current window with `o`
* Open the file in a vertical split with `s`
* Open the file in a horizontal split with `i`
* Get a list of stuff you can do with `?` (press again to get back)
