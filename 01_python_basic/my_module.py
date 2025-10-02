# my_module.py

# 변수
__version__ = 0.1

def plus(num1, num2):
    return num1 + num2

def minus(num1, num2):
    return num1 - num2

def multiply(num1, num2):
    return num1 * num2

def divide(num1, num2):
    return num1 / num2

# 실행구문
# 위에 정의한 함수들을 호출
result = plus(10, 20)
print(result)
result = minus(result, 50)
print(result)

# python  my_module.py (script 파일의 경로)
# control + j (터미널 실행)