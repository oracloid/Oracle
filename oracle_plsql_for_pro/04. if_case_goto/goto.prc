-- команда GOTO используется для быстрого перехода в конец программы в том случае,
-- если состояние данных указывает, что дальнейшая обработка не требуется
--
-- При обнаружении ошибки в одном из разделов остальные проверки обходятся командой
-- GOTO. Поскольку в конце процедуры делать ничего не нужно, но там должна находиться
-- хотя бы одна исполняемая команда, после метки помещается NULL. Хотя последняя
-- никаких реальных действий не выполняет, она считается исполняемым оператором

PROCEDURE process_data (data_in IN orders%ROWTYPE,
                        data_action IN VARCHAR2)
IS
   status INTEGER;
BEGIN
   -- Первая проверка
   IF data_in.ship_date IS NOT NULL
   THEN
      status := validate_shipdate (data_in.ship_date);
      IF status != 0 THEN GOTO end_of_procedure; END IF;
   END IF;
-- Вторая проверка
   IF data_in.order_date IS NOT NULL
   THEN
      status := validate_orderdate (data_in.order_date);
      IF status != 0 THEN GOTO end_of_procedure; END IF;
   END IF;
--... Дополнительные проверки ...
   <<end_of_procedure>>
   NULL;
END;