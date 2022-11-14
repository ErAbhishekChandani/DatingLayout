//
//  Mock.swift
//  DatingApp
//
//  Created by Er. Abhishek Chandani on 12/11/22.
//

import Foundation
import UIKit

//MARK: - Mock data for home page Pictures layout.
struct MatchProfile {
    var name: String = "Sarah"
    var age: String = "23"
    var interests: [ProfileInterest] = []
    var about: String = ""
    var images: [String] = []
}

class HomeMockData {
    
    private var mockProfilesCount: Int = 6
    private var pageCount: Int = 0

    func getProfile()->MatchProfile {
        let matchProfile = HomeMockData.mocks[pageCount]
        return matchProfile
    }
    
    func nextProfile(){
        pageCount = pageCount + 1
        if pageCount >= mockProfilesCount {
            pageCount = 0
        }
    }
    
    static private let mocks = [
    
        MatchProfile.init(
            name: "Sarah",
            age: "23",
            interests: [
                ProfileInterest.init(name: "Woman", type: .gender),
                ProfileInterest.init(name: "Dental Hygienist", type: .profession),
                ProfileInterest.init(name: "UCLA", type: .education),
                ProfileInterest.init(name: "5’4”", type: .height),
                ProfileInterest.init(name: "San Francisco, CA", type: .home),
                ProfileInterest.init(name: "Los Angeles, CA", type: .location),
                ProfileInterest.init(name: "Relationship", type: .relationship),
                ProfileInterest.init(name: "Friends", type: .friends),
            ],
            about: "Having a laugh and as much fun as physically possible is an absolute must for me! Trying not to take myself too seriously and just enjoying life 🤗",
            images: ["3-1","3-2","3-3"]
        ),
        
        MatchProfile.init(
            name: "Sam",
            age: "27",
            interests: [
                ProfileInterest.init(name: "Data Engineer", type: .profession),
                ProfileInterest.init(name: "UC Berkeley", type: .education),
                ProfileInterest.init(name: "5’9”", type: .height),
                ProfileInterest.init(name: "Chicago, Illinois", type: .home),
                ProfileInterest.init(name: "Los Angeles, CA", type: .location),
                ProfileInterest.init(name: "Relationship", type: .relationship),
                ProfileInterest.init(name: "Friends", type: .friends),
            ],
            about: "Just living life to the fullest and trying to find myself a lifelong hiking partner 🏔 ",
            images: ["4-1","4-2","4-3","4-4"]
        ),
        
        MatchProfile.init(
            name: "Josh",
            age: "25",
            interests: [
                ProfileInterest.init(name: "Man", type: .gender),
                ProfileInterest.init(name: "Marketing Manager", type: .profession),
                ProfileInterest.init(name: "NYU", type: .education),
                ProfileInterest.init(name: "6’0”", type: .height),
                ProfileInterest.init(name: "New York, NY", type: .home),
                ProfileInterest.init(name: "New York, NY.", type: .location),
                ProfileInterest.init(name: "Relationship", type: .relationship),
                ProfileInterest.init(name: "Friends", type: .friends),
            ],
            about: "I only work out so I can guiltlessly eat wings afterwards. Trying to find a tennis partner 🎾",
            images: ["2-1","2-2"]
        ),
        
        MatchProfile.init(
            name: "Jennifer",
            age: "24",
            interests: [
                ProfileInterest.init(name: "Admin Assistant", type: .profession),
                ProfileInterest.init(name: "University of Chicago", type: .education),
                ProfileInterest.init(name: "5’2”", type: .height),
                ProfileInterest.init(name: "Chicago, IL", type: .home),
                ProfileInterest.init(name: "Los Angeles, CA", type: .location),
                ProfileInterest.init(name: "Relationship", type: .relationship)
            ],
            about: "Love hiking, baking, and spending time with friends & family. Looking for someone I can talk to for hours & lose track of time 💖",
            images: ["4-5","4-6","4-7","4-8"]
        ),
        
        MatchProfile.init(
            name: "Jack",
            age: "23",
            interests: [
                ProfileInterest.init(name: "Art Collector", type: .profession),
                ProfileInterest.init(name: "Yale University", type: .education),
                ProfileInterest.init(name: "5’11”", type: .height),
                ProfileInterest.init(name: "New York, NY", type: .home),
                ProfileInterest.init(name: "New Haven, CT", type: .location),
                ProfileInterest.init(name: "Relationship", type: .relationship),
                ProfileInterest.init(name: "Friends", type: .friends)
            ],
            about: "Adore everything new, interesting and exciting. PS I’m looking for my muse 🎨",
            images: ["3-4","3-5","3-6"]
        ),
        MatchProfile.init(
            name: "Dylan",
            age: "24",
            interests: [
                ProfileInterest.init(name: "Man", type: .gender),
                ProfileInterest.init(name: "Product Manager", type: .profession),
                ProfileInterest.init(name: "Stanford University", type: .education),
                ProfileInterest.init(name: "5’11”", type: .height),
                ProfileInterest.init(name: "San Francisco, CA", type: .home),
                ProfileInterest.init(name: "Shadyside, PA", type: .location),
                ProfileInterest.init(name: "Relationship", type: .relationship),
                ProfileInterest.init(name: "Casual", type: .casual),
            ],
            about: "I drink massive amounts of coffee, love anything ridiculous or bizarre, and will shamelessly use my dog to flirt with you 🐶",
            images: ["4-9","4-10","4-11","4-12"]
        )
    ]
}

struct ProfileInterest {
    var name: String?
    var type: ProfileInterestType?
}

enum ProfileInterestType: String {
    case gender = "Woman"
    case profession = "DentalHygienist"
    case education = "UCLA"
    case height = "Hieght"
    case home = "home"
    case location = "Location"
    case relationship = "Relationship"
    case friends = "Friends"
    case casual = "casual"
}

