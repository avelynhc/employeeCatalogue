import Foundation
import UIKit
import CoreData

class CoreDataHandler {

    static let shared = CoreDataHandler()

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext?

    private init() {
        context = appDelegate.persistentContainer.viewContext
    }

    func saveContext() {
        appDelegate.saveContext()
    }

    func insert(name: String, age: Int, phone: String, completion: @escaping () -> Void) {
        let emp = Emp(context: context!)
        emp.name = name
        emp.age = Int64(age)
        emp.phone = phone
        saveContext()
        completion()
    }

    func update(emp: Emp, name: String, age: Int, phone: String, completion: @escaping () -> Void) {
        emp.name = name
        emp.age = Int64(age)
        emp.phone = phone
        saveContext()
        completion()
    }

    func fetchData() -> Array<Emp> {
        let fetchRequest: NSFetchRequest<Emp> = Emp.fetchRequest()
        do {
            let emp = try context?.fetch(fetchRequest)
            return emp!
        } catch {
            print(error.localizedDescription)
            let emp = Array<Emp>()
            return emp
        }
    }

    func deleteData(for emp: Emp, completion: @escaping () -> Void) {
        context!.delete(emp)
        saveContext()
        completion()
    }

    func searchData(with searchText: String) -> [Emp] {
        let fetchRequest: NSFetchRequest<Emp> = Emp.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@ OR age == %@ OR phone CONTAINS[c] %@", searchText, searchText, searchText)
        do {
            let result = try context!.fetch(fetchRequest)
            return result
        } catch {
            print("Failed to search employees")
            return []
        }
    }
}
