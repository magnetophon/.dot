;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; (setq doom-font (font-spec :family "FuraMono Nerd Font" :size 12 :weight 'regular))
;; (setq doom-font (font-spec :family "Hasklug Nerd Font" :size 12 :weight 'light))
(setq doom-font (font-spec :family "Terminus" :size 8))
;; (setq doom-font (font-spec :family "Dina" :size 8))
(setq doom-big-font (font-spec :family "RobotoMono Nerd Font" :size 26 :weight 'regular))
(setq doom-theme 'doom-solarized-light)
(setq display-line-numbers-type 'relative)

(setq which-key-idle-delay 0.1)

;; make sure we get vertical splits:
(set-popup-rule! "*" :side 'right :size 0.5)
(setq split-height-threshold `nil)

(add-to-list 'load-path  "/run/current-system/sw/share/emacs/site-lisp/mu4e")
;; mu4e-installation-path "/home/bart/.nix-profile/share/emacs/site-lisp/mu4e"

(setq ispell-aspell-data-dir "/run/current-system/sw/lib/aspell/" )
(setq ispell-aspell-dict-dir ispell-aspell-data-dir)

;; (add-to-list 'ispell-dictionary-alist
;;              '("english-US" "[[:alpha:]]" "[^[:alpha:]]" "'" t ("-d" "en_US") nil utf-8))
;; (ispell-change-dictionary "english-US")

;; I prefer to stay on the original character when leaving insert mode
(setq evil-move-cursor-back nil)
(setq evil-escape-unordered-key-sequence t)
(setq undo-tree-auto-save-history t)

(defhydra resize-window-hydra (:hint nil)
  "
         _k_
      _h_     _l_
         _j_
"
  ("h" evil-window-decrease-width)
  ("j" evil-window-decrease-height)
  ("k" evil-window-increase-height)
  ("l" evil-window-increase-width))

(map! :leader (:prefix ("w" . "window") "~" #'resize-window-hydra/body))

  ;; ORG config
(after! org
  ;;use org mode for eml files (useful for thunderbird plugin)
  (add-to-list 'auto-mode-alist '("\\.eml\\'" . mu4e-compose-mode))

  (setq org-startup-folded nil ; do not start folded
        org-log-done 'time ; record the time when an element was marked done/checked
        org-fontify-done-headline nil ; do not change the font of DONE items
        org-ellipsis " ↴ "
        org-return-follows-link t  ; RET follows links
        org-hide-emphasis-markers t ; do not show format markers
        org-startup-with-inline-images t ; open buffers show inline images
        org-agenda-files (directory-files-recursively "~/org" "\.org$")
        org-todo-keywords
            '((sequence "TODO(t)" "|" "DONE(d!)")
            (sequence "NEXT(n)" "WAITING(w@)" "LATER(l)" "|" "CANCELLED(c@)"))
        org-enforce-todo-dependencies t
        ;; prepend the filename for each org target
        org-refile-use-outline-path 'full-file-path
        ;; since we're using ivy just put all the files + headers in a list
        org-outline-path-complete-in-steps nil
        org-M-RET-may-split-line nil
        ))

;; The standard unicode characters are usually misaligned depending on the
;; font. This bugs me. Markdown #-marks for headlines are more elegant.
(after! org-bullets
  (setq org-bullets-bullet-list '("*")))

(with-eval-after-load 'mu4e
  ;; (setq special-display-regexps '("mu4e"))

;;; Set up some common mu4e variables
  (setq mu4e-maildir "~/.mail"
        mu4e-trash-folder "/Trash"
        mu4e-sent-folder "/Sent"
        mu4e-refile-folder "/Archive"
        mu4e-drafts-folder "/Drafts"
        mu4e-attachment-dir  "~/Downloads"
        +mu4e-backend nil
        ;; mu4e-get-mail-command "mbsync -V -a"
        mu4e-get-mail-command "true"
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
        ;; smtpmail-smtp-server         "smtp.dreamhost.com"
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
  ;; mu4e-conversation must be enabled here.
  ;; REVIEW: https://github.com/djcb/mu/issues/1258

  ;; (when (require 'mu4e-conversation nil t)
    ;; (setq mu4e-view-func 'mu4e-conversation)
    ;; (setq mu4e-headers-show-threads nil
    ;;       mu4e-headers-include-related nil)
    ;; For testing purposes:
    ;; (set-face-background mu4e-conversation-sender-1 "#335533")
    ;; (set-face-background mu4e-conversation-sender-2 "#553333")
    ;; (set-face-background mu4e-conversation-sender-3 "#333355")
    ;; (set-face-background mu4e-conversation-sender-4 "#888855")
    ;; (defun mu4e-conversation-toggle ()
    ;;   "Toggle-replace `mu4e-view' with `mu4e-conversation' everywhere."
    ;;   (interactive)
    ;;   (if (eq mu4e-view-func 'mu4e-conversation)
    ;;       (setq mu4e-view-func 'mu4e~headers-view-handler)
    ;;     (setq mu4e-view-func 'mu4e-conversation)))
    ;; )

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
  ;; (setq mu4e-change-filenames-when-moving t)
  (require 'mu4e-contrib nil t)

  ;;store org-mode links to messages
  (require 'org-mu4e)
  ;;store link to message if in header view, not to header query
  (setq org-mu4e-link-query-in-headers-mode nil)
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

)
;; end mu4e settings


;; stop asking “Keep current list of tags tables also”
(setq tags-add-tables nil)

;;; config.el ends here
