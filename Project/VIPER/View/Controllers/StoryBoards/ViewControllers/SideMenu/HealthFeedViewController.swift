//
//  HealthFeedViewController.swift
//  Mi Dokter
//
//  Created by Mithra Mohan on 17/03/20.
//  Copyright © 2020 Mithra Mohan. All rights reserved.
//

import UIKit
import ObjectMapper

class HealthFeedViewController: UIViewController {

    @IBOutlet weak var tableViewHealthFeed: UITableView!
    @IBOutlet weak var noArticleView: UIView!
    @IBOutlet weak var noArticleImageView: UIImageView!
    @IBOutlet weak var noArticleLabel: UILabel!
    
    var article : [Article] = [Article]()
    
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
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: self.view.frame.height, height: 40))
        label.text = "Published Articles"
        label.textColor = .black
        headerView.addSubview(label)
        self.tableViewHealthFeed.tableHeaderView = headerView
        self.tableViewHealthFeed.separatorStyle = .none
    }
}


//MARK:- TABLEVIEW DELEGATES AND DATASOURCES

extension HealthFeedViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.article.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HealthFeedTableViewCell") as! HealthFeedTableViewCell
        cell.selectionStyle = .none
        self.populateCell(cell: cell, data: self.article[indexPath.row])
        return cell
    }
    
    func populateCell(cell : HealthFeedTableViewCell , data : Article){
        cell.ArticleImage.setURLImage(data.cover_photo ?? "")
        cell.ArticleTitle.text = data.name ?? ""
        cell.Articlecontent.text = data.description ?? ""
        cell.publishedDate.text = dateConvertor(data.created_at ?? "", _input: .date_time, _output: .DMY)
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(id: Storyboard.Ids.HealthFeedDetailsViewController, animation: true)
    }
}


//Api calls
extension HealthFeedViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.ArticleModel:
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
    }
    
}
