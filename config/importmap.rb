# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
# jqueryの追記
pin "jquery", to: 'https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js'
# axiosの追記
pin "axios", to: "https://cdn.skypack.dev/axios@1.13.2"
# handle_heart.jsの追記（pin モジュール名, to: ファイルパス）
# importmapはapp/javascriptをルートとしてパスを解決するので、ファイルパスに「../」は書かなくてOK
pin "modules/handle_heart", to: "modules/handle_heart.js"
# axios.jsを追加
pin "modules/axios", to: "modules/axios.js"
# article.jsを追加
pin "packs/article", to: "packs/article.js"
