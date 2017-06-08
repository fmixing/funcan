all: build/main.pdf

build/main.pdf: Makefile main.tex 1-operators.tex 2-spectrum.tex
	mkdir -p build
	rubber --into=build --warn all --pdf main.tex

push: build/main.pdf sync 
	git push --all

sync: build/main.pdf
	git stash
	mv build/main.pdf ../
	git checkout gh-pages
	git pull origin gh-pages
	mv ../main.pdf build/
	git add build/main.pdf
	git commit -m 'sync'
	git checkout master
	git stash apply

clean:
	rm -rf build
