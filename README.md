# Approach and Considerations

## Q1

### Approach. 
Innermost query is focused on pulling all valid data and calculating total confirmed amount. The outermost query is focused on grouping and summarizing the data. The number of inner queries was a balance between efficiency and readability
### Challenges.
The biggest challenge of the query  was deciding which data is valid. Should I include failed transaction or not, Is confirmed amount enough to guarantee that a transaction is valid. Another decision was what plans are valid and what users are valid. At the end of the day, I decided to use is_active and is_account deleted to determine active users, and is_archived and is_deleted to determine active plans. I realise this might not be accurate since it was not required by the question. However, in a work setting, I will ask my manager for confirmation before I use them.


## Q2

### Approach. 
Innermost query is focused on pulling all valid data and determining month of a transaction. The middle layer is focused on categorizing users. The number of inner queries was a balance between efficiency and readability
### Challenges.
Like the first question, the biggest challenge of the query  was deciding which data is valid. And whether to round the average number of users or not. This consideration was important because the categories were determined by round numbers. I decided to round the values.

## Q3

### Approach. 
Innermost query is focused on pulling all valid data and determining account type. The middle query is focused on determining the last transaction date. The number of inner queries was a balance between efficiency and readability
### Challenges.
The biggest challenge of the query  was deciding which data is valid. 

## Q4
### Approach. 
Innermost query is focused on pulling all valid data and calculating tenure month and transaction profit. The outermost query was focused on calculating estimated clv. The number of inner queries was a balance between efficiency and readability
### Challenges.
The biggest challenge of the query  was deciding which data is valid. 
