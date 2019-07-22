;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

;; mu4e
(package! helm-mu)
(package! mu4e-conversation)
;;
;; org-mode
;; (package! org-bullets :disable t)
;; (package! org-recoll :recipe (:fetcher github :repo "alraban/org-recoll"))
(package! aggressive-indent)

;; magit
(package! magit-todos :disable t)
