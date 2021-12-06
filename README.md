# Credit Card Attrition Prediction
Using a dataset provided by a bank, several variables are analyzed as predictors for a logistic regression, which will infer the probability of losing a customer.

### Problem Recognition
After the 2008 crisis, the financial sector and credit card market is more and more witnessing high volatility, acquiring new customers can now cost up to 7 times more than retaining one, which means that losing customers can be a large financial loss.

## Data Analysis
After looking at demographics and all data involving the bank and customers, the following result to be the most relevant variables:

### Relationship Count
Taking into consideration the number of products held by a client, it seems true that customers with more products have a lower ratio of attrition.


### Transaction Amount
Filtering by attrition we can see that a pattern shows up, those that spend very high amounts of money (above the higher dotted line) can be considered the loyal customers. Those leaving the bank seem to have less transactions for similar values of money spent. 
However, it is not unlikely that leaving customers are already adopting services from other banks, explaining the lower count of transactions, so lets look at the utilization ratio. 


### Average Utilization
The majority of customers that left have a much lower utilization ratios, and show some outliers with higher ratios, whereas existing customers follow a more flat density curve. 


### Contact Count and Inactivity in the last 12 Months
more contacts with the bank the higher the share of leaving customers, to the point that only lost customers have reached 6 touch-points. 
It is possible that the intention of leaving is a causation for the many contacts before ending the relationship, however it is also possible to assume that the more contacts implies a customer is less satisfied with the service. 
Hence, a first confounding factor is identified in the analysis, since data about customer satisfaction is not provided. 
In the meantime, the time being inactive in the last 12 months follows a very similar ratio, and might not affect substantially the probability of attrition.


### Revolving Balance
The high majority of lost customers tend to have much lower revolving balances. 


## Regression



### Limitations
Around 19% of the customers in the data are customers that left the bank; a higher percentage of representative cases would have been more insightful.
