//
//  Person+CoreDataProperties.swift
//  CYRecord
//
//  Created by 陈煜 on 16/4/28.
//  Copyright © 2016年 陈煜. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var name: String?
    @NSManaged var pic: String?
    @NSManaged var date: Date?
    @NSManaged var record: NSSet?

}
