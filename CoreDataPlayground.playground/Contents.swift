import Foundation
import CoreData

let entityName = "Comment"
let coreDataStack = CoreDataStack()
		
// 1 
let commentEntity = NSEntityDescription.entity(forEntityName: entityName, in: coreDataStack.context)

//2 
let comment = Comment(entity: commentEntity!, insertInto: coreDataStack.context)

//3 
comment.id = 1
comment.comment = "Core Data is interesting"

//4 
coreDataStack.saveContext()

////1 
let fetchRequest = NSFetchRequest<Comment>(entityName: entityName)
//
////2 
let sort = NSSortDescriptor(key: "id", ascending: true)
fetchRequest.sortDescriptors = [sort]
//
////3
//
if let results = try? coreDataStack.context.fetch(fetchRequest)
{
   results.count
    results[0].comment
}
else
{
print("There was an error getting the results.")
}
