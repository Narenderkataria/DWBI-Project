#install.packages(c("rjson", "bit64", "httr", "doBy", "XML", "base64enc"))
library(devtools)
#install_github("geoffjentry/twitteR")
#install_github('R-package','quandl')
library(ROAuth)
library(plyr)
library(httr)
library(doBy)
library(Quandl)
library(twitteR)
library(htmltab)
library(tidyr)
library(reshape)
library(ggthemes)
library(ggplot2)

consumer_key <- 'rf6m9pbPE4dgdJqtXwIrzPNp2'
consumer_secret <- '9eBF9WQC8eBb4AzKxwVLDr9ZUj3h2aMYbysMtexV41D14RZQuz'
access_token <- '350960941-7VCLXp3E1dHnAxv0UrZH92gAWr4EsBvOqFJ17Su4'
access_secret <- 'vCKVsBVVOmWmYJngvmcJjNgBTuzqYKW7bQSXcCxFxdnvj'

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

cred <- OAuthFactory$new(consumerKey=consumer_key,consumerSecret=consumer_secret, 
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')


pos.words <- scan('C:/Users/Narender/Desktop/postive_words.txt', what='character')
neg.words <- scan('C:/Users/Narender/Desktop/negative_words.txt', what='character')


#now we can add some domain-specific terminolgy

pos.words <- c(pos.words, 'congrats', 'prizes', 'prize', 'thanks', 'thanx', 'grt', 'g8')
neg.words <- c(neg.words, 'fight', 'fighting', 'wtf', 'arrest', 'no', 'not',"nonsense")

#our first function

score.sentence <- function(sentence, pos.words, neg.words) {
  #here some basic cleaning
  sentence = gsub('[[:punct:]]', '', sentence)
  sentence = gsub('[[:cntrl::]]', '', sentence)
  sentence = gsub('\\d+', '', sentence)
  sentence = tolower(sentence)
  
  #basic data structure construction
  word.list = str_split(sentence, '\\s+')
  words = unlist(word.list)
  
  #here we count the number of words that are positive and negative
  pos.matches = match(words, pos.words)
  neg.matches = match(words, neg.words)
  
  #throw away those that didn't match
  pos.matches = !is.na(pos.matches)
  neg.matches = !is.na(neg.matches)
  
  #compute the sentiment score
  score = sum(pos.matches) - sum(neg.matches)
  
  return(score)
}

#our second function that takes an array of sentences and sentiment analyses them
score.sentiment <- function(sentences, pos.words, neg.words) {
  require(plyr)
  require(stringr)
  
  #here any sentence/tweet that causes an error is given a sentiment score of 0 (neutral)
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    tryCatch(score.sentence(sentence, pos.words, neg.words ), error=function(e) 0)
  }, pos.words, neg.words)
  
  #now we construct a data frame
  scores.df = data.frame(score=scores, text=sentences)
  
  return(scores.df)
}

#our third function, that communicates with twitter and then scores each of the tweets returned
collect.and.score <- function (handle, cityName, pos.words, neg.words) {
  
  tweets = searchTwitter(handle, n=250)
  text = laply(tweets, function(t) t$getText())
  
  score = score.sentiment(text, pos.words, neg.words)
  score$cityName = cityName
  #  score$code = code
  
  return (score)  
}

#here we invoke the function above for each of our airlines
Paris = collect.and.score("Hotel+Paris","Paris", pos.words, neg.words)
Milan = collect.and.score("Hotel+Milan","Milan", pos.words, neg.words)
Vienna= collect.and.score("Hotel+Vienna","Vienna", pos.words, neg.words)
Amsterdam = collect.and.score("Hotel+Amsterdam","Amsterdam", pos.words, neg.words)
Barcelona = collect.and.score("Hotel+Barcelona","Barcelona", pos.words, neg.words)
London = collect.and.score("Hotel+London","London", pos.words, neg.words)




all.scores1 = rbind(
  
  Paris,
  Milan,
  Vienna,
  Amsterdam,
  Barcelona,
  London
  )

head(all.scores1)

write.csv(all.scores1, file = "All.Tweets.csv")

#skim only the most positive or negative tweets to throw away noise near 0
all.scores1$pos = as.numeric( all.scores1$score >= 1)
all.scores1$neg = as.numeric( all.scores1$score <= -1)

#now we construct the twitter data frame and simultaneously compute the pos/neg sentiment scores for each airline
twitter.df = ddply(all.scores1, c('countryName'), summarise, pos.count = sum (pos), neg.count = sum(neg))

#and here the general sentiment 
twitter.df$all.count = twitter.df$pos.count + twitter.df$neg.count

#now in order to be able to compare data sets we normalise the sentiment score to be a percentage
twitter.df$score = round (100 * twitter.df$pos.count / twitter.df$all.count)

#and to help understand our data, order by our now normalised score
orderBy(~-score, twitter.df)

write.csv(twitter.df, file="results1.csv")
