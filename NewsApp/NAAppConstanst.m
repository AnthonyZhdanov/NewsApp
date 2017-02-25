//
//  NAConstanst.m
//  NewsApp
//
//  Created by BRABUS on 2/24/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NAAppConstanst.h"

@implementation NAAppConstanst

NSString *const kAllSourcesList = @"https://newsapi.org/v1/sources?language=en"; //"?language=en" is optional and means code of the language you would like to get sources for
NSString *const kArticlesList = @"https://newsapi.org/v1/articles?source="; //Provides a list of live article metadata from a news source or blog
//the-next-web&sortBy=latest&apiKey={API_KEY}
NSString *const kSeparateCategory = @"https://newsapi.org/v1/sources?category=";
NSString *const kApiKey = @"&apiKey=262fcd3d295b4304ba053ac59ef70492"; //mine key for API
NSString *const kSortingTypeLatest = @"&sortBy=latest";
//All poossible categories: business, entertainment, gaming, general, music, science-and-nature, sport, technology.
NSString *const kAllCategories = @"";
NSString *const kBusiness = @"business";
NSString *const kEntertainment = @"entertainment";
NSString *const kGaming = @"gaming";
NSString *const kGeneral = @"general";
NSString *const kMusic = @"music";
NSString *const kScienceAndNature = @"science-and-nature";
NSString *const kSport = @"sport";
NSString *const kTechnology = @"technology";
NSString *const kLanguage = @"language=en";

@end
