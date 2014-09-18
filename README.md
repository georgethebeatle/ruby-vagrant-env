# Simple vagrant environment for ruby development

## Prerequisutes

1. Install VirtualBox
2. Install vagrant
3. Install vagrant proxy plugin

        vagrant plugin install vagrant-proxyconf
        
4. Install RubyMine (optional)


## Setup the environment

1. Clone this repo

        git clone git@github.wdf.sap.corp:i056003/ruby-vagrant-env.git
        
2. Vagrant Up

        cd ruby-vagrant-env
        vagrant up
        
## Setup RubyMine to work with our environment (optional)

1. Start RubyMine
2. Open File->Settings
  1. Go to Build, Execution, Deployment -> Deployment and click the + button
  1. Chose SFTP for type of connection
  1. SFTP host: 127.0.0.1
  1. Port: 2222
  1. User/Password: vagrant/bagrant
  1. Check the remember password checkbox
  1. Click the Autodetect rootpath button
  1. Test the connection - should be green
  1. Click Apply
3. Go to Languages and Frameworks -> Ruby SDK and Gems and click the + button
  1. Choose Deployment Configuration
  1. Enter the correct path to the ruby interpreter. This can be found out by executing `vagrant ssh -c "which ruby"` from the root of this repo.
  1. Click on the ssh connection url to verify it is working - should be green
  1. Click OK

At this point RubyMine is configured to work with the provisioned vagrant environment. You may refer to [this video](https://www.youtube.com/watch?v=5KQUhMM_99Y) that shows how to upload a project to vagrant and run it.
  

