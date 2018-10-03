//
//  FirstViewController.swift
//  SoukainabenchekrounMobileChallenge
//
//  Created by Soukaina benchekroun on 02/10/2018.
//  Copyright © 2018 Soukaina benchekroun. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var index = 1
    final let url = URL(string: "https://api.github.com/search/repositories?q=created:%3E2017-10-22&sort=stars&order=desc&page=1")
    private var repos = item(items: [items(name: "", owner: Owner(login: "", avatar_url: ""), description: "", stargazers_count: 0)])
    final let limit = 34
    let activityIndicatorView : UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
    }
    
    func downloadJson() {
        activityIndicatorViewStart()
        let url = URL(string: "https://api.github.com/search/repositories?q=created:%3E2017-10-22&sort=stars&order=desc&page=1")
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                return
            }
            do
            {
                let decoder = JSONDecoder()
                self.repos = try decoder.decode(item.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicatorViewStop()
                }
            } catch {
                print("something wrong after downloaded")
                print(error)
            }
            }.resume()
    }
    func downloadJson(_ i : Int) {
        let url = URL(string: "https://api.github.com/search/repositories?q=created:%3E2017-10-22&sort=stars&order=desc&page=" + String(describing: i))
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                return
            }
            do
            {
                let decoder = JSONDecoder()
                let repos_temp : item = try decoder.decode(item.self, from: data)
                for r in repos_temp.items {
                    self.repos.items.append(r)
                }
            } catch {
                print("something wrong after downloaded")
                print(error)
            }
            }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell") as? RepoTableViewCell else { return UITableViewCell() }
        cell.numberOfStarsLbl.text = String(format: "%.1fk", ((Float((self.repos.items[indexPath.row].stargazers_count)))/10000))
        cell.repoDescriptionTxt.text = self.repos.items[indexPath.row].description.capitalized
        cell.repoNameLbl.text = self.repos.items[indexPath.row].name.capitalized
        cell.repoOwnerNameLbl.text = self.repos.items[indexPath.row].owner.login.capitalized
        if let imageURL = URL(string: self.repos.items[indexPath.row].owner.avatar_url) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.repoAvatarImg.image = image
                    }
                }
            }
        }
        return cell
    }
    
 
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maxOffset - currentOffset <= 40{
            index = index + 1
            if index < limit+1 {
                loadData()
            }
        }
    }
    
    func loadData(){
        downloadJson(index)
        tableView.reloadData()
    }
    
    func activityIndicatorViewStart() {
        activityIndicatorView.center = self.view.center
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    func activityIndicatorViewStop() {
        activityIndicatorView.stopAnimating()
    }
}

