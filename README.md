# Exchange-Eureka

가상 화폐 거래소 컨셉의 MSA 서비스 구현 토이 프로젝트

## Developer

- 👩‍💻 [HashCitrine](https://github.com/HashCitrine) (`webflux, oauth, MSA` 구현 및 개발 흐름 기획)
- 👩‍💻 [Soo-ss](https://github.com/Soo-ss) (`api, oauth, wallet` 구현)

## 사용 기술

- `Spring Boot` : WebFlux, Eureka
- `DB` : PostgreSQL, Redis
- `Message Queue `: Kafka

※ Kafka는 Docker container 이용.

## 개발한 서버 목록

- [exchange-api](https://github.com/HashCitrine/exchange-api) 
- [exchange-oauth](https://github.com/HashCitrine/exchange-oauth) 
- [exchange-eureka](https://github.com/HashCitrine/exchange-eureka) 
- [exchange-gateway](https://github.com/HashCitrine/exchange-gateway) 
- [exchange-webflux](https://github.com/HashCitrine/exchange-webflux) 
- [exchange-wallet](https://github.com/HashCitrine/exchange-wallet) 

😀 `exchange-api, exchange-oauth, exchange-wallet, exchange-webflux` 4개의 서버를 관리하기 위해, `exchange-eureka, exchange-gateway`를 통하여 MSA를 구현했습니다.

## MSA 서비스 관리

---

### 1. 현재 Eureka에 연동 설정된 서비스 목록  
- 8801 : [exchange-api](https://github.com/HashCitrine/exchange-api) 
- 8802 : [exchange-oauth](https://github.com/HashCitrine/exchange-oauth) 
---

### 2. 연동 설정
1. Eureka 서버 생성 (현재 설정된 Eureka 서버 포트 : 8761)
2. Gateway 서버 설정을 통해 Eureka 서버와 연동 (참조 : [exchange-gateway](https://github.com/HashCitrine/exchange-gateway))
3. Eureka 서버와 연동할 하위 서버에 Eureka 설정 추가 (참조 : [exchange-oauth application.yml 설정](https://github.com/HashCitrine/exchange-oauth/blob/master/src/main/resources/application.yml))
4. 각 서버를 실행하여 연동 상태 확인
---
