Project skeleton
================

A project skeleton, with starting points for Vagrant and puppet.



Starting a new project:
-----------------------

1. Create new project:

		mkdir new-project
		cd new-project
		git init


2. Add this skeleton as a remote

		git remote add puppet-modules git://github.com/isofarro/puppet-modules.git
		git pull puppet-modules master
		git remote rm puppet-modules

3. Start developing...

