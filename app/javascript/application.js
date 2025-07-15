import "./controllers"
import "bootstrap"
// import "bootstrap-icons"  // この行を削除または修正

console.log("★ application.js loaded!!");

// ひらがな・カタカナをカタカナに変換（完全版）
function toKatakana(str) {
  return str.replace(/[\u3041-\u3096\u309d-\u309f]/g, function(match) {
    const code = match.charCodeAt(0);
    if (code >= 0x3041 && code <= 0x3096) {
      return String.fromCharCode(code + 0x60);
    } else if (code >= 0x309d && code <= 0x309f) {
      return String.fromCharCode(code + 0x60);
    }
    return match;
  });
}

// 入力値と候補をカタカナに変換して部分一致判定
function matchesInput(input, suggestion) {
  const inputKatakana = toKatakana(input).toLowerCase();
  const suggestionKatakana = toKatakana(suggestion).toLowerCase();
  
  console.log(`Debug: "${input}" -> "${inputKatakana}", "${suggestion}" -> "${suggestionKatakana}"`);
  
  return suggestionKatakana.includes(inputKatakana);
}

// オートコンプリート機能
document.addEventListener('DOMContentLoaded', function() {
  console.log('Enhanced autocomplete script loaded');
  
  // 候補データ
  const suggestions = {
    origin: [
      'エチオピア', 'ケニア', 'コロンビア', 'ブラジル', 'グアテマラ', 
      'コスタリカ', 'パナマ', 'ジャマイカ', 'インドネシア', 'ベトナム', 
      'インド', 'ペルー', 'ボリビア', 'エルサルバドル', 'ホンジュラス', 
      'ニカラグア', 'メキシコ', 'ハワイ', 'タンザニア', 'ルワンダ'
    ],
    bean_type: [
      'アラビカ', 'ロブスタ', 'リベリカ', 'ブルボン', 'ティピカ', 
      'カトゥーラ', 'カツアイ', 'ムンドノーボ', 'パカマラ', 'ゲイシャ', 
      'エチオピアンヒエラルム', 'ケニアSL28', 'ケニアSL34'
    ],
    process_method: [
      'ウォッシュド', 'ナチュラル', 'ハニー', 'アナエロビック', 
      'カーボニックマセレーション', 'パルプドナチュラル'
    ]
  };
  
  // フィールドを動的に取得してオートコンプリートを設定
  const originField = document.querySelector('input[name="coffee_record[origin]"]');
  const beanTypeField = document.querySelector('input[name="coffee_record[bean_type]"]');
  const processMethodField = document.querySelector('input[name="coffee_record[process_method]"]');
  
  if (originField) {
    setupAutocomplete(originField, suggestions.origin);
    console.log('Autocomplete setup for: origin');
  } else {
    console.log('Origin field not found');
  }
  
  if (beanTypeField) {
    setupAutocomplete(beanTypeField, suggestions.bean_type);
    console.log('Autocomplete setup for: bean_type');
  } else {
    console.log('Bean type field not found');
  }
  
  if (processMethodField) {
    setupAutocomplete(processMethodField, suggestions.process_method);
    console.log('Autocomplete setup for: process_method');
  } else {
    console.log('Process method field not found');
  }
});

// オートコンプリート設定関数
function setupAutocomplete(input, suggestions) {
  let currentFocus = -1;
  let suggestionList = null;
  
  // 候補リストのHTMLを作成
  function createSuggestionList() {
    const list = document.createElement('ul');
    list.className = 'autocomplete-suggestions';
    list.style.display = 'none';
    input.parentNode.appendChild(list);
    return list;
  }
  
  // 候補を表示
  function showSuggestions() {
    const value = input.value;
    suggestionList.innerHTML = '';
    
    if (value.length === 0) {
      suggestionList.style.display = 'none';
      return;
    }
    
    // 候補をフィルタリング
    const filteredSuggestions = suggestions.filter(suggestion => 
      matchesInput(value, suggestion)
    );
    
    console.log('Input:', value, 'Filtered suggestions:', filteredSuggestions);
    
    if (filteredSuggestions.length === 0) {
      suggestionList.style.display = 'none';
      return;
    }
    
    // 候補リストを作成
    filteredSuggestions.forEach((suggestion, index) => {
      const item = document.createElement('li');
      item.textContent = suggestion;
      item.className = 'suggestion-item';
      
      // クリックイベント
      item.addEventListener('click', function() {
        input.value = suggestion;
        suggestionList.style.display = 'none';
        input.focus();
      });
      
      // マウスオーバーイベント
      item.addEventListener('mouseenter', function() {
        currentFocus = index;
        updateActiveItem();
      });
      
      suggestionList.appendChild(item);
    });
    
    suggestionList.style.setProperty('display', 'block', 'important');
    suggestionList.style.background = 'yellow'; 
    currentFocus = -1;
  }
  
  // アクティブアイテムの更新
  function updateActiveItem() {
    const items = suggestionList.querySelectorAll('.suggestion-item');
    items.forEach((item, index) => {
      if (index === currentFocus) {
        item.classList.add('active');
      } else {
        item.classList.remove('active');
      }
    });
  }
  
  // 候補リストを初期化
  suggestionList = createSuggestionList();
  
  // 入力イベント
  input.addEventListener('input', showSuggestions);
  
  // キーボードイベント
  input.addEventListener('keydown', function(e) {
    const items = suggestionList.querySelectorAll('.suggestion-item');
    
    if (suggestionList.style.display === 'block') {
      if (e.key === 'ArrowDown') {
        e.preventDefault();
        currentFocus++;
        if (currentFocus >= items.length) currentFocus = 0;
        updateActiveItem();
      } else if (e.key === 'ArrowUp') {
        e.preventDefault();
        currentFocus--;
        if (currentFocus < 0) currentFocus = items.length - 1;
        updateActiveItem();
      } else if (e.key === 'Enter') {
        e.preventDefault();
        if (currentFocus > -1 && items[currentFocus]) {
          input.value = items[currentFocus].textContent;
          suggestionList.style.display = 'none';
        }
      } else if (e.key === 'Escape') {
        suggestionList.style.display = 'none';
        currentFocus = -1;
      }
    }
  });
  
  // フォーカスアウトで候補を非表示
  input.addEventListener('blur', function() {
    setTimeout(() => {
      suggestionList.style.display = 'none';
      currentFocus = -1;
    }, 150);
  });
}