# 02. Roadmap

> PRD §5 의 Phase 1 / Phase 2 / Phase 3 를 일정 단위로 풀어낸 문서. 일정은 한 명 기준 순수 작업 일수.

## Phase 0 — 스캐폴드 (1~2일) ✅

- [x] PRD.md 작성 (12장 구성, Decision Log 포함)
- [x] docs/01~07 작성
- [x] 루트 `CLAUDE.md` §5 표 + `docs/01-common-infrastructure.md` §9 표 + 메모리 인덱스 갱신 (포트 8002, 서브도메인 mermaid.aidalabs.kr 선점)
- [x] Astro 골격 (`site/`) — `consts.ts`, `BaseLayout`, 헤더/푸터, 5종 페이지 (index + 4 법적), 404, robots.txt, sitemap
- [x] deploy/ — nginx conf, bootstrap.sh (비파괴 모드)
- [x] `.github/workflows/deploy-site.yml`

## Phase 1 — MVP 도구 (3~5일)

- [ ] mermaid.js 의존성 추가 (npm `mermaid`)
- [ ] `/` (홈) — Hero + 11종 다이어그램 카드 + 차별화 4 카드 + 가이드 3편 추천
- [ ] `/preview/` — 라이브 프리뷰 도구 (PRD §5-1 F01~F13 전부)
- [ ] LZ-string 압축 + base64url → `#code=` Share URL
- [ ] securityLevel `'strict'` 하드코딩
- [ ] 키보드 단축키 (Ctrl+Enter / Ctrl+S / Ctrl+Shift+S / Ctrl+K / Ctrl+.)
- [ ] 빈 상태 UX (placeholder + 예시 갤러리 진입)
- [ ] 에러 표시 (mermaid parse error → 사람이 읽을 수 있는 메시지)

## Phase 2 — 다이어그램 타입 페이지 (3~5일)

총 11개 mermaid 다이어그램 타입 중 검색 수요·러닝커브 균형으로 우선 8개 랜딩 페이지를 만든다.

- [ ] `/flowchart/` — 가장 많이 쓰이는 타입. 기본 노드/엣지/방향/스타일 cheat sheet + 5+ 시나리오 예시
- [ ] `/sequence/` — API 문서·인시던트 회고
- [ ] `/class/` — 객체지향 설계
- [ ] `/state/` — 상태 머신·UI 플로우
- [ ] `/er/` — DB 스키마
- [ ] `/gantt/` — 프로젝트 일정
- [ ] `/pie/` — 단순 비율 차트
- [ ] `/mindmap/` — 노트·아이디어 정리

각 페이지 공통 구조:
1. Hero (1문단 What + Why + 미니 cheat sheet)
2. "Try it now" CTA → `/preview/` 로 prefilled link (`#code=...`)
3. 5+ 실용 시나리오 (작은 SVG + 설명)
4. 흔한 실수 3개
5. 관련 가이드 / 용어 내부 링크 5+

## Phase 3 — 가이드·용어·FAQ (5~7일, 승인 전 필수)

- [ ] **가이드 10+편** (1500~2500자), `/guides/`
  - [ ] "Why text-based diagrams" (vs draw.io)
  - [ ] "Mermaid in GitHub README"
  - [ ] "Mermaid in Notion / Obsidian / GitBook"
  - [ ] "Embedding Mermaid in Hugo / Jekyll / VuePress"
  - [ ] "Flowchart vs Sequence: which one when"
  - [ ] "Mermaid theme customization"
  - [ ] "Common parse errors and fixes"
  - [ ] "Mermaid syntax style guide"
  - [ ] "From whiteboard photo to Mermaid (workflow)"
  - [ ] "Sharing Mermaid diagrams in code review"
- [ ] **용어 10+** (200~400자), `/glossary/`
  - flowchart, sequence diagram, class diagram, state diagram, ER diagram, gantt chart, pie chart, mindmap, theme, securityLevel, render, SVG, viewport, sanitization
- [ ] **FAQ 10+**, `/faq/`

## Phase 4 — 배포 + 색인 (1~2주 + 대기)

- [ ] DNS A 레코드 추가 (`mermaid.aidalabs.kr` → OCI Public IP) — 사용자 액션
- [ ] `deploy/` 를 OCI VM 에 업로드 후 `bootstrap.sh` 실행 — 사용자 액션
- [ ] Let's Encrypt 발급 (`certbot --nginx -d mermaid.aidalabs.kr`)
- [ ] GitHub Secrets 등록 → workflow 수동 실행 → 200 확인
- [ ] Search Console 속성 등록 + sitemap 제출
- [ ] GSC verification token → `consts.ts` `GSC_VERIFICATION` → 재배포

## Phase 5 — AdSense 승인 (2~6주 심사 + 후속)

- [ ] 색인 페이지 ≥ 10 확인
- [ ] `docs/05-adsense-checklist.md` 100% 통과
- [ ] AdSense 신청
- [ ] 심사 중 사이트 구조·URL 변경 금지 (콘텐츠 추가는 OK)
- [ ] 승인 후 `ads.txt` → `site/public/ads.txt` 추가
- [ ] 광고 슬롯 배치 (PRD §7-4 원칙: 도구 first fold 광고 금지)

## Phase 6+ — 백엔드 도입 (선택, 트래픽 확보 후)

- [ ] FastAPI + Uvicorn @ port `8002` (예약됨)
- [ ] `mermaid-api.aidalabs.kr` 서브도메인 + Let's Encrypt
- [ ] 서버 렌더 API (`POST /api/v1/render`) — mermaid-cli + headless chromium
- [ ] 단축 URL (`mermaid.aidalabs.kr/s/<id>`) — fragment 길이 한계 우회
- [ ] rate limit (IP/key)

## 일정 관찰 (목표가 아닌 관측)

| Phase | 누적 일수 (낙관) | 누적 일수 (현실) |
|---|---|---|
| 0 | 1 | 2 |
| 1 | 4 | 7 |
| 2 | 7 | 12 |
| 3 | 12 | 19 |
| 4 | 14 | 23 |
| 5 (심사 대기 포함) | 14 + 4주 | 23 + 6주 |

승인까지 보수적으로 **2.5~3개월** 으로 가정.
