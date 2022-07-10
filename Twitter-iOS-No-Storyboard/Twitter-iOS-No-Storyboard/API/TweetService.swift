//
//  TweetService.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 10.07.2022.
//

import Foundation
import Firebase
struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping (Error?, DatabaseReference) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweets": 0,
                      "caption": caption] as [String : Any]
        
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTweets(completion: @escaping (Error?, [Tweet]) -> Void) {
        var tweets = [Tweet]()
        REF_TWEETS.getData { error, snapshot in
            if let error = error {
                completion(error, tweets)
                return
            }
            
            guard let jsonArray = snapshot?.value as? [String: Any] else {
                completion(nil, tweets)
                return
            }
            
            for i in jsonArray {
                guard let dictionary = i.value as? [String: Any] else { continue }
                guard let id = i.key as? String else { continue }
                let tweet = Tweet(tweetID: id, dictionary: dictionary)
                tweets.append(tweet)
            }
           completion(nil, tweets)
        }
//        REF_TWEETS.observe(.childAdded) { snapshot in
//            guard let dictionary = snapshot.value as? [String : Any] else { return }
//            guard let tweetID = snapshot.key else { return }
//            let tweet = Tweet(tweetID: tweetID, dictionary: dictionary)
//            tweets.append(tweet)
//            completion(tweets)
//            print("sd: ", dictionary)
//        }
    }
}
