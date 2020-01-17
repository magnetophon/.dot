;;; ~/.dot/common/.doom.d/+org.el -*- lexical-binding: t; -*-


;; ORG config

(after! evil-collection-outline
  (setq evil-collection-outline-bind-tab-p nil))

(after! org
  ;;use org mode for eml files (useful for thunderbird plugin)
  (add-to-list 'auto-mode-alist '("\\.eml\\'" . mu4e-compose-mode))

  (setq org-startup-folded nil ; do not start folded
        org-log-done 'nil ;time is recorded in LOGBOOK
        org-fontify-done-headline nil ; do not change the font of DONE items
        org-return-follows-link t  ; RET follows links
        org-hide-emphasis-markers t ; do not show format markers
        org-startup-with-inline-images t ; open buffers show inline images
        org-agenda-files (directory-files-recursively "~/org" "\.org$")
        ;; see https://orgmode.org/manual/Tracking-TODO-state-changes.html#Tracking-TODO-state-changes
        org-todo-keywords
        '((sequence "TODO(t)" "|" "DONE(d!)" "PASSED-ON(p@)")
          (sequence "NEXT(n)" "WAITING(w@/!)" "LATER(l)" "|" "CANCELLED(c@)"))
        ;; hl-todo-keyword-faces
        ;; `(("TODO"     . ,(face-foreground 'warning))
        ;;   ("NEXT"     . ,(face-foreground 'warning))
        ;;   ("WAITING"  . ,(face-foreground 'warning))
        ;;   ("LATER"    . ,(face-foreground 'warning))
        ;;   ("CANCELED" . ,(face-foreground 'error))
        ;;   ("DONE"     . ,(face-foreground 'success)))
        ;; hl-todo--regexp
        ;; "\\(\\<\\(TODO\ \\| NEXT \\|WAITING\\)\\(?:\\>\\|\\>\\?\\)\\)"
        org-not-done-heading-regexp
        "^\\(\\*+\\)\\(?: +\\(TODO\\|NEXT\\|WAITING\\|LATER\\)\\)\\(?: +\\(.*?\\)\\)?[ 	]*$"
        org-enforce-todo-dependencies t
        org-enforce-todo-checkbox-dependencies t
        org-hierarchical-todo-statistics nil
        org-checkbox-hierarchical-statistics nil
        org-log-into-drawer t
        ;; prepend the filename for each org target
        org-refile-use-outline-path 'full-file-path
        ;; since we're using ivy just put all the files + headers in a list
        org-outline-path-complete-in-steps nil
        org-M-RET-may-split-line nil
        org-indirect-buffer-display 'other-window
        org-default-notes-file (concat org-directory "/inbox.org")
        deft-directory org-directory
        deft-recursive t
        org-sticky-header-full-path 'full
        org-sticky-header-heading-star "████"
        org-ellipsis " ▼ "
        )

  (after! org-bullets
    (setq org-bullets-bullet-list '("")))
  (custom-set-faces '(org-ellipsis ((t (:foreground "dark gray" :underline nil)))))

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
  (defun up-heading-and-preview ()
    (interactive)
    "Go to previous level heading and show preview in dedicated buffer"
    (org-speed-move-safe (quote outline-up-heading))
    (org-tree-to-indirect-buffer)
    ;; (hide-subtree)
    )
  (defun down-heading-and-preview ()
    (interactive)
    "Go to next level heading and show preview in dedicated buffer"
    (org-speed-move-safe (quote outline-up-heading))
    (hide-subtree)
    (org-speed-move-safe (quote outline-next-visible-heading))
    (show-children)
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
    ("h" up-heading-and-preview)
    ("j" forward-and-preview)
    ("k" back-and-preview)
    ("l" inside-and-preview)
    ("J" down-heading-and-preview "down heading")
    ("K" up-heading-and-preview "up heading")
    ("t" org-todo "org-todo")
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

  (map! :localleader :map org-mode-map "n" #'org-nav)


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
  (defun tree-up-heading-and-preview ()
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


  (defun next-org-not-done-heading-and-preview ()
    (interactive)
    "Go to next not-done task and show preview in dedicated buffer"
    (evil-end-of-line)
    (re-search-forward  org-not-done-heading-regexp nil t)
    (back-to-indentation)
    (org-tree-to-indirect-buffer)
    )
  (defun previous-org-not-done-heading-and-preview ()
    (interactive)
    "Go to previous not-done task and show preview in dedicated buffer"
    (re-search-backward org-not-done-heading-regexp nil t)
    (back-to-indentation)
    (org-tree-to-indirect-buffer)
    )

  (defhydra org-todo-tree-hydra (:hint nil)
    "
         _k_
      _h_     _l_
         _j_
    "
    ("h" up-heading-and-preview)
    ("j" next-org-not-done-heading-and-preview)
    ("k" previous-org-not-done-heading-and-preview)
    ("l" inside-and-preview)
    ("J" down-heading-and-preview "down heading")
    ("K" up-heading-and-preview "up heading")
    ("t" org-todo "org-todo")
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

  (map! :localleader :map org-mode-map "T" #'org-todo-tree-nav)

  (map! :map org-mode-map
        :m "]t" (lambda! (re-search-forward  org-not-done-heading-regexp nil t))
        :m "[t" (lambda! (re-search-backward org-not-done-heading-regexp nil t)))

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
  (add-hook 'org-mode-hook
            (lambda ()
              (visual-line-mode 1)
              (turn-off-auto-fill)
              (org-sticky-header-mode)))
  )
