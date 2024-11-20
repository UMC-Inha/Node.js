# Swagger

Swagger는 개발한 Rest API를 편리하게 문서화 해주고, 이를 통해서 관리 및 제 3의 사용자가 편리하게 API를 호출해보고 테스트 할 수 있는 프로젝트입니다.

## 컨트롤러 생성

```java
@RestController
@RequestMapping("/api")
public class ApiController {

    @GetMapping("/hello")
    public String hello(){
        return "hello swagger";
    }
}
```

## API Controller 설명 넣는 방법

```java
@Api(tags = "API정보를 제공하는 Controller")
@RestController
@RequestMapping("/api")
public class ApiController {

    @GetMapping("/hello")
    public String hello(){
        return "hello, Swagger";
    }
}
```

# OpenAPI

OpenAPI는 공공기관이든 누군가가 제공하는 서비스가 아닌, API를 정의하는 표준 포멧이다. 정식명칭은 OpenAPI Specification이고 줄여서 OAS라고도 한다.

OAS(OpenAPI Specification)은 RESTful 웹 서비스를 약속된 규칙에 따라 API 스펙을 json과 yaml 형식으로 표현한다. 이를 통해 직접 소스코드를 보거나 추가 문서를 작성할 필요 없이 서비스를 이해할 수 있다.

위에 설명한 스웨거는 api들이 가지고있는 스펙/명세들을 관리할 수 있는 프로젝트이다.

→ openAPI 스펙을 맞춘 api-docs를 이용하여 html 페이지로 문서화해주는 프레임워크이다.

→ 스웨거는 OpenAPI의 옛 명칭이다.

# OpenAPI 버전 별 특징 및 주요 차이점

## OpenAPI 2.0 (Swagger)

- Swagger에서 OpenAPI로 이름 변경
- API 설계 및 문서화를 위한 JSON 기반의 명세 형식 지원
- HTTP 메서드 중심 (GET, POST, PUT, DELETE 등)
- 재사용을 위해 컴포넌트를 구조화할 수 있지만, 복잡한 모델 정의나 참조 처리에 한계가 있다.
- URL 매개변수 및 경로에서의 유효성 검증이 제한적이다.

## OpenAPI 3.0

- Components로 통합된 재사용 가능한 스키마, 응답, 파라미터 등을 정의
- 스키마 JSON뿐만 아니라 YAML 형식으로도 작성 가능
- 요청 및 응답 본문에서 여러 Media Type 지원
- 보안 강화
- Callback

## OpenAPI 3.1

- JSON Schema와 완전 호환
- HTTP Method 외의 프로토콜 지원 (WebSocket, gRPC 등)
- Discriminator 개선
- 보안 스키마 확장
- Markdown 지원 강화

# OpenAPI Component

OpenAPI의 맥락에서 **컴포넌트**는 API 정의의 재사용 가능한 부분입니다. 여기에는 스키마, 응답, 매개변수, 예제, 요청 본문, 헤더, 보안 스키마, 링크 및 콜백이 포함될 수 있습니다.

## 1. 스키마

스키마는 JSON 스키마를 사용하여 요청 및 응답 본문의 구조를 설명합니다. 스키마는 데이터 유형과 필수 및 선택 필드를 모두 정의할 수 있습니다.

## 2. 응답

응답은 API가 어떻게 동작할 것인지를 설명하는 사전 정의된 내용입니다. 각 응답은 상태 코드, 설명 및 스키마를 포함할 수 있습니다.

```yaml
components:
  responses:
    NotFound:
      description: Entity not found.
    IllegalInput:
      description: Illegal input for operation.
```

응답 구성 요소는 api가 작업에 응답하는 방식을 설명함

## 3. 매개변수

매개변수는 api 엔드포인트가 허용할 수 있는 입력 값을 정의한다.

경로 . 쿼리 .헤더 매개변수 또는 쿠키 매개변수가 될 수 있다.

## 4.예시

## 5.요청

## 6.헤더

## 7.SecuritySchemes

## 8.링크

## 9.콜백
