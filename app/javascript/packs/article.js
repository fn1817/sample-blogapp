// node_modulesフォルダにあるjQueryを読み込み、jQueryが使えるようになる
// import $ from "jquery";
import $ from "jquery";
import axios from "modules/axios";
// 以下を追記
import {
  listenInactiveHeartEvent,
  listenActiveHeartEvent,
  // "../modules/handle_heart"でもOK
} from "modules/handle_heart";

// アロー関数を変数に代入
const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    // もしhasLikedがtrue（既にいいねされている）の場合は、active-heartクラスのhiddenを外す（赤いハートを表示）
    $(".active-heart").removeClass("hidden");
  } else {
    // いいねされていない場合は、inactive-heartクラスのhiddenを外す（通常のハートを表示）
    $(".inactive-heart").removeClass("hidden");
  }
};

// フォームを表示するためのコメントを追加ボタンを押したら、押したボタンを消して、フォームと新たなコメントを追加ボタンを表示するメソッドを定義
const handleCommentForm = () => {
  $(".show-comment-form").on("click", () => {
    // フォームを表示するためのコメントを追加ボタンは非表示にする
    $(".show-comment-form").addClass("hidden");
    // フォームと新たなコメントを追加ボタンを表示する（クラスからhiddenを取り除く）
    $(".comment-text-area").removeClass("hidden");
  });
};

// .comments-containerに新たなコメントを追加するメソッドを定義
const appendNewComment = (comment) => {
  $(".comments-container").append(
    // append = そのタグの中にHTMLを挿入する
    `<div class="article_comment"><p>${comment.content}</p></div>`
  );
};

// turbo:loadにすると、リロードした時も画面遷移した時もイベントが発生
// APIにリクエストを投げて「いいね」されているかどうかチェックする
document.addEventListener("turbo:load", () => {
  // #article-showに書かれているdata属性をオブジェクトとして取得
  // 例：（HTML）data-article-id="14"→（javaScript）{ articleId: 14 }にjQueryが自動で変換し取得
  const dataset = $("#article-show").data();
  // 例：articleId = 14が代入される
  const articleId = dataset.articleId;
  // RailsとjavaScriptが両方動いている時は使える

  // 記事詳細ページが読み込まれたら、コメント一覧を表示
  axios
    .get(`/articles/${articleId}/comments`)
    // 処理成功時
    .then((response) => {
      // コメント一覧の取得
      const comments = response.data;
      // コメントを一つ一つ取り出す
      comments.forEach((comment) => {
        // メソッドの呼び出し
        appendNewComment(comment);
      });
    })
    .catch((error) => {
      window.alert("失敗");
    });

  // メソッドの呼び出し
  handleCommentForm();

  // コメントを追加するためのボタンを押したら、フォームの値を取得して、postリクエストを送信する
  $(".add-comment-button").on("click", () => {
    const content = $("#comment_content").val();
    // contentが無ければリクエストを送らずアラートを表示
    if (!content) {
      window.alert("コメントを入力してください");
    } else {
      // contentが入っていたらpostリクエストを送信
      axios
        .post(`/articles/${articleId}/comments`, {
          // comment_paramsメソッドに沿った形式で送信
          comment: { content: content },
        })
        // 処理成功時
        .then((res) => {
          const comment = res.data;
          // メソッドの呼び出し
          appendNewComment(comment);
          // コメントを追加できたら、コメント欄を空欄に戻す
          $("#comment_content").val("");
        });
    }
  });

  // リクエストがうまく行ったらレスポンスが返ってくる
  axios.get(`/articles/${articleId}/like`).then((response) => {
    // hasLikedの値（true/false）を取得
    const hasLiked = response.data.hasLiked;
    // 変数の呼び出し
    handleHeartDisplay(hasLiked);
  });

  // メソッドの呼び出し
  listenInactiveHeartEvent(articleId);

  // メソッドの呼び出し
  listenActiveHeartEvent(articleId);
});
