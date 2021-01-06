//
//  MedicalRecordsViewController.swift
//  MiDokter User
//
//  Created by Vinod Reddy Sure on 12/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class MedicalRecordsViewController: UIViewController {

    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var downloadMedicalView: UIView!
    @IBOutlet weak var addMedicalRecordButton: UIButton!
    
     var medical  = [Medicals]()
    lazy var loader  : UIView = {
        return createActivityIndicator(self.view.window ?? self.view)
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.getMedicalRecords()
        self.setupNavigationBar()
    }

}

extension MedicalRecordsViewController {
    func initialLoads() {
        registerCell()
      
        self.addMedicalRecordButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)

    }
    private func setupNavigationBar() {
         self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Medical Records"
         Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
         self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
        self.noDataLabel.text = "No Medical Records Found"
    }

    func registerCell(){
//        self.listTable.registerCell(withId: XIB.Names.FavDoctorTableViewCell)
        self.listTable.register(UINib(nibName: XIB.Names.FavDoctorTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.FavDoctorTableViewCell)
    }
    
    @IBAction private func addAction(sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.AddMedicalRecordViewController) as! AddMedicalRecordViewController
        vc.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MedicalRecordsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.medical.count > 0{
//            return self.medical.count + 1
//        }
        return self.medical.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.listTable.dequeueReusableCell(withIdentifier: XIB.Names.FavDoctorTableViewCell, for: indexPath) as! FavDoctorTableViewCell
//        if indexPath.row == self.medical.count{
//            cell.doctorImage.setURLImage(self.medical[indexPath.row].doctor_profile?.profile_pic ?? "")
//            cell.labelName.text = "Other Doctors"
//            cell.labelSpeciality.text = "Nil"
//            return cell
////        }else{
        cell.doctorImage.setURLImage(self.medical[indexPath.row].doctor_profile?.profile_pic ?? "")
        cell.labelName.text = "\(self.medical[indexPath.row].first_name ?? "Other") \(self.medical[indexPath.row].last_name ?? "Doctors")"
        cell.labelSpeciality.text = "\(self.medical[indexPath.row].doctor_profile?.speciality?.name ?? "Nil")"
        return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == self.medical.count{
            let recordVC = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.PatientRecordsViewController) as! PatientRecordsViewController
            recordVC.doctorId = 0
            self.navigationController?.pushViewController(recordVC, animated: true)
        }else{
        let recordVC = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.PatientRecordsViewController) as! PatientRecordsViewController
        recordVC.doctorId = self.medical[indexPath.row].clinic?.doctor_id ?? 0
        self.navigationController?.pushViewController(recordVC, animated: true)
        }

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
        headerView?.lbl.text = "Medical Records given by Doctors"
        headerView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        return headerView
    }

}
//Api calls
extension MedicalRecordsViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.ListMedicalRecord:
                self.loader.isHideInMainThread(true)
                let data = dataDict as? ListMedicalRecord
                self.medical = data?.medicals ?? []
                if self.medical.count > 0 {
                    self.downloadMedicalView.isHidden = false
                    self.listTable.isHidden = false
                    self.noDataView.isHidden = true
                }else{
                    self.downloadMedicalView.isHidden = true
                    self.listTable.isHidden = true
                    self.noDataView.isHidden = false
                }
                self.listTable.reloadData()
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getMedicalRecords(){
        self.presenter?.HITAPI(api: Base.medicalRecords.rawValue, params: nil, methodType: .GET, modelClass: ListMedicalRecord.self, token: true)
        self.loader.isHidden = false
    }
    
}
