# Install theme and plugins in default site.
if [ -d /srv/www/wordpress-default ]; then

	cd /srv/www/wordpress-default
	
	# **
	# Get themes
	# **
	echo 'Enter econatstate OAUTH_TOKEN ...'
	read OAUTH_TOKEN
	echo 'Downloading econatstate ...'
	curl -O -L -H "Authorization: token $OAUTH_TOKEN" https://github.com/kennyr87/econatstate/archive/master.zip
	
	for i in `ls ./*.zip`
	do
		wp theme install $i
	done
	
	rm master.zip
    echo 'Theme installed ...' 
    
	# **
	# # Plugins
	# **
    echo 'Installing plugins ...'
    	# TODO Add econatstate plugins
	wp plugin install wordpress-importer --activate
	wp plugin install developer --activate
	wp plugin install theme-check --activate
	wp plugin install theme-mentor --activate
	wp plugin install theme-checklist --activate
	wp plugin install what-the-file --activate
	wp plugin install vip-scanner --activate
	wp plugin install wordpress-database-reset --activate
	wp plugin install toolbar-theme-switcher --activate
	wp plugin install rtl-tester
	wp plugin install piglatin
	wp plugin install debug-bar  --activate
	wp plugin install debug-bar-console  --activate
	wp plugin install debug-bar-cron  --activate
	wp plugin install debug-bar-extender  --activate
	wp plugin install rewrite-rules-inspector  --activate
	wp plugin install log-deprecated-notices  --activate
	wp plugin install log-viewer  --activate
	wp plugin install monster-widget  --activate
	wp plugin install user-switching  --activate
	wp plugin install regenerate-thumbnails  --activate
	wp plugin install simply-show-ids  --activate
	wp plugin install theme-test-drive  --activate
	wp plugin install wordpress-beta-tester  --activate

	# **
	# Unit Data
	# **

	# Import the unit data.
	curl -O https://wpcom-themes.svn.automattic.com/demo/theme-unit-test-data.xml
	wp import theme-unit-test-data.xml --authors=create
	rm theme-unit-test-data.xml

	# Replace url from unit data
	wp search-replace 'wpthemetestdata.wordpress.com' 'themereview.wordpress.dev' --skip-columns=guid

	cd ..

else
    
    echo 'wordpress-default does not exist'
	cd htdocs/

	# Updates
	if $(wp core is-installed); then

		# Update WordPress.
		wp core update
		wp core update-db

		# Update Plugins
		wp plugin update --all

		# **
		# Your themes
		# **
		for i in `ls ../*.zip`
		do
			wp theme install $i
		done

	fi

	cd ..

fi
