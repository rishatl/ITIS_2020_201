//
//  TwitterViewModel.swift
//  Twitter
//
//  Created by Teacher on 16.02.2021.
//

import Foundation

protocol TwitterViewModel {
    var tweets: (([Tweet]) -> Void)? { get set }

    func loadData()
    func like(tweet: Tweet)
    func retweet(tweet: Tweet)
}

class TwitterViewModelImplementation: TwitterViewModel {
    private let twitterService: TwitterDataService = TwitterDataService()
    private var cachedTweets: [Tweet] = []
    var tweets: (([Tweet]) -> Void)?

    func loadData() {
        cachedTweets = twitterService.tweets
        tweets?(cachedTweets)
    }

    func like(tweet: Tweet) {
        twitterService.like(tweet: tweet) { [weak self] result in
            switch result {
                case .success:
                    self?.updateTweets()
                case .failure(let error):
                    print(error)
            }
        }
    }

    func retweet(tweet: Tweet) {
        twitterService.retweet(tweet: tweet) { [weak self] result in
            switch result {
                case .success:
                    self?.updateTweets()
                case .failure(let error):
                    print(error)
            }
        }
    }

    private func updateTweets() {
        cachedTweets = twitterService.tweets
        tweets?(cachedTweets)
    }
}
