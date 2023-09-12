
# 1. Creating the repository
1. Create a git *bare* repository with the following line
```
    mkdir $HOME/.dotfiles
    git init --bare $HOME/.dotfiles
```
2. Create an alias for a better managing of the configuration
```
    alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
 ```
 It should be highlighted that you can put it in your .bashrc or the  file you use for your alias, in my case *$HOME/.zshrc*
 
3. Disable the tacking of any single file
 ``` 
    cfg config --local status.showUntrackedFiles no
 ```
4. You can use it in a normal basis with config and keywords like "add, delete, status, checkout, ...". Remember to add a remote repositoryy with this lines
 ```
    cfg remote add origin <remote-url>
    cfg push -u origin main
 ```
 
 For example you can create a diferent configuration in different branches for each machine that you have.
 
# 2. Restore a configuration
1. Prevent weird circular dependencies
  ``` 
      echo ".dotfiles" >> .gitignore 
  ```
2. Clone the remote repository
 ``` 
    git clone --bare <remote-git-repo-url> $HOME/.dotfiles 
 ```
3. Restore the alias and configuration of tracking
  ```
      alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
      cfg config --local status.showUntrackedFiles no
  ```
4. Proceed to checkout
  ```
  config checkout
  ```
