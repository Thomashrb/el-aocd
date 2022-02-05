;;; el-aocd.el --- Advent of Code data
;; Author: Tåmmas
;;; Commentary:
;; advent of code input downloader adventofcode.com helper
;;; Code:

(require 'url)

(defvar elaocd-session-cookie nil
  "Your advent session cookie that has to be set.")

(defvar elaocd-input-dir
  (expand-file-name "~/.config/aocd")
  "The directory for storing your advent of code input.")

(defvar elaocd--input-file "input.txt")

(defun elaocd-login (cookie)
  "Set session cookie 'COOKIE'."
  (interactive
   (list (read-string "Session cookie: " elaocd-session-cookie)))
  (url-cookie-store "session" cookie "Thu, 25 Dec 2027 00:00:00 -0000" ".adventofcode.com" "/" t))

(defun elaocd-input (day year)
  "Load input for 'DAY' 'YEAR' from cache if exists else get input from adventofcode.com and cache it before loading."
  (interactive "nDay \nnYear ")
  (let* ((url (format "https://adventofcode.com/%s/day/%d/input" year day))
         (dir (format "%s/%s/%d" elaocd-input-dir year day))
         (file (format "%s/%s" dir elaocd--input-file)))
     (if (not (file-exists-p file))
         (url-retrieve url 'elaocd--download-callback (list file))
         (find-file-other-window file))))

(defun elaocd--download-callback (status file)
  (if (plist-get status :error)
      (message "Failed to download todays advent input %s" status)
      (mkdir (file-name-directory file) t)
      (goto-char (point-min))
      (re-search-forward "\r?\n\r?\n")
      (write-region (point) (point-max) file)
      (find-file-other-window file)))

;;; advent.el ends here
