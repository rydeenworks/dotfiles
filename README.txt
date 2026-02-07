dotfiles - AI-Native Terminal Environment
=========================================

Nushell + Starship + devbox によるクロスプラットフォーム(macOS / WSL2)ターミナル環境。


構成ファイル
-----------
.config/nushell/config.nu   Nushell メイン設定(エイリアス, プロジェクト切替)
.config/nushell/env.nu      Nushell 環境変数(Starship連携, devbox統合)
.config/starship.toml       Starship プロンプト設定
devbox.json                 devbox global パッケージ定義
install.sh                  セットアップスクリプト


セットアップ手順
---------------

1. devbox をインストール

    curl -fsSL https://get.jetify.com/devbox | bash

2. リポジトリを clone

    mkdir -p ~/ghq/github.com/rydeenworks
    cd ~/ghq/github.com/rydeenworks
    git clone https://github.com/rydeenworks/dotfiles.git

3. install.sh を実行

    ./dotfiles/install.sh

    実行内容:
    - devbox global でツール一括インストール
    - 各設定ファイルへの symlink 作成(既存ファイルは .bak にバックアップ)
    - Nushell をデフォルトシェルにするか確認

4. シェルを再起動

    exec nu


インストールされるツール (devbox global)
---------------------------------------
nushell      構造化データシェル
starship     プロンプト
ghq          リポジトリ管理
direnv       ディレクトリ単位の環境変数
ripgrep      高速grep
fd           高速find
bat          catの代替(シンタックスハイライト付き)
jq           JSONプロセッサ
fzf          ファジーファインダー
delta        diffビューア


ターミナルエミュレータについて
----------------------------
ターミナルは各OS毎に管理する。このリポジトリには含めない。

macOS   iTerm2
Windows Windows Terminal
