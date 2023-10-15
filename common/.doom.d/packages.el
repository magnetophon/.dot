;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

;; undo-tree
;; (package! undo-tree :disable t)

;; mu4e
;; (package! helm-mu)
(package! mu4e-conversation)
;;
;; org-mode
(package! org-sticky-header)
(package! org-sidebar)
;; (package! org-bullets :disable t)
(package! org-superstar :disable t)
;; (package! org-recoll :recipe (:fetcher github :repo "alraban/org-recoll"))

;; don't create ID's when doing org-capture
(package! org-bookmark-heading :disable t)

;; (package! org-roam :recipe (:host github :repo "jethrokuan/org-roam"))

(package! aggressive-indent)

;; magit
(package! magit-todos :disable t)

;; snippets
;; (package! doom-snippets :ignore t)
;; If you want to replace it with yasnippet's default snippets
;; (package! yasnippet-snippets)
;; (package! closql :pin "0a7226331ff1f96142199915c0ac7940bac4afdd")
;; Misc
(package! chatgpt-shell
  :recipe (:host github :repo "xenodium/chatgpt-shell"))
