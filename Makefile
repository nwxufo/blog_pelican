# For more language support
# https://github.com/jupyter/jupyter/wiki/Jupyter-kernels.
#

PREFIX=/srv/${USER}

#virtual environment
Virtual_ENV=blog.virtualenv

#Patch generate blog into.
Blog_Gen=blog.generate

SHELL := /bin/bash

help:
#For Pelican
#https://blog.getpelican.com/
#How To Use Jupyter notebook:
#http://jupyter-notebook.readthedocs.io/en/latest/notebook.html
#For Math/Latex pulgins
#https://github.com/getpelican/pelican-plugins/tree/master/render_math
#themes
#https://moelove.info/2014/05/07/%E4%BD%BF%E7%94%A8Pelican%E6%90%AD%E5%BB%BABlog/
#https://www.mawenbao.com/note/pelican-setup-summary.html
test:
	make html;
	pelican content;
	make serve #default port:8000
install-all: config-themes config-jpynb

#opertional
config-themes: config-general
	#git clone https://github.com/getpelican/pelican-themes.git
	git clone https://github.com/Pelican-Elegant/elegant.git ${PREFIX}/${Virtual_ENV}/themes/elegant
	( \
	source ${PREFIX}/${Virtual_ENV}/bin/activate; \
		pelican-themes -i ${PREFIX}/${Virtual_ENV}/themes/elegant ; \
		pelican-themes -l -v ; \
	deactivate; \
	)
	#Modify the pelicanconf.py
	#THEME = 'pelican-themes/gum'
	echo "THEME = 'elegant'" >> ${PREFIX}/${Blog_Gen}/pelicanconf.py

#Opertional
config-comments:
#在Disqus上申请帐号，按照流程Disqus会分配给你站点的Shortname，记牢Shortname，如果忘了请进入admin/settings中查看。然后同理，在pelicanconf.py添加
#DISQUS_SITENAME = Shortname

#. add ipynb plugin
config-ipynb: 
	# These lines tell Pelican to activate the plugin when generating HTML.
	#TODO: Test dir if exits. 
	#( \
	#	if [ ! -d "plugins" ]; then  mkdir plugins ; \
	#	fi \
	#)
	#git init
	#git submodule add git://github.com/danielfrg/pelican-ipynb.git plugins/ipynb
	git clone git://github.com/danielfrg/pelican-ipynb.git ${PREFIX}/${Blog_Gen}/plugins/ipynb
	echo "MARKUP = ('md', 'ipynb')" >> ${PREFIX}/${Blog_Gen}/pelicanconf.py
	echo "PLUGIN_PATH = './plugins'" >> ${PREFIX}/${Blog_Gen}/pelicanconf.py
	echo "PLUGINS = ['ipynb.markup']" >> ${PREFIX}/${Blog_Gen}/pelicanconf.py

config-general: install
	#. content: your edition dir. this will be saved and sync this Dir.
	rm -r  ${PREFIX}/${Blog_Gen}/content
	ln -s `pwd`/content ${PREFIX}/${Blog_Gen}/

	#. quickstart pelican. it would autogen pelicanconf.py 
	( \
        source ${PREFIX}/${Virtual_ENV}/bin/activate; \
		pelican-quickstart --path  ${PREFIX}/${Blog_Gen}/ --title "Milo's Blog" --author "Milo" --lang zh	;\
	deactivate; \
	)

install: prepare
	( \
        source ${PREFIX}/${Virtual_ENV}/bin/activate; \
		#pip install -r requirements.txt;\
		#requiremnets.txt located the same directionary with this Makefile.;\
		pip install --trusted-host pypi.douban.com -i http://pypi.douban.com/simple -r requirements.txt; \
	deactivate; \
	)

prepare:
	rm -rf ${PREFIX}/${Virtual_ENV} 
	virtualenv -p /usr/bin/python3 ${PREFIX}/${Virtual_ENV}
