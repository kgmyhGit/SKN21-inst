# my_package/todo_module.py


# 1
def summation(start:int=0, end:int=10) -> int:
    """
    Start 정수 ~ End 정수까지의 합을 계산하는 함수

    Args:
        start(int):  계산 범위의 시작 정수. default: 0
        end(int): 계산 범위의 끝 정수. default: 10

    Returns
        int: start ~ end까지의 모든 정수들의 합계
    """
    result = 0
    for v in range(start, end+1):
        result += v
    return result

# 3 구구단
def print_gugudan(dan:int):
    print(f"{dan}단을 출력합니다.")
    for v in range(1, 10):
        print(f"{dan} x {v} = {dan * v}")

# 4. BMI 지수
def check_weight(tall:float, weight:float) -> tuple[float, str]:
    """
    BMI 지수를 계산해서 체중상태를 알려주는 함수

    Args:
        tall (float): 키. 단위: 미터
        weight (float) : 몸무게. 단위: kg

    Returns
        tuple: BMI 지수와 체중상태를 튜플로 묶어서 반환.
    """
    bmi = weight / tall**2
    result = None
    if bmi < 18.5:
        result = "저체중"
    elif bmi < 25:
        result = "정상체중"
    elif bmi < 30:
        result = "과체중"
    else:
        result = "비만"
    return bmi, result

def plus(num):
    print(num + 1000)
    print("todo의 plus")


print("="*20)
print(__name__)
print("="*20)
if __name__ == "__main__":
    print(check_weight(2, 70))
    print(check_weight(1.7, 100))
    print(summation(1, 10))
    print(summation(end=20))
    print(summation(5))
    print_gugudan(3)
    print("="*30)
    print_gugudan(7)

