;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     rust
     ;; rust
     ;; yaml
     shell-scripts
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ( auto-completion :variables
                       auto-completion-enable-help-tooltip t
                       auto-completion-enable-sort-by-usage t
                       auto-completion-enable-snippets-in-popup t)
     ( evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)
     ;;                    layouts-autosave-delay 300)
     ;; (spacemacs-layouts :variables layouts-enable-autosave t
     ;; colors
     ;; dash
     ;; eww
     ;; extra-langs
     ;; eyebrowse
     ;; fasd
     fzf
     ;; github
     ;; gnus
     ;; graphviz ;; keeps re-installing...
     ;; ranger
     ;; rcirc
     ;; search-engine
     ;; yaml
     (erc :variables
          erc-server-list
          '(("irc.freenode.net"
             :port "6697"
             :ssl t
             :nick "magnetophon"
             :password "nil")
            ))
     better-defaults
     ;; clojure ;; for overtone
     emacs-lisp
     ;; deft
     ;; faust
     git
     helm
     ;; html
     markdown
     nixos
     ;; notmuch
     (mu4e :variables
           ;; mu4e-installation-path "/run/current-system/sw/share/emacs/site-lisp/mu4e"
           mu4e-installation-path "/home/bart/.nix-profile/share/emacs/site-lisp/mu4e"
           mu4e-use-maildirs-extension t
           mu4e-enable-async-operations t)
     org
     ;; python
     ;; semantic
     shell
     spell-checking
     syntax-checking
     ;; version-control
     ;; vimscript ;; for pentadactylrc
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(magit-annex helm-mu mbsync org-autolist faustine auto-complete )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(org-bullets)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         solarized-light
                         leuven
                         spacemacs-dark
                         spacemacs-light
                         solarized-dark
                         monokai
                         zenburn)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `vim-powerline' and `vanilla'. The first three
   ;; are spaceline themes. `vanilla' is default Emacs mode-line. `custom' is a
   ;; user defined themes, refer to the DOCUMENTATION.org for more info on how
   ;; to create your own spaceline theme. Value can be a symbol or list with\
   ;; additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave)
   ;; dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 2)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Dina"
                               :size 8
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "home"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout t

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.1

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
  dotspacemacs-line-numbers '(:relative t
                              :disabled-for-modes dired-mode
                              doc-view-mode
                              ;; markdown-mode
                              ;; org-mode
                              pdf-view-mode
                              ;; text-mode
                              :size-limit-kb 1000)

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  ;; (persp-load-state-from-file "~/.emacs.d/.cache/layouts/mylayout")
  ;; when you open a (single) file it uses another window (creating it if necessary):
  ;; stopped working...
  ;; (setq server-window 'pop-to-buffer)

  ;; put undo-tree history in a central directory
  (setq undo-tree-history-directory-alist `(("." . ,(expand-file-name "~/.undo-tree/"))))

  (setq evilnc-invert-comment-line-by-line t)
  (setq vc-follow-symlinks t)
  ;; make sure we get vertical splits:
  (setq split-height-threshold `nil)

  (global-set-key (kbd "<f5>") #'deadgrep)
  ;; (global-set-key [f5] 'cider-eval-defun-at-point)
  ;; (global-set-key [f5] (do 'normal-mode 'cider-eval-defun-at-point))

  ;; (setq-default rust-enable-racer t)
  (global-company-mode)

  (setq browse-url-browser-function 'browse-url-generic
        engine/browser-function 'browse-url-generic
        browse-url-generic-program "qutebrowser")

  ;; (define-key evil-normal-state-map (kbd "<left>") 'previous-buffer)
  ;; (define-key evil-normal-state-map (kbd "<right>") 'next-buffer)
  ;; I prefer to stay on the original character when leaving insert mode
  (setq evil-move-cursor-back nil)
  (setq evil-escape-unordered-key-sequence t)
  (setq undo-tree-auto-save-history t)

  ;; (setq default-frame-alist '((background-color . "white")))

  ;; (add-to-list 'auto-mode-alist '("/mutt" . notmuch-message-mode))

  (spacemacs|define-custom-layout "@Mail"
    :binding "m"
    :body
    (mu4e)
    )

  (with-eval-after-load 'mu4e
    ;; (setq special-display-regexps '("mu4e"))
;;; Set up some common mu4e variables
  (setq mu4e-maildir "~/.mail"
        mu4e-trash-folder "/Trash"
        mu4e-sent-folder "/Sent"
        mu4e-refile-folder "/Archive"
        mu4e-drafts-folder "/Drafts"
        mu4e-attachment-dir  "~/Downloads"
        mu4e-get-mail-command "mbsync -V -a"
        mu4e-update-interval nil
        mu4e-compose-signature-auto-include nil
        mu4e-view-show-images t
        mu4e-view-show-addresses t
        mu4e-enable-mode-line t
        mu4e-user-mail-address-list  '("bart@magnetophon.nl")
        user-mail-address "bart@magnetophon.nl"
        user-full-name  "Bart Brouns"
        message-send-mail-function   'smtpmail-send-it
        ;; smtpmail-default-smtp-server "sub5.mail.dreamhost.com"
        smtpmail-smtp-server         "sub5.mail.dreamhost.com"
        ;; smtpmail-local-domain        "example.com"
        mu4e-use-fancy-chars t
        mu4e-headers-include-related t
        mu4e-split-view 'vertical
        mu4e-headers-visible-columns 130
        mu4e-headers-skip-duplicates t
        mu4e-headers-leave-behavior 'apply
        ;; mu4e-view-image-max-width 400
        message-kill-buffer-on-exit t
        mu4e-enable-notifications t
        )
    ;; I want my format=flowed thank you very much
    ;; mu4e sets up visual-line-mode and also fill (M-q) to do the right thing
    ;; each paragraph is a single long line; at sending, emacs will add the
    ;; special line continuation characters.
    (setq mu4e-compose-format-flowed t)

    ;; every new email composition gets its own frame! (window)
    (setq mu4e-compose-in-new-frame t)

    (add-hook 'mu4e-view-mode-hook 'visual-line-mode)

  (with-eval-after-load 'mu4e-alert
    ;; Enable Desktop notifications
    (mu4e-alert-set-default-style 'notifications))

    (define-key mu4e-main-mode-map "s" 'helm-mu)
    (define-key mu4e-headers-mode-map "s" 'helm-mu)
    (define-key mu4e-view-mode-map "s" 'helm-mu)

;;; Mail directory shortcuts
  (setq mu4e-maildir-shortcuts
        '(("/INBOX" . ?i)
          ("/INBOX.*" . ?a)))

;;; Bookmarks
  (setq mu4e-bookmarks
        `(("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
          ("date:today..now" "Today's messages" ?t)
          ("date:7d..now" "Last 7 days" ?w)
          ("mime:image/*" "Messages with images" ?p)
          (,(mapconcat 'identity
                       (mapcar
                        (lambda (maildir)
                          (concat "maildir:" (car maildir)))
                        mu4e-maildir-shortcuts) " OR ")
           "All inboxes" ?i)))


  ;;rename files when moving
  ;;NEEDED FOR MBSYNC
  (setq mu4e-change-filenames-when-moving t)
    (require 'mu4e-contrib nil t)

    ;;store org-mode links to messages
    (require 'org-mu4e)
    ;;store link to message if in header view, not to header query
    (setq org-mu4e-link-query-in-headers-mode nil)

    ;;use org mode for eml files (useful for thunderbird plugin)
    (add-to-list 'auto-mode-alist '("\\.eml\\'" . mu4e-compose-mode))

    (setq org-M-RET-may-split-line nil)

    (defun mbork/message-attachment-present-p ()
      "Return t if an attachment is found in the current message."
      (save-excursion
        (save-restriction
          (widen)
          (goto-char (point-min))
          (when (search-forward "<#part" nil t) t))))

    (defcustom mbork/message-attachment-intent-re
      (regexp-opt '("attach"
                    "attached"
                    "attachment"
                    "included"
                    "file"
                    "pdf"
                    "doc"
                    "ods"
                    ))
      "A regex which - if found in the message, and if there is no
attachment - should launch the no-attachment warning.")

    (defcustom mbork/message-attachment-reminder
      "Are you sure you want to send this message without any attachment? "
      "The default question asked when trying to send a message
containing `mbork/message-attachment-intent-re' without an
actual attachment.")

    (defun mbork/message-warn-if-no-attachments ()
      "Ask the user if s?he wants to send the message even though
there are no attachments."
      (when (and (save-excursion
                   (save-restriction
                     (widen)
                     (goto-char (point-min))
                     (re-search-forward mbork/message-attachment-intent-re nil t)))
                 (not (mbork/message-attachment-present-p)))
        (unless (y-or-n-p mbork/message-attachment-reminder)
          (keyboard-quit))))

    (add-hook 'message-send-hook #'mbork/message-warn-if-no-attachments)

    ;; function to return first name of email recipients
    ;; used by yasnippet
    ;; inspired by
    ;;http://blog.binchen.org/posts/how-to-use-yasnippets-to-produce-email-templates-in-emacs.html
    (defun bjm/mu4e-get-names-for-yasnippet ()
      "Return comma separated string of names for an email"
      (interactive)
      (let ((email-name "") str email-string email-list email-name2 tmpname)
        (save-excursion
          (goto-char (point-min))
          ;; first line in email could be some hidden line containing NO to field
          (setq str (buffer-substring-no-properties (point-min) (point-max))))
        ;; take name from TO field - match series of names
        (when (string-match "^To: \"?\\(.+\\)" str)
          (setq email-string (match-string 1 str)))
        ;;split to list by comma
        (setq email-list (split-string email-string " *, *"))
        ;;loop over emails
        (dolist (tmpstr email-list)
          ;;get first word of email string
          (setq tmpname (car (split-string tmpstr " ")))
          ;;remove whitespace or ""
          (setq tmpname (replace-regexp-in-string "[ \"]" "" tmpname))
          ;;join to string
          (setq email-name
                (concat email-name ", " tmpname)))
        ;;remove initial comma
        (setq email-name (replace-regexp-in-string "^, " "" email-name))

        ;;see if we want to use the name in the FROM field
        ;;get name in FROM field if available, but only if there is only
        ;;one name in TO field
        (if (< (length email-list) 2)
            (when (string-match "^\\([^ ,\n]+\\).+writes:$" str)
              (progn (setq email-name2 (match-string 1 str))
                     ;;prefer name in FROM field if TO field has "@"
                     (when (string-match "@" email-name)
                       (setq email-name email-name2))
                     )))
        (upcase-initials (downcase email-name))))

  )

  (defun dear-leader/swap-keys (key1 key2)
    "Swap two leader keys."
    (let ((map1 (lookup-key spacemacs-default-map key1))
          (map2 (lookup-key spacemacs-default-map key2)))
      (spacemacs/set-leader-keys key1 map2 key2 map1)))

  ;; Swap mail and music keys
  (dear-leader/swap-keys "aM" "am")

  (with-eval-after-load 'erc

  ;; Stop displaying channels in the mode line for no good reason.
  (setq erc-track-exclude-types
        '("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE" "333" "353"))

  (add-hook 'erc-mode-hook
            #'(lambda ()
                ;; (setup-irc-environment)
                (set (make-local-variable 'scroll-conservatively) 100)))

  (setq
   erc-server-reconnect-timeout 30
   ;; erc-prompt-for-nickserv-password nil
   erc-autojoin-channels-alist '((".*freenode.net" "#nixos" "#ardour" "#opensourcemusicians" "#musnix" "#i3" "#ranger"))
   erc-hide-list '("JOIN" "PART" "QUIT")
   erc-log-channels-directory nil
  )
  ;; autorejoin
  (require 'erc-join)
  (erc-autojoin-mode)

  ;; (defun run-irc ()
    ;; (interactive)
    ;; (erc :server "irc.freenode.net" :nick "magnetophon" :password nil))
  )

  (spacemacs|define-custom-layout "faustlib"
    :binding "l"
    :body
    (find-file "/run/current-system/sw/lib/faust/*.lib" t)
    ;; (find-file "~/.nix-profile/lib/faust/*.lib" t)
    )

  (add-to-list 'auto-mode-alist
               '("\\.dsp\\'" . faustine-mode))

  ;; rcirc
  ;; Change user info
  ;; (setq rcirc-default-nick "magnetophon")
  ;; (setq rcirc-default-user-name "magnetophon")
  ;; (setq rcirc-default-full-name "magnetophon")

  ;; Join these channels at startup.
  ;; (setq rcirc-server-alist
  ;;       '(("irc.freenode.net" :channels ("#lad" "#ardour" "#opensourcemusicians" "#musnix" "#nixos"))))

  (setq org-directory "~/org/")
  (setq org-brain-path org-directory )
  (setq deft-directory org-directory )
  ;; (setq org-agenda-files '(org-directory) )
  ;; (setq org-agenda-files '("~/org"))
  (setq org-agenda-files (directory-files-recursively "~/org/" "\.org$"))
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
  (setq org-todo-keywords '(
                            (sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELLED(c@)")
                            ))
  (setq org-capture-templates
        '(("t" "todo" entry (file+headline "~/org/todo.org" "Tasks")
           "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")))

  (defun magnetophon/load-my-layout ()
    (interactive)
    (persp-load-state-from-file "~/.dot/common/.spacemacs_dir/MyLayout"))

  (add-hook 'spacemacs-post-user-config-hook 'magnetophon/load-my-layout  'append)

  ;; (define-hook-helper git-rebase-mode ()
    ;; (remove-hook 'git-rebase-mode-hook 'delete-trailing-whitespace))

  ;; *********** MMA **********************************************************
  (push "/home/bart/.spacemacs_dir/elisp/" load-path)
  (autoload 'mma-mode "mma.el" "mma music file mode" t)
    (setq auto-mode-alist
        (append '(("\\.mma$" . mma-mode)) 
  	       auto-mode-alist))
    (setq mma-midi-player "/run/current-system/sw/bin/fluidsynth")
    (setq mma-midi-player-arg "--audio-driver=jack --midi-driver=jack --connect-jack-outputs --no-shell --no-midi-in --server /home/bart/Downloads/Compifont_NEW.sf2")

  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-Y-yank-to-eol nil)
 '(magit-diff-section-arguments (quote ("--ignore-all-space" "--no-ext-diff")))
 '(org-agenda-files
   (quote
    ("/home/bart/org/festivals/IFC18/notes.org" "/home/bart/org/festivals/at.tension_2017/notes.org" "/home/bart/org/festivals/attension2019/notes.org" "/home/bart/org/festivals/fusion2018/akustik/Akustik_Cabaret.org" "/home/bart/org/festivals/fusion2018/bands_mail.org" "/home/bart/org/festivals/fusion2018/notes.org" "/home/bart/org/festivals/fusion2018/riders.org" "/home/bart/org/festivals/fusion2019/notes.org" "/home/bart/org/festivals/sha2017/riders.org" "/home/bart/org/festivals/sha2017/sha2017.org" "/home/bart/org/projects/leoparte/notes.org" "/home/bart/org/adm.org" "/home/bart/org/adm2.org" "/home/bart/org/notes.org" "/home/bart/org/papillon.org" "/home/bart/org/todo.org")))
 '(package-selected-packages
   (quote
    (lv transient helm-rg yaml-mode toml-mode racer linum-relative insert-shebang flycheck-rust fish-mode faustine eyebrowse treepy graphql deft company-shell cargo rust-mode yapfify xterm-color ws-butler winum which-key web-mode volatile-highlights vimrc-mode vi-tilde-fringe uuidgen use-package unfill toc-org tagedit stickyfunc-enhance srefactor spaceline powerline smeargle slim-mode shell-pop scss-mode sass-mode restart-emacs rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode pcre2el paradox orgit org-projectile org-category-capture org-present org-pomodoro org-plus-contrib org-mime org-download org-autolist open-junk-file nix-mode neotree mwim multi-term mu4e-maildirs-extension mu4e-alert alert log4e gntp move-text mmm-mode mbsync markdown-toc markdown-mode magit-gitflow magit-gh-pulls magit-annex macrostep lorem-ipsum live-py-mode link-hint less-css-mode indent-guide hy-mode dash-functional hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-pydoc helm-projectile helm-nixos-options helm-mu helm-mode-manager helm-make projectile helm-gitignore request helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag haml-mode google-translate golden-ratio gnuplot gitignore-mode github-search github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gist gh marshal logito pcache ht gh-md fuzzy flyspell-correct-helm flyspell-correct flycheck-pos-tip flycheck flx-ido flx fill-column-indicator faust-mode fancy-battery expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit magit magit-popup git-commit ghub let-alist with-editor evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eshell-z eshell-prompt-extras esh-help erc-yt erc-view-log erc-social-graph erc-image erc-hl-nicks emmet-mode elisp-slime-nav dumb-jump diminish diff-hl define-word dactyl-mode cython-mode company-web web-completion-data company-statistics company-quickhelp pos-tip company-nixos-options nixos-options company-anaconda company column-enforce-mode clojure-snippets clj-refactor hydra inflections edn multiple-cursors paredit peg clean-aindent-mode cider-eval-sexp-fu eval-sexp-fu highlight cider seq spinner queue pkg-info clojure-mode epl bind-map bind-key auto-yasnippet yasnippet auto-highlight-symbol auto-dictionary auto-compile packed anaconda-mode pythonic f s aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core async ac-ispell auto-complete popup solarized-theme dash)))
 '(paradox-github-token t)
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-Y-yank-to-eol nil)
 '(magit-diff-section-arguments (quote ("--ignore-all-space" "--no-ext-diff")))
 '(package-selected-packages
   (quote
    (toml-mode racer helm-gtags ggtags flycheck-rust counsel-gtags cargo rust-mode yapfify xterm-color ws-butler winum which-key web-mode volatile-highlights vimrc-mode vi-tilde-fringe uuidgen use-package unfill toc-org tagedit stickyfunc-enhance srefactor spaceline powerline smeargle slim-mode shell-pop scss-mode sass-mode restart-emacs rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode pcre2el paradox orgit org-projectile org-category-capture org-present org-pomodoro org-plus-contrib org-mime org-download org-autolist open-junk-file nix-mode neotree mwim multi-term mu4e-maildirs-extension mu4e-alert alert log4e gntp move-text mmm-mode mbsync markdown-toc markdown-mode magit-gitflow magit-gh-pulls magit-annex macrostep lorem-ipsum live-py-mode link-hint less-css-mode indent-guide hy-mode dash-functional hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-pydoc helm-projectile helm-nixos-options helm-mu helm-mode-manager helm-make projectile helm-gitignore request helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag haml-mode google-translate golden-ratio gnuplot gitignore-mode github-search github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gist gh marshal logito pcache ht gh-md fuzzy flyspell-correct-helm flyspell-correct flycheck-pos-tip flycheck flx-ido flx fill-column-indicator faust-mode fancy-battery expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit magit magit-popup git-commit ghub let-alist with-editor evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eshell-z eshell-prompt-extras esh-help erc-yt erc-view-log erc-social-graph erc-image erc-hl-nicks emmet-mode elisp-slime-nav dumb-jump diminish diff-hl define-word dactyl-mode cython-mode company-web web-completion-data company-statistics company-quickhelp pos-tip company-nixos-options nixos-options company-anaconda company column-enforce-mode clojure-snippets clj-refactor hydra inflections edn multiple-cursors paredit peg clean-aindent-mode cider-eval-sexp-fu eval-sexp-fu highlight cider seq spinner queue pkg-info clojure-mode epl bind-map bind-key auto-yasnippet yasnippet auto-highlight-symbol auto-dictionary auto-compile packed anaconda-mode pythonic f s aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core async ac-ispell auto-complete popup solarized-theme dash)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
