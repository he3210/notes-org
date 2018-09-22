all:
	/usr/local/bin/emacs --script publish-notes.el

upload:
	scp -r /Users/he/notes/html/* root@www.langdebuqing.com:/root/notes-html/

clean:
	rm -rf /Users/he/notes/html/*
	rm -rf /Users/he/.org-timestamps/
