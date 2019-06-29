# we can create the our own required ansible.cfg and hosts file in one single folder

#like below

<# 
    Root mywindows
        |-------ansible.cfg
        |-------hosts
#>

ansible.cfg
[defaults]
inventory= hosts
log_path= mywindows.log

hosts
[win]
dineshlabpc ansible_connection=winrm ansible_user=dinesh ansible_password='dineshLAB@007'  





