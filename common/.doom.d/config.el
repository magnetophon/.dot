;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       Visual
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq doom-font (font-spec :family "Terminus" :size 8))
;; (setq doom-font (font-spec :family "Dina" :size 8))
;; (setq doom-big-font (font-spec :family "Anonymous Pro" :size 11 ))
(setq doom-big-font (font-spec :family "Terminus" :size 18))
;; (setq doom-big-font (font-spec :family "Oxygen Mono" :size 16))
;; (setq doom-big-font (font-spec :family "Source Code Pro" :size 16))
;; (setq doom-big-font (font-spec :family "RobotoMono Nerd Font" :size 16 :weight 'regular))
(setq doom-theme 'doom-solarized-light)
(setq display-line-numbers-type 'relative)

;; make sure we get vertical splits:
(after! org
  ;; (set-popup-rule! "^\\*Org Agenda" :side 'right :size 0.5)
  (set-popup-rule! "\\*" :side 'right :size 0.5)
  (setq split-height-threshold nil)
  (setq split-width-threshold 160)
  )

;; clearer highlight for current line
(after! solaire-mode
  (custom-set-faces! '(solaire-hl-line-face  :background "#f0e9d7")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 tab-width 4                                      ; Set width for tabs
 uniquify-buffer-name-style 'forward              ; Uniquify buffer names
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t)                      ; By default while in insert all changes are one big blob. Be more granular

(delete-selection-mode 1)                         ; Replace selection when inserting text
;; (display-time-mode 1)                             ; Enable time in the mode-line
;; (display-battery-mode 1)                          ; On laptops it's nice to know how much power you have
(global-subword-mode 1)                           ; Iterate through CamelCase words

                                        ; This really simplifies prompt style issues with tramp
(eval-after-load 'tramp '(setenv "SHELL" "/run/current-system/sw/bin/zsh"))

;; Fix for #2386 until further investigation
(when noninteractive
  (after! undo-tree
    (global-undo-tree-mode -1)))

(after! which-key
  (setq
   which-key-idle-delay 0.1
   which-key-allow-imprecise-window-fit nil
   which-key-max-description-length nil))

;; don't ask to quit ediff
;; TODO: only if no changes!
;; (defun disable-y-or-n-p (orig-fun &rest args)
;; (cl-letf (((symbol-function 'y-or-n-p) (lambda (prompt) t)))
;; (apply orig-fun args)))

(setq
 ispell-aspell-data-dir "/run/current-system/sw/lib/aspell/"
 ispell-aspell-dict-dir ispell-aspell-data-dir
 langtool-language-tool-jar "/run/current-system/sw/share/languagetool-commandline.jar")
;; (add-to-list 'ispell-dictionary-alist
;;              '("english-US" "[[:alpha:]]" "[^[:alpha:]]" "'" t ("-d" "en_US") nil utf-8))
;; (ispell-change-dictionary "english-US")

;; I prefer to stay on the original character when leaving insert mode
(setq evil-move-cursor-back nil)

(setq evil-escape-unordered-key-sequence t)
(setq evil-want-fine-undo t)
;; (setq undo-tree-auto-save-history t)

(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

;;no auto popups, use C-SPC
(setq company-idle-delay nil)

;; ivy config, default now
;; (after! ivy
;;   (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

;; stop asking “Keep current list of tags tables also”
(setq tags-add-tables nil)
(setq confirm-kill-emacs nil)
(setq +ivy-buffer-preview 'everything) ;; to turn on auto-previewing in SPC bb and SPC bB
(after! counsel ;; always search hidden files
  (setq counsel-rg-base-command "rg --with-filename --no-heading --line-number --color never --hidden %s"))
;; Alternatively, you can include hidden files by:

;; 1. Passing the prefix arg to +ivy/project-search (e.g. SPC u SPC s p)
;; 2. Adding -u -- to the beginning of your search query
;; 3. Adding ! to the ex command. e.g. :pg! SEARCH TERMS
;; 4. Or by rebinding SPC s p so that the prefix arg is always passed to +ivy/project-search:
;; (map! :leader "s p" (λ!! #'+ivy/project-search t))

(setq evilnc-invert-comment-line-by-line t)

(setq ranger-override-dired 'ranger)

;; Don’t compact font caches during GC.
(setq inhibit-compacting-font-caches t)


(remove-hook 'text-mode-hook #'auto-fill-mode) ; disable hard wrapping;
;; (add-hook 'text-mode-hook #'visual-line-mode) ; enable soft wrapping
;; (add-hook! "(text-mode-hook prog-mode-hook conf-mode-hook) #"visual-line-mode) ; enable soft wrapping
;; (global-visual-line-mode +1) ; globally enable soft wrapping

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       Bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defhydra resize-window-hydra (:hint nil)
  "resize window"
  ("h" evil-window-decrease-width 5 "decrease width")
  ("j" evil-window-decrease-height 5 "decrease height")
  ("k" evil-window-increase-height 5 "increase height")
  ("l" evil-window-increase-width 5 "increase width")
  ("q" nil "stop resizing")
  )

(map! :leader (:prefix ("w" . "window") "~" #'resize-window-hydra/body))
(map! :leader (:prefix ("/" . "search") "r" #'counsel-recoll))

;; doom has this under SPC `
;; (defun spacemacs/alternate-buffer (&optional window)
;;   "Switch back and forth between current and last buffer in the
;; current window."
;;   (interactive)
;;   (let ((current-buffer (window-buffer window))
;;         (buffer-predicate
;;          (frame-parameter (window-frame window) 'buffer-predicate)))
;;     ;; switch to first buffer previously shown in this window that matches
;;     ;; frame-parameter `buffer-predicate'
;;     (switch-to-buffer
;;      (or (cl-find-if (lambda (buffer)
;;                        (and (not (eq buffer current-buffer))
;;                             (or (null buffer-predicate)
;;                                 (funcall buffer-predicate buffer))))
;;                      (mapcar #'car (window-prev-buffers window)))
;;          ;; `other-buffer' honors `buffer-predicate' so no need to filter
;;          (other-buffer current-buffer t)))))

;; (map! :leader (:prefix ("b" . "buffer") "TAB" #'spacemacs/alternate-buffer))

                                        ; auto back-and-forth for workspaces
(dotimes (i 9)
  (advice-add (intern (format "+workspace/switch-to-%d" i))
              :override
              (lambda () (interactive)
                (let* ((workspaces (+workspace-list-names))
                       (current-workspace (+workspace-current-name))
                       (target-workspace (nth i workspaces)))
                  (if (equal current-workspace target-workspace)
                      (+workspace/other)
                    (+workspace/switch-to i))))))

(defun doom/ediff-init-and-example ()
  "ediff the current `init.el' with the example in doom-emacs-dir"
  (interactive)
  (ediff-files (concat doom-private-dir "init.el")
               (concat doom-emacs-dir "init.example.el")))

(define-key! help-map
  "di"   #'doom/ediff-init-and-example
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       IRC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! irc
  (set-irc-server! "freenode"
                   `(
                     ;; :use-tls t
                     :nick "magnetophon"
                     ;; :user "magnetophon/freenode"
                     :pass nil
                     :port 6666
                     ;; :host "magnetophon.nl"
                     ;; :server-buffer-name "{network}:{host}:{port}"
                     :server-buffer-name "{network}:{port}"
                     :channels ("#ardour" "#nixos"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       faust
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq faustine-build-backend `"time faust2jack -time -t 0" )
(add-to-list 'auto-mode-alist '("\\.lib$" . faustine-mode))
;; (after! faustine
;;   (set-company-backend! '(faust-mode faustine-mode) '(company-dabbrev-code +faust-company-backend company-yasnippet)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       load
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load! "+org")
(load! "+mail")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       mma
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load! "lisp/mma")

(setq auto-mode-alist
      (append '(("\\.mma$" . mma-mode))
              auto-mode-alist))
(setq mma-midi-player "/run/current-system/sw/bin/fluidsynth")
(setq mma-midi-player-arg "--audio-driver=jack --midi-driver=jack --connect-jack-outputs --no-shell --no-midi-in --server /home/bart/Downloads/Compifont_NEW.sf2")

(map! :localleader
      :map mma-mode-map
      "c" #'mma-compile
      "p" #'mma-compile-and-play
      "P" #'mma-play
      "s" #'mma-stop
      "t" #'mma-test
      "a" #'mma-select-audio
      "r" #'mma-create-regexp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       openscad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load! "lisp/scad-mode")

(setq auto-mode-alist
      (append '(("\\.scad$" . scad-mode))
              auto-mode-alist))

;; (map! :localleader
;; :map scad-mode-map
;; "c" #'mma-compile
;; "p" #'mma-compile-and-play
;; "P" #'mma-play
;; "s" #'mma-stop
;; "t" #'mma-test
;; "a" #'mma-select-audio
;; "r" #'mma-create-regexp)

;;; config.el ends here
