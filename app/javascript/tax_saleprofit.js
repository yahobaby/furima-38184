//new.html.erbの販売手数料や販売利益の計算
//入力された価格によって、販売手数料や販売利益の表示が変わる
window.addEventListener("load", tax_saleprofit);//ページが読み込まれた後、JS実行
function tax_saleprofit() {
  const itemPrice = document.getElementById("item-price"); //IDがitem-priceのドキュメント要素を取得
    itemPrice.addEventListener('change', () => {//change	new.html.erbの価額フォームの状態が変更されたとき      
      const price = itemPrice.value;
      const addTaxPrice = document.getElementById("add-tax-price");
      const profit = document.getElementById("profit");
      const taxPrice = price * 0.1;
      const saleProfit = price - taxPrice;      
      addTaxPrice.innerHTML = taxPrice; //.innerHTML : html要素の中身を変更
      profit.innerHTML = saleProfit;  
  });
}
