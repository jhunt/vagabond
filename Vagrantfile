$setup = <<EOF
cd /home/vagrant
git clone https://github.com/jhunt/env
cd env
IAMJAMESHUNT=yes ./install
EOF

Vagrant.configure('2') do |config|
  config.vm.box = 'vagabond'
  config.vm.provision "shell", privileged: false, inline: $setup
end
