SELECT item_name AS "ITEM", SUM(item_quantity) AS "TOTAL ORDERED" FROM ITEM_ORDER NATURAL JOIN ITEM GROUP BY item_name HAVING SUM(item_quantity) < 3;

SELECT item_name AS "ITEM", item_price AS "PRICE", SUM(cost) AS "ITEM PROFITS" FROM ITEM_ORDER NATURAL JOIN ITEM WHERE item_price <= 3 GROUP BY item_name, item_price HAVING SUM(COST) >= 5;

SELECT C.customer_id, customer_fname, customer_lname, customer_dob, IO.order_id, IO.item_id, item_quantity, R.receipt_id, tip, total_cost, CT.transaction_id, transaction_date, card_check_digit, CT.employee_id
FROM CUSTOMER C JOIN ITEM_ORDER IO ON C.customer_id = IO.customer_id JOIN RECEIPT R ON IO.order_id = R.order_id JOIN CARD_TRANSACTION CT ON R.receipt_id = CT.receipt_id

SELECT employee_fname, employee_lname, E.employee_id, employee_dob, employee_type, manager_id, office_phone, company_email, date_scheduled, start_time, end_time
FROM MANAGER M JOIN EMPLOYEE E ON M.employee_id = E.employee_id JOIN SCHEDULE S ON E.employee_id = S.employee_id
WHERE employee_type = 'MR';

SELECT date_scheduled AS DATE_, employee_fname AS EMP_FIRST_NAME,employee_lname AS EMP_LAST_NAME, SUM((s.end_time - s.start_time)* 0.01) AS TOTAL_HOURS FROM EMPLOYEE e JOIN SCHEDULE s ON e.employee_id = s.employee_id WHERE s.date_scheduled = '09-APR-2024' GROUP BY e.employee_id, e.employee_fname, e.employee_lname, s.date_scheduled HAVING SUM(s.end_time - s.start_time) >= 800 ORDER BY SUM(s.end_time - s.start_time);

SELECT receipt_id, total_cost,item_quantity FROM RECEIPT r JOIN ITEM_ORDER i ON r.order_id = i.order_id WHERE r.total_cost >= (SELECT AVG(total_cost) FROM RECEIPT) GROUP BY r.receipt_id, r.total_cost, i.item_quantity ORDER BY r.total_cost DESC;

SELECT order_id, item_name, item_quantity  FROM ITEM i NATURAL JOIN ITEM_ORDER io NATURAL JOIN RECEIPT r NATURAL JOIN CARD_TRANSACTION c WHERE io.item_quantity = (SELECT FLOOR(AVG(item_quantity)) from ITEM_ORDER) OR io.item_quantity = (SELECT CEIL(AVG(item_quantity)) from ITEM_ORDER)

SELECT item_id, item_name, "Gross Profit" FROM ITEM NATURAL JOIN (SELECT item_id, SUM(cost) as "Gross Profit" FROM ITEM_ORDER GROUP BY item_id) ORDER BY item_id;

FROM EMPLOYEE e
	JOIN MANAGER m ON e.employee_id = m.employee_id
	JOIN SCHEDULE s ON e.employee_id = s.employee_id;

SELECT c.customer_id, c.customer_fname, c.customer_lname, (SELECT COUNT(*) FROM ITEM_ORDER io WHERE io.customer_id = c.customer_id) AS total_orders,
(SELECT SUM(r.total_cost) FROM RECEIPT r
 JOIN ITEM_ORDER io ON r.order_id = io.order_id
 WHERE io.customer_id = c.customer_id) AS total_spent
FROM CUSTOMER c;
