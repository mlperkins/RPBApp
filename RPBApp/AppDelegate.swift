//
//  AppDelegate.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/4/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//
import Alamofire
import UIKit
import FBSDKCoreKit
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    public enum HTTPMethod: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }
    var window: UIWindow?
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AppModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //FACEBOOK DELEGATE CONNECT
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        // Initialize the window
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        // Set Background Color of window
        window?.backgroundColor = UIColor.white
        
        //automatically relog in if next line is not commented
        FBSDKAccessToken.setCurrent(nil)

        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        if (FBSDKAccessToken.current() != nil) {
            // Allocate memory for an instance of the 'MainViewController' class
            getFBInfo()
            let mainViewController = TabController(nibName: nil, bundle: nil)
            
            // Set the root view controller of the app's window
            window!.rootViewController = mainViewController
            
        }
        else {
            // Allocate memory for an instance of the 'MainViewController' class
            let loginViewController = LoginViewController(nibName: nil, bundle: nil)
            
            // Set the root view controller of the app's window
            window!.rootViewController = loginViewController
            
           
        }
        
        // Make the window visible
        window!.makeKeyAndVisible()
        
        
        return true
    }
    //CORE DATA
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //FACEBOOK
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        return handled
    }
    //gets users info from Facebook
    func getFBInfo(){
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let profileToStore = Profile(context: context)
        
        var profile: UserProfile!
        if (FBSDKAccessToken.current()) != nil{
            print("HERE")
            
            FBSDKGraphRequest (graphPath: "me", parameters: ["fields": "id, name, first_name, last_name,email, picture.type(large)"]).start(completionHandler: { (connection, result, Error) in
                if(Error == nil) {
                    print ("result \(String(describing: result))")
                    let fbData: [String:AnyObject] = result as! [String:AnyObject]
                    let id = fbData["id"]
                    profileToStore.email = fbData["email"] as? String
                    profileToStore.f_name = fbData["first_name"] as? String
                    profileToStore.l_name = fbData["last_name"] as? String
                    let profilePicURL = "http://graph.facebook.com/\(String(describing: id))/picture?type=large"
                    profileToStore.pic = profilePicURL as String?
                    //profile = UserProfile(n: fbData["first_name"] as! String, e: fbData["email"] as! String, p: "")
                    //GlobalVariables.sharedManager.profile = profile
                    print("HERE: " + profileToStore.pic!)
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    
                }
                else{
                    print("Error \(String(describing: Error))")
                }
                
            })
            
            
            
        }
    }
  
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        FBSDKAccessToken.setCurrent(nil)
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        FBSDKAccessToken.setCurrent(nil)
    }


}

