2   1024 RAM
    2 Proc
    64 Гб
    
3   Необходимо добавить следующие строчки в Vagrantfile
config.vm.provider "virtualbox" do |v|
  v.memory = 1024
  v.cpus = 2
end
    
5     HISTSIZE
      The number of commands to remember in the command history (see HISTORY below).  If the value is 0, commands are not saved in the history list.  Numeric values less than zero result in every command being saved on the history list (there is no limit).  The shell sets the default value to 500 after reading any startup files.
     
    
6  
    
7   git log --pretty=oneline -S "synchronizedWriters"

    Выбираем более старый коммит и смотрим в нем имя автора 
    
    git show 5ac311e2a91e381e2f52234668b49ba670aa0fe5

    Author: Martin Atkins <mart@degeneration.co.uk>
