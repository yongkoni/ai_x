# example.py = main()

from customer import load_customers
from functions import fn1_insert_customer_info, fn2_print_customers, fn3_delete_customer, fn4_search_customer, fn5_save_customer_csv, fn9_save_customer_txt


def main() :
    global customer_list
    customer_list = load_customers()  # ch09_customers.txt의 내용을 load
    while True :
        print('1:입력', '2:전체출력', '3:삭제', '4:이름찾기', '5:내보내기(CSV)', '9:종료', sep = ' | ', end = '')
        fn = input('메뉴선택 : ')
        if fn == '1' :  # fn1_ 호출한 결과를 customer에 받아 customer_list에 append
            customer = fn1_insert_customer_info()
            customer_list.append(customer)
        elif fn == '2' :  # fn2_ 호출
            fn2_print_customers(customer_list)
        elif fn == '3' :  # fn3_ 호출
            fn3_delete_customer(customer_list)
        elif fn == '4' :  # fn4_ 호출
            fn4_search_customer(customer_list)
        elif fn == '5' :  # fn5_ 호출
            fn5_save_customer_csv(customer_list)
        elif fn == '9' :  # fn9_ 호출
            fn9_save_customer_txt(customer_list)
            break
        else :
            print('메뉴선택을 정확하게 해주십시오')

if __name__ == '__main__' :
    main()