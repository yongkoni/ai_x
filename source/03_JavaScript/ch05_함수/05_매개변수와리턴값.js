console.log(pow(5, 3));
// 선언된 매개변수보다 많은 매개변수를 호출하는 경우 뒷부분은 무시
console.log(pow(5, 2, 12));
// 선언된 매개변수보다 적은 매개변수를 호출하는 경우 전달되지 않은 파라미터는 undefined
console.log(pow(5));
console.log(pow());

function pow(x, y){
    // x의 y승을  return
    console.log('함수내의 x = ', x, ' / y = ', y);
    let result = 1;
    for (let cnt = 1; cnt <= y; cnt++){
        result *= x; //result = result * x;
    }
    return result; // return이 없으면 return값에 undefined
}