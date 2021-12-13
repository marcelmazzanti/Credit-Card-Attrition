# Credit Card Attrition Prediction
Using a dataset provided by a bank, several variables are analyzed as predictors for a logistic regression, which will infer the probability of losing a customer.

### Problem Recognition
After the 2008 crisis, the financial sector and credit card market is more and more witnessing high volatility, acquiring new customers can now cost up to 7 times more than retaining one, which means that losing customers can be a large financial loss.

## Data Analysis
After looking at demographics to maek sure there was no big disparity in the data that could work as confounding factor, the following resulted to be the most relevant variables:

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

<img width="715" alt="Screenshot 2021-12-13 at 16 30 20" src="https://user-images.githubusercontent.com/77210085/145892002-40d49693-97cd-48e6-9224-02385fe1b21d.png">

<img width="822" alt="logreg" src="https://user-images.githubusercontent.com/77210085/144941735-1237c79b-51c1-453e-987c-85457b509190.png">

A logistic regression with Frank Harrell’s method was used to gain some indicators. Disctimination indexes have been found as follow:
Dxy = 0.8, this represents the correlation between predicted and observed values and is considered to be of relevant when higher than 0.6, indicating a good similarity between prediction and observation.
C-index = 0.9, representing the quality of prediction (0.5 would be a random prediction), pointing again at a very good classificatory quality.
However, the possible presence of confounding factors these numbers are also likely to be indicators of an overoptimistic model. Plotting the distribution of the predicted leaving customer by observed leaving customers it is possible to see how many would be correctly guessed with this model:

<img width="820" alt="logaccuracy" src="https://user-images.githubusercontent.com/77210085/144942472-3e25fd64-7cef-41ba-9104-6ff3e98b8dff.png">

It seems that the majority of customers staying with the bank where correctly predicted, however, lost customers show a widely spread distribution over the risk of attrition, indicating a far less precise prediction. Accuracy is 89% which is significantly high, this might again come from the fact that the majority of observations are not lost customers (the ones that are mostly predicted correctly). However it is important to check accuracy for each type of error.

<img width="820" alt="Screenshot 2021-12-13 at 16 33 22" src="https://user-images.githubusercontent.com/77210085/145892708-c5e4589a-1aa7-4df1-a593-952de4b25979.png">


After running a confusion matrix and testing, the accuracy resulted to be at 51%, the problem with this result is that, as stated, it is very expensive to lose customers and acquire new ones as compared to retain existing ones. The probability of a Type 1 error (trying to retain a client when not necessary) is far less financially risky than a Type 2 error (not trying to retain a customer when it is needed). Following this model the probabilities of committing a Type 2 error are consistently higher than those of committing a Type 1 error.

## Coclusions

- The coefficients indicate that the number of contacts made with the bank in the last 12 months is the most relevant predictor
- The second most important predictor is the inactivity of a client, those that have been inactive for a longer than average time should be involved and target with retaining strategies
- The next predictor to consider is the number of products held, trying to augment the extent of the relationship with a customer can function as a way to strengthen the relationship and enhance commitment
- Customers that are making a lower than usual number of transactions are also important to target with retaining strategies.
- Considering Revolving balance and the amount spent for each transaction, the coefficients indicate that the influence of these variables on the attrition probability is very low, but when needed to be assessed, customers to target are those with a low revolving balance and higher transactions amount


### Limitations
Around 19% of the customers in the data are customers that left the bank; a higher percentage of representative cases would have been more insightful.
