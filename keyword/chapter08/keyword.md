- Swagger
    - RESTful API를 설계, 빌드, 문서화 및 사용하는 데 도움이 되는 Open API 사양을 중심으로 구축된 오픈 소스 도구
    - API 개발자가 아닌 제 3자가 편리하게 API를 호출해보고 테스트를 할 수 있음.
    - 잘못하면 코드와 로직을 비롯한 내부 정보가 빠져나갈 수도 있으니 외부에 노출되지 않는 환경에서 사용해야 한다.
    - 코드에 주석을 채워 넣어서 API 설명을 정의해줄 수 있다.
    
    ```jsx
    export const handleUserSignUp = async (req, res, next) => {
      /*
        #swagger.summary = '회원 가입 API';
        #swagger.requestBody = {
          required: true,
          content: {
            "application/json": {
              schema: {
                type: "object",
                properties: {
                  email: { type: "string" },
                  name: { type: "string" },
                  gender: { type: "string" },
                  birth: { type: "string", format: "date" },
                  address: { type: "string" },
                  detailAddress: { type: "string" },
                  phoneNumber: { type: "string" },
                  preferences: { type: "array", items: { type: "number" } }
                }
              }
            }
          }
        };
        #swagger.responses[200] = {
          description: "회원 가입 성공 응답",
          content: {
            "application/json": {
              schema: {
                type: "object",
                properties: {
                  resultType: { type: "string", example: "SUCCESS" },
                  error: { type: "object", nullable: true, example: null },
                  success: {
                    type: "object",
                    properties: {
                      email: { type: "string" },
                      name: { type: "string" },
                      preferCategory: { type: "array", items: { type: "string" } }
                    }
                  }
                }
              }
            }
          }
        };
        #swagger.responses[400] = {
          description: "회원 가입 실패 응답",
          content: {
            "application/json": {
              schema: {
                type: "object",
                properties: {
                  resultType: { type: "string", example: "FAIL" },
                  error: {
                    type: "object",
                    properties: {
                      errorCode: { type: "string", example: "U001" },
                      reason: { type: "string" },
                      data: { type: "object" }
                    }
                  },
                  success: { type: "object", nullable: true, example: null }
                }
              }
            }
          }
        };
      */
      res.success(...);
    };
    ```
    
    - 중복되는 schema는 한 곳에서 관리하고 주석에서 $ref를 통해 참조만 할 수 있게 할 수도 있음.
    
    ```jsx
    const doc = {
        ...
        components: {
            schemas: {
                someSchema: {
                    $name: 'John Doe',
                    $age: 29,
                    about: ''
                },
                ...
            }
        }
    };
    
    //$ref로 호출하기
    app.get('/path', (req, res) => {
        ...
        /*  #swagger.requestBody = {
                required: true,
                content: {
                    "application/json": {
                        schema: {
                            $ref: "#/components/schemas/someSchema"
                        }  
                    }
                }
            } 
        */
        ...
        /* #swagger.responses[200] = {
                description: "Some description...",
                content: {
                    "application/json": {
                        schema:{
                            $ref: "#/components/schemas/someSchema"
                        }
                    }           
                }
            }   
        */
       ...
    
    })
    ```
    
- OpenAPI
    - Open API - 개방된 API. 누구나 사용할 수 있도록 API의 endpoint가 공개되어 있는 API.
    - OpenAPI - OpenAPI Specification. RESTful API를 정의된 규칙에 맞게 API의 spec을 json이나 yaml로 표현하는 방식. 소스코드나 별도의 문서 없이 API의 서비스를 이해할 수 있다.
    - Swagger vs OpenAPI - 옛날에는 OpenAPI 2.0을 swagger 2.0이라고 했었음. 그러다 OpenAPI로 완전히 이름이 변경되었고, 지금 swagger는 OpenAPI를 쓰기 위한 도구라는 의미로 쓰임.
- OpenAPI 버전 별 특징 및 주요 차이점
    - Swagger를 OpenAPI에 기부하면서 OpenAPI 3.0 출시. 2.0에 비해서 구조가 단순해지고 재상용성이 증가될 수 있도록 개발됨.
    
    ![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/d32beb2d-cafa-4d99-b608-dd96a7f92d4d/e4da28c1-237b-4087-8b3d-f70c5317ad3a/image.png)
    
    - 2.0에서는 API Endpoint URL을 3가지(host, basePath, schemes)로 정의함. 3.0부터는 멀티 URL을 지원함.
    
    ```jsx
    "host": "petstore.swagger.io",
      "basePath": "/v1",
      "schemes": [
        "http"
      ]
    ```
    
    ```jsx
    "servers": [
        {
          "url": "https://{username}.gigantic-server.com:{port}/{basePath}",
          "description": "The production API server",
          "variables": {
            "username": {
              "default": "demo",
              "description": "this value is assigned by the service provider, in this example `gigantic-server.com`"
            },
            "port": {
              "enum": [
                "8443",
                "443"
              ],
              "default": "8443"
            },
            "basePath": {
              "default": "v2"
            }
          }
        }
      ]
    ```
    
    - Component 기능 - 2.0에서는 중복되는 것이 있어도 일일이 다 적어줘야 했다. 3.0 부터는 component 기능으로 참조할 수 있게 만들어놔서 중복성이 줄어들고 유지보수가 편해졌다.
- OpenAPI Component
    
    ```jsx
    const doc = {
        ...
        components: {
            schemas: {
                someSchema: {
                    $name: 'John Doe',
                    $age: 29,
                    about: ''
                },
                ...
            }
        }
    };
    
    //$ref로 호출하기
    app.get('/path', (req, res) => {
        ...
        /*  #swagger.requestBody = {
                required: true,
                content: {
                    "application/json": {
                        schema: {
                            $ref: "#/components/schemas/someSchema"
                        }  
                    }
                }
            } 
        */
        ...
        /* #swagger.responses[200] = {
                description: "Some description...",
                content: {
                    "application/json": {
                        schema:{
                            $ref: "#/components/schemas/someSchema"
                        }
                    }           
                }
            }   
        */
       ...
    
    })
    ```
    
    - Component를 통해 중복되는 scheme은 따로 저장해 놓아서 관리하고 $ref로 호출해서 사용할 수 있다. schemas, parameters, responses, examples, security schemes, links, request bodies, headers, callbacks를 포함한다.