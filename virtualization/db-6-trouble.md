1.

- напишите список операций, которые вы будете производить для остановки запроса пользователя;
  1. Находим данный процесс
    db.currentOp({“secs_running”:{$gte:180}})
  2. "Убиваем" данный процесс
    db.killOp(<opid of the query to kill>)
- предложите вариант решения проблемы с долгими (зависающими) запросами в MongoDB
  Настроить профилирование со сбором логов по операция превышающим время выполнения в минуту и на основе этих данных либо оптимизировать запросы, либо настоить индексацию для ускорения выполнения операций
 
2.
  Это может происходит из-за того что Redis начинает удалять старые ключи по достижении ими 25 % от всех ключей. В этот момент Redis блокирует запись. Если обьем истекающих ключей большой - блокировка
  может продолжаться длительное время.

3.
Иногда форма проблема возникает, когда миллионы строк отправляются как часть одного или нескольких запросов. Если вы знаете, что это происходит, вам следует попробовать увеличить значение net_read_timeout
с 30 секунд по умолчанию до 60 секунд или более, достаточного для завершения передачи данных.

Реже это может происходит, когда клиент пытается установить первоначальное соединение с сервером. В этом случае, если ваше значение connect_timeout установлено всего на несколько секунд, вы можете решить 
проблему, увеличив его до десяти секунд, возможно, больше, если у вас очень большое расстояние или медленное соединение. Вы можете определить, испытываете ли вы эту более необычную причину, используя 
SHOW GLOBAL STATUS LIKE 'Aborted_connects'. Он увеличивается на единицу за каждую первоначальную попытку подключения, которую прерывает сервер. Вы можете увидеть «чтение пакета авторизации» как часть 
сообщения об ошибке; если это так, это также говорит о том, что это решение, которое вам нужно.

Если причина не является ни одной из только что описанных, у вас может возникнуть проблема со значениями BLOB, превышающими max_allowed_packet, что может вызвать эту ошибку на некоторых клиентах. 
Иногда вы можете увидеть ошибку ER_NET_PACKET_TOO_LARGE, и это подтверждает, что вам нужно увеличить max_allowed_packet.
  
4.
Это запускает процесс очистки памяти сервера Linux. что означает, что все доступные ресурсы оперативной памяти "съедены" PostgreSQL.
Способы решения:
- установить ограничение на объем доступной памяти для PostgreSQL

Например просто ограничить целиком на весь сервер - ulimit -d <Предельный размер памяти>
  
Или systemctl set-property postgresql.service MemoryLimit=<необходимое значение>
  
Или изменить shared_buffers в postgresql.conf
- увеличить объем памяти на сервере
