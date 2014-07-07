 #!/usr/bin/env bash

echo "export PATH=${PATH}" >> /home/vagrant/bashrc
cat /home/vagrant/.bashrc >> /home/vagrant/bashrc
mv  /home/vagrant/bashrc  /home/vagrant/.bashrc
