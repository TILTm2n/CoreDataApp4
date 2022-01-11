//
//  TableViewController.swift
//  CoreDataApp4
//
//  Created by Eugene on 11.01.2022.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var toDoItems: [MyTask] = []
    
    @IBAction func addTask(_ sender: Any) {
        let ac = UIAlertController(title: "Add Task", message: "add new task", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            let textField = ac.textFields?[0]
            self.saveTask(taskToDo: (textField?.text)!)
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        ac.addTextField { textField in
            
        }
        
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    func saveTask(taskToDo: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //создаем сущность
        let taskObject = MyTask(context: context)
        taskObject.taskToDo = taskToDo
        
        do {
            try? context.save()
            toDoItems.append(taskObject)
            print("savd, nice job")
        } catch {
            print(error.localizedDescription)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //обращение в БД для получения всех сущностей MyTask
        let fetchRequest: NSFetchRequest<MyTask> = MyTask.fetchRequest()
        
        do{
            //присваиваем массиву массив сущностей, полученных из контекста
            toDoItems = try context.fetch(fetchRequest)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        let task = toDoItems[indexPath.row]
        cell.textLabel?.text = task.taskToDo

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
