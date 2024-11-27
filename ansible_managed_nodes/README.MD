ansible -i hosts -m ping all


Yes, if you do not explicitly specify the private key location in your Ansible inventory or commands, Ansible (and SSH in general) will default to using the ~/.ssh/id_rsa private key of the user running the command.

ansible_ssh_private_key_file=/home/ansible/.ssh/id_rsa

The host_key_checking option in Ansible controls whether SSH will verify the host's key when connecting to remote machines. By default, SSH performs host key checking, meaning that it will verify the identity of the remote server by checking its host key. If the key does not match what's stored in ~/.ssh/known_hosts, SSH will refuse to connect.


The authenticity of host '10.0.3.219 (10.0.3.219)' can't be established.
ED25519 key fingerprint is SHA256:24GKLGEkm5nHjboeLvCs39TV0u0PxAtwYYraP2BYJQ4.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
[WARNING]: Platform linux on host 10.0.3.219 is using the discovered Python interpreter at /usr/bin/python3.9, but future
installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.15/reference_appendices/interpreter_discovery.html for more information.
10.0.3.219 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.9"
    },
    "changed": false,
    "ping": "pong"
}

. -m ping
Tells Ansible to use the ping module.

The ping module is a simple way to test if Ansible can connect to and communicate with the target nodes.
It doesn’t use ICMP but checks SSH connectivity and ensures Python is installed on the managed node.

4. all
Specifies the group or host to target.

all: Refers to all hosts defined in the inventory file.
You can replace all with:
A specific hostname or IP address (e.g., 10.0.3.219).
A group name defined in the inventory file (e.g., managed_nodes).

Best Practices Followed:
Use of Roles: The NGINX installation is abstracted into a role, which can be reused across different playbooks and projects.
Separation of Concerns: Different aspects of the role are divided into tasks, handlers, defaults, and vars files for better maintainability.
Idempotency: The tasks ensure that NGINX is installed, started, and enabled without being repeated unnecessarily on subsequent runs.
Scalability: The use of Ansible inventory groups allows for easy scaling to multiple web servers by adding them to the webservers group in the inventory file.
Use of become: The become: yes directive ensures that tasks requiring elevated privileges (like package installation and starting services) are executed with sudo.