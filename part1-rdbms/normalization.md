## Anomaly Analysis
- insert anomaly: it occurs when user is unable to add new records independently (example: new products can only be entered with an order)
- update anomaly: it occurs when data inconsistency arises when updates are not uniformly applied across duplicates (example: Multiple rows have the customer ID C002; if I have to change the customer_city, updates must be done across all rows, otherwise update anomaly may arise). The following order_id rows are at the risk of update anomaly inconsistency. 
(ORD1027
ORD1002
ORD1037
ORD1054
ORD1048
ORD1094
ORD1035
ORD1147
ORD1045
ORD1165
ORD1003
ORD1122
ORD1134
ORD1063
ORD1055
ORD1010
ORD1020
ORD1069
ORD1008
ORD1074
ORD1000)

- delete anomaly: it occurs when deleting a record might result in unintended loss of important data (example: If I delete product_id P004; all orders associated with it will also get deleted). The following order_id rows are at the risk of delete anomaly inconsistency if the above mentioned product_id is delted.
(ORD1010
ORD1017
ORD1021
ORD1027
ORD1030
ORD1040
ORD1049
ORD1050
ORD1052
ORD1056
ORD1057
ORD1082
ORD1096
ORD1099
ORD1104
ORD1106
ORD1112
ORD1113
ORD1120
ORD1126
ORD1128
ORD1130
ORD1133
ORD1136
ORD1142
ORD1145
ORD1152
ORD1156
ORD1159
ORD1160
ORD1161
ORD1162
ORD1172
ORD1180)


## Normalization Justification

While keeping everything in a single table may appear simpler at first, it introduces serious data integrity and maintenance issues. In the given dataset, these problems are clearly visible through common anomalies.

Consider the update anomaly. Customer ID C002 appears in multiple rows because the same customer has placed multiple orders. If the customer’s city needs to be updated, the change must be applied to every row where C002 exists. If even one row is missed, the database will contain inconsistent information for the same customer. This creates confusion and reduces trust in the data.

Now look at the delete anomaly. Suppose product ID P004 becomes obsolete and needs to be removed from the system. In a single flat table, deleting all rows related to P004 would also delete all past order records associated with that product. This means valuable historical data, such as which customers purchased the product and when, would be permanently lost. This is a critical issue for any business that relies on historical analysis.

Normalization solves these problems by separating data into logical tables such as customers, products, and orders. Each piece of information is stored only once and referenced using keys. This ensures consistency, prevents accidental data loss, and makes updates much safer and more efficient.

Therefore, normalization is not over-engineering but a necessary step for building a reliable and scalable database system.