// var : 변수선언시 사용. 변수 재선언 사능. 전역변수로 주로 사용
// let : 변수선언시 사용. 변수 재선언 불가. 블록{} 레벨 범위에서만 적용
// const : 상수 선언시 사용.
var v = 10;
var v = 20;
v++; // v를 1증가
++v;
v--; // v를 1감소
--v;
console.log('v = ', v); // 터미널 열기 : ctrl + j, ctrl + ~
// print('v = ' + str(v))
console.log('v = ' + v);
let l;
l = 10;
// let l = 10;
const C = [10, 20, 30]; // 배열
C[0] = 99;
console.log(C);
