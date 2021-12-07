# Credit Card Attrition Prediction
Using a dataset provided by a bank, several variables are analyzed as predictors for a logistic regression, which will infer the probability of losing a customer.

### Problem Recognition
After the 2008 crisis, the financial sector and credit card market is more and more witnessing high volatility, acquiring new customers can now cost up to 7 times more than retaining one, which means that losing customers can be a large financial loss.

## Data Analysis
After looking at demographics and all data involving the bank and customers, the following result to be the most relevant variables:

### Relationship Count
Taking into consideration the number of products held by a client, it seems true that customers with more products have a lower ratio of attrition.

<img width="805" alt="relationshipcount" src="https://user-images.githubusercontent.com/77210085/144941405-2cb38b34-40cc-48d5-b7cb-089a41211713.png">

### Transaction Amount
Filtering by attrition we can see that a pattern shows up, those that spend very high amounts of money (above the higher dotted line) can be considered the loyal customers. Those leaving the bank seem to have less transactions for similar values of money spent. 
However, it is not unlikely that leaving customers are already adopting services from other banks, explaining the lower count of transactions, so lets look at the utilization ratio. 

<img width="816" alt="transamountcount" src="https://user-images.githubusercontent.com/77210085/144941428-4237694f-e57c-49d4-a5da-1369305a2af6.png">

### Average Utilization
The majority of customers that left have a much lower utilization ratios, and show some outliers with higher ratios, whereas existing customers follow a more flat density curve. 

<img width="824" alt="avgutilization" src="https://user-images.githubusercontent.com/77210085/144941455-4df8694c-17dd-4b3a-83d1-13ab9e917e5a.png">

### Contact Count and Inactivity in the last 12 Months
more contacts with the bank the higher the share of leaving customers, to the point that only lost customers have reached 6 touch-points. 
It is possible that the intention of leaving is a causation for the many contacts before ending the relationship, however it is also possible to assume that the more contacts implies a customer is less satisfied with the service. 
Hence, a first confounding factor is identified in the analysis, since data about customer satisfaction is not provided. 
In the meantime, the time being inactive in the last 12 months follows a very similar ratio, and might not affect substantially the probability of attrition.


<img width="821" alt="contactcount" src="https://user-images.githubusercontent.com/77210085/144941467-2e268082-5a5e-4438-b49d-8ee0e76229ce.png">
<img width="821" alt="inactivecount" src="https://user-images.githubusercontent.com/77210085/144941479-b5e1364b-f1fa-4341-9cb4-14d0cd9bd5a6.png">


### Revolving Balance
The high majority of lost customers tend to have much lower revolving balances. 

<img width="820" alt="revolvingbalance" src="https://user-images.githubusercontent.com/77210085/144941507-dd4bb0b1-0028-4e1a-bb83-baa905dbb35e.png">

## Regression
<img width="822" alt="logreg" src="https://user-images.githubusercontent.com/77210085/144941735-1237c79b-51c1-453e-987c-85457b509190.png">

A logistic regression with Frank Harrell’s method was used to gain some indicators. Disctimination indexes have been found as follow:
Dxy = 0.8, this represents the correlation between predicted and observed values and is considered to be of relevant when higher than 0.6, indicating a good similarity between prediction and observation.
C-index = 0.9, representing the quality of prediction (0.5 would be a random prediction), pointing again at a very good classificatory quality.
However, the possible presence of confounding factors these numbers are also likely to be indicators of an overoptimistic model. Plotting the distribution of the predicted leaving customer by observed leaving customers it is possible to see how many would be correctly guessed with this model:

<img width="833" alt="logaccuracy" src="https://user-images.githubusercontent.com/77210085/144942472-3e25fd64-7cef-41ba-9104-6ff3e98b8dff.png">

It seems that the majority of customers staying with the bank where correctly predicted, however, lost customers show a widely spread distribution over the risk of attrition, indicating a far less precise prediction. Accuracy is 89% which is significantly high, this might again come from the fact that the majority of observations are not lost customers (the ones that are mostly predicted correctly).


### Limitations
Around 19% of the customers in the data are customers that left the bank; a higher percentage of representative cases would have been more insightful.
