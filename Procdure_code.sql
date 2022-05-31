DELIMITER &&
CREATE PROCEDURE  proc()
BEGIN
SELECT REPORT.SUPP_ID, REPORT.SUPP_NAME, REPORT.AVERAGE,
CASE
WHEN REPORT.AVERAGE = 5 THEN "Excellent Service"
WHEN REPORT.AVERAGE > 4 THEN "Good Service"
WHEN REPORT.AVERAGE > 2 THEN "Average Service"
ELSE "Poor Service"
END AS type_of_service from 
(SELECT FINAL.SUPP_ID, supplier.SUPP_NAME, FINAL.AVERAGE FROM 
(SELECT test2.SUPP_ID, SUM(test2.RAT_RATSTARS)/COUNT(test2.RAT_RATSTARS) AS AVERAGE FROM 
(SELECT SUPPLIER_PRICING.SUPP_ID, test.ORD_ID,test.RAT_RATSTARS FROM SUPPLIER_PRICING INNER JOIN 
(SELECT ORDERS.PRICING_ID, RATING.ORD_ID, RATING.RAT_RATSTARS
FROM ORDERS INNER JOIN RATING ON RATING.ORD_ID = ORDERS.ORD_ID)
AS test ON test.PRICING_ID = SUPPLIER_PRICING.PRICING_ID)
AS test2 GROUP BY SUPPLIER_PRICING.SUPP_ID)
AS FINAL INNER JOIN SUPPLIER WHERE FINAL.SUPP_ID = SUPPLIER.SUPP_ID) AS REPORT;

END &&
DELIMITER ;
CALL proc();


