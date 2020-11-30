CREATE CONSTRAINT ON (i:Item) ASSERT i.StockCode IS UNIQUE;
CREATE CONSTRAINT ON (c:Customer) ASSERT c.CustomerID IS UNIQUE;
CREATE CONSTRAINT ON (t:Transaction) ASSERT t.TransactionID IS UNIQUE;
CREATE CONSTRAINT ON (c:Category) ASSERT c.Category IS UNIQUE;
CREATE CONSTRAINT ON (c:Country) ASSERT c.Name IS UNIQUE;

LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/AliciaFrame/GDS_Retail_Demo/master/Data/UniqueCategories.csv" AS row
WITH row.ITEMCATEGORY as ItemCategory
MERGE (c:Category{Category:ItemCategory})
RETURN COUNT (c);

LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/AliciaFrame/GDS_Retail_Demo/master/Data/UniqueItems.csv" AS row
WITH toInteger(row.StockCode) as StockCode, row.Description as Description where StockCode is not null
MERGE (i:Item{StockCode: StockCode, Description:Description})
RETURN COUNT (i);

LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/AliciaFrame/GDS_Retail_Demo/master/Data/UniqueCountries.csv" AS row
WITH row.Country as CountryName
MERGE (c:Country{Country:CountryName})
RETURN COUNT (c);

LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/AliciaFrame/GDS_Retail_Demo/master/Data/UniqueHouseholds.csv" AS row
WITH toInteger(row.CustomerID) as CustomerID
MERGE (c:Customer{CustomerID:CustomerID})
RETURN COUNT (c);

LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/AliciaFrame/GDS_Retail_Demo/master/Data/UniqueTransactions.csv" AS row
WITH toInteger(row.Transaction_ID) as TransactionID, row.InvoiceDate as InvoiceDate, toInteger(row.epochtime) as EpochTime
MERGE (t:Transaction{TransactionID:TransactionID, InvoiceDate:InvoiceDate, EpochTime:EpochTime})
RETURN COUNT (t);

//Add relationships
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/AliciaFrame/GDS_Retail_Demo/master/Data/item-category.csv" as row
WITH toInteger (row.StockCode) as StockCode, row.CATEGORY as Category
MATCH (i:Item{StockCode:StockCode})
MATCH (c:Category{Category:Category})
MERGE (i)-[:TYPE]->(c);

USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/AliciaFrame/GDS_Retail_Demo/master/Data/household-transaction.csv" as row
WITH toInteger(row.CustomerID) as CustomerID, toInteger(row.Transaction_ID) as TransactionID
MATCH (c:Customer{CustomerID:CustomerID})
MATCH (t:Transaction{TransactionID:TransactionID})
MERGE (c)-[:MADE_TRANSACTION]->(t);

USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/AliciaFrame/GDS_Retail_Demo/master/Data/household-country.csv" as row
WITH toInteger(row.CustomerID) as CustomerID, row.Country as Country
MATCH (c:Customer{CustomerID:CustomerID})
MATCH (c2:Country{Country:Country})
MERGE (c)-[:FROM]->(c2);

USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/AliciaFrame/GDS_Retail_Demo/master/Data/customer-item.csv" as row
WITH toInteger(row.NumberPurchased) as NumberPurchase, toInteger(row.CustomerID) as CustomerID, tointeger (row.StockCode) as StockCode
MATCH (c:Customer{CustomerID:CustomerID})
MATCH (i:Item {StockCode:StockCode})
MERGE (c)-[:BOUGHT{Quantity:NumberPurchase}]->(i);

USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/AliciaFrame/GDS_Retail_Demo/master/Data/transaction-item.csv" as row
WITH tointeger (row.StockCode) as StockCode, toFloat(row.Price) as Price, toInteger(row.Transaction_ID) as TransactionID, toInteger(row.Quantity) as Quantity
MATCH (i:Item{StockCode:StockCode})
MATCH (t:Transaction{TransactionID:TransactionID})
MERGE (t)-[:CONTAINS{Quantity:Quantity, Price:Price}]->(i);

//set item specific prices and quantities
MATCH (i:Item)-[c:CONTAINS]-(t:Transaction)
WITH  i, AVG(c.Price) as Price, count(c) as Num_Sold
SET i.avg_price=Price, i.num_sold = Num_Sold
RETURN count(i)
