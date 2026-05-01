# 05. AdSense Checklist (mermaid_preview 로컬판)

> 상위 폴더 `docs/03-adsense-approval-playbook.md` 의 체크리스트를 본 프로젝트 변수로 치환하고 mermaid 특화 항목을 추가. 승인 신청 직전 모든 박스가 체크되어야 한다.

## 1. 인프라

- [ ] DNS A 레코드: `mermaid.aidalabs.kr` → `<OCI_IP>` (Reserved Public IP)
- [ ] HTTPS 정상 (Let's Encrypt 발급 + 자동 갱신 cron)
- [ ] HTTP → HTTPS 리다이렉트
- [ ] HSTS 헤더 (Nginx)
- [ ] `https://mermaid.aidalabs.kr/sitemap-index.xml` 200
- [ ] `https://mermaid.aidalabs.kr/robots.txt` 200, sitemap URL 명시
- [ ] 404 페이지가 noindex + 200 가 아니라 404 응답

## 2. 법적 페이지 4종

- [ ] `/about/` — 운영자 정체·연락처·사이트 목적 (1인 운영 명시)
- [ ] `/privacy/` — AdSense 쿠키 + 제3자 광고 + GDPR + CCPA + 한국 PIPA + mermaid 특화 (입력 텍스트가 fragment 에 들어가 서버 미전송) 모두 포함
- [ ] `/terms/` — 무보증, 책임 제한, 준거법
- [ ] `/contact/` — 작동하는 폼 (FormSubmit 첫 제출 확인 메일 클릭 완료) + mailto

## 3. 콘텐츠 분량

- [ ] 가이드 ≥ 10편, 각 1500자+
- [ ] 다이어그램 타입 페이지 ≥ 8개, 각 600자+
- [ ] 용어 ≥ 10개, 각 200자+
- [ ] FAQ ≥ 10개
- [ ] 총 실질 페이지 ≥ 30 (홈 + 도구 + 다이어그램 8 + 가이드 10 + 용어 10 + FAQ 1 + 법적 4 = 35+)

## 4. 페이지별 SEO

- [ ] 모든 페이지 고유 `<title>`
- [ ] 모든 페이지 고유 `<meta description>`
- [ ] 모든 페이지 canonical
- [ ] og:title / og:description / og:url
- [ ] twitter:card
- [ ] JSON-LD: 홈 = `WebSite` + `Organization`, 도구 = `SoftwareApplication`, 가이드 = `Article`, 다이어그램 타입 = `Article` + `HowTo` 가능 시, FAQ = `FAQPage`
- [ ] 헤더·푸터에서 모든 주요 페이지 접근 가능

## 5. Search Console

- [ ] 속성 등록 (URL prefix `https://mermaid.aidalabs.kr/`)
- [ ] meta-tag 또는 DNS TXT 검증 완료 (`consts.ts` `GSC_VERIFICATION` 입력 후 재배포)
- [ ] sitemap 제출
- [ ] **색인된 URL ≥ 10** (Coverage 리포트)
- [ ] Core Web Vitals = Good (모바일·데스크톱)
- [ ] mobile usability 이슈 0

## 6. mermaid 특화 보안·UX

- [ ] mermaid `securityLevel: 'strict'` 가 코드에 하드코딩됨 (검색 grep 으로 확인)
- [ ] 사용자 입력에서 `<script>` / `<iframe>` 이 결과에 그대로 출력되지 않음 (수동 테스트)
- [ ] 도구 페이지 first fold 안에 광고 0개 (수동 검토)
- [ ] 모바일에서 도구가 동작 (375×667 / 414×896 viewport 수동 테스트)
- [ ] 가이드 / 다이어그램 타입 페이지에서 자동광고가 본문 흐름 끊지 않음 (자동광고 활성화 후 1주 모니터)

## 7. 운영 기간

- [ ] 사이트 공개 후 ≥ 14일 (가능하면 ≥ 21일) 운영
- [ ] 최소 7일 이상 매일 사이트 접근 가능 (Uptime Robot 99% 이상)

## 8. AdSense 신청 직전 한 번 더

- [ ] 사이트의 모든 외부 링크 작동 확인 (자동 도구 또는 수동)
- [ ] 콘솔 에러 0개 (도구 페이지에서 빈 입력·잘못된 입력·매우 큰 입력 시나리오 모두)
- [ ] 모든 이미지에 alt 또는 aria-label
- [ ] AdSense 신청 시 **`mermaid.aidalabs.kr` 자체** 가 신청 대상. `mermaid-api.aidalabs.kr` 가 등장한 이후 (Phase 6+) 라도 광고 서브도메인은 분리 유지

## 9. 신청 후

- [ ] 심사 중 사이트 구조 변경 금지 (URL slug, 메뉴, 도메인)
- [ ] 신규 콘텐츠 추가는 OK
- [ ] 반려 시 사유 코드 별 대응 (`docs/03-adsense-approval-playbook.md` 참고) → 4주+ 보완 후 재신청

## 10. 승인 후

- [ ] `site/public/ads.txt` 추가 → 배포 → `https://mermaid.aidalabs.kr/ads.txt` 200 확인
- [ ] 광고 슬롯 위치 확정 (PRD §7-4: 도구 first fold 광고 금지 원칙 유지)
- [ ] 자동광고 vs 수동 슬롯 1주 단위 비교
- [ ] RPM 트래킹 시작 (수익성 낮은 페이지 식별)
