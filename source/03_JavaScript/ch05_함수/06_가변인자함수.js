// 가변인자함수 : 매개변수의 개수에 따라 변하는 함수로 화살표에서는 불가
// 내장함수 Array()
var arr1 = [1, 2, '삼'];
var arr2 = Array(1, 2, '삼');
var arr3 = [, ,]; // 방의 개수가 2인 배열
var arr4 = Array(2);
var arr5 = []; // 방의 개수가 0인 배열
var arr6 = Array();
console.log(arr1);
console.log(arr2);
console.log(arr3);
console.log(arr4);
console.log(arr5);
console.log(arr6);