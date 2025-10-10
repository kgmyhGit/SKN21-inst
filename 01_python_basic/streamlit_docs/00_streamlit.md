# [Streamlit](https://streamlit.io/)

- **Streamlit**은 데이터 과학자나 머신러닝 엔지니어가 **순수 Python 코드**만을 사용하여 **대화형(interactive) 웹 애플리케이션**을 빠르고 쉽게 구축하고 공유할 수 있게 해주는 **오픈 소스 프레임워크**이다.
- Documentation: https://docs.streamlit.io/
## Streamlit의 특징

  * **Python 중심 개발:** HTML, CSS, JavaScript와 같은 프런트엔드 웹 개발 지식 없이도 파이썬만으로 앱을 만들 수 있다.
  * **간편한 API:** 간단하고 선언적인 문법을 제공하여 적은 코드로도 시각화, 위젯, 레이아웃 등을 쉽게 구성할 수 있다.
  * **빠른 프로토타이핑:** 데이터 스크립트를 몇 분 만에 공유 가능한 웹 앱으로 변환할 수 있어 신속한 프로토타이핑에 이상적이다.
  * **자동 업데이트:** 코드를 저장하면 앱이 자동으로 업데이트되어 개발 과정이 매우 효율적이다.


## Streamlit 언제 사용하나


| 상황                              | Streamlit 사용 이유                                     |
| ------------------------------- | --------------------------------------------------- |
| **데이터 분석 결과를 웹으로 공유하고 싶을 때**    | `st.line_chart`, `st.map`, `st.metric` 등 고수준 API 제공 |
| **머신러닝 모델의 데모/시연용 앱을 빠르게 만들 때** | 모델 예측 함수를 직접 UI에 연결 가능                              |
| **대시보드·리포트를 자동화할 때**            | Pandas, Matplotlib, Plotly 등과 자연스럽게 통합              |
| **웹 프론트엔드 경험이 적은 경우**           | HTML/CSS/JS 불필요. Python 스크립트만으로 웹 완성                |
| **사내 공유용 툴 제작**                 | 로컬 실행 또는 Streamlit Cloud/내부 서버 배포 용이                |

- Streamlit은 Django나 Flask 같은 범용 웹 프레임워크가 아니다. 그래서 일반적인 웹서비스(로그인, 결제, 게시판)를 구현하기엔 제약이 많다. 또한 기본 구조가 단일 스레드(single-thread) 중심이라 동시접속자가 수십~수백 명을 넘으면 성능 저하 발생한다.

## `streamlit run` 명령어

Streamlit 으로 작성한 앱을 실행하는 가장 기본적인 명령어.

```bash
streamlit run <entrypoint file> [options]
```

### 1. 기본 실행 (Entrypoint File)

  * **`<entrypoint file>`**: 실행할 Streamlit 앱의 Python 스크립트 파일 경로(예: `app.py`).

    ```bash
    streamlit run my_app.py
    ```

### 2. 설정 옵션 (`--`를 이용한 설정)

Streamlit은 명령줄에서 `--` 다음에 설정 옵션을 전달하여 기본 구성을 재정의할 수 있다. 옵션은 일반적으로 `--<section>.<option>=<value>` 형식으로 지정된다.

Streamlit 실행 옵션 (Command Line Flags)

| 옵션                         | 형태                               | 설명                            |
| -------------------------- | -------------------------------- | --------------------------------- |
| `--server.port`            | `--server.port 9999`             | 실행 포트 지정 (기본값: 8501)       |
| `--server.address`         | `--server.address 0.0.0.0`       | 외부 접속 허용 (예: 클라우드/도커 환경) |
| `--server.headless`        | `--server.headless true`         | 브라우저 자동 실행 비활성화 (서버모드에 적합)   |
| `--server.fileWatcherType` | `--server.fileWatcherType none`  | 코드 변경 감지 비활성화 (성능 향상용)     |
| `--theme.base`             | `--theme.base dark`              | 기본 테마 설정 (light/dark)             |
| `--help`                   |                                  | 사용 가능한 모든 명령어 옵션 목록 출력     |


### 3. 기타 유용한 명령어

| 명령어 | 설명 |
| :--- | :--- |
| `streamlit hello` | Streamlit의 공식 데모 앱을 실행하여 설치를 확인하고 기능을 미리 볼 수 있다. |
| `streamlit config show` | 현재 Streamlit 설치에 적용된 모든 구성 옵션을 표시 |
| `streamlit version` | 설치된 Streamlit 버전 확인 |
| `streamlit cache clear` | 디스크에 저장된 모든 캐시 데이터를 제거|