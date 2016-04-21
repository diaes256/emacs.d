(defun clojure:namespace-refresh ()
  (interactive)
  (save-some-buffers)
  (cider-interactive-eval
   "(ns user)
    (require 'clojure.tools.namespace.repl)
    (clojure.tools.namespace.repl/set-refresh-dirs 
      \"src/main/clojure\" \"src\"
      \"src/test/clojure\" \"test\")
    (when (resolve 'dev/stop)
      (print :stop-app (eval '(dev/stop))))
    (let [refresh-result (clojure.tools.namespace.repl/refresh)]
      (when-not (instance? java.lang.Exception refresh-result)
        (when (resolve 'dev/start)
          (print :start-app (eval '(dev/start)))))
      (print refresh-result)
      refresh-result)"))

(defun clojure:run-tests ()
  (interactive)
  (save-some-buffers)
  (cider-test-run-project-tests))

(defun clojure:connect-repl ()
  (interactive)
  (cider-connect "localhost" 4005))

(defun clojure:config-shortcuts ()
  (cl-flet ((d (key func)
	       (let ((keymap (kbd key)))
		 (define-key clojure-mode-map keymap func)
		 (define-key cider-repl-mode-map keymap func)
		 (define-key cider-mode-map keymap func))))
    (d "C-c d"     'cider-doc)
    (d "C-c C-c"   'cider-eval-defun-at-point)
    (d "C-c s r"   'cider-restart)
    (d "C-c TAB"   'helm-company)
    (d "C-c r"     'clojure:namespace-refresh)
    (d "C-c M-j"   'cider-jack-in)
    (d "C-c M-x"   'clojure:connect-repl)))

(defun clojure:hook ()
  (cider-mode)
  (lisp:edit-modes)
  (auto-complete-mode -1)
  (company-mode t)
  (clojure:config-shortcuts))

(defun clojure:repl-hook ()
  (company-mode t)
  (paredit-mode t)
  (projectile-mode t))

(add-hook 'clojure-mode-hook 'clojure:hook)
(add-hook 'cider-repl-mode-hook 'clojure:repl-hook)

(setq cider-repl-clear-help-banner nil)
