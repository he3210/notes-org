all:
	/usr/local/bin/emacs --script publish-notes.el
clean:
	rm -rf /Users/he/notes/html/*
	rm -rf /Users/he/.org-timestamps/
