// axiosライブラリのデフォルトエクスポート（オブジェクト兼関数）をaxiosという名前で受け取っている
import axios from "axios";

// metaタグからCSRFトークンを取得
const token = document.querySelector('meta[name="csrf-token"]').content;
// axiosにセット
axios.defaults.headers.common["X-CSRF-Token"] = token;

export default axios;
