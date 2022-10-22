2   1024 RAM
    2 Proc
    64 Гб
    
3   Необходимо добавить следующие строчки в Vagrantfile
config.vm.provider "virtualbox" do |v|
  v.memory = 1024
  v.cpus = 2
end
    
5   - 569 HISTSIZE
    The number of commands to remember in the command history (see HISTORY below).  If the value is 0, commands are not saved in the history list.  Numeric values less than zero result in every command being saved on the history list (there is no limit).  The shell sets the default value to 500 after reading any startup files.
    - позволяет игнорировать пробелы и задвоенные символы в истории команд
    
6  {} используются в скриптах для передачи списка команд. Описано на 160 строке
    
7   touch {1…100000}. Создать  Не получится ввиду слишком большого списка Argument list too long
8   конструкция [[ -d /tmp ]] проверяет существует ли папка tmp и возращает значение Истина.
9   sudo mkdir /gambrilus
    sudo cp /bin/bash /gambrilus/
    PATH=/gambrilus:$PATH
10  Команда at используется для назначения одноразового задания на заданное время, а команда batch — для назначения одноразовых задач, которые должны выполняться, когда загрузка системы становится меньше 0,8
