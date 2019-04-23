# For more language support
# https://github.com/jupyter/jupyter/wiki/Jupyter-kernels.
#

PREFIX=/home
PRODUCT=${USER}.blog

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
	git clone https://github.com/Pelican-Elegant/elegant.git

	# pelican-theme -i /path/to/your/themes
	# pelican-themes -l -v ; \

	#Modify the pelicanconf.py
	#THEME = 'pelican-themes/gum'
	#THEME = 'pelican-themes/elegant'

#Opertional
config-comments:
#在Disqus上申请帐号，按照流程Disqus会分配给你站点的Shortname，记牢Shortname，如果忘了请进入admin/settings中查看。然后同理，在pelicanconf.py添加
#DISQUS_SITENAME = Shortname

config-ipynb: config-general
	#. add ipynb plugin
	# These lines tell Pelican to activate the plugin when generating HTML.
	cd ${PREFIX}/${PRODUCT}/
	git init
	mkdir plugins
	git submodule add git://github.com/danielfrg/pelican-ipynb.git plugins/ipynb
	echo "MARKUP = ('md', 'ipynb')" >> pelicanconf.py
	echo "PLUGIN_PATH = './plugins'" >> pelicanconf.py
	echo "PLUGINS = ['ipynb.markup']" >> pelicanconf.py

config-general: install
	#. content: your edition dir. this will be saved and sync this Dir.
	ln -s `pwd`/content ln_content
	mv ln_content ${PREFIX}/${PRODUCT}/content

	#. quickstart pelican. it would autogen pelicanconf.py 
	( \
        source ${PREFIX}/${PRODUCT}/bin/activate; \
	cd ${PREFIX}/${PRODUCT}/ ;\
	pelican-quickstart; \
	)

install: prepare
	( \
        source ${PREFIX}/${PRODUCT}/bin/activate; \
		#pip install -r requirements.txt;\
		#requiremnets.txt located the same directionary with this Makefile.;\
		pip install --trusted-host pypi.douban.com -i http://pypi.douban.com/simple -r requirements.txt; \
	)

prepare:
	rm -rf ${PREFIX}/${PRODUCT}
	virtualenv -p /usr/bin/python3 ${PREFIX}/${PRODUCT}.env
