(require 'package)
(dolist (i '(("marmalade" . "http://marmalade-repo.org/packages/")
	     ("elpa" . "http://tromey.com/elpa/")
	     ("melpa" . "http://melpa.milkbox.net/packages/")))
  (add-to-list 'package-archives i t))

(setq pkg:packages
      '(slime
	magit
	auto-complete
	company
	helm-company
	ac-slime
	ac-helm
	fill-column-indicator

	solarized-theme
	monokai-theme
	calmer-forest-theme
	birds-of-paradise-plus-theme
	nyan-mode
        neotree
	
	projectile
	helm
	helm-projectile
	paredit
	hideshow
	rainbow-delimiters
	rainbow-identifiers
	multiple-cursors
	indent-guide

	highlight-parentheses
	hl-sexp
	rainbow-blocks
        highlight-80+

	fsharp-mode
	cider
        ac-cider
        
	web-mode
        coffee-mode
        
        dockerfile-mode

        sql
        sql-indent
        emacsql-psql))

(defun pkg:load-packages ()
  (package-initialize)
  (let ((pkgs (remove-if #'package-installed-p pkg:packages)))
    (when pkgs
      (message "%s" "Emacs refresh packages database...")
      (package-refresh-contents)
      (message "%s" " done.")
      (dolist (p pkgs)
	(package-install p)))))

(pkg:load-packages)
(helm-projectile-on)
