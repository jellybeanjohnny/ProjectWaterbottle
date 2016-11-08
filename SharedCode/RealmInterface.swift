//
//  RealmInterface.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 11/6/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

public class RealmInterface {
  
  public static let shared = RealmInterface()
  
  //MARK: Setup and initialization
  init() {
    setupRealmAppGroup()
  }
  
  func setupRealmAppGroup() {
    let realmPath: URL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Secrets.appGroupName)!.appendingPathComponent("db.realm")
    
    let config = RLMRealmConfiguration.default()
    config.fileURL = realmPath
    
    RLMRealmConfiguration.setDefault(config)
  }
  
  public func save(person: Person) {
    
    let realm = try! Realm()
    
    try! realm.write {
      realm.add(person)
      print("Added to Realm")
    }
  }
  
  public func loadPeople() -> Results<Person> {
    
    let realm = try! Realm()
    
    return realm.objects(Person.self)
  }
}

