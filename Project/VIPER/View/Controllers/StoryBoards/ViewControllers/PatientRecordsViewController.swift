//
//  PatientRecordsViewController.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 02/12/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class PatientRecordsViewController: UIViewController {

    @IBOutlet weak var patientRecordTableView: UITableView!
    
    var patientRecords = [Record_details]()
    var doctorId : Int = 0
    private lazy var loader  : UIView = {
        return createActivityIndicator(self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getPatientRecords()
    }

}


extension PatientRecordsViewController {
    
    
    private func initialLoads() {
        self.registerCell()
        self.setupNavigationBar()
    }
    private func setupNavigationBar() {
         self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Patient Medical Records"
         Common.setFontWithType(to: self.navigationItem.title!, size: 18)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
         self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
    }

    func registerCell(){
        self.patientRecordTableView.register(UINib(nibName: XIB.Names.FavDoctorTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.FavDoctorTableViewCell)
    }
    
    func getPatientRecords(){
        let url = "\(Base.patientRecords.rawValue)/\(doctorId)"
        self.presenter?.HITAPI(api: url, params: nil, methodType: .GET, modelClass: PatientRecord.self, token: true)
        self.loader.isHidden = false
    }
    
}

extension PatientRecordsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        return self.patientRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.FavDoctorTableViewCell, for: indexPath) as! FavDoctorTableViewCell
        cell.doctorImage.setURLImage(self.patientRecords[indexPath.row].file ?? "")
        cell.labelName.text = "\(self.patientRecords[indexPath.row].title ?? "")"
        cell.labelSpeciality.text = "Created By \(self.patientRecords[indexPath.row].created_by ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ShowRecordViewController) as! ShowRecordViewController
        vc.titleString = self.patientRecords[indexPath.row].title ?? ""
        vc.descriptionText = self.patientRecords[indexPath.row].instruction ?? ""
        vc.Imagestring = self.patientRecords[indexPath.row].file ?? ""
        self.navigationController?.pushViewController(vc, animated: true)

    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.3))
        view.backgroundColor = section != 2 ? UIColor(named: "TextForegroundColor") : .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("FilterHeaderView", owner: self, options: nil)?.first as? FilterHeaderView
        headerView?.lbl.text = "Patient Medical Records"
        headerView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        return headerView
    }

}


extension PatientRecordsViewController : PresenterOutputProtocol {
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.PatientRecord:
                self.loader.isHideInMainThread(true)
                let data = dataDict as? PatientRecord
                self.patientRecords = data?.record_details ?? []
                self.patientRecordTableView.reloadInMainThread()
                break
            
            default: break
            
        }
         
    }
    
    func showError(error: CustomError) {
        showToast(msg: error.localizedDescription)
    }
    
    
}

