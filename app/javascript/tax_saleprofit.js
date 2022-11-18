//「なぜ必要か？」new.html.erbの販売手数料や販売利益の計算で入力された価格によって、販売手数料や販売利益の表示が変わる機能実装の為

window.addEventListener('load', () => { //「なぜ必要か？」ページが読み込まれた後、JS実行
  const itemPrice = document.getElementById("item-price");//「なぜ必要か？」IDがitem-priceのドキュメント要素を取得
  itemPrice.addEventListener("input", () => {//「学習メモ」inputのオプションにより、new.html.erbの価額フォームの状態が変更されたときの情報が取得される      
  const Price = itemPrice.value;
  const addTaxPrice = document.getElementById("add-tax-price");
  const Profit = document.getElementById("profit");
  // 入力金額をもとに販売手数料計算
  addTaxPrice.innerHTML = Math.floor(Price * 0.1);//「学習メモ」Math.floor(); 小数点以下を切り捨てて表示
  // 出品価格から販売手数料を引いた金額
  Profit.innerHTML = Price - addTaxPrice.innerHTML;//「学習メモ」.innerHTML : html要素の中身を変更
  })
});