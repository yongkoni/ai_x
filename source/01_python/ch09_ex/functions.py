# functions.py = fn1_()부터 fn_9()

from customer import Customer

def fn1_insert_customer_info() :
    '''
    사용자로부터 name, phone, email, age, grade, etc를 입력받아 Customer형 객체 변환
    '''
    import re
    
    name = input('이름을 입력하시오 : ')
    name_pattern = r'[가-힣]{2,}'
    while not re.search(name_pattern, name) :
        print('이름을 제대로 입력하시오')
        name = input('이름을 입력하시오 : ')
        
    phone = input('전화번호를 입력하시오 : ')
    phone_pattern = r'\d{2,3}[\-) .]?[0-9]{3,4}.?\d{4}'
    while not re.search(phone_pattern, phone) :
        print('전화번호를 제대로 입력하시오')
        phone = input('전화번호를 입력하시오 : ')
    
    
    email = input('이메일을 입력하시오 : ')
    email_pattern = r'\w+@[a-zA-Z0-9가-힣]+\.\w+[\.\w]*'
    while not re.search(email_pattern, email) :
        print('이메일을 제대로 입력하시오')
        email = input('이메일을 입력하시오 : ')
        
    while True :
        try :
            age = int(input('나이를 입력하시오 : '))
            if (age < 0) or (age >= 130) :
                raise Exception('나이 범위 이상')
            break
        except :
            print('올바른 나이를 입력하시오')
    try :
        grade = int(input('등급을 입력하시오 : '))
        if grade < 1 :
            grade = 0
        if grade > 5 :
            grade = 5
    except :
        print('유효하지 않은 등급을 입력시 0등급으로 초기화')
    etc = input('특이사항을 입력하시오 : ')
    
    return Customer(name, phone, email, age, grade, etc)

def fn2_print_customers(customer_list) :
    'customer_list를 출력(pdf 40page 스타일)'
    print('=' * 80)
    print('{:^80}'.format('고객 정보'))
    print('-' * 80)
    print('{:>5}\t{:^5}\t{:^20}\t{:^20}\t{:^3}\t{}'.format('GRADE',
                                                       '이름',
                                                       '전화',
                                                       '메일',
                                                       '나이',
                                                       '기타사항'))
    print('-' * 80)
    
    for customer in customer_list :
        print(customer)

def fn3_delete_customer(customer_list) :
    '''
    삭제하고자 하는 고객이름을 input으로 받아
    매개변수로 들어온 customer_list에서 삭제하고 '삭제에 성공하였습니다/삭제에 실패하였습니다'를 메세지로 출력
    '''
    
    del_name = input('삭제할 고객의 이름을 입력하시오 : ')
    del_idx = []  # 삭제할 인덱스를 저장하는 용도
    for idx, customer in enumerate(customer_list) :
        if customer.name == del_name :
            del_idx.append(idx)
    if del_idx :
        for idx in del_idx[::-1] :
            print(customer_list[idx], '지우겠습니까?', end = '')
            answer = input(' (Y / N) : ')
            if answer.upper() == 'Y' :  # (answer == 'Y') | (answer == 'y')
                print('요청하신 {}({})님 삭제하였습니다'.format(del_name, customer_list[idx].phone))
                del customer_list[idx]                
    else :
        return '{} 고객님 데이터가 존재하지 않습니다'.format(del_name)

def fn4_search_customer(customer_list) :
    '''
    찾고자 하는 이름을 input으로 받아 customer_list에서 검색하여
    동명이인이 있으면 search_list에 append한 후 search_list를 출력
    동명이인이 없으면 없다고 출력
    '''
    
    search_name = input('찾는 고객님의 이름을 입력하시오 : ')
    search_idx = []
    for idx, customer in enumerate(customer_list) :
        if customer.name == search_name :
            search_idx.append(idx)
    if search_idx :
        print('=' * 80)
        print('{:^80}'.format('고객 정보'))
        print('-' * 80)
        print('{:>5}\t{:^5}\t{:^20}\t{:^20}\t{:^3}\t{}'.format('GRADE',
                                                           '이름',
                                                           '전화',
                                                           '메일',
                                                           '나이',
                                                           '기타사항'))
        for idx in search_idx:
            print(customer_list[idx])
    else:
        print("{} 고객님 데이터는 존재하지 않습니다".format(search_name))

def fn5_save_customer_csv(customer_list) :
    '매개변수로 받은 customer_list를 딕셔너리리스트로 변환해서 csv 출력'
    import csv
    
    if customer_list :
        customer_dic_list = []
        for customer in customer_list :
            customer_dic_list.append(customer.as_dic())
        fieldnames = list(customer_dic_list[0].keys())
        filename = input('저장할 csv 파일명을 입력하시오 : ')
        with open ('data/{}.csv'.format(filename), 'w', encoding = 'utf-8', newline = '') as f :
            dict_writer = csv.DictWriter(f, fieldnames = fieldnames)
            dict_writer.writeheader  # 헤더
            dict_writer.writerows(customer_dic_list)
            print('data/{}.csv 내보내기 완료하였습니다'.format(filename))
    else : 
        print('입력된 회원 데이터가 없어 csv 내보내기를 취소합니다')

def fn9_save_customer_txt(customer_list) :
    '''
    customer_list를 to_list_style()을 이용해서 ['홍길동, 010-9999-9999, a@a.com, 30, 3, 까칠해', ~]
    ch09_customers.txt로 백업
    '''
    
    customer_txt_list = []
    for customer in customer_list :
        customer_txt_list.append(customer.to_list_style() + '\n')
    with open('data/ch09_customers.txt', 'w', encoding = 'utf-8') as f :
        f.writelines(customer_txt_list)