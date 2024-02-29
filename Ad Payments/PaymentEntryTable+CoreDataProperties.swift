//
//  PaymentEntryTable+CoreDataProperties.swift
//  Ad Payments
//
//  Created by Muhammed Ayaz on 29/02/24.
//
//

import Foundation
import CoreData


extension PaymentEntryTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PaymentEntryTable> {
        return NSFetchRequest<PaymentEntryTable>(entityName: "PaymentEntryTable")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?

}

extension PaymentEntryTable : Identifiable {

}
