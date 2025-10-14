import streamlit as st
import pandas as pd
import numpy as np

st.set_page_config(page_title="Input Widget", layout="wide")
# streamlit  run  03_input_widget.py
################################################################
# 위젯(Widget): 버튼, 텍스트박스 등과 같이 사용자가 직접 상호작용하는 개별 GUI 구성요소.
# 컨테이너(Container): 여러 위젯을 포함하고 배치(layout)/정렬을 관리하는 GUI 구성요소.
#
#  값 입력 받기
################################################################
st.subheader("text 입력")
name_value = st.text_input("이름")
if name_value:
    st.write("이름: " + name_value)

st.subheader("여러줄 텍스트 입력")
info = st.text_area("정보", height=200)  #height: pixcel
if info:
    st.write(info.replace("\n", "<br>"), unsafe_allow_html=True)

st.subheader("Number Input")
num = st.number_input("값")
st.write("입력값:", num)

st.subheader("slide")
v = st.slider("X", min_value=-10, max_value=10, value=0)  # default: min_value=0, max_value=100, step=1, value: 시작 값
st.write("선택된 값: ", str(v))

st.subheader("날짜")
col1, col2 = st.columns(2)
v = col1.date_input("날짜")
col1.write(v)

v = col2.time_input("시간", step=60)  # step단위: 초
col2.write(v)

########################################
# 다양한 입력 버튼
########################################
st.divider()
st.subheader("일반 버튼")

##### 일반버튼: click 하면 True 반환
bool_value = st.button("인사말 출력")
print(bool_value)
if not bool_value:
    st.write("아직 클릭 안됨")
else:
    if name_value:
        st.write(f"{name_value}님 안녕하세요.")
    else:
        st.write("이름을 입력하세요.")

##### 링크 버튼. 버튼 클릭시 지정한 url로 이동한다.
st.subheader("링크버튼")
col1, col2, col3 = st.columns(3)
col1.link_button("Streamlit", "https://streamlit.io/")
col2.link_button("구글", "https://google.co.kr")
col3.link_button("Naver", "https://www.naver.com")


st.subheader("Select Box")
####### selectbox
option = st.selectbox(
    "지역을 선택하세요",
    ("서울", "인천", "부산", "광주"),
    index=None
)
st.write("**선택한 지역**:", option)

###### checkbox
st.subheader("Checkbox")

@st.cache_data
def get_data():
    # csv 파일을 읽어서 DataFrame(판다스의 표)로 생성(read_csv). 
    # 앞 10개 행만 조회 (head(10))
    df = pd.read_csv("data/boston_housing.csv").head(10)
    return df

bool_value = st.checkbox("**표를 보시겠습니까?**") # check: True, check 해제: False 반환
if bool_value:
    df = get_data()
    st.dataframe(df)
else:
    st.write("데이터가 없습니다.")


####### file_uploader()
st.subheader("파일 업로드 버튼")
# col4, col5 = st.columns(2)

uploaded_file = st.file_uploader(
    "이미지 업로드", 
    type=["png", "jpg"],           # 업로드 파일 확장자 제한. (생략하면 모든 확장자의 파일을 다 업로드 할 수있다.)
    accept_multiple_files=False    # True 설정 시 한번에 여러개 파일 업로드 가능.
)

########## 업로드 된 파일 저장 ##########
import os
import io
from PIL import Image

save_dir = "save_files"
os.makedirs(save_dir, exist_ok=True)
if uploaded_file is not None:
    # UploadFile.getvalue(): 업로드된 파일을 bytes로 반환
    # UploadFile.name      : 업로드된 파일이름 반환.
    bytes_data = uploaded_file.getvalue()
    
    # 저장할 경로
    save_filepath = os.path.join(save_dir, uploaded_file.name)
    # 업로드된 파일 저장.
    with open(save_filepath, "wb") as fw:
        fw.write(bytes_data)
    st.write(uploaded_file.name)
    st.write("타입:" + str(type(bytes_data)))
    
    #################### 업로드 이미지 화면에 출력 (bytes to PIL.Image)
    data_io = io.BytesIO(bytes_data)
    img = Image.open(data_io)
    st.write(img)

####### 다중 파일 업로드.
upload_file_list = st.file_uploader(  
    "다중파일 업로드",
    accept_multiple_files=True,
)
st.write("업로드 파일개수:", len(upload_file_list))
for uploaded_file in upload_file_list:
    bytes_data = uploaded_file.getvalue()
    with open(os.path.join(save_dir, uploaded_file.name), "wb") as fw:
        fw.write(bytes_data)

   
##### 다운로드 버튼
st.subheader("다운로드 버튼")
down_filepath = "data/boston_housing.csv"
with open(down_filepath, "rb") as fr:
    st.download_button(
        "파일 다운로드",                             # Button Label
        data=fr.read(),                             # 다운로드 시킬 파일 content. (str or bytes)
        file_name=os.path.basename(down_filepath),  # 다운 로드 될때 파일명 (경로일 경우)
        # os.path.basename("경로") 경로에서 마지막 경로(basename)을 반환.
    ) 


