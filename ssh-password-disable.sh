#!/bin/bash
sudo sed -i -e 's/^PasswordAuthentication.*$/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo grep PasswordAuthentication /etc/ssh/sshd_config
sudo /etc/init.d/sshd reload
