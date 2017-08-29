//
//  Record+CoreDataProperties.swift
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

extension Record {

    @NSManaged var acid: NSNumber?
    @NSManaged var bathe: NSNumber?
    @NSManaged var height: NSNumber?
    @NSManaged var weight: NSNumber?
    @NSManaged var carapace: NSNumber?
    @NSManaged var breastplate: NSNumber?
    @NSManaged var remark: String?
    @NSManaged var date: Date?
    @NSManaged var person: Person?

}
