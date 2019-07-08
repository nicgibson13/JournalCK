//
//  Entry.swift
//  JournalCK
//
//  Created by Nic Gibson on 7/8/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation
import CloudKit

class Entry {
    
    var title: String
    var body: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
    convenience init?(record: CKRecord) {
    guard let title = record[EntryConstants.TitleKey] as? String,
          let body = record[EntryConstants.BodyKey] as? String,
          let timestamp = record[EntryConstants.TimestampKey] as? Date else {return nil}
        self.init(title: title, body: body, timestamp: timestamp, ckRecordID: record.recordID)
    }
}

struct EntryConstants {
    static let TitleKey = "title"
    static let BodyKey = "body"
    static let TimestampKey = "timestamp"
    static let recordType = "Entry"
}

extension CKRecord {
    convenience init(entry: Entry) {
        
        self.init(recordType: EntryConstants.recordType, recordID: entry.ckRecordID)
        self.setValue(entry.title, forKey: EntryConstants.TitleKey)
        self.setValue(entry.body, forKey: EntryConstants.BodyKey)
        self.setValue(entry.timestamp, forKey: EntryConstants.TimestampKey)
    }
}
