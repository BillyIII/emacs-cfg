
;;
;; CEDET
;;

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/cedet-1.0pre6/common"))
;;(load "~/.emacs.d/cedet-1.0pre6/common/cedet")
;;(load "~/.emacs.d/shared/cedet/common/cedet")
(require 'cedet)
(require 'semantic)
(require 'srecode)

;;
;; Custom compilers for cegcc
;;

;;(require 'ede-proj)
(require 'ede-proj-obj)

(defvar ede-arm-mingw32ce-gcc-compiler
  (ede-object-compiler
   "ede-c-compiler-arm-mingw32ce-gcc"
   :name "arm-mingw32ce-gcc"
   :dependencyvar '("C_DEPENDENCIES" . "-Wp,-MD,.deps/$(*F).P")
   :variables '(("CC" . "arm-mingw32ce-gcc")
		("C_COMPILE" .
		 "$(CC) $(DEFS) $(INCLUDES) $(CPPFLAGS) $(CFLAGS)"))
   :rules (list (ede-makefile-rule
		 "c-inference-rule"
		 :target "%.o"
		 :dependencies "%.c"
		 :rules '("@echo '$(C_COMPILE) -c $<'; \\"
			  "$(C_COMPILE) $(C_DEPENDENCIES) -o $@ -c $<"
			  )
		 ))
   :autoconf '("AC_PROG_CC" "AC_PROG_GCC_TRADITIONAL")
   :sourcetype '(ede-source-c)
   :objectextention ".o"
   :makedepends t
   :uselinker t)
  "ARM MinGW cross-compiler for C sourcecode."
)


(defvar ede-arm-mingw32ce-g++-compiler
  (ede-object-compiler
   "ede-c-compiler-arm-mingw32ce-g++"
   :name "arm-mingw32ce-g++"
   :dependencyvar '("CXX_DEPENDENCIES" . "-Wp,-MD,.deps/$(*F).P")
   :variables '(("CXX" "arm-mingw32ce-g++")
		("CXX_COMPILE" .
		 "$(CXX) $(DEFS) $(INCLUDES) $(CPPFLAGS) $(CFLAGS)")
		)
   :rules (list (ede-makefile-rule
		 "c++-inference-rule"
		 :target "%.o"
		 :dependencies "%.cpp"
		 :rules '("@echo '$(CXX_COMPILE) -c $<'; \\"
			  "$(CXX_COMPILE) $(CXX_DEPENDENCIES) -o $@ -c $<"
			  )
		 ))
   :autoconf '("AC_PROG_CXX")
   :sourcetype '(ede-source-c++)
   :objectextention ".o"
   :makedepends t
   :uselinker t)
  "ARM MinGW cross-compiler for C sourcecode."
)

(defvar ede-arm-mingw32ce-ld-linker
  (ede-linker
   "ede-arm-mingw32ce-ld-linker"
   :name "arm-mingw32ce-ld"
   :variables  '(("LD" . "arm-mingw32ce-ld")
		 ("LD_LINK" .
		  "$(LD) $(LDFLAGS) -L. -o $@")
		 )
;;   :commands '("$(LD_LINK) $^")
   :commands '("$(LD) $(LDFLAGS) -L. $^ -lstdc++ -lmingw32 -lgcc -lceoldname -lmingwex -lcoredll -lcoredll -lmingw32 -lgcc -lceoldname -lmingwex -lcoredll -o $@")
   :objectextention ".exe")
  "Linker needed for c++ WinCE programs."
)

;;
;; Other configuration
;;

;; Enable EDE (Project Management) features
(global-ede-mode t)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")

;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

;; http://xtalk.msk.su/~ott/common/emacs/rc/emacs-rc-cedet.el.html
;; Alex Ott <alexott@gmail.com>
(require 'semantic-lex-spp)
(require 'semantic-load)

(semantic-load-enable-gaudy-code-helpers)
;; (semantic-load-enable-excessive-code-helpers)
;;(semantic-load-enable-semantic-debugging-helpers)

(setq senator-minor-mode-name "SN")
(setq semantic-imenu-auto-rebuild-directory-indexes nil)
(global-srecode-minor-mode 1)
(global-semantic-mru-bookmark-mode 1)

(require 'semantic-decorate-include)

;; gcc setup
(require 'semantic-gcc)

;; smart complitions
(require 'semantic-ia)

(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local erlang-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))

(require 'eassist)

(global-semantic-tag-folding-mode 1)

;; gnu global support
;; TODO: enable when global is installed
;; (require 'semanticdb-global)
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)
;; (semantic-load-enable-all-exuberent-ctags-support)

(semantic-add-system-include "/usr/include" 'c-mode)
;; header files are opened is c-mode by default
;;(semantic-add-system-include "/usr/include/c++/4.4.3" 'c-mode)

(semantic-add-system-include "/usr/include" 'c++-mode)
;;(semantic-add-system-include "/usr/include/c++/4.4.3" 'c++-mode)

;; setup compile package
;; TODO: allow specifying function as compile-command
(require 'compile)
(setq compilation-disable-input nil)
(setq compilation-scroll-output t)
(setq mode-compile-always-save-buffer-p t)

;; fix tab behaviour in c/c++ mode
(defun my/c-indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
      ;; throws unknown method
      (semantic-complete-analyze-inline)
      ;;(semantic-ia-complete-symbol)
    (indent-for-tab-command)
    ))

;; (defun my/c-func-summary (arg)
;;   "Inserts self & prints summary"
;;   (interactive "p")
;;   (self-insert-command arg)
;;   (semantic-ia-show-summary arg)
;; )

(defun my/check-syntax-c ()
  "Checks C syntax in current buffer"
  (interactive)
  (compile
   (concat "gcc -fsyntax-only " (buffer-file-name))
  )
)

(defun my/check-syntax-c++ ()
  "Checks C++ syntax in current buffer"
  (interactive)
  (compile
   (concat "g++ -fsyntax-only " (buffer-file-name))
  )
)

;; c/c++ hook
(defun my/cedet-c-c++-mode-hook ()
  ;; (local-set-key "." 'semantic-complete-self-insert)
  ;; (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key (kbd "<tab>") 'my/c-indent-or-complete)
  (local-set-key (kbd "s-d") 'semantic-ia-fast-jump)
  (local-set-key (kbd "<f6>") 'senator-force-refresh)
  (local-set-key (kbd "(") 'insert-parentheses)
;;  (local-set-key "(" 'my/c-func-summary)
)

;; c hook
(defun my/cedet-c-mode-hook ()
  (local-set-key (kbd "C-<f7>") 'my/check-syntax-c)
)

;; c++ hook
(defun my/cedet-c++-mode-hook ()
  (local-set-key (kbd "C-<f7>") 'my/check-syntax-c++)
)

(add-hook 'c-mode-common-hook 'my/cedet-c-c++-mode-hook)
(add-hook 'c++-mode-hook 'my/cedet-c-c++-mode-hook)

(add-hook 'c-mode-common-hook 'my/cedet-c-mode-hook)
(add-hook 'c++-mode-common-hook 'my/cedet-c++-mode-hook)

