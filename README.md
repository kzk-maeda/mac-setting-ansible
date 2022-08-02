# mac-setting-ansible
## How to Install via Ansible
- Allow remote connect
- Install [Task](https://taskfile.dev/)
- Install below 
  - `brew install ansible`
  - `brew install hudochenkov/sshpass/sshpass`
- Run Playbook
  - `task check`
  - `task apply`

## How to Install VSCode Extentions
- mod `libs/vscode/extentions.txt`
  - If you already have set extentions in some environment, you can get as below.
    - `code --list-extensions`
- run `libs/vscode/install.sh`