# run.py

# my_module을 실행. 현재 실행모듈(run.py)와 같은 디렉토리(패키지)에서 찾는다.
# import my_module  

# my_package 모듈안에 있는 todo_module을 실행. (사용)
# import my_package.todo_module as todo  # as 별칭 -> my_package.todo_module 대신 todo를 사용.

from my_package import todo_module # as todo

from my_module import *

# def plus():
#     print("run의 plus")



# print(plus(100, 200))




# todo_module.plus(100)

# r = my_module.plus(100, 200)  # module.함수()
# print(r)
# r = my_module.minus(230, 100)
# print(r)

# # my_package.todo_module.print_gugudan(5)
# todo.print_gugudan(8)


# plus()
# python  run.py
