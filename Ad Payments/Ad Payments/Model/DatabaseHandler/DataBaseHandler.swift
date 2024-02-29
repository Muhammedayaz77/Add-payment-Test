//
//  DataBaseHandler.swift
//  Ad Payments
//
//  Created by Muhammed Ayaz on 28/02/24.
//

import UIKit
import CoreData

let Str_PaymentEntryTable = "PaymentEntryTable"


let Str_DataBaseName = "AdPaymentDataBase"
let Str_DataBaseExtensionResource = ".momd"
let Str_DataBaseExtension = ".sqlite"

class DataBaseHandler: NSObject {
    
    override init() {
        super.init()
        self.copyDatabaseIfNeeded()
    }
    
    var managedObject: [NSManagedObject] = []
    
    static let sharedInstance = DataBaseHandler()

    
    func getDatBasePath() -> String {
        let path:Array=NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let directory:String=path[0]
        let DBpath=(directory as NSString).appendingPathComponent("AdPaymentDataBase.xcdatamodeld")
        
        return DBpath
    }
    
    func copyDatabaseIfNeeded()
    {
        let DBpath=getDatBasePath()

        print(DBpath)

        if (FileManager.default.fileExists(atPath: DBpath))
        {
            print("Successfull database create")
        }
        else
        {
            let pathfrom:String=(Bundle.main.resourcePath! as NSString).appendingPathComponent("AdPaymentDataBase.momd")//TalkLine.momd//TalkLine/model/DatabaseHandler/TalkLine.xcdatamodeld

            var success:Bool
            do {
                try FileManager.default.copyItem(atPath: pathfrom, toPath: DBpath)
                success = true
            } catch _ {
                success = false
            }

            if !success
            {
                print("database not create ")
            }
            else
            {
                print("Successfull database new create")
            }
        }
    }
    
    
    //MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer =
        {
            /*
             The persistent container for the application. This implementation
             creates and returns a container, having loaded the store for the
             application to it. This property is optional since there are legitimate
             error conditions that could cause the creation of the store to fail.
             */
            let container = NSPersistentContainer(name: "AdPaymentDataBase")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
                
            })
            return container
    }()
    
    
    func getContext () -> NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    
    
    func getTableObj(tableNameStr : String) -> NSManagedObject {
        //to get all attributs of table
        let entity = NSEntityDescription.entity(forEntityName: tableNameStr, in: getContext())!
        
         let NSManagedObjectObj = NSManagedObject(entity: entity, insertInto: getContext())
        return NSManagedObjectObj
    }
    
   

    
  
    
    
     //MARK: - Fetch
    
    func fetchAllDataFromTable(entityNameStr: String) -> Array<Any>
    {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityNameStr)
        do
        {
            // Execute Fetch Request
            let records = try getContext().fetch(fetchRequest)
            return records
        }
        catch
        {
            print("Error fetchAllDataFromTable \(error.localizedDescription).")
        }
        return []
    }
    
    
    func fetchDataFromTable(entityNameStr: String, predicate:NSPredicate) -> Array<Any>
       {
           // Create Fetch Request
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityNameStr)
           do
           {
               // Execute Fetch Request
               let records = try getContext().fetch(fetchRequest)
               return records
           }
           catch
           {
               print("Error fetchDataFromTable \(error.localizedDescription).")
           }
           return []
       }
       
       
    
    //MARK: - Delete
    func deleteDataFromTable(managedObject:NSManagedObject)
    {
        getContext().delete(managedObject)
        SaveInDB()
    }
     
    func deleteAllDataFromTable(tableName: String)
    {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: tableName)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            
            try persistentContainer.persistentStoreCoordinator.execute(request, with: getContext())
        }
        catch {
             print("Error deleteAllDataFromTable  \(error.localizedDescription).")
        }
       
        SaveInDB()
    }
    
    
    //MARK: - Core Data Save
       func SaveInDB() {
              do {
                 try getContext().save()
                } catch let error as NSError {
                 print("Error SaveInDB \(error), \(error.userInfo)")
              }
          }
       
    
    func copyDatabase () {
        let databasePath = getDBPath()
        if fileExistsAtpath(pathStr: databasePath) {
            //File is already exist
            print("Database file already exists")
            return
        } else {
            let fileManager = FileManager.default
            let bundelDatabasePathStr = getFilePathFromBundel(fileName: Str_DataBaseName+Str_DataBaseExtensionResource)
            let documentPathStr = getDBPath()
            //var error : NSError?
            do{
                try fileManager.copyItem(atPath: bundelDatabasePathStr!, toPath: documentPathStr)
            }catch{
                print("\n")
                print(error)
            }
        }
    }
    
    
    
    
    func getFilePathFromBundel (fileName fileNameStr : String) -> String? {
        let BundleFilelPath = Bundle.main.path(forResource: fileNameStr, ofType: nil)
          return BundleFilelPath
    }
    
    func getDocumentDirectoriesPath () -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print("documentsPath = ",(documentsPath))
        return documentsPath
    }
    
    func getDBPath() -> String {
        let documentsPath = getDocumentDirectoriesPath()
        let databasePath = documentsPath+Str_DataBaseName+Str_DataBaseExtension
        return databasePath
    }
    
    func fileExistsAtpath (pathStr : String) -> Bool {
        let fileManager = FileManager.default
        let success = fileManager.fileExists(atPath: pathStr)
        return success
    }
    
}
