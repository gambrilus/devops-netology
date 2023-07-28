
##Задание 1
Приложите скриншот входящих правил "Группы безопасности" в ЛК Yandex Cloud или скриншот отказа в предоставлении доступа к preview версии.

![изображение](https://github.com/gambrilus/devops-netology/assets/100866321/0eb518b2-9493-4556-9e64-3c7309f4b03d)

##Задание 2


Создайте файл [count-vm.tf](https://github.com/gambrilus/devops-netology/blob/terraform-03/virtualization/03/src/count-vm.tf). Опишите в нем создание двух одинаковых ВМ web-1 и web-2(не web-0 и web-1!), с минимальными параметрами, используя мета-аргумент count loop. Назначьте ВМ созданную в 1-м задании группу безопасности.

Создайте файл [for_each-vm.tf](https://github.com/gambrilus/devops-netology/blob/terraform-03/virtualization/03/src/for_each-vm.tf). Опишите в нем создание 2 ВМ с именами "main" и "replica" разных по cpu/ram/disk , используя мета-аргумент for_each loop. Используйте переменную типа list(object({ vm_name=string, cpu=number, ram=number, disk=number })). При желании внесите в переменную все возможные параметры.
ВМ из пункта 2.2 должны создаваться после создания ВМ из пункта 2.1.

Используйте функцию file в local переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из ДЗ №2.

Инициализируйте проект, выполните код.

##Задание 3

Создайте 3 одинаковых виртуальных диска, размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count в файле [disk_vm.tf](https://github.com/gambrilus/devops-netology/blob/terraform-03/virtualization/03/src/disk_vm.tf) .
Создайте в том же файле одну ВМ c именем "storage" . Используйте блок dynamic secondary_disk{..} и мета-аргумент for_each для подключения созданных вами дополнительных дисков.

##Задание 4

В файле [ansible.tf](https://github.com/gambrilus/devops-netology/blob/terraform-03/virtualization/03/src/ansible.tf) создайте inventory-файл для ansible. Используйте функцию tepmplatefile и файл-шаблон для создания ansible inventory-файла из лекции. Готовый код возьмите из демонстрации к лекции demonstration2. Передайте в него в качестве переменных группы виртуальных машин из задания 2.1, 2.2 и 3.2.(т.е. 5 ВМ)

Инвентарь должен содержать 3 группы [webservers], [databases], [storage] и быть динамическим, т.е. обработать как группу из 2-х ВМ так и 999 ВМ.

Выполните код. Приложите скриншот получившегося файла.
    
![изображение](https://github.com/gambrilus/devops-netology/assets/100866321/97f38186-751c-42a3-acdf-e32d0f8ef535)

