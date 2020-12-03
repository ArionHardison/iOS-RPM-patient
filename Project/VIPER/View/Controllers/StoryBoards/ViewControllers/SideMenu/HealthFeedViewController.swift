//
//  HealthFeedViewController.swift
//  Mi Dokter
//
//  Created by Mithra Mohan on 17/03/20.
//  Copyright © 2020 Mithra Mohan. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class HealthFeedViewController: UIViewController {

    @IBOutlet weak var tableViewHealthFeed: UITableView!
    @IBOutlet weak var noArticleView: UIView!
    @IBOutlet weak var noArticleImageView: UIImageView!
    @IBOutlet weak var noArticleLabel: UILabel!
    
    var article : [Article] = [Article]()
    
    lazy var loader  : UIView = {
        return createActivityIndicator(self.view.window ?? self.view)
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
         self.getArticlesList()

    }


}


extension HealthFeedViewController {
    func initialLoads() {
        registerCell()
        setupNavigationBar()
        self.setDesign()
    }
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Articles"
         Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
         self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
        self.noArticleLabel.text = "No Articles Available Currently"
        self.noArticleView.isHidden = true
        self.tableViewHealthFeed.isHidden = false
    }

    func registerCell(){
        self.tableViewHealthFeed.registerCell(withId: XIB.Names.HealthFeedTableViewCell)
        
        self.tableViewHealthFeed.tableFooterView = UIView()
    }

    func setDesign() {

        self.tableViewHealthFeed.separatorStyle = .none
    }
}


//MARK:- TABLEVIEW DELEGATES AND DATASOURCES

extension HealthFeedViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.article.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: self.view.frame.height, height: 40))
        label.text = "Published Articles"
        headerView.backgroundColor = .white
        label.textColor = .black
        headerView.addSubview(label)
        Common.setFontWithType(to: label, size: 18.0, type: .meduim)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HealthFeedTableViewCell") as! HealthFeedTableViewCell
        DispatchQueue.main.async {
            cell.selectionStyle = .none
            self.populateCell(cell: cell, data: self.article[indexPath.row])
          
        }

        return cell
    }
    
    func populateCell(cell : HealthFeedTableViewCell , data : Article){
//        Cache.image(forUrl: "\(imageURL)\(data.cover_photo ?? "")", completion: {  (image) in
//            if image != nil{
//                DispatchQueue.main.async {
//                    cell.ArticleImage.image = image
//                }
//
//            }
//        })
        let image = data.cover_photo
       
        cell.ArticleImage.imageFromUrl( "\(imageURL)\(data.cover_photo ?? "")", completion: { (image) in
         
            cell.ArticleImage.image = image
//            if image != nil{
//            cell.ArticleImage.image = image
//            }else{
//                cell.ArticleImage.image = #imageLiteral(resourceName: "NoImageFound")
//            }
            
        })
            if image == nil{
                cell.ArticleImage.image = #imageLiteral(resourceName: "NoImageFound")
            }
       
        cell.ArticleTitle.text = data.name ?? "".capitalized
        cell.Articlecontent.text = data.description ?? "".capitalized
        cell.publishedDate.text = dateConvertor(data.created_at ?? "", _input: .date_time, _output: .DMY)
 
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.HealthFeedDetailsViewController) as! HealthFeedDetailsViewController
        vc.titleText = self.article[indexPath.row].name ?? "" .capitalized
        vc.descriptionText = self.article[indexPath.row].description ?? ""
        vc.imageTitle = self.article[indexPath.row].cover_photo ?? ""
        vc.timeText = self.article[indexPath.row].updated_at ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
//        self.push(id: Storyboard.Ids.HealthFeedDetailsViewController, animation: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225 //UITableViewAutomaticDimension
    }
}


//Api calls
extension HealthFeedViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.ArticleModel:
                self.loader.isHideInMainThread(true)
                let data = dataDict as? ArticleModel
                self.article = data?.article ?? [Article]()
                if self.article.count > 0{
                    self.noArticleView.isHidden = true
                    self.tableViewHealthFeed.isHidden = false
                }else{
                    self.noArticleView.isHidden = false
                    self.tableViewHealthFeed.isHidden = true
                }
                self.tableViewHealthFeed.reloadData()
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getArticlesList(){
        self.presenter?.HITAPI(api: Base.articles.rawValue, params: nil, methodType: .GET, modelClass: ArticleModel.self, token: true)
        self.loader.isHidden = false
    }
    
}




extension UIImageView {
    
    public func imageFromUrl(_ urlStr: String,completion: @escaping (_ img: UIImage) -> Void) {
        
      //  self.image = #imageLiteral(resourceName: <#T##String#>)
        
        if urlStr.count > 0 {
        
            if let cachedImg = CacheA.imgCache.object(forKey: urlStr as NSString) {
               
                completion(cachedImg)
           
            }else {
                Alamofire.request(urlStr).responseString { (res) in
                    
                    switch res.result   {
                    
                    case .success(_):
                        
                        CacheA.imgCache.setObject(UIImage(data: res.data!) ?? UIImage(), forKey: urlStr as NSString)
                        let cachedImg = CacheA.imgCache.object(forKey: urlStr as NSString)
                      //  https://telehealthmanager.net/storage/images/article_img/bjOsiGZuBsBWvYuGn64abYAsDOJfhtuxfdJ9RkG6.jpeg
                        completion(cachedImg ?? #imageLiteral(resourceName: "NoImageFound"))
                        if urlStr == "https://telehealthmanager.net/storage/" {
                            completion (#imageLiteral(resourceName: "NoImageFound"))
                        }else{
                            completion(cachedImg ?? #imageLiteral(resourceName: "NoImageFound"))
                        }
                        
                    case .failure(let error):
                        
                        print("errrr", error)
                        completion(#imageLiteral(resourceName: "NoImageFound"))
                    }
            }
            }
           
        }else {
            completion(#imageLiteral(resourceName: "NoImageFound"))
        }
    }
    
}

struct CacheA {
    static let imgCache = NSCache<NSString,UIImage>()
}
