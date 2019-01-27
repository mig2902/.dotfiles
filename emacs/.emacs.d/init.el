;;================================================
;   █████  ██████████   ██████    █████   ██████
;  ██░░░██░░██░░██░░██ ░░░░░░██  ██░░░██ ██░░░░ 
; ░███████ ░██ ░██ ░██  ███████ ░██  ░░ ░░█████ 
; ░██░░░░  ░██ ░██ ░██ ██░░░░██ ░██   ██ ░░░░░██
; ░░██████ ███ ░██ ░██░░████████░░█████  ██████ 
;  ░░░░░░ ░░░  ░░  ░░  ░░░░░░░░  ░░░░░  ░░░░░░  
;================================================

;; Repositorios
;;==================

(package-initialize)
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
   (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

(add-to-list 'load-path "~/.emacs.d/modes")

;;Definir cuando descargar paquetes
;;====================================

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Wich-key
;;===============

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;;Llamar al config.org
;;=========================

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
(global-hl-line-mode 1)
(set-face-background 'highlight "#202734")
(set-face-foreground 'highlight nil)



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
    (powerline solarized-theme magit helm-projectile swiper-helm mu4e-alert citeproc-org ox-word ox-pandoc auctex org-ref neotree spaceline smart-mode-line-atom-one-dark-theme smart-mode-line airline-themes nov evil rainbow-delimiters rainbow-delimeters expand-region auto-complete try foo 2048-game chess ace-window ztree counsel-projectile projectile org-beamer-mode demo-it latex-math-preview yasnippet-snippets yasnippet markdown-preview-mode markdown-mode+ markdown-mode epresent htmlize ox-reveal company dashboard switch-window avy smex ido-vertical-mode spacemacs-theme elfeed org-bullets nord-theme zenburn-theme telephone-line which-key use-package rich-minority python material-theme arjen-grey-theme)))
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

(rainbow-mode t)
