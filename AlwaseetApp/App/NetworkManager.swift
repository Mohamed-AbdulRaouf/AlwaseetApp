//
//  NetworkManager.swift
//  AlwaseetApp
//
//  Created by mohamed on 6/30/22.
//

import Foundation
import RealmSwift
import ObjectMapper

typealias UserCompletionHandler = (_ user: UserData?, _ error: Error?) -> Void
typealias RegisterCompletionHandler = (_ isRegister: Bool?, _ error: Error?) -> Void
typealias SliderCompletionHandler = (_ slider: [SlidersData]?, _ error: Error?) -> Void
typealias AdvsCompletionHandler = (_ advsData: [AdvsData]?, _ error: Error?) -> Void
typealias ResponseCompletionHandler = (_ data: [Document]?, _ error: Error?) -> Void
typealias isAddAdvsCompletionHandler = (_ isAdvsAdd: Bool?, _ error: Error?) -> Void

class NetworkManager {
    
    public static var shared = NetworkManager()
    let appId = RealmSwift.App(id: "live_chat-dhkyv")
    var client: MongoClient?
    var database: MongoDatabase?
    var collection: MongoCollection?
    //    var collectionName: String = "Test"
    
    //    init(collectionName: String = "Test") {
    //        self.collectionName = collectionName
    //        connectToServer()
    //    }
    init() {
        connectToServer()
    }
    
    func connectToServer() {
        appId.login(credentials: Credentials.anonymous) { (result) in
            // Remember to dispatch back to the main thread in completion handlers
            // if you want to do anything on the UI.
            //            DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print("Login failed: \(error)")
            case .success(let user):
                print("Login as \(user) succeeded!")
                // Continue below
                self.client = self.appId.currentUser?.mongoClient("mongodb-atlas")//"project_test")//("mongodb-atlas")
                self.database = self.client?.database(named: "alwaseet_db")
            }
        }
        //        }
        //        client = self.appId.currentUser?.mongoClient("mongodb-atlas")//"project_test")//("mongodb-atlas")
        //        database = client?.database(named: "alwaseet_db")
        //        collection = database?.collection(withName: self.collectionName)
    }
    
    func register(name: String,
                  phone: String,
                  email: String,
                  password: String,
                  completionHandler: @escaping RegisterCompletionHandler) {
        
        let user: Document = ["name": AnyBSON(stringLiteral:name),
                              "phone": AnyBSON(stringLiteral:phone),
                              "email": AnyBSON(stringLiteral:email),
                              "password": AnyBSON(stringLiteral:password),
                              "create_at": AnyBSON(stringLiteral: Date().description)]
        
        self.collection = database?.collection(withName: "users")
        
        self.collection?.insertOne(user, { result in
            switch result {
            case .failure(let error):
                print("Call to MongoDB failed: \(error.localizedDescription)")
                completionHandler(false,error)
                return
            case .success(let user):
                print(user)
                completionHandler(true,nil)
            }
        })
        
    }
    
    func login(phone: String, password: String, completionHandler: @escaping UserCompletionHandler) {
        //        connectToServer()
        let loginFilter: Document = ["phone": AnyBSON(stringLiteral: phone),
                                     "password": AnyBSON(stringLiteral: password)]
        self.collection = database?.collection(withName: "users")
        
        self.collection?.find(filter: loginFilter) { result in
            switch result {
            case .failure(let error):
                print("Call to MongoDB failed: \(error.localizedDescription)")
                completionHandler(nil,error)
                return
            case .success(let user):
                print("Found this many documents in the collection matching the filter: \(user)")
                if user.count == 0 {
                    var error = NSError()
//                    error.code = 400
                    completionHandler(nil,error)
                    return
                }
                var userData = UserData()
                user.first?.forEach { (key, value) in
                    //                        propertyArgs[key] = AnyBSON(value)
                    print(key)
                    print(value)
                    if key == "email" {
                        print(value?.stringValue)
                        userData.email = value?.stringValue ?? ""
                    } else if key == "name" {
                        print(value?.stringValue)
                        userData.name = value?.stringValue ?? ""
                    } else if key == "phone" {
                        print(value?.stringValue)
                        userData.phone = value?.stringValue ?? ""
                    }
                }
                completionHandler(userData,nil)
            }
        }
        
    }
    
    func getSlider(completionHandler: @escaping SliderCompletionHandler) {
        let filter: Document  = [:] //["type": AnyBSON(stringLiteral: "slider")]
        
        self.collection = database?.collection(withName: "sliders")
        
        self.collection?.find(filter: filter) { result in
            switch result {
            case .failure(let error):
                print("Call to MongoDB failed: \(error.localizedDescription)")
                completionHandler(nil,error)
                return
            case .success(let sliders):
                print("Found this many documents in the collection matching the filter: \(sliders)")
                var sliderData = [SlidersData]()
                for slider in sliders {
                    slider.forEach { (key, value) in
                        if key == "img_url" {
                            print(value?.stringValue)
                            sliderData.append(SlidersData(imageUrl: value?.stringValue ?? ""))
                        }
                    }
                }
                completionHandler(sliderData,nil)
            }
        }
    }
    
    func getAdvs(filterBy: AdvsFilter, completionHandler: @escaping AdvsCompletionHandler) {
        var filter: Document  = ["category_type": AnyBSON(stringLiteral: filterBy.rawValue)]
        if filterBy == .all {
            filter = [:]
        }
        
        
        self.collection = database?.collection(withName: "advs")
        
        self.collection?.find(filter: filter) { result in
            switch result {
            case .failure(let error):
                print("Call to MongoDB failed: \(error.localizedDescription)")
                completionHandler(nil,error)
                return
            case .success(let data):
                print("Found this many documents in the collection matching the filter: \(data)")
                var advsData = [AdvsData]()
                var advData = AdvsData()
                for adv in data {
                    advData = AdvsData()
                    adv.forEach { (key, value) in
                        if key == "title" {
                            print(value?.stringValue)
                            advData.title = value?.stringValue ?? ""
                        }
                        
                        if key == "category_type" {
                            print(value?.stringValue)
                            advData.category_type = value?.stringValue ?? ""
                        }
                        if key == "background_image" {
                            print(value?.stringValue)
                            advData.background_image = value?.stringValue ?? ""
                        }
                        if key == "address" {
                            print(value?.stringValue)
                            advData.address = value?.stringValue ?? ""
                        }
                        if key == "phone" {
                            print(value?.stringValue)
                            advData.phone = value?.stringValue ?? ""
                        }
                        if key == "price" {
                            print(value?.stringValue)
                            advData.price = value?.stringValue ?? ""
                        }
                        if key == "images" {
                            print(value?.arrayValue)
                            for image in value?.arrayValue ?? [] {
                                advData.images.append(image?.stringValue ?? "")
                            }
                        }
                        //images
                    }
                    advsData.append(advData)
                }
                completionHandler(advsData,nil)
            }
        }
    }
    
    func getMyAdvs(completionHandler: @escaping AdvsCompletionHandler) {
        let filter: Document  = ["user_phone_created": AnyBSON(stringLiteral: UserLoginData.shared.userPhone)]
        self.collection = database?.collection(withName: "my_advs")
        
        self.collection?.find(filter: filter) { result in
            switch result {
            case .failure(let error):
                print("Call to MongoDB failed: \(error.localizedDescription)")
                completionHandler(nil,error)
                return
            case .success(let data):
                print("Found this many documents in the collection matching the filter: \(data)")
                var advsData = [AdvsData]()
                var advData = AdvsData()
                for adv in data {
                    advData = AdvsData()
                    adv.forEach { (key, value) in
                        if key == "title" {
                            print(value?.stringValue)
                            advData.title = value?.stringValue ?? ""
                        }
                        if key == "category_type" {
                            print(value?.stringValue)
                            advData.category_type = value?.stringValue ?? ""
                        }
                        if key == "background_image" {
                            print(value?.stringValue)
                            advData.background_image = value?.stringValue ?? ""
                        }
                        if key == "address" {
                            print(value?.stringValue)
                            advData.address = value?.stringValue ?? ""
                        }
                        if key == "phone" {
                            print(value?.stringValue)
                            advData.phone = value?.stringValue ?? ""
                        }
                        if key == "price" {
                            print(value?.stringValue)
                            advData.price = value?.stringValue ?? ""
                        }
                        if key == "images" {
                            print(value?.arrayValue)
                            for image in value?.arrayValue ?? [] {
                                advData.images.append(image?.stringValue ?? "")
                            }
                        }
                        //images
                        
                        //                        advsData.append(advData)
                    }
                    advsData.append(advData)
                }
                completionHandler(advsData,nil)
            }
        }
    }
    
    func addAdvs(advs: AdvsData, completionHandler: @escaping isAddAdvsCompletionHandler) {
        
        let advs: Document = ["phone": AnyBSON(stringLiteral:advs.phone),
                              "title": AnyBSON(stringLiteral:advs.title),
                              "background_image": AnyBSON(stringLiteral:advs.background_image),
                              "price": AnyBSON(stringLiteral:advs.price),
                              "address": AnyBSON(stringLiteral:advs.address),
                              "category_type": AnyBSON(stringLiteral:advs.category_type),
                              "user_phone_created": AnyBSON(stringLiteral: UserLoginData.shared.userPhone),
                              "create_at": AnyBSON(stringLiteral: Date().description)]
        
        self.collection = database?.collection(withName: "my_advs")
        
        self.collection?.insertOne(advs, { result in
            switch result {
            case .failure(let error):
                print("Call to MongoDB failed: \(error.localizedDescription)")
                completionHandler(false,error)
                return
            case .success(let user):
                print(user)
                completionHandler(true,nil)
            }
        })
        
        // add advs to main collection
        self.collection = database?.collection(withName: "advs")
        
        self.collection?.insertOne(advs, { result in
            switch result {
            case .failure(let error):
                //                print("Call to MongoDB failed: \(error.localizedDescription)")
                //                completionHandler(false,error)
                //                return
                print(error)
            case .success(let user):
                print(user)
                //                completionHandler(true,nil)
            }
        })
        
    }
    
    
}
