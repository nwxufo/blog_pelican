PREFIX=/srv/test
PRODUCT=MyBlog

SHELL := /bin/bash

help:
#For Pelican
#https://blog.getpelican.com/
#How To Use Jupyter notebook:
#http://jupyter-notebook.readthedocs.io/en/latest/notebook.html
#For Math/Latex pulgins
#https://github.com/getpelican/pelican-plugins/tree/master/render_math

#opertional
config-themes:
	#git clone https://github.com/getpelican/pelican-themes.git
	#Modify the pelicanconf.py
	#THEME = 'pelican-themes/gum'

#Opertional
config-comments:
#在Disqus上申请帐号，按照流程Disqus会分配给你站点的Shortname，记牢Shortname，如果忘了请进入admin/settings中查看。然后同理，在pelicanconf.py添加
#DISQUS_SITENAME = Shortname

config-ipynb: config-general
	#. add ipynb plugin
	# These lines tell Pelican to activate the plugin when generating HTML.
	cd ${PREFIX}/${PRODUCT}.env/
	git init
	mkdir plugins
	git submodule add git://github.com/danielfrg/pelican-ipynb.git plugins/ipynb
	echo "MARKUP = ('md', 'ipynb')" >> pelicanconf.py
	echo "PLUGIN_PATH = './plugins'" >> pelicanconf.py
	echo "PLUGINS = ['ipynb.markup']" >> pelicanconf.py

config-general: install
	#. content: your edition dir. this will be saved and sync this Dir.
	ln -s `pwd`/content ln_content
	mv ln_content ${PREFIX}/${PRODUCT}.env/content

	#. quickstart pelican. it would autogen pelicanconf.py 
	( \
        source ${PREFIX}/${PRODUCT}.env/bin/activate; \
	pelican-quickstart \
	)

install: prepare
	( \
        source ${PREFIX}/${PRODUCT}.env/bin/activate; \
	pip install -r requirements.txt --trusted-host pypi.mirrors.ustc.edu.cn \
	)

prepare:
	rm -rf ${PREFIX}/${PRODUCT}.env
	virtualenv -p python3 ${PREFIX}/${PRODUCT}.env
