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
    #econatstate plugins
    wp plugin install advanced-custom-fields --activate
    wp plugin install wp-likes --activate
    wp plugin install the-events-calendar --activate
    #developer plugins
    wp plugin install wordpress-importer --activate
	wp plugin install theme-check --activate
	wp plugin install theme-checklist --activate
	wp plugin install what-the-file --activate
	wp plugin install vip-scanner --activate
	wp plugin install wordpress-database-reset --activate
	wp plugin install debug-bar  --activate
	wp plugin install debug-bar-console  --activate
	wp plugin install debug-bar-cron  --activate
	wp plugin install debug-bar-extender  --activate
	wp plugin install rewrite-rules-inspector  --activate
	wp plugin install log-deprecated-notices  --activate
	wp plugin install log-viewer  --activate
	wp plugin install user-switching  --activate
	wp plugin install regenerate-thumbnails  --activate
	wp plugin install simply-show-ids  --activate

	# **
	# Unit Data
	# **

	# Import the unit data.
	curl -O https://wpcom-themes.svn.automattic.com/demo/theme-unit-test-data.xml
	wp import theme-unit-test-data.xml --authors=create
	rm theme-unit-test-data.xml

	# Replace url from unit data
	wp search-replace 'wpthemetestdata.wordpress.com' 'local.wordpress.dev' --skip-columns=guid

	cd ..

else
    
    echo 'wordpress-default does not exist'

fi
