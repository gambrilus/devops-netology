1.
Электронные чеки в json виде - Использовать любой документо-ориентированный NoSQL, потому что чеки это документы и хранить их целиком удобней.

Склады и автомобильные дороги для логистической компании - Использовать графовые БД, так как они созданы для создания оптимальных маршрутов

Генеалогические деревья - Иерархическая БД Она состоит из записей, которые связаны друг с другом. Каждая запись-это набор полей, каждое из которых содержит одно значение. Иерархическая база данных устроена таким образом «родитель-ребенок».

Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации - Key-value БД. Например, Redis, или другие key-value бд которые хранят данные в оперативной памяти.

Отношения клиент-покупка для интернет-магазина - Старые добрые реляционные БД, так как все данные внутри таких баз связаны между собой.


2.
  данные записываются на все узлы с задержкой до часа (асинхронная запись) - AP (нет консистентности), PACELC - PA/EC (есть доступность, если нет разделения есть задержка, поэтому ЕС)
  
  при сетевых сбоях система может разделиться на 2 раздельных кластера - AP (система разделенная), PACELC - PA/EL или PA/EC (есть доступность, далее приоритет не обозначен, следовательно можно выбирать)
  
  система может не прислать корректный ответ или сбросить соединение - PC - так как в таком случае нет доступности, PACELC - PC/EC (при разделении нет доступности, при отсутствии разделения - из-за сброса соединения возможна задержка)

3.
Нет, не могут. BASE - это противопоставление ACID. Например, ACID гарантирует консистентность данных после транзакции, BASE же допускает возврат неверных данных.

4.
Это Redis.  
Помимо большого списка преимуществ, как и любого другого ресурса, у Redis есть свои недостатки. 

    Redis обеспечивает только базовую безопасность на уровне экземпляра.
    В Redis нет языка запросов, есть только команды. Также нет поддержки реляционной алгебры. Нельзя отправлять специальные запросы. Разработчик должен предвидеть все обращения к данным и спроектировать к ним правильные пути доступа. Считается, что из-за этого теряется гибкость.
    Все данные должны уместиться в памяти. Реляционная СУБД обычно хранит информацию на дисках и кэш-часть данных в памяти. Redis не дает возможности управлять большим количеством данных, которые не вмещаются в его внутреннюю память.
    В отличие от автономных баз данных, кластеры Redis поддерживают только одну базу данных. Команда SELECT запрещена в Redis.
    Уникальный экземпляр Redis не считается масштабируемым, так как работает только на одном ядре процессора в однопоточном режиме. 
