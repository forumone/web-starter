install_node_npm:
  pkg.installed:
    - pkgs:
      - nodejs
      - npm
    - enablerepo: epel
