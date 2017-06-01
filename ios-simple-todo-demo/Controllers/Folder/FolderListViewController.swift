//
//  FolderListViewController.swift
//  ios-simple-todo-demo
//
//  Created by Eiji Kushida on 2017/06/01.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class FolderListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    fileprivate var alert: UIAlertController!

    //MARK : - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    //MARK : - Action
    @IBAction func didTapEditFolder(_ sender: UIBarButtonItem) {

        if tableView.isEditing {
        } else {
            showCreateFolderAlert()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
        setupEditButton(isEditing: editing)
    }

    /// ナビゲーションバーを設定する
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.hideBackButtonTitle()
    }

    /// 編集ボタンを設定する
    ///
    /// - Parameter isEditing: 編集モードか？
    private func setupEditButton(isEditing: Bool) {
        editButton.title = isEditing ?
            "すべて削除" : "新規作成"
    }

    private func showCreateFolderAlert() {

        alert = FolderAlertHelper()
            .createFolder(type: .add,
                          title: "新規フォルダ",
                          message: "このフォルダの名前を入力してください。",
                          delegate: self)
        present(alert, animated: true, completion: {
            self.alert = nil
        })
    }
}

//MARK : - AlertHelperDelegate
extension FolderListViewController: FolderAlertHelperDelegate {

    /// フォルダの追加または、更新完了通知を受信したときの処理
    ///
    /// - Parameters:
    ///   - type: 更新タイプ(登録 or 更新)
    ///   - folderName: フォルダ名
    func setFolder(type: FolderAlertHelperType, folderName: String) {

        switch type {
        case .add:
            print(folderName)
            break

        case .update(let index):
            print(index)
            break
        }
    }

    /// 全フォルダとそれに関連するメモを削除する
    func deleteAll() {
    }
}
