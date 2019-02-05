;=================================================
;
;   █████  ██████████   ██████    █████   ██████
;  ██░░░██░░██░░██░░██ ░░░░░░██  ██░░░██ ██░░░░ 
; ░███████ ░██ ░██ ░██  ███████ ░██  ░░ ░░█████ 
; ░██░░░░  ░██ ░██ ░██ ██░░░░██ ░██   ██ ░░░░░██
; ░░██████ ███ ░██ ░██░░████████░░█████  ██████ 
;  ░░░░░░ ░░░  ░░  ░░  ░░░░░░░░  ░░░░░  ░░░░░░ 
;
;=================================================

;============================
; CONFIGURACIONES GENERALES
;============================



(defun my-frame-config (&optional frame)
  (with-selected-frame (or frame (selected-frame))
    ;==== Telephone line ====
(require 'telephone-line)
(setq telephone-line-lhs
'((evil . (telephone-line-evil-tag-segment))
(accent . (telephone-line-vc-segment
    telephone-line-erc-modified-channels-segment
    telephone-line-process-segment))
(nil . (telephone-line-buffer-segment))))

(setq telephone-line-subseparator-faces '()) 
(setq telephone-line-primary-left-separator 'telephone-line-abs-left
telephone-line-secondary-left-separator 'telephone-line-abs-hollow-left
telephone-line-primary-right-separator 'telephone-line-abs-right
telephone-line-secondary-right-separator 'telephone-line-abs-hollow-right)
(setq telephone-line-height 24)
(telephone-line-mode 1)


(use-package nord-theme
  :ensure t
  :config
  (setq nord-region-highlight "frost")
  (setq nord-comment-brightness 15)
  :init
  (load-theme 'nord t))

))
(add-hook 'after-make-frame-functions 'my-frame-config)
(add-hook 'after-init-hook 'my-frame-config)

;; Responder y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Desplazarse una línea en lugar de media página
(setq scroll-conservatively 100)

;; Destacar la línea donde está el cursor
(global-hl-line-mode t)

;; Mandar los archivos de autosave a un directorio especial
(setq backup-directory-alist
      `((".*" . ,"~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs.d/backups/")))

;; Ocultar barras de menús y despalzamiento
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(global-set-key (kbd "M-m") 'menu-bar-mode) ; M-m hace aparecer el menú

;; IDO
(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Abrir configuración con C-c e
(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-c e") 'config-visit)

;; Reevaluar init.el
(global-set-key (kbd "C-c r") '(load-file "~/.emacs.d/init.el"))

;; Seguir al buffer nuevo
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;; Paréntesis automáticos
(setq electric-pair-pairs '(
		      (?\( . ?\))
		      (?\[ . ?\])
		      (?\{ . ?\})
		      ))
(electric-pair-mode t)

;; Muestra línea y columna actual en mode-line
(line-number-mode 1)
(column-number-mode 1)

;; Matar buffer actual
(defun kill-curr-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-curr-buffer)

;; Visual line mode
(global-set-key (kbd "C-c v") 'visual-line-mode)

;; Dashboard al iniciar
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

;; Flyspell con F5
(global-set-key (kbd "<f5>")  'ispell-word) 

;; Mostrar números de línea
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;===============
; REPOSITORIOS
;===============

(package-initialize)
(require 'package)

;; Repositorio melpa
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
(add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
(when (< emacs-major-version 24)
;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

;; Repositorio local
(add-to-list 'load-path "~/.emacs.d/modes")

;; Definir cuando descargar paquetes
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;===============
; PAQUETES
;===============

;==== which key ====
(use-package which-key
  :ensure t
  :init
  (which-key-mode))


;;==== elfeed ====
(use-package elfeed
  :ensure t
  :bind ( :map elfeed-search-mode-map
	       ("q" . bjm/elfeed-save-db-and-bury)
	       ("Q" . bjm/elfeed-save-db-and-bury)
	       ("m" . elfeed-toogle-star)
	       ("M" . elfeed-toogle-star)
	       )
)

;;==== IDO-vertical =====
(use-package ido-vertical-mode
    :ensure
    :init
    (ido-vertical-mode 1))

;;==== Smex ====
(use-package smex
   :ensure t
   :init (smex-initialize)
   :bind
   ("M-x" . smex))

;;==== Avy ====
(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

;;==== Rainbow ====
(use-package rainbow-mode
   :ensure t
   :config (rainbow-mode))

;;==== Ace window ====
(use-package ace-window
   :ensure t
   :init (ace-window 1))
(global-set-key (kbd "C-x o") 'ace-window)

;;==== Dashboard ====
(use-package dashboard
  :ensure t
 :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)
		      (bookmarks . 5)
		      (projects . 5))))
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-banner-logo-title "Inserte frase edgy aquí")      (add-to-list 'dashboard-items '(agenda) t)
  (setq show-week-agenda-p t)

;;==== Ox-reveal =====
(require 'ox-reveal)
(setq org-reveal-root "file:///home/equipo/reveal.js")
(setq org-reveal-title-slide nil)

;;==== Yassnippet ====
(use-package yasnippet
   :ensure t
   :config
   (yas-global-mode)
   (use-package yasnippet-snippets
   :ensure t)
   (yas-reload-all))

;;==== Projectile ====
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy))
(global-set-key (kbd "C-c p") 'projectile-switch-project)
(global-set-key (kbd "C-c f") 'projectile-find-file)

;;==== Swiper ====
(use-package swiper
  :ensure t
  :bind (("C-s" . swiper))
  )

;;==== Auto-complete ====
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

;;==== Evil-mode ====
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
;; Make movement keys work respect visual lines
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;; Make horizontal movement cross lines
(setq-default evil-cross-lines t))

;;==== Nov.el ====
(use-package nov
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;;==== Neotree ====
(use-package neotree
  :ensure t
  :config
  (global-set-key [f8] 'neotree-toggle)
)

;;==== Ox-pandoc ====
(use-package ox-pandoc
  :ensure t)
(setq helm-bibtex-format-citation-functions
      '((org-mode . (lambda (x) (insert (concat
                                         "\\cite{"
                                         (mapconcat 'identity x ",")
                                         "}")) ""))))

;;==== Magit ====
(use-package magit
  :ensure t
)
(global-set-key (kbd "C-x g") 'magit)

;;==== Pdf-tools ====
(use-package pdf-tools
  :pin manual
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-annot-activate-created-annotations t))

  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (define-key pdf-view-mode-map (kbd "j") 'pdf-view-next-line-or-next-page)
  (define-key pdf-view-mode-map (kbd "k") 'pdf-view-previous-line-or-previous-page)
  (define-key pdf-view-mode-map (kbd "l") 'image-forward-hscroll)
  (define-key pdf-view-mode-map (kbd "h") 'image-backward-hscroll)
  (define-key pdf-view-mode-map (kbd "J") 'pdf-view-next-page)
  (define-key pdf-view-mode-map (kbd "K") 'pdf-view-previous-page)
  (define-key pdf-view-mode-map (kbd "u") 'pdf-view-scroll-down-or-previous-page)
  (define-key pdf-view-mode-map (kbd "d") 'pdf-view-scroll-up-or-next-page)
  (define-key pdf-view-mode-map (kbd "0") 'image-bol)
  (define-key pdf-view-mode-map (kbd "$") 'image-eol)
         ;; Scale/Fit
  (define-key pdf-view-mode-map (kbd "W") 'pdf-view-fit-width-to-window)
  (define-key pdf-view-mode-map (kbd "H") 'pdf-view-fit-height-to-window)
  (define-key pdf-view-mode-map (kbd "P") 'pdf-view-fit-page-to-window)
  (define-key pdf-view-mode-map (kbd "m") 'pdf-view-set-slice-using-mouse)
  (define-key pdf-view-mode-map (kbd "b") 'pdf-view-set-slice-from-bounding-box)
  (define-key pdf-view-mode-map (kbd "R") 'pdf-view-reset-slice)
  (define-key pdf-view-mode-map (kbd "zr") 'pdf-view-scale-reset)
        ;; Annotations
  (define-key pdf-view-mode-map (kbd "aD") 'pdf-annot-delete)
  (define-key pdf-view-mode-map (kbd "a t") 'pdf-annot-attachment-dired); :exit t)
  (define-key pdf-view-mode-map (kbd "al") 'pdf-annot-list-annotations); :exit t)
  (define-key pdf-view-mode-map (kbd "am") 'pdf-annot-add-markup-annotation)
        ;; Actions
  (define-key pdf-view-mode-map (kbd "s") 'pdf-occur); :exit t)
  (define-key pdf-view-mode-map (kbd "O") 'pdf-outline); :exit t)
  (define-key pdf-view-mode-map (kbd "p") 'pdf-misc-print-document); :exit t)
  (define-key pdf-view-mode-map (kbd "o") 'pdf-links-action-perform); :exit t)
  (define-key pdf-view-mode-map (kbd "r") 'pdf-view-revert-buffer)
  (define-key pdf-view-mode-map (kbd "t") 'pdf-annot-attachment-dired); :exit t)
  (define-key pdf-view-mode-map (kbd "n") 'pdf-view-midnight-minor-mode)
;  (define-key pdf-view-mode-map (kbd "q") 'nil :exit t)


;;====================================
;; CONFIGURACIONES DE ORG-MODE
;;====================================

;;==== org bullets ====
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode)))

;;==== org-agenda ====
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-window-setup
      'other-window)

;;==== próximos 14 dias en agenda ====
(setq org-agenda-span 14)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-start-day "-3d")

;;==== Añadir partes de un archivo como link ====
(global-set-key (kbd "C-c l") 'org-store-link)

;;==== org-capture ====
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-capture-templates
 '(("t" "TODO" entry
   (file+headline "~/Drive/sync/cuaderno/index.org" "TO-DO")
   "* TODO %?\n%t" :prepend t)
  ("n" "Notas" entry
   (file+headline "~/Drive/sync/cuaderno/index.org" "Notas")
   "* %?" :prepend t)
  ("d" "Diario" entry
   (file+olp+datetree "~/Drive/sync/cuaderno/diario.org")
   "* %?" :prepend t)
))

;;==== Shift support ====
(setq org-support-shift-select t)

;;==== Ortografía ====
(add-hook 'org-mode-hook 'turn-on-flyspell)

;;==== Org-ref ====
(use-package org-ref
  :ensure t)
(setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))

;;==== Cireproc-org ====
(add-to-list 'load-path "/home/equipo/.emacs.d/modes/")
(require 'citeproc-org)
;  (citeproc-org-setup)
'(citeproc-org-locales-dir "/home/equipo/.emacs.d/csl-locales/")

;;==== <el = emacs-lisp ====
(add-to-list 'org-structure-template-alist
       '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))

;;==== Exportar en beamer ====
'(org-beamer-mode 1)

;;==== Formatos extra para latex ====
(add-to-list 'org-latex-classes
      '("koma-article"
	"\\documentclass{scrartcl}"
	("\\section{%s}" . "\\section*{%s}")
	("\\subsection{%s}" . "\\subsection*{%s}")
	("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	("\\paragraph{%s}" . "\\paragraph*{%s}")
	("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
	    
(add-to-list 'org-latex-classes
	     '("doc-recepcional"
	       "\\documentclass{report}"
	       ("\\chapter{%s}" . "\\chapter*{%s}")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
	       )
)

;;===============================
;; CONFIGURACIONES AUTOMÁTICAS
;;===============================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(citeproc-org-bibtex-export-use-affixes t)
 '(citeproc-org-suppress-author-cite-link-types (quote ("citet")))
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (nord)))
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "f66ffeadda7b52d40c8d698967ae9e9836f54324445af95610d257fa5e3e1e21" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a94f1a015878c5f00afab321e4fef124b2fc3b823c8ddd89d360d710fc2bddfc" "0cd56f8cd78d12fc6ead32915e1c4963ba2039890700458c13e12038ec40f6f5" "de0b7245463d92cba3362ec9fe0142f54d2bf929f971a8cdf33c0bf995250bcf" "251348dcb797a6ea63bbfe3be4951728e085ac08eee83def071e4d2e3211acc3" "3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" "721bb3cb432bb6be7c58be27d583814e9c56806c06b4077797074b009f322509" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "bf390ecb203806cbe351b966a88fc3036f3ff68cd2547db6ee3676e87327b311" "0c32e4f0789f567a560be625f239ee9ec651e524e46a4708eb4aba3b9cdc89c5" "1e9001d2f6ffb095eafd9514b4d5974b720b275143fbc89ea046495a99c940b0" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" default)))
 '(delete-selection-mode nil)
 '(elfeed-feeds
   (quote
    ("http://www.xatakaciencia.com/index.xml" "http://www.muyinteresante.com.mx/home.rss/" "http://www.theverge.com/rss/full.xml" "http://www.malavida.com/rss/nov-all/es/0/winlinmac_ultima_act.xml" "http://feeds.feedburner.com/Malavida" "http://metalportuculo.com/feed" "http://www.elportaldelmetal.com/rss.xml" "http://www.metalsucks.net/feed/rss/" "http://feeds2.feedburner.com/metalinjection" "http://colectivopericu.wordpress.com/feed/" "http://www.bcsnoticias.mx/feed/" "https://manjaro.org/feed.xml" "https://kernelpanicblog.wordpress.com/feed/" "https://mantisfistjabn.wordpress.com/feed/" "http://feeds.feedburner.com/ElBlogDeEnriqueDans" "http://www.xatakandroid.com/index.xml" "http://es.engadget.com/rss.xml" "http://www.xatakamovil.com/atom.xml" "http://www.genbeta.com/index.xml" "http://www.elandroidelibre.com/feed/" "http://feeds.weblogssl.com/xataka2" "http://www.jornada.unam.mx/rss/edicion.xml" "http://www.eluniversal.com.mx/rss/mexico.xml" "http://news.google.com/news?hl=en&gl=us&q=NoticiasM%C3%A9xico&um=1&ie=UTF-8&output=rss" "http://feeds.feedburner.com/proceso" "http://eldeforma.com/feed/" "http://www.reforma.com/rss/portada.xml" "http://www.elpais.com/rss/feed.html?feedId=1022" "http://www.teamfortress.com/rss.xml" "http://feeds.ign.com/ign/games-all" "http://www.vandal.net/cgi-bin/xml.cgi" "http://www.eurogamer.es/rss/eurogamer_frontpage_feed.rss" "http://www.3djuegos.com/universo/rss/rss.php?plats=1-2-3-4-5-6-7&tipos=noticia-analisis-avance-video-imagenes-demo&fotos=no&limit=20" "https://blog.xfce.org/feed")))
 '(evil-want-C-i-jump nil)
 '(fci-rule-color "#383838")
 '(flyspell-default-dictionary "espanol")
 '(frame-background-mode nil)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors
   (quote
    ("#B9F" "#B8D" "#B7B" "#B69" "#B57" "#B45" "#B33" "#B11")))
 '(hl-sexp-background-color "#1c1f26")
 '(inhibit-startup-screen t)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(org-agenda-files nil)
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "zathura %s"))))
 '(package-selected-packages
   (quote
    (pdf-tools nov powerline solarized-theme magit helm-projectile swiper-helm mu4e-alert citeproc-org ox-word ox-pandoc auctex org-ref neotree spaceline smart-mode-line-atom-one-dark-theme smart-mode-line airline-themes evil rainbow-delimiters rainbow-delimeters expand-region auto-complete try foo 2048-game chess ace-window ztree counsel-projectile projectile org-beamer-mode demo-it latex-math-preview yasnippet-snippets yasnippet markdown-preview-mode markdown-mode+ markdown-mode epresent htmlize ox-reveal company dashboard switch-window avy smex ido-vertical-mode spacemacs-theme elfeed org-bullets nord-theme zenburn-theme telephone-line which-key use-package rich-minority python material-theme arjen-grey-theme)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(rainbow-delimiters-max-face-count 5)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :family "Fantasque Sans Mono"))))
 '(border ((t nil)))
 '(cursor ((t nil)))
 '(highlight ((t (:background "#85BBCA" :foreground "#e1e1e0"))))
 '(hl-line ((t (:inherit nil :background "#404451"))))
 '(mode-line ((t (:foreground "light gray"))))
 '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :foreground "gray45"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "dark violet"))))
 '(rainbow-delimiters-depth-3-face ((t (:inherit rainbow-delimiters-base-face :foreground "goldenrod"))))
 '(rainbow-delimiters-depth-4-face ((t (:inherit rainbow-delimiters-base-face :foreground "cyan4"))))
 '(rainbow-delimiters-depth-5-face ((t (:inherit rainbow-delimiters-base-face :foreground "sky blue"))))
 '(region ((t nil)))
 '(spaceline-evil-normal ((t (:background "#BF616A" :foreground "#3E3D31" :inherit (quote mode-line)))))
 '(spaceline-highlight-face ((t (:background "SkyBlue2" :foreground "#3E3D31" :inherit (quote mode-line)))))
 '(spaceline-modified ((t (:background "#BF616A" :foreground "#3E3D31" :inherit (quote mode-line)))))
 '(spaceline-unmodified ((t (:background "SkyBlue2" :foreground "#3E3D31" :inherit (quote mode-line)))))
 '(telephone-line-accent-active ((t (:inherit mode-line :background "#3B4251" :foreground "white")))))

