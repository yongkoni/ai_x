/*class Person:
    def __init__(self, name, age):
      self.name = name
      self.age  = age
    def method(self):
      무시기 무시기 명령
    def __str__(self):
      return 문자
  person = Person('홍길동', 20)
  print(person.name, person.age);
*/
const person = {'name':'홍길동', 'age':20};
console.log('person :',person['name'], person['age']);
console.log('person :', person.name, person.age);
const arr    = ['홍길동', 20]; // {0:'홍길동', 1:20}
console.log('arr :',arr[0], arr[1]);