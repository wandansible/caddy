Ansible role: caddy
===================

Installs the caddy webserver along with any non-standard caddy plugins required.

Allows for caddy to be configured by adding one or more Caddyfiles.

Role Variables
--------------

```
ENTRY POINT: main - Install and configure caddy webserver

          Installs the caddy webserver and non-standard caddy plugins.
          Allows for configuration of caddy through adding one or more
          Caddyfiles.

Options (red indicates it is required):

   caddy_apt_key_fingerprint  Fingerprint for caddy apt repo GPG key
          default: 65760C51EDEA2017CEA2CA15155B6D79CA56EA34
          type: str

   caddy_apt_key_url  URL for caddy apt repo GPG key
          default: https://dl.cloudsmith.io/public/caddy/stable/gpg.key
          type: str

   caddy_apt_packages  List of packages to install
          default: [caddy]
          elements: str
          type: list

   caddy_apt_repo  Entry for caddy apt repo in sources.list file
          default: https://dl.cloudsmith.io/public/caddy/stable/deb/debian any-version main
          type: str

   caddy_dpkg_hook_script  Path to where dpkg hook for caddy should be installed
          default: /usr/local/bin/caddy-upgrade
          type: str

   caddy_file  Contents of the /etc/caddy/Caddyfile configuration file, or empty
               string to leave file as is
          default: ''
          type: str

   caddy_files  List of additional Caddyfiles to create
          default: []
          elements: dict
          type: list
          options:

             config            Contents of the Caddyfile
            type: str

             dir            Directory for the Caddyfile
            default: null
            type: str

             name            Name of the Caddyfile
            type: str

   caddy_packages  List of non-standard caddy packages to install
          default: []
          elements: str
          type: list
```

Installation
------------

This role can either be installed manually with the ansible-galaxy CLI tool:

    ansible-galaxy install git+https://github.com/wandansible/caddy,main,wandansible.caddy

Or, by adding the following to `requirements.yml`:

    roles:
      - name: wandansible.caddy
        src: https://github.com/wandansible/caddy

Roles listed in `requirements.yml` can be installed with the following ansible-galaxy command:

    ansible-galaxy install -r requirements.yml

Example Playbook
----------------

    - hosts: all
      roles:
         - role: wandansible.caddy
           become: true
           vars:
             caddy_packages:
               - github.com/mholt/caddy-webdav

             caddy_file: |
               import sites-enabled/*.Caddyfile

             caddy_files:
               - name: website1.Caddyfile
                 dir: sites-enabled
                 config: |
                   website1.example.org {
                     root * /var/www/website1
                     file_server
                   }

               - name: website2.Caddyfile
                 dir: sites-enabled
                 config: |
                   website2.example.org {
                     root * /var/www/website2
                     file_server
                   }
