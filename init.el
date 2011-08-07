

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 164 :width normal :foundry "bitstream" :family "Bitstream Vera Sans Mono")))))

;; disable menu- and tool-bar
(tool-bar-mode 0)
;; (menu-bar-mode 0)

;; browse urls in emacs buffer
(setq browse-url-browser-function 'w3m-browse-url)

;; paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d/shared"))

;; ergonomic layout
(require 'edmacro)
(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us") ; US layout
(load "ergoemacs-keybindings-5.1/ergoemacs-mode")
;; (define-key ergoemacs-keymap (kbd "C-j") 'newline-and-indent)
(define-key ergoemacs-keymap (kbd "M-n") 'newline-and-indent)
(define-key ergoemacs-keymap (kbd "C-S-l") 'forward-sexp)
(define-key ergoemacs-keymap (kbd "C-S-j") 'backward-sexp)
(define-key ergoemacs-keymap (kbd "C-S-i") 'backward-up-list)
(define-key ergoemacs-keymap (kbd "C-S-k") 'down-list)
(define-key ergoemacs-keymap (kbd "M-TAB") 'dabbrev-expand)

(setq parens-require-spaces nil)

(defun my/insert-brackets ()
  (interactive)
  (insert-pair nil ?{ ?}))

(defun my/insert-quotes ()
  (interactive)
  (insert-pair nil ?\" ?\"))

(define-key ergoemacs-keymap (kbd "M-(") 'my/insert-brackets)
(define-key ergoemacs-keymap (kbd "\"") 'my/insert-quotes)

(ergoemacs-mode 1)

;; jdee
;; (add-to-list 'load-path (expand-file-name "/usr/local/jdee/lisp"))
;; (load "jde-autoload")

;; (defun my/jde-indent-or-complete ()
;;   "Complete if point is at end of a word, otherwise indent line."
;;   (interactive)
;;   (if (looking-at "\\>")
;;       ;; throws unknown method
;;       (jde-complete-minibuf)
;;       ;;(semantic-ia-complete-symbol)
;;     (indent-for-tab-command)
;;     ))

;; (defun my/jde-mode-hook ()
;;   (local-set-key (kbd "<tab>") 'my/jde-indent-or-complete)
;;   (local-set-key (kbd "C-<f7>") 'jde-compile)
;;   (local-set-key (kbd "<f5>") 'jde-debug)
;;   (local-set-key (kbd "s-d") 'jde-browse-class-at-point)
;;   (local-set-key (kbd "C-c <SPC>") 'jde-debug-toggle-breakpoint)
;; )

;; (add-hook 'jde-mode-hook 'my/jde-mode-hook)


;; ;; d-mode
;; (autoload 'd-mode "d-mode" "Major mode for editing D code." t)
;; (add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode))

;; cppref
(setq cppref-doc-dir "~/.emacs.d/shared/emacs-cppref/docs")
(load "emacs-cppref/cppref")
(require 'cppref)

;; ;; cedet
(load "rc-cedet")
(semantic-add-system-include "/usr/include/c++/4.2" 'c-mode)
(semantic-add-system-include "/usr/local/share/OGRE/samples/Common/include" 'c-mode)
(semantic-add-system-include "/usr/local/include/OGRE" 'c-mode)
(semantic-add-system-include "/usr/local/include/OIS" 'c-mode)
(semantic-add-system-include "/usr/local/include" 'c-mode)
(semantic-add-system-include "/usr/include/boost" 'c-mode)
(semantic-add-system-include "/usr/include/CEGUI" 'c-mode)
(semantic-add-system-include "/usr/include/c++/4.2" 'c++-mode)
(semantic-add-system-include "/usr/local/share/OGRE/samples/Common/include" 'c++-mode)
(semantic-add-system-include "/usr/local/include/OGRE" 'c++-mode)
(semantic-add-system-include "/usr/local/include/OIS" 'c-mode)
(semantic-add-system-include "/usr/local/include" 'c++-mode)
(semantic-add-system-include "/usr/include/boost" 'c++-mode)
(semantic-add-system-include "/usr/include/CEGUI" 'c++-mode)

;; cedet projects
;;  (ede-cpp-root-project "app0" :file "/home/tima/src/cpp/ogre/app0/main.cpp"
;;      :include-path '( "/" )
;; ;;     :system-include-path '( "/usr/include" )
;;      :spp-table '( ("pure" . "=0")
;;                    ("CONST" . "const") )
;;      :spp-files '( "stdafx.h" "all.h" "Common.h" )
;;      ) 

;; sunrise commander
(load "sunrise-commander")

;; wander lust
(load "rc-wl.el")

;; ;; elim
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/shared/elim"))
;; (setq garak-icon-directory (expand-file-name "~/.emacs.d/shared/elim/icons/"))
;; (setq elim-executable (expand-file-name "~/.emacs.d/shared/elim/elim-client"))
;; (autoload 'garak "garak" nil t)

;; ; haskell mode
;; (add-to-list 'load-path (expand-file-name "/usr/share/emacs/site-lisp/haskell-mode"))
;; (autoload 'haskell-mode "haskell-mode" nil t)

;; ; g-client
;; ;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/shared/g-client"))
;; ;; (load "gnotebook")


;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; ;; clojure-mode
;; ;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/clojure-mode")
;; ;; (require 'clojure-mode)

;; ;; (defun clojure-indent-or-expand (arg)
;; ;;   "Either indent according to mode, or expand the word preceding
;; ;; point."
;; ;;   (interactive "*P")
;; ;;   (if (and
;; ;;        (or (bobp) (= ?w (char-syntax (char-before))))
;; ;;        (or (eobp) (not (= ?w (char-syntax (char-after))))))
;; ;;       (dabbrev-expand arg)
;; ;;     (indent-according-to-mode)))
 
;; ;; (defun clojure-tab-fix ()
;; ;;   (local-set-key [tab] 'clojure-indent-or-expand))
 
;; ;; (add-hook 'emacs-lisp-mode-hook 'clojure-tab-fix)
;; ;; (add-hook 'clojure-mode-hook    'clojure-tab-fix)

;; ;; transparent encryption
(require 'epa-file)
(epa-file-enable)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

(defun add-note ()
  "Create a new note as ~/.notes/year/month/day/HH_MM_SS.org.gpg"
  (interactive)
  (let* ((dir (expand-file-name (format-time-string "~/.notes/%Y/%m/%d" (current-time))))
	 (file (concat dir (format-time-string "/%H_%M_%S.org.gpg" (current-time))))
	 )
    (make-directory dir t)
    (find-file file)
    )
  )
