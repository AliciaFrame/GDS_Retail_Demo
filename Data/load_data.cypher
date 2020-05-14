CREATE CONSTRAINT ON (i:Item) ASSERT i.StockCode IS UNIQUE;
CREATE CONSTRAINT ON (c:Customer) ASSERT c.CustomerID IS UNIQUE;
CREATE CONSTRAINT ON (t:Transaction) ASSERT t.TransactionID IS UNIQUE;
CREATE CONSTRAINT ON (c:Category) ASSERT c.Category IS UNIQUE;
CREATE CONSTRAINT ON (c:Country) ASSERT c.Name IS UNIQUE;

LOAD CSV WITH HEADERS FROM "file:///UniqueCategories.csv" AS row 
WITH row.ITEMCATEGORY as ItemCategory
MERGE (c:Category{Category:ItemCategory})
RETURN COUNT (c);

LOAD CSV WITH HEADERS FROM "file:///UniqueItems.csv" AS row
WITH toInteger(row.StockCode) as StockCode, row.Description as Description where StockCode is not null
MERGE (i:Item{StockCode: StockCode, Description:Description})
RETURN COUNT (i);

LOAD CSV WITH HEADERS FROM "file:///UniqueCountries.csv" AS row
WITH row.Country as CountryName
MERGE (c:Country{Country:CountryName})
RETURN COUNT (c);

LOAD CSV WITH HEADERS FROM "file:///UniqueHouseholds.csv" AS row
WITH toInteger(row.CustomerID) as CustomerID
MERGE (c:Customer{CustomerID:CustomerID})
RETURN COUNT (c);

LOAD CSV WITH HEADERS FROM "file:///UniqueTransactions.csv" AS row
WITH toInteger(row.Transaction_ID) as TransactionID, row.InvoiceDate as InvoiceDate, toInteger(row.epochtime) as EpochTime
MERGE (t:Transaction{TransactionID:TransactionID, InvoiceDate:InvoiceDate, EpochTime:EpochTime})
RETURN COUNT (t);

//Add relationships
:auto
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///item-category.csv" as row
WITH toInteger (row.StockCode) as StockCode, row.CATEGORY as Category
MATCH (i:Item{StockCode:StockCode})
MATCH (c:Category{Category:Category})
MERGE (i)-[:TYPE]->(c);

:auto
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///household-transaction.csv" as row
WITH toInteger(row.CustomerID) as CustomerID, toInteger(row.Transaction_ID) as TransactionID
MATCH (c:Customer{CustomerID:CustomerID})
MATCH (t:Transaction{TransactionID:TransactionID})
MERGE (c)-[:MADE_TRANSACTION]->(t);

:auto
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///household-country.csv" as row
WITH toInteger(row.CustomerID) as CustomerID, row.Country as Country
MATCH (c:Customer{CustomerID:CustomerID})
MATCH (c2:Country{Country:Country})
MERGE (c)-[:FROM]->(c2);

:auto
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///customer-item.csv" as row
WITH toInteger(row.NumberPurchased) as NumberPurchase, toInteger(row.CustomerID) as CustomerID, tointeger (row.StockCode) as StockCode
MATCH (c:Customer{CustomerID:CustomerID})
MATCH (i:Item {StockCode:StockCode})
MERGE (c)-[:BOUGHT{Quantity:NumberPurchase}]->(i);

:auto
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///transaction-item.csv" as row
WITH tointeger (row.StockCode) as StockCode, toFloat(row.Price) as Price, toInteger(row.Transaction_ID) as TransactionID, toInteger(row.Quantity) as Quantity
MATCH (i:Item{StockCode:StockCode})
MATCH (t:Transaction{TransactionID:TransactionID})
MERGE (t)-[:CONTAINS{Quantity:Quantity, Price:Price}]->(i);
