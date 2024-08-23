
# terraform-conoha-v3-api


## 概要

このリポジトリは、Terraformを使用して[ConoHa VPS Ver.3.0](https://doc.conoha.jp/api-vps3/)のAPIを操作するためのサンプルコードと設定ファイルを提供します。

ConoHaのクラウドサービスに対応するインフラストラクチャをコードで管理し、自動化するための具体的な手順を含んでいます。


## 前提条件

1. Terraformがインストールされていること
1. ConoHaアカウントとAPIの認証情報があること

## Terraformのインストール



以下はMacOSにTerraformをインストールするためのコマンド例です。

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

Terraformのインストールについての詳細な手順は、[公式ドキュメント](https://learn.hashicorp.com/tutorials/terraform/install-cli)を参照してください。


## ConoHa APIの認証情報

ConoHa APIを利用するためには、API認証情報が必要です。
詳しくは以下記事内の『ConoHa API利用のための事前準備ガイド』の章を参照してください。

[ConoHa APIを「Postman API ネットワーク」で使えるようにしてみた](https://qiita.com/skworks33/items/68f7ca09a8f5cf291d65#conoha-api%E5%88%A9%E7%94%A8%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AE%E4%BA%8B%E5%89%8D%E6%BA%96%E5%82%99%E3%82%AC%E3%82%A4%E3%83%89)

## クイックスタート

### 1. リポジトリをクローン

```bash
git clone https://github.com/skworks33/terraform-conoha-v3-api.git
cd terraform-conoha-v3-api
```

### 2. 変数の設定

`terraform.tfvars`ファイルを作成し、以下のようにAPI認証情報とサーバの設定を記述します。

```hcl
conoha_v3_auth_url        = "https://identity.c3j1.conoha.io/v3"
conoha_v3_tenant_name     = "gnct********"
conoha_v3_user_name       = "gncu********"
conoha_v3_password        = "****************"

ssh_keypair_name          = "your-terraform-keypair-name"
ssh_keypair_public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAA..."
boot_volume_name          = "your-terraform-boot-volume-name"
instance_name             = "your-terraform-instance-name"
instance_root_password    = "****************"
```

### 3. Terraformの初期化

```bash
terraform init
```

### 4. 設定ファイルの適用

```bash
terraform apply
```

プロンプトが表示されたら`yes`と入力して続行します。

## 詳細な説明

本リポジトリの詳細な説明は、作者が投稿している以下の記事を参照してください。

[ConoHaとTerraformで始めるインフラ自動化 前編：導入から基本のサーバー構築まで](https://developers.gmo.jp/technology/47155)

[ConoHaとTerraformで始めるインフラ自動化 後編：GPUサーバー構築と運用ガイド](https://developers.gmo.jp/technology/49439)

## OpenStack CLIを利用する際の手順

本リポジトリはTerraformを利用してインフラストラクチャを管理するためのものですが、フレーバー情報を取得する際などにOpenStack CLIが必要な場合があります。

以下に、OpenStack CLIを使用してフレーバー情報を取得する手順を示します。

### 1. OpenStack CLIのインストール



以下はMacOSにOpenStack CLIをインストールするためのコマンド例です。

```bash
pip install python-openstackclient
```

OpenStack CLIのインストールについての詳細な手順は、[公式ドキュメント]()を参照してください。


### 2. 認証情報の設定

ConoHaへのアクセスに必要な認証情報を設定します。

環境変数を使用するか、OpenStackクライアント環境スクリプトを作成して読み込む方法があります。
以下は、OpenStackクライアント環境スクリプトを作成して読み込む方法の例です。

必要な認証情報を含む `PROJECT-openrc.sh` ファイルを作成します。

ユーザ固有の値についてはConoHaのコントロールパネル内の「[API](https://manage.conoha.jp/V3/API/)」から取得してください。


```sh
#!/bin/bash
# This file should be sourced to set up OpenStack CLI environment variables

export OS_AUTH_URL=https://identity.c3j1.conoha.io/v3
export OS_USER_DOMAIN_NAME=gnc
export OS_PROJECT_DOMAIN_ID=gnc
export OS_PROJECT_ID="your_project_id"
export OS_PROJECT_NAME="your_project_name"
export OS_USERNAME="your_username"
export OS_PASSWORD="your_password"
export OS_REGION_NAME=c3j1
export OS_INTERFACE=public
export OS_IDENTITY_API_VERSION=3
```

`source`コマンドを使用して、環境変数を設定します。

```bash
source PROJECT-openrc.sh
```


環境変数を設定した後、設定が正しいかを確認します。

```bash
openstack token issue
```

これにより、認証トークンが発行され、設定が正しいことが確認できます。

### 3. フレーバー情報の取得

認証情報を設定した後、以下のコマンドを実行してフレーバー情報を取得します。

```bash
openstack flavor list
```

このコマンドにより、利用可能なすべてのフレーバーのリストが表示されますが、
ConoHaのAPI経由で指定可能なフレーバーは時間課金プランのみのため、以下のコマンドで絞り込むことができます。

```bash
openstack flavor list | grep -v -- '-p-'
```


```bash
+--------------------------------------+----------------------+--------+------+-----------+-------+-----------+
| ID                                   | Name                 |    RAM | Disk | Ephemeral | VCPUs | Is Public |
+--------------------------------------+----------------------+--------+------+-----------+-------+-----------+
| 09efe5d4-725a-4027-a28a-acd85286d87c | g2w-t-c2m1           |   1024 |    0 |         0 |     2 | True      |
| 1488a6c7-6c8f-4e39-a522-ccab7d3acc84 | g2d-t-c1m2d30        |   2048 |   40 |         0 |     1 | True      |
| 2e60a683-1f84-4f12-a3a9-7caf4bdb5e21 | g2w-t-c6m8           |   8192 |    0 |         0 |     6 | True      |
| 32ec2250-4123-4d73-b13e-985771208a2e | g2d-t-c6m16d240      |  16384 |  250 |         0 |     6 | True      |
...
...
```

また、ConoHaではLinux用とWindows用のフレーバーが異なるため、以下のコマンドでLinux用の時間課金フレーバーのみを表示することもできます。

```bash
output=$(openstack flavor list); echo "$output" | head -n 3; echo "$output" | grep 'g2l-t-'
```

```bash
+--------------------------------------+----------------------+--------+------+-----------+-------+-----------+
| ID                                   | Name                 |    RAM | Disk | Ephemeral | VCPUs | Is Public |
+--------------------------------------+----------------------+--------+------+-----------+-------+-----------+
| 3f8244e7-c7a2-4c60-84b9-cd76dd98a177 | g2l-t-c1m512         |    512 |    0 |         0 |     1 | True      |
| 66394e53-3e1c-455a-a09e-e575520edcef | g2l-t-c22m228g1-h100 | 233472 |    0 |         0 |    22 | True      |
| 6f3c4747-8471-4a38-902b-4c57ad76d776 | g2l-t-c4m4           |   4096 |    0 |         0 |     4 | True      |
| 719b3191-3163-478a-b14c-cb667e0e19b2 | g2l-t-c8m16          |  16384 |    0 |         0 |     8 | True      |
| 784f1ae8-0bc8-4d06-a06b-2afaa9580e0a | g2l-t-c3m2           |   2048 |    0 |         0 |     3 | True      |
| 95afc016-cf7f-4cc1-8622-8790bdc95bb7 | g2l-t-c24m64         |  65536 |    0 |         0 |    24 | True      |
| b5d0e377-3440-41c2-a967-15bbde929325 | g2l-t-c20m128g1-l4   | 131072 |    0 |         0 |    20 | True      |
| b9eb8f9f-6cbf-4c8b-89cd-b0cfb484f13a | g2l-t-c12m32         |  32768 |    0 |         0 |    12 | True      |
| c8ce932a-a7de-4fbb-ab64-903826082be3 | g2l-t-c6m8           |   8192 |    0 |         0 |     6 | True      |
| edb9d02a-a2a6-4b5a-b53b-679259ad73d7 | g2l-t-c88m912g4-h100 | 933888 |    0 |         0 |    88 | True      |
| f2a77529-1815-43a2-bc14-1f3f6b09079c | g2l-t-c2m1           |   1024 |    0 |         0 |     2 | True      |
```


## トラブルシューティング

以下の記事に、TerraformでConoHa APIを利用する際に発生する可能性のあるエラーとその対処法をまとめています。

[ConoHaとTerraformで始めるインフラ自動化 後編 トラブルシューティングセクション](https://developers.gmo.jp/technology/49439#troubleshooting)


## 貢献

バグ報告や機能改善の提案は、[Issues](https://github.com/skworks33/terraform-conoha-v3-api/issues)からお願いします。プルリクエストも歓迎します。

## ライセンス

このプロジェクトはMITライセンスの下で提供されています。詳細については、[LICENSE](LICENSE)ファイルを参照してください。

## 参考資料

- [Terraform公式ドキュメント](https://www.terraform.io/docs/index.html)
- [ConoHa VPS Ver.3.0 APIドキュメント](https://doc.conoha.jp/api-vps3/)
