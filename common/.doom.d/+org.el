;;; ~/.dot/common/.doom.d/+org.el -*- lexical-binding: t; -*-


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
        org-enforce-todo-checkbox-dependencies t
        ;; prepend the filename for each org target
        org-refile-use-outline-path 'full-file-path
        ;; since we're using ivy just put all the files + headers in a list
        org-outline-path-complete-in-steps nil
        org-M-RET-may-split-line nil
        )

  (defun forward-and-preview ()
    (interactive)
    "Go to same level next heading and show preview in dedicated buffer"
    (hide-subtree)
    (org-speed-move-safe (quote outline-next-visible-heading))
    (show-children)
    (org-tree-to-indirect-buffer)
    )
  (defun back-and-preview ()
    (interactive)
    "Go to same level previous heading and show preview in dedicated buffer"
    (hide-subtree)
    (org-speed-move-safe (quote outline-previous-visible-heading))
    (show-children)
    (org-tree-to-indirect-buffer)
    )
  (defun up-back-and-preview ()
    (interactive)
    "Go to previous level heading and show preview in dedicated buffer"
    (org-speed-move-safe (quote outline-up-heading))
    (org-tree-to-indirect-buffer)
    (hide-subtree)
    )
  (defun up-forward-and-preview ()
    (interactive)
    "Go to previous level next heading and show preview in dedicated buffer"
    (org-speed-move-safe (quote outline-up-heading))
    (hide-subtree)
    (org-speed-move-safe (quote outline-next-visible-heading))
    (org-tree-to-indirect-buffer)
    )
  (defun inside-and-preview ()
    (interactive)
    "Go to next level heading and show preview in dedicated buffer"
    (org-speed-move-safe (quote outline-next-visible-heading))
    (show-children)
    (org-tree-to-indirect-buffer)
    )
  (defhydra org-nav-hydra (:hint nil)
    "
         _k_
      _h_     _l_
         _j_
    "
    ("h" up-back-and-preview)
    ("j" forward-and-preview)
    ("k" back-and-preview)
    ("l" inside-and-preview)
    ("J" up-forward-and-preview "up forward")
    ("K" up-back-and-preview "up backward")
    ;; ("RET" (windmove-right) "enter preview window") ;; orig RET binding is still active
    ("q" winner-undo "quit" :exit t)
    )
  (defun org-nav ()
    (interactive)
    "Fold everything but the current heading and enter org-nav-hydra"
    (org-overview)
    (org-reveal)
    (org-show-subtree)
    (org-tree-to-indirect-buffer)
    (org-nav-hydra/body)
    )
  (map! :leader (:prefix ("m" . "localleader") "n" #'org-nav))



  (defun tree-forward-and-preview ()
    (interactive)
    "Go to same level next heading and show preview in dedicated buffer"
    (org-speed-move-safe (quote outline-next-visible-heading))
    (org-tree-to-indirect-buffer)
    )
  (defun tree-back-and-preview ()
    (interactive)
    "Go to same level previous heading and show preview in dedicated buffer"
    (org-speed-move-safe (quote outline-previous-visible-heading))
    (org-tree-to-indirect-buffer)
    )
  (defun tree-up-back-and-preview ()
    (interactive)
    "Go to previous level heading and show preview in dedicated buffer"
    (org-speed-move-safe (quote outline-up-heading))
    (org-tree-to-indirect-buffer)
    (hide-subtree)
    )
  (defun tree-down-and-preview ()
    (interactive)
    "Go to previous level next heading and show preview in dedicated buffer"
    (org-speed-move-safe (quote outline-up-heading))
    (hide-subtree)
    (org-speed-move-safe (quote outline-next-visible-heading))
    (org-tree-to-indirect-buffer)
    )
  (defun inside-and-preview ()
    (interactive)
    "Go to next level heading and show preview in dedicated buffer"
    (org-speed-move-safe (quote outline-next-visible-heading))
    (show-children)
    (org-tree-to-indirect-buffer)
    )
  (defhydra org-todo-tree-hydra (:hint nil)
    "
         _k_
      _h_     _l_
         _j_
    "
    ("h" up-back-and-preview)
    ("j" tree-forward-and-preview)
    ("k" tree-back-and-preview)
    ("l" inside-and-preview)
    ("J" up-forward-and-preview "up forward")
    ("K" up-back-and-preview "up backward")
    ;; ("RET" (windmove-right) "enter preview window") ;; orig RET binding is still active
    ("q" winner-undo "quit" :exit t)
    )
  (defun org-todo-tree-nav ()
    (interactive)
    "Fold everything but the current heading and enter org-nav-hydra"
    (org-show-todo-tree nil)
    (org-tree-to-indirect-buffer)
    (org-todo-tree-hydra/body)
    )
  (map! :leader (:prefix ("m" . "localleader") "T" #'org-todo-tree-nav))

  ;; auto save all org files after doing a common action
  (advice-add 'org-agenda-quit      :before #'org-save-all-org-buffers)
  ;; (advice-add 'org-agenda-schedule  :after #'org-save-all-org-buffers)
  (advice-add 'org-agenda-todo      :after #'org-save-all-org-buffers)
  (advice-add 'org-agenda-refile    :after #'org-save-all-org-buffers)
  (advice-add 'org-agenda-clock-in  :after #'org-save-all-org-buffers)
  ;; (advice-add 'org-agenda-clock-out :after #'org-save-all-org-buffers)

  ;; (advice-add 'org-deadline         :after #'org-save-all-org-buffers)
  ;; (advice-add 'org-schedule         :after #'org-save-all-org-buffers)
  ;; (advice-remove 'org-schedule  #'org-save-all-org-buffers)

  (advice-add 'org-todo             :after #'org-save-all-org-buffers)
  (advice-add 'org-refile           :after #'org-save-all-org-buffers)
  ;; (advice-add 'org-clock-in         :after #'org-save-all-org-buffers)
  ;; (advice-add 'org-clock-out        :after #'org-save-all-org-buffers)
  (advice-add 'org-store-log-note   :after #'org-save-all-org-buffers)

  ;; also, let's turn on auto-fill-mode
  (add-hook 'org-mode-hook 'auto-fill-mode)
  )

;; The standard unicode characters are usually misaligned depending on the
;; font. This bugs me. Markdown #-marks for headlines are more elegant.
(after! org-bullets
  (setq org-bullets-bullet-list '("*")))