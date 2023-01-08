const pay = () => {
  //環境変数をもとに公開鍵を復号
  const payjp = Payjp(process.env.PAYJP_PUBLIC_KEY); 
  //elementsインスタンスを生成
  const elements = payjp.elements();
  //入力欄ごとにelementインスタンスを生成
  const numberElement = elements.create('cardNumber')
  const cvcElement = elements.create('cardCvc')
  const expiryElement = elements.create('cardExpiry')
  //入力欄をDOM上に表示
  numberElement.mount('#number')
  cvcElement.mount('#cvc') 
  expiryElement.mount('#exp-date')
  //フォームの要素を取得
  const form = document.getElementById("charge-form");
  //PAY.JPと通信が成功した場合のみトークンをフォームに埋め込む
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(expiryElement).then((response) => {
      if (response.error) {
      } 
      const token = response.id;
      const renderDom = document.getElementById("charge-form"); 
      const tokenObj = `<input value=${token} name='token' type="hidden"> `;
      renderDom.insertAdjacentHTML("beforeend", tokenObj);
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);

/* PAYJP v1終了に伴い、v2へ切り替えの為
const pay = () => {
  //「学習メモ」 PAY.JPテスト公開鍵
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  // 入力フォーム全体を、変数に定義
  const form = document.getElementById("charge-form");
  //「学習メモ」 クリックした時に実行
  form.addEventListener("submit", (e) => {
    // submitボタンクリックで起こる標準設定イベントを無効化
    e.preventDefault();
    // "charge-form"というidでフォーム情報取得、FormDataオブジェクト(フォームに入力された値を取得できるオブジェクト)として生成
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    // 生成したFormDataオブジェクトから、クレジットカード情報を取得、変数cardに代入するオブジェクト定義（name属性の値）
    const card = {
      number: formData.get("order_address[number]"),
      exp_month: formData.get("order_address[exp_month]"),
      exp_year: `20${formData.get("order_address[exp_year]")}`,
      cvc: formData.get("order_address[cvc]"),
    };

    // 第一引数は15行目で定義したカード情報。第二関数はアロー関数を用いてPAYJP側からのレスポンス・ステータスコードを受け取った後処理の定義
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        // response.idでトークンの値、取得
        const token = response.id;
        // HTMLのinput要素にトークンの値を埋め込み、フォームに追加
        const renderDom = document.getElementById("charge-form");
        // valueは実際に送られる値、nameはその値を示すプロパティ名（params[:name]のように取得できるようになる）を示す。トークンはユーザーに見せる必要なし＝type属性の値にhidden指定
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        // フォームの中に作成したinput要素を追加（内部の最後の子要素の後に挿入）
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // フォームに存在するクレジットカードの各情報を削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");

      // フォーム情報をサーバーサイドへ送信
      //「学習メモ」 上段部e.preventDefault();で通常のRoRにおけるフォーム送信処理がCxlされており、JavaScript側からフォーム送信処理を行う必要あり
      document.getElementById("charge-form").submit();
    });
  });
};

//「学習メモ」 payページを読み込んだ時、実行
window.addEventListener("load", pay);
*/