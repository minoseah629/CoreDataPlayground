
//1
import CoreData

//2
public class CoreDataStack {

    //3
    public let model: NSManagedObjectModel
    public let persistentStoreCoordinator:NSPersistentStoreCoordinator
    public let context: NSManagedObjectContext

    public init (){
        //initialize our comment entity
        let commentEntity = NSEntityDescription()
        commentEntity.name = "Comment"
        commentEntity.managedObjectClassName = NSStringFromClass(Comment.self)
        
        //create the attributes for the entity
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .integer64AttributeType
        idAttribute.isOptional = false
        idAttribute.isIndexed = true
        
        let commentAttribute = NSAttributeDescription()
        commentAttribute.name = "comment"
        commentAttribute.attributeType = .stringAttributeType
        commentAttribute.isOptional = false
        commentAttribute.isIndexed = false
        
        //add the properties to the entity
        commentEntity.properties = [idAttribute, commentAttribute]
        
        model = NSManagedObjectModel()
        model.entities = [commentEntity]
        
        // 4
        // setup the persistent store coordinator
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        }
        catch {
            print("error creating persistentstorecoordinator: \(error)")
        }
        
        // 5
        // set up managed object context
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        
    }
    // 6
    public func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    

}
