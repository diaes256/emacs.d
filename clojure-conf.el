(defun clojure:namespace-refresh ()
  (interactive)
  (save-some-buffers)
  (cider-interactive-eval
   "(ns user)
    (require 'clojure.tools.namespace.repl)
    (clojure.tools.namespace.repl/set-refresh-dirs \"src/main/clojure\" \"src\" )
    (when (resolve 'user/stop-app)
      (print :stop-app (eval '(user/stop-app))))
    (let [refresh-result (clojure.tools.namespace.repl/refresh)]
      (when-not (instance? java.lang.Exception refresh-result)
        (when (.exists (java.io.File. \"./dev-src/user.clj\"))
          (load-file \"./dev-src/user.clj\"))
        (when (resolve 'user/start-app)
          (print :start-app (eval '(user/start-app)))))
      (print refresh-result)
      refresh-result)"))

(defun clojure:connect-repl ()
  (interactive)
  (cider-connect "localhost" 4005))

(defun clojure:mvn-repl ()
  (interactive)
  (cider-connect "localhost"))

(defun clojure:config-shortcuts ()
  (cl-flet ((d (key func)
	       (let ((keymap (kbd key)))
		 (define-key clojure-mode-map keymap func)
		 (define-key cider-repl-mode-map keymap func)
		 (define-key cider-mode-map keymap func))))
    (d "C-c d"     'ac-cider-popoup-doc)
    (d "C-c C-d d" 'cider-doc)
    (d "C-c C-c"   'cider-eval-defun-at-point)
    (d "C-c s r"   'cider-restart)
    (d "C-c t"     'cider-run-tests)
    (d "C-c TAB"   'helm-company)
    (d "C-c r"     'clojure:namespace-refresh)
    (d "C-c M-j"   'clojure:connect-repl)))

(defun clojure:hook ()
  (cider-mode)
  (lisp:edit-modes)
  (auto-complete-mode -1)
  (company-mode t)
  (clojure:config-shortcuts))

(add-hook 'clojure-mode-hook 'clojure:hook)
(add-hook 'cider-repl-mode-hook 'company-mode)

(setq cider-repl-clear-help-banner nil)
