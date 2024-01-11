
`	`**![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.001.png)![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.002.png)**

**Project 1** 

**OLAP**

**Structured Database**

**Team 05**

**Members**

**Fredin Alberto Vázquez Martínez**

**Aleksei Ithan Garcia Diaz**

**Requirements sheet:**

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.003.jpeg)

**Multidimensional Diagram (Star diagram):**


![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.004.jpeg)


**Why Choose the Star Model?**

Upon analyzing the business, it becomes evident that our client, despite having numerous sales, offers a limited product range, typically comprising fewer than 30 items. This strategic approach prompts the adoption of a star model. While this may result in some data redundancy, it facilitates quicker query processing.

In our `dim_geography` table, each state is associated with three cities, structured across five hierarchical levels:

- Level 1: Full registration
- Level 2: Region
- Level 3: Country
- Level 4: Status
- Level 5: City

The `dim_customer` and `dim_vendors` tables, dedicated to customer and vendor information respectively, have a single-level structure.

Within the product dimension (`dim_product`), we organize information across four dimensions:

- Level 1: Full registration
- Level 2: Milliliters
- Level 3: Price
- Level 4: Product name

The `dim_tiempol` table, containing extensive time-related data, spans six levels:

- Level 1: Full registration
- Level 2: Name of the day
- Level 3: Number of the day month
- Level 4: Name of the month
- Level 5: Year
- Level 6: Number of months

As for the `dim_vendors` table, it features two levels:

- Level 1: Full registration
- Level 2: Vendor quota


**Creation of the database:**

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.005.png)

**Creation of indexes**

Indexes used to avoid the search to be executed in the whole column, instead it will be executed only in one column, that is why it should be placed in common query leader fields and not in all the attributes. So the common query ones were placed.

It is reminded that for UNIQUE and PK their indexes are automatically generated.

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.006.png)

**Code**

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.007.png)














**Insertion of records**

The insertion of records was all done from csv.

dim\_customer

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.008.png)

dim\_geography

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.009.png)

dim\_product

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.010.png)

dim\_time

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.011.png)

dim\_vendors

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.012.png)


sales

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.013.png)

Consultation procedure

Query 1 : 

"For the last two years, obtain the city with the highest sales. From that city, identify the soft drink that sells the most, and from the top-selling soft drink, find the vendor with the highest sales of that particular soft drink."

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.014.png)

Qlik sense

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.015.jpeg)

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.016.png)









Query 2 

"We want to know which city has the most purchase orders and who its customer is that buys the most soft drinks."

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.017.png)


![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.018.png)





Qlik sense

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.019.jpeg)





















Query 3 

"We want to know in which month of the year the most soda is sold and specifically which day of the year the most soda is sold."

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.020.png)

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.021.png)











Qlik sense

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.022.jpeg)

























Consultation 4 

"We want to know which soft drink has the least sales in the last 2 years."

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.023.png)



![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.024.png)







Qlik sense

![](readme/Aspose.Words.2027b2d3-7b1c-4c2b-9784-ce38b7404176.025.jpeg)




### RapidMiner 


![](readme/market_analysis.png)

![](readme/time_series_holt_winters.png)


![](readme/prediccion_time_holt_winters.png)

