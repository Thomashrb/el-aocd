# El advent of code data

yet another advent of code input downloader.

- the goal is for this to be programming language agnostic so as long as you use emacs this will do what you want.

## Install and configure

using use-package and straight:

```elisp
(use-package elaocd
  :straight (elaocd :type git :host github :repo "thomashrb/el-aocd")
  :config
  (setq elaocd-session-cookie "<your session cookie>"))
```


## Usage

M-x elaocd-login

M-x elaocd-input
