(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)

(delete-selection-mode 1)  ;;This means when you highlight and hit the delete key it deletes.



;;(load "~/.emacs.d/icicles/icicles-install")
(add-to-list 'load-path "~/.emacs.d/lisp/")
;;(add-to-list 'load-path "~/.emacs.d/icicles")


;; Do not suspend window.
(global-unset-key (kbd "C-z"))

;; 3rd Party Requires

(require 'dirtree)
(require 'buffer-move)
(require 'web-mode)
(require 'smart-tabs-mode)
;;(require 'icicles)
(require 'multiple-cursors)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

;; Custom Mouse Binding
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)


(global-set-key (kbd "M-.") 'mc/mark-next-like-this)
(global-set-key (kbd "M-,") 'mc/unmark-next-like-this)


;; Custom Key Bindings

(global-set-key [(ctrl x) (ctrl b)] 'buffer-menu)

(global-set-key [(ctrl shift up)] 'buf-move-up)
(global-set-key [(ctrl shift down)] 'buf-move-down)
(global-set-key [(ctrl shift right)] 'buf-move-right)
(global-set-key [(ctrl shift left)] 'buf-move-left)


(global-set-key [(meta shift up)]  'move-line-up)
(global-set-key [(meta shift down)]  'move-line-down)

;; Allows winmove to move cursor from window to window (Not move windows around)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)


;; Default startup modes
;;(icy-mode 1)

(custom-set-variables
 '(package-selected-packages '(lsp-mode ## multiple-cursors js2-refactor js2-mode))
 '(tab-stop-list
   '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Java Script Config

;; Make sure commonn Node.js keywords are defined
(setq-default js2-global-externs '("module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "describe" "it" "before" "after"))
(setq js2-include-node-externs t)

;; Pick Default modes based on file extension
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

;; Set tab size
(setq js-indent-level 4 indent-level 4)
(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 4)))
(smart-tabs-advice js2-indent-line js2-basic-offset)
(setq-default tab-width 4)
;;(setq-default indent-tabs-mode t)
(setq-default tab-stop-list    ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; C++ Config
(c-set-offset 'access-label 0)
(c-add-style "custom-c++-style"
  '("stroustrup"
    (c-basic-offset   . 4)
    (c-offsets-alist  . ((inline-open         . 0)
                         (brace-list-open     . 0)
                         (inextern-lang       . 0)
                         (innamespace         . 4)
                         (inlambda            . 4)
                         (statement-case-open . +)))
     (c-hanging-braces-alist . (
         (defun-open  after)
         (class-open before)
         (inline-open before)
         (block-open  before)
         (block-close .  c-snug-do-while)
         (statement-cont)
         (substatement-open before)
         (statement-case-open after)
         (brace-list-open)
         (brace-entry-open)
         (extern-lang-open after)
         (namespace-open  after)
         (module-open  after)
         (composition-open  after)
         (inexpr-class-open  after)
         (inexpr-class-close  before)
         (arglist-cont-nonemcdpty)
         )
         )
        )
  )

(defun custom-c++-mode-hook ()
  (c-set-style "custom-c++-style")        ; use my-style defined above
  (c-toggle-auto-hungry-state 1)
 )

(add-hook 'c++-mode-hook 'custom-c++-mode-hook )

;; Python Config

(add-hook 'python-mode-hook
	    (lambda ()
		  (setq tab-width 4)
		  (setq python-indent-offset 4)
		  ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; CSS/HTML Config


(add-hook 'css-mode-hook (lambda()(setq indent-tabs-mode t) (setq tab-width 4)))

(add-hook 'html-mode-hook
          (lambda()
            (setq tab-width 4)
			(setq sgml-basic-offset 4)
            (setq indent-tabs-mode t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Org Mode Config

;; Make sure that the moving of windows still works in org mode.
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set Default formats
(setq tab-width 4)
(setq-default c-basic-offset 4)

(smart-tabs-insinuate 'c 'c++ 'javascript 'python)

;; Try to avoid poluting working directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq lock-file-name-transforms
	  `((".*" ,temporary-file-directory t)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Make the Emacs window appropriately sized
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 180 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
        (add-to-list 'default-frame-alist (cons 'width 180))
      (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
                 (cons 'height (/ (- (x-display-pixel-height) 200) (frame-char-height)))))))
(set-frame-size-according-to-resolution)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load "tree-widget"
  '(if (boundp 'tree-widget-themes-load-path)
       (add-to-list 'tree-widget-themes-load-path "~/.emacs.d/")))
(autoload 'imenu-tree "imenu-tree" "Imenu tree" t)
(autoload 'tags-tree "tags-tree" "TAGS tree" t)



(if (= 1 (length command-line-args)) 
    (progn
       (interactive)
       (dirtree "." 1)
       (set-window-dedicated-p (selected-window) t)
       )
  )

;;(win:startup-with-window)
(add-hook 'js-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(fset 'insert-python-main
   "def main():\C-mpass\C-m\C-mif __name__==\"__main__\":\C-mmain()\C-m\C-?")


(setq pop-up-windows nil)

(defun my-display-buffer-function (buf not-this-window)
  (if (and (not pop-up-frames) (one-window-p)
           (or not-this-window (not (eq (window-buffer (selected-window)) buf))) (> (frame-width) 162))
      (split-window-horizontally))
  ;; Note: Some modules sets `pop-up-windows' to t before calling
  ;; `display-buffer' -- Why, oh, why!
  (let ((display-buffer-function nil)
        (pop-up-windows nil))
    (display-buffer buf not-this-window)))


;;(setq display-buffer-function 'my-display-buffer-function)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
