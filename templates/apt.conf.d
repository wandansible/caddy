# {{ ansible_managed }}

DPkg::Pre-Install-Pkgs { "{{ caddy_dpkg_hook_script }} || true"; };
DPkg::Tools::Options::{{ caddy_dpkg_hook_script }}::Version "3";
