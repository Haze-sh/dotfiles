;; base16-nord-theme.el -- A base16 colorscheme

;;; Commentary:
;; Base16: (https://github.com/chriskempson/base16)

;;; Authors:
;; Scheme: arcticicestudio
;; Template: Kaleb Elwert <belak@coded.io>

;;; Code:

(require 'base16-theme)

(defvar base16-nord-colors
  '(:base00 "#2E3440"
    :base01 "#3B4252"
    :base02 "#434C5E"
    :base03 "#4C566A"
    :base04 "#D8DEE9"
    :base05 "#E5E9F0"
    :base06 "#ECEFF4"
    :base07 "#8FBCBB"
    :base08 "#BF616A"
    :base09 "#D08770"
    :base0A "#EBCB8B"
    :base0B "#A3BE8C"
    :base0C "#88C0D0"
    :base0D "#81A1C1"
    :base0E "#B48EAD"
    :base0F "#5E81AC")
  "All colors for Base16 Nord are defined here.")

;; Define the theme
(deftheme base16-nord)

;; Add all the faces to the theme
(base16-theme-define 'base16-nord base16-nord-colors)

;; Mark the theme as provided
(provide-theme 'base16-nord)

(provide 'base16-nord-theme)

;;; base16-nord-theme.el ends here
