




"       HOW TO DO 90% OF WHAT PLUGINS DO (WITH JUST VIM)

"                          Max Cantor

"               NYC Vim Meetup -- August 3, 2016











" FEATURES TO COVER:
" - Fuzzy File Search
" - Tag jumping
" - Autocomplete
" - File Browsing
" - Snippets
" - Build Integration (if we have time)



" KB going off the beaten path:

" comment shortcut is really hard...
" here is some details: https://www.ostechnix.com/comment-multiple-lines-vim-editor/
" Some great wisdom here in the above. One quote: If you want to be productive in Vim you need to talk with Vim with *language* Vim is using. Every solution that gets out of “normal mode” is most probably not the most effective.
" noremap <C-r> 0i#<Esc>''

" backspacing is super weird
" this gives vim standard backspacing behaviour
set backspace=indent,eol,start
" here's why it doesnt have it: https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode
" https://vim.fandom.com/wiki/Map_Ctrl-Backspace_to_delete_previous_word
" see note: Mapping Ctrl+Backspace doesn't work in terminal vim. 
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" Colors have always eluded me. These guys might describe why:
" https://unix.stackexchange.com/questions/118806/tmux-term-and-256-colours-support






" GOALS OF THIS TALK:
" - Increase Vim understanding
" - Offer powerful options

" NOT GOALS OF THIS TALK:
" - Hate on plugins
" - Get people to stop using plugins


" Biggest take away of this talk - USE THE VIM HELP DOCS!! THEY ARE GOOD!
" You could literally read them start to finish
" Know the various ways to access them


" {{{ BASIC SETUP
" BASIC SETUP:

" enter the current millenium
" not bother pretending to be its predecessor vi
" vim tries to act like vi and thinks you hate change
" this tells it otherwise
set nocompatible

" enable syntax and plugins (for netrw)
" enable nice colors on screen
syntax enable
" kind of cheating. this enables a plugin that comes with vim
filetype plugin on



" set changes a built in configuration variable
" += means "append to"
" two stars means something important
" K at cursor to get help at cursor. Vims docs are pretty comprehensive
" help ^n = show me what Ctrl+n does in normal mode
" help i_^n = show me what Ctrl+n does in insert mode
" helpgrep <TYPE ANYTHING> = will search the entire help docs to find what you might be looking for


" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
" if you arent familiar with vim configuration syntax
" ** means "when you search for a file, search through every directory and subdirectory"
" KBQ: how to exclude some directories like __pycache__? or .venv?
    " A: set wildignore+=**/node_modules/**
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer
" hit tab to cycle through options
" typing in ANY subset of the name of the buffer will bring it up


" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
" ctags is what VSCode uses as well (but poorly lol)
" ! makes things run in console
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor. This will go to definition
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack. That's Ctrl-t


" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags
" Q: What languages does ctags support?
    " A: ctags --list-languages
" Q: How do you keep tags in sync with your codebase?
    " A: I do a very unscientific thing - I keep using it til it does something weird then I rebuild it
    " A: ctags might have a watch mode sort of thing
    " A: You could also bind it to your write command. I've never felt good about that one


" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|
" It's already configured. Reads from tag file if it exists.
" If not, it will automatically checkout the file youre in and use some lang specific config to follow dependency chain

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option
" :help ins-completion to see the tons of options available to you

" KBQ: I dont see files where things are coming from
" KBQ: my list is full of useless crap...what gives?
" KBQ: can I see docs or something inline here?

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list





" FILE BROWSING:

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings



" SNIPPETS:

" Read an empty HTML template and move cursor to title
" THIS IS SUPER IMPORTANT - to understand how the below works
" Vim uses modes yea? typically you're in normal mode. If you press i you go into insert mode, etc etc
" If you press : you go into command mode. : below goes into command mode.
" for some reason an extra line is added unless you include -1 after :
" <CR> is the vim equivalent of Enter
" 3jwf>a - go 3 lines down, go to first word, find >, insert after cursor. Gets you to insert mode at a spot
nnoremap ,html :-1read $HOME/code/learnvim/no_plugins/skeleton.html<CR>3jwf>a
" nnoremap ,html :-1read $HOME/code/learnvim/no_plugins/skeleton.html<CR>/title><CR>ela

" NOW WE CAN:
" - Take over the world!
"   (with much fewer keystrokes)









" BUILD INTEGRATION:

" Steal Mr. Bradley's formatter & add it to our spec_helper
" http://philipbradley.net/rspec-into-vim-with-quickfix

" Configure the `make` command to run RSpec
set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter

" NOW WE CAN:
" - Run :make to run RSpec
" - :cl to list errors
" - :cc# to jump to error by number
" - :cn and :cp to navigate forward and back





"                          THANK YOU!

"                    Download this file at:
"                github.com/mcantor/no_plugins

"                Follow me for kitten pictures:
"                     twitter.com/mcantor

"          Contact me at `max at maxcantor dot net` for:
"                  - Consulting (Dev and PM)
"                          - Tutoring
"                     - Classroom Teaching
"                     - Internal Training
"                       - Encouragement

