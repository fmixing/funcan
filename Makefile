all: build/main.pdf

build/main.pdf: Makefile *.tex
	mkdir -p build
	rubber --into=build --pdf main.tex

push: build/main.pdf sync 
	git push --all

sync: build/main.pdf
	mv build/main.pdf ../
	git checkout gh-pages
	git pull origin gh-pages
	mv ../main.pdf build/
	git add build/main.pdf
	git commit -m 'sync'
	git checkout master

clean:
	rm -rf build
