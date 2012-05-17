PYTHON = /opt/local/bin/python3.2

all: tree.svg

tree.svg: tree.dot
	dot -Tsvg tree.dot -o tree.svg
#	cat tree.pre.svg | sed -e 's/scale(1 1)/scale(0.2 0.2)/g' > tree.svg
#	dot -Tpng tree.dot -o tree.png
