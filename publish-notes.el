#!/usr/local/bin/emacs --script

(add-to-list 'load-path "~/.emacs.d/elpa/")
(add-to-list 'load-path "~/.emacs.d/elpa/htmlize-20180412.1244/")

;; 虽然 htmlize 加载上了，不知道为啥代码不能高亮。但是在 emacs 中执行命令可以高亮： C-u M-x org-publish-project RET notes RET
(require 'htmlize)
(require 'org)
(require 'ox-html)
(require 'ox-publish)

(setq org-src-fontify-natively t)

(setq user-full-name "时中贺"
      user-mail-address "shi_zhonghe@163.com")
(setq org-export-with-sub-superscripts nil)    ;; 禁用 _ 转义成下标，^转义成上标。但加 {} 就可以转义了

;; HTML模板目录
(defvar *site-template-directory* "~/notes/org/templates")

(defun read-html-template (template-file)
  (with-temp-buffer
    (insert-file-contents (concat *site-template-directory* "/" template-file))
    (buffer-string)))


(setq org-publish-project-alist
      '(
        ("org-notes"
         :base-directory "~/notes/org"
         :base-extension "org"
         :publishing-directory "~/notes/html"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :language "zh-CN"              ;; 设置为 zh-CN 会影响一些东西。比如：目录会显示为汉字
         :section-numbers t             ;; 是否为标题编号
         :with-toc t                    ;; 是否创建 table of contents
         :with-latex t                  ;; 是否可以使用 latex
         :htmlized-source t
         :html-head-include-default-style nil  ;; 取消默认的 css
         :html-head-include-scripts nil        ;; 取消默认的 javascript 代码
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"file:///Users/he/notes/html/css/style.css\" />"
         ;;	 :html-head-extra "<script src=\"file:///Users/he/notes/html/css/default.js\" type=\"text/javascript\"></script>"
         :exclude "test*\\|.*\.test\.org"      ;; test 为前缀的文件和文件夹都不导出 html
         :include ("./test/math.org" "./test/worg.org")          ;; 虽然 math.org 在 test 文件夹里，但依然会导出到 html，显然 include 比 exclude 优先
         )
        ("static"
         :base-directory "~/notes/org"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|txt\\|asc"
         :publishing-directory "~/notes/html"
         :recursive t
         :publishing-function org-publish-attachment)
        ("notes" :components ("org-notes" "static"))))

(setq org-html-preamble (read-html-template "preamble.html"))
(setq org-html-postamble (read-html-template "postamble.html"))


;;; 设置Mathjax库的路径
(add-to-list 'org-html-mathjax-options '(path "https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML"))
;;; 参数 t 表示强制导出（不会忽略未修改的文件），在 emacs 中执行该命令有同样效果：C-u M-x org-publish-project RET notes RET
(org-publish-project "notes" t)

