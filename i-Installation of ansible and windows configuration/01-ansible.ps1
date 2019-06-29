
install ansible

sudo apt-get update 

apt install vim
dhclient -r ens33
dhclient 

shutdown -h now
reboot 
#for cdrom issue remove the cdrom from the /etc/apt/sources.list (https://askubuntu.com/questions/776721/problem-with-sudo-apt-get-update-the-repository-cdrom-does-not-have-a-releas)
#install latest vim
apt-get install vim

# In case of E: Could not get lock /var/lib/dpkg/lock - open (11 Resource temporarily unavailable) error

apt install openssh-server
systemctl status ssh

sudo apt-get install software-properties-common 

sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update 
sudo apt-get install ansible

sudo add-apt-repository --remove ppa:ansible/ansible


ANSIBLE_CFG: This is an environment variable
~/ansible.cfg: This is in the current directory
ansible.cfg: This is in the users home directory
./etc/ansible/ansible.cfg

#refer Below link to refer more details on the ansible for windows
https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html




#winrm on windows

apt install python-pip
pip install "pywinrm>=0.3.0"


<#
You can remove the default security at the PS remoting but this is not recommended
    Basic:

    ansible_user: LocalUsername
    ansible_password: Password
    ansible_connection: winrm
    ansible_winrm_transport: basic


    Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true
    set-item -path wsman:\localhost\service\Allowunencrypted -value $true
#>

<# 
Components for doing configuration using ansible
inventory
inventory variables settings
modules/Roles


inventory
[win]
172.16.2.5 
172.16.2.6 

[win:vars]
ansible_user=vagrant
ansible_password=password
ansible_connection=winrm
ansible_winrm_server_cert_validation=ignore

#>


ad-hoc command

ansible {hosts group} -m {modulename } -a "{Module Args}" -C "{use this if you just want to check}" -i {Inventory file} -o {one line output} -k {connection password} -u {user} -v -vv -vvv {verbosity level}
-c {connection type} 

ansible win1 -i hosts -m win_ping 

# for windows module list
https://docs.ansible.com/ansible/latest/modules/list_of_windows_modules.html 

Inventory # hosts files

[windows]
winclient

[windows:vars]
ansible_user= ""
ansible_password= ""
ansible_port= 5986
ansible_conenction= winrm
ansible_winrm_server_cert_validation= ignore



now we can run commands 
ansible windows -i hosts -m raw -a "ping 8.8.8.8" -u dinesh -k 

ansible windows -i hosts -m script -a "test.ps1" -u dinesh -k

ansible win1 -i hosts -m setup










#  foo: "{{ variable }}"

  running for windows

  - name: test script module
  hosts: windows
  tasks:
    - name: run test script
      script: files/test_script.ps1

Running individual commands uses the ‘raw’ module

- name: test raw module
  hosts: windows
  tasks:
    - name: run ipconfig
      raw: ipconfig
      register: ipconfig
    - debug: var=ipconfig

how to use the win_stat module to test for file existence.

- name: test stat module
  hosts: windows
  tasks:
    - name: test stat module on file
      win_stat: path="C:/Windows/win.ini"
      register: stat_file

    - debug: var=stat_file

    - name: check stat_file result
      assert:
          that:
             - "stat_file.stat.exists"
             - "not stat_file.stat.isdir"
             - "stat_file.stat.size > 0"
             - "stat_file.stat.md5"



  

  ansible winclient -m setup

  ubuntu:

  - name: Install Nginx
  apt:
   name: nginx
   state: latest

   or

   package:
    name: nginx
    state: latest
   

Ansible-PlayBook





  #Check what is include and import


  #Check what is tag
  define various tags in yml file

  run below commands

  ansible-playbook tags.yml --tags 'TAG1'

  --tags 'TAG1,TAG2'

  ansible-palybook tags.yml --skip-tags 'TAG2'


  we can also defile tags at hosts so as if we select that then whole yml file will run

  tags:
      - always

 

 tagged

 untagged
 all


 #Roles

Roles are grouped with logical structure , making easier to share

Example Project Structure

site.yml
webservers.yml
fooservers.yml
roles/
   common/
     tasks/--- main.yml
     handlers/ --- main.yml
     files/
     templates/
     vars/ ---main.yml
     defaults/ --- main.yml
     meta/ -- main.yml

   webservers/
     tasks/
     defaults/
     meta/

tasks - contains the main list of tasks to be executed by the role.
handlers - contains handlers, which may be used by this role or even anywhere outside this role.
defaults - default variables for the role .
vars - other variables for the role .
files - contains files which can be deployed via this role.
templates - contains templates which can be deployed via this role.
meta - defines some meta data for this role. 





