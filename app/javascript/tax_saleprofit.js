//「なぜ必要か？」new.html.erbの販売手数料や販売利益の計算で入力された価格によって、販売手数料や販売利益の表示が変わる機能実装の為

window.addEventListener("load", tax_saleprofit);//「なぜ必要か？」ページが読み込まれた後、JS実行
function tax_saleprofit() {
  const itemPrice = document.getElementById("item-price"); //「なぜ必要か？」IDがitem-priceのドキュメント要素を取得
    itemPrice.addEventListener('change', () => {//「学習メモ」changeのオプションにより、new.html.erbの価額フォームの状態が変更されたときの情報が取得される      
      const price = itemPrice.value;
      const addTaxPrice = document.getElementById("add-tax-price");
      const profit = document.getElementById("profit");
      const taxPrice = Math.floor(price * 0.1); //「学習メモ」Math.floor(); 小数点以下を切り捨てて表示
      const saleProfit = Math.floor(price - taxPrice);      
      addTaxPrice.innerHTML = taxPrice; //「学習メモ」.innerHTML : html要素の中身を変更
      profit.innerHTML = saleProfit;  
  });
}
