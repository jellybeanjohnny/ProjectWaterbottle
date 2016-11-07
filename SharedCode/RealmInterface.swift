//
//  RealmInterface.swift
//  ProjectWaterBottle
//
//  Created by Matt Amerige on 11/6/16.
//  Copyright © 2016 BuildThings. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmInterface {
  
  public init() {
    
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
