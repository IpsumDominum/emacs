(require 'counsel)
(require 'magit)

(defun record-keyboard-macro-string()
  (interactive)
  (kill-new (key-description (read-key-sequence-vector "Key:"))))

(defun hellothere()
  (interactive)
  (kill-new "hello there"))

(defun dired-jump-reinforcementlearning()
  (interactive)
  (dired-jump t "/home/ipsum/Desktop/AI stuff/Reinforcement learning/")
  )
(defun open-config-file()
  (interactive)
  (find-file "/home/ipsum/emacs/init.el")
  )
(defun dired-jump-config-files()
  (interactive)
  (dired-jump t "/home/ipsum/emacs/")
  )

(defun my-counsel-ag()
  (interactive)
  (let((initsearch (if (region-active-p) (selection) nil)))
    (counsel-ag initsearch)))
;;(defun run-python()
  ;;())
(defun str (thing)
  "converts object or string to an unformatted string."
  (setq thing (format "%s" thing))
  (set-text-properties 0 (length thing) nil thing)
  thing)
(defun my/selected-text ()
  "Just give me the selected text as a string. If it's empty, then nothing was selected. region-active-p does not work for evil selection."
  (interactive)
  (if (or (region-active-p) (eq evil-state 'visual))
      (str (buffer-substring (region-beginning) (region-end)))))
(defalias 'get-selection 'my/selected-text)
(defalias 'selection 'my/selected-text)
(defalias 'selected-text 'my/selected-text)

(defun create-new-repo()
  (interactive)
  (let ((dir-name-choices '("blogs" "random" "projects")))        
    (let ((dir-name (concat "/home/ipsum/git-repos/" (ido-completing-read "Which type?:" dir-name-choices)
                            (read-string "Enter name of repo:"))))
      (magit-init dir-name)
      (dired-jump t dir-name))
    )
  )
(defun enter-repo()
  (interactive)
  (let ((dir-name-choices '("blogs" "random" "projects")))
    (dired-jump t (concat  "/home/ipsum/git-repos/" (ido-completing-read "Which type?:" 'dir-name-choices) "/")))
  )


(define-prefix-command 'my-prefix-m-l)
(define-prefix-command 'my-prefix-m-g)
(global-set-key (kbd "M-l") 'my-prefix-m-l)
(global-set-key (kbd "M-g") 'my-prefix-m-g)


(define-key global-map (kbd "M-?") #'my-counsel-ag)
(define-key global-map (kbd "M-l M-i") 'package-install)
(define-key global-map (kbd "M-l k") 'record-keyboard-macro-string)
(define-key global-map (kbd "M-l h") 'hellothere)
(define-key global-map (kbd "M-l r") 'dired-jump-reinforcementlearning)
(define-key global-map (kbd "M-l c") 'dired-jump-config-files)
(define-key global-map (kbd "M-l C-c") 'open-config-file)

(define-key global-map (kbd "M-g i") 'create-new-repo)
(define-key global-map (kbd "M-g e") 'enter-repo)



