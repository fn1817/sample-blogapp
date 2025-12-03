// node_modulesフォルダにあるjQueryを読み込み、jQueryが使えるようになる
// import $ from "jquery";
import "jquery";
import axios from "modules/axios";

// 通常のハートの状態でいねがクリックされたら、赤いハートにする
const listenInactiveHeartEvent = (articleId) => {
  $(".inactive-heart").on("click", () => {
    axios
      .post(`/api/articles/${articleId}/like`)
      // 処理成功時
      .then((response) => {
        if (response.data.status === "ok") {
          // 赤いハートにする
          $(".active-heart").removeClass("hidden");
          $(".inactive-heart").addClass("hidden");
        }
      })
      // 処理失敗時（e = error）
      .catch((e) => {
        window.alert("Error");
        console.log(e);
      });
  });
};

// 赤いハートの状態でいねがクリックされたら、通常のハートにする
const listenActiveHeartEvent = (articleId) => {
  $(".active-heart").on("click", () => {
    axios
      .delete(`/api/articles/${articleId}/like`)
      // 処理成功時
      .then((response) => {
        if (response.data.status === "ok") {
          // 通常のハートにする
          $(".active-heart").addClass("hidden");
          $(".inactive-heart").removeClass("hidden");
        }
      })
      // 処理失敗時（e = error）
      .catch((e) => {
        window.alert("Error");
        console.log(e);
      });
  });
};

// どのメソッドを外部から読み込ませるか指定する
export {
  // ハッシュ形式で記述する（外部からimportするときに使う名前: このファイル内で定義している変数（関数）名）
  // listenInactiveHeartEvent: listenInactiveHeartEvent,
  // listenActiveHeartEvent: listenActiveHeartEvent
  // 外部からimportするときに使う名前とこのファイル内で定義している変数（関数）名が一緒の場合は省略できる（javaScriptのバージョンによってはできないこともあるので注意）
  listenInactiveHeartEvent,
  listenActiveHeartEvent,
};
