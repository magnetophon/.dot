;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       Visual
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq doom-font (font-spec :family "Terminus" :size 8))
;; (setq doom-font (font-spec :family "Dina" :size 8))
(setq doom-big-font (font-spec :family "RobotoMono Nerd Font" :size 26 :weight 'regular))
(load-theme 'doom-solarized-light t)
(setq display-line-numbers-type 'relative)

;; make sure we get vertical splits:
(after! org
  ;; (set-popup-rule! "^\\*Org Agenda" :side 'right :size 0.5)
  (set-popup-rule! "\\*" :side 'right :size 0.5)
  (setq split-height-threshold nil)
  (setq split-width-threshold 160)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq which-key-idle-delay 0.1)

(setq ispell-aspell-data-dir "/run/current-system/sw/lib/aspell/" )
(setq ispell-aspell-dict-dir ispell-aspell-data-dir)

;; (add-to-list 'ispell-dictionary-alist
;;              '("english-US" "[[:alpha:]]" "[^[:alpha:]]" "'" t ("-d" "en_US") nil utf-8))
;; (ispell-change-dictionary "english-US")

;; I prefer to stay on the original character when leaving insert mode
(setq evil-move-cursor-back nil)

(setq evil-escape-unordered-key-sequence t)
(setq evil-want-fine-undo t)
(setq undo-tree-auto-save-history t)

(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

;; ivy config, default now
;; (after! ivy
;;   (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

;; stop asking “Keep current list of tags tables also”
(setq tags-add-tables nil)
(setq confirm-kill-emacs nil)

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

(defun spacemacs/alternate-buffer (&optional window)
  "Switch back and forth between current and last buffer in the
current window."
  (interactive)
  (let ((current-buffer (window-buffer window))
        (buffer-predicate
         (frame-parameter (window-frame window) 'buffer-predicate)))
    ;; switch to first buffer previously shown in this window that matches
    ;; frame-parameter `buffer-predicate'
    (switch-to-buffer
     (or (cl-find-if (lambda (buffer)
                       (and (not (eq buffer current-buffer))
                            (or (null buffer-predicate)
                                (funcall buffer-predicate buffer))))
                     (mapcar #'car (window-prev-buffers window)))
         ;; `other-buffer' honors `buffer-predicate' so no need to filter
         (other-buffer current-buffer t)))))

(map! :leader (:prefix ("b" . "buffer") "TAB" #'spacemacs/alternate-buffer))

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
;;                       load
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load! "+org")
(load! "+mail")
;;; config.el ends here
