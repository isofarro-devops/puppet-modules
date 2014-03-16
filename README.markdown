Project skeleton
================

A project skeleton, with starting points for Vagrant and puppet.

The software platform:

* Nginx
* PHP-FPM
* PHP5
* MySQL
* PHPUnit -- Unit testing
* Composer -- for installing PHP modules
* Beanstalk -- message queues



Starting a new project:
-----------------------

1. Create new project:

		mkdir new-project
		cd new-project
		git init


2. Pull in this skeleton:

		git remote add puppet-modules git://github.com/isofarro/puppet-modules.git
		git pull puppet-modules master
		git remote rm puppet-modules

3. Edit `puppet/base.pp` commenting in/out the modules you want
4. Start vagrant:

		vagrant up

5. Start developing.


Project structure:
------------------

* `bin/` -- scripts run from the command line
* `etc/` -- project config, templates
	* `app/` -- application configuration and bootstrap
	* `conf/` -- service configuration, (e.g. nginx)
	* `templates/` -- templating engine templates (e.g. Twig templates)
	* `www/` -- project web document root
* `lib/` -- project specific code, in namespaced directories (PSR-0)
* `puppet/` -- puppet set up and modules
* `tests/` -- PHPUnit tests, in namespaces directories matching `lib/`
	* `stubs/` -- stub data or resources used by unit tests
* `share/` -- meta information or resources about the project
	* `docs` -- documentation and notes about the project
* `tmp/` -- project related temporary files
* `var/` -- place for larger project resources
	* `log/` -- project log files
	* `software/` -- downloaded software, plugins, extensions, themes, etc.
* `vendor/` -- installed composer modules and dependencies

