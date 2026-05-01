# PRD — Mermaid Preview

> 본 문서는 Mermaid Preview 서비스의 제품 요구사항을 한 파일로 집약한 **원본 소스(source of truth)** 입니다. 개별 문서(`docs/01`~`07`) 는 이 PRD 를 세분화·실행 수준으로 풀어낸 파생 문서입니다. PRD 와 파생 문서 간 충돌 시 **PRD 가 우선**합니다.

- **문서 버전**: v0.1 (2026-05-01)
- **작성자**: 운영자 + Claude
- **상태**: 초안 — Phase 0 검토 중

---

## 1. Executive Summary

### 한줄 비전
> **"An English-first, privacy-respecting online Mermaid preview that turns text-based diagram syntax into clean SVG/PNG instantly — paired with short guides clear enough that a developer new to Mermaid can master each diagram type in one sitting."**

### 타깃 (한 문장)
전 세계 영어권 **개발자·기술문서 작성자·DevOps 엔지니어·교육자**, 그리고 README/Notion/Confluence 에 다이어그램을 끼워 넣어야 하는 **PM·아키텍트**.

### 성공의 정의
1. **Google AdSense 승인**을 첫 신청 후 ≤ 3개월 내 획득.
2. 승인 후 6개월 내 월간 순방문자(UV) **8,000+** 달성.
3. Core Web Vitals 모든 페이지 Good (LCP < 2.5s).
4. 월 광고 수익 첫 마일스톤 **USD 50+** 도달.
5. 색인 페이지 **30+** (도구 1 + 다이어그램 타입 8 + 가이드 10+ + 용어 10+ + 법적 4 + 홈).

---

## 2. Problem Statement

### 시장 현황
"mermaid live editor", "mermaid online", "online flowchart maker", "sequence diagram online" 키워드는 월 수십만 회 검색되며, GitHub README·기술 블로그·문서 도구(Notion/Obsidian/GitBook) 가 mermaid 를 1급 시민으로 채택한 이후 수요가 꾸준히 증가하고 있다.

| 경쟁사 | 관찰된 한계 |
|---|---|
| mermaid.live (공식) | 단일 페이지 SPA 로 SEO 깊이 약함, 가이드·예시 페이지 부재. UI 는 깔끔하지만 광고도 없어 수익 모델이 다른 차원 |
| mermaidchart.com | 풀 SaaS 유료 모델. 무료 플랜은 제한적, 익명 사용 어려움 |
| kroki.io | 다양한 다이어그램 엔진 지원하지만 mermaid 단일 사용성·UX 는 미흡, 영문 가이드 부족 |
| draw.io / diagrams.net | 일반 다이어그램 도구. mermaid 텍스트 신택스 워크플로우와는 결이 다름 |
| swimlanes.io / sequencediagram.org | 시퀀스 전용. mermaid 의 11종 다이어그램 다 못 다룸 |

### 본 프로젝트의 포지션
- **얇은 도구 + 광고** 가 아니라 **도구 + 각 다이어그램 타입 가이드 + 실수 사례 + 용어사전**을 함께 제공해 SEO 깊이 확보.
- **100% 클라이언트 렌더** 를 UI 에 명시 ("Your diagram never leaves your browser") → 사내 시스템 다이어그램·아키텍처 도면을 다루는 엔지니어에게 신뢰 획득.
- 각 다이어그램 타입(`/flowchart/`, `/sequence/`, `/class/` 등) 별 **전용 랜딩 페이지** 를 두어 롱테일 SEO 노출. mermaid.live 의 SPA 단일 URL 한계와 차별화.

### 왜 지금인가
- GitHub 가 README 에서 mermaid 코드 블록을 자동 렌더링하기 시작한 이후 (2022 후반) 카탈로그 수요가 안정적으로 누적. 지금은 "mermaid syntax" 같은 신규 학습 키워드 검색량이 꾸준히 우상향.
- AdSense 의 "value-added content" 심사 강화 추세상, 도구 + 가이드 결합 사이트가 단순 도구 사이트보다 승인률이 높음. 본 프로젝트의 차별화와 정렬됨.
- json-beautifier 에서 검증한 Astro SSG + 클라이언트 라이브러리 패턴을 **거의 그대로** 적용 가능 — 자산 재사용 4~5/5.

---

## 3. Target Users

| 우선순위 | 페르소나 | 주요 상황 | 니즈 |
|---|---|---|---|
| 1차 | 백엔드/풀스택 개발자 | README · 기술 블로그 · ADR 작성 시 다이어그램 추가 | mermaid syntax → 즉시 미리보기, copy SVG |
| 2차 | 기술 문서 작성자 (TW) | API 가이드·아키텍처 문서 | 다이어그램 타입별 best practice, PNG export 고해상도 |
| 3차 | DevOps / SRE | 인시던트 회고·시스템 다이어그램 | flowchart·state·sequence 빠른 작성, 공유 URL |
| 4차 | 교육자·강사 | 강의 슬라이드·블로그 글 | 학습용 가이드, 키워드 별 예시 갤러리 |
| 5차 | PM / 아키텍트 | 회의록·기획서에 다이어그램 끼워 넣기 | "어떤 다이어그램이 적절한지" 선택 가이드 |

**명시적 비타깃**: 풀 SaaS UML 도구 사용자(Lucid·Visio·draw.io 워크플로우), 비코드 다이어그램 사용자(드래그 앤 드롭).

---

## 4. User Stories

모든 스토리는 `As a <persona>, I want <capability>, so that <outcome>.` 형식.

### MVP (Phase 1)

1. 개발자로서, 붙여넣은 mermaid syntax 가 **타이핑 즉시(≤ 300ms 디바운스)** 미리보기로 렌더되기를 원한다 — 시행착오 사이클 단축.
2. 개발자로서, syntax 에 오류가 있으면 **어디서 파싱이 실패했는지** 메시지로 보고 싶다 — 디버깅.
3. 기술문서 작성자로서, 결과를 **SVG 또는 PNG 로 다운로드**하고 싶다 — Notion/문서에 첨부.
4. 개발자로서, 결과를 **클립보드 SVG/이미지로 복사**하고 싶다 — drag & drop 없이 paste.
5. 개발자로서, **다이어그램 코드를 URL 로 공유**하고 싶다 (입력 텍스트 압축 후 fragment 에 인코딩) — Slack/리뷰에 한 줄 공유.
6. 개발자로서, **테마(default / dark / forest / neutral)** 를 선택하고 싶다 — 다크모드 문서 통일.
7. 학습자로서, 11종 다이어그램의 **예시를 한 클릭으로 로드**하고 싶다 — 빠른 실험.
8. 프라이버시 민감 사용자로서, 내 다이어그램이 **서버로 전송되지 않는다**는 표시를 상단에서 보고 싶다.

### Phase 2

9. 개발자로서, **PNG 해상도(1×, 2×, 3×)** 를 선택하고 싶다 — 고해상도 슬라이드.
10. 개발자로서, **배경(투명 / 흰색 / 다크)** 을 선택하고 싶다 — 다양한 매체 호환.
11. 개발자로서, **줄 번호가 표시되는 코드 에디터** 를 쓰고 싶다 — 큰 다이어그램 디버깅.
12. 학습자로서, 각 다이어그램 타입 페이지에서 **interactive cheat sheet** 를 보고 싶다 — 이 곳에서 학습 완료.
13. 개발자로서, mermaid 외에도 **PlantUML** syntax 를 시험할 수 있으면 좋겠다 — 비교·전환.

### Phase 3 (백엔드 API)

14. CI/CD 운영자로서, **REST API** 로 mermaid → SVG/PNG 렌더를 자동화하고 싶다.
15. 사용자로서, **단축 URL (mermaid.aidalabs.kr/s/abc123)** 를 만들고 싶다 — fragment 인코딩 길이 한계 우회.
16. 사용자로서, **저장된 다이어그램 갤러리(개인 옵션)** 를 갖고 싶다 — 자주 쓰는 패턴.

---

## 5. Functional Requirements

### 5-1. MVP (Phase 1 — 클라이언트 only)

| # | 기능 | 설명 | 우선순위 |
|---|---|---|---|
| F01 | 라이브 프리뷰 | 입력 → 디바운스 300ms → mermaid.js 렌더 → 우측 SVG | Must |
| F02 | 오류 표시 | mermaid parse 실패 시 사람이 읽을 수 있는 메시지 (라인 추출 가능 시 라인 번호) | Must |
| F03 | 테마 선택 | default / dark / forest / neutral 4종 | Must |
| F04 | SVG Download | 현재 렌더된 SVG 다운로드 | Must |
| F05 | PNG Download | SVG → canvas → PNG (1×) | Must |
| F06 | Copy SVG | 클립보드 SVG 텍스트 복사 | Must |
| F07 | Copy Image | 클립보드 PNG (가능한 브라우저 한정) | Should |
| F08 | Share URL | 입력 텍스트를 LZ-string 또는 base64 압축 → `#code=` fragment | Must |
| F09 | URL 자동 로드 | 페이지 로드 시 `#code=` 가 있으면 prefill | Must |
| F10 | 예시 갤러리 | 11종 mermaid 다이어그램 샘플 한 클릭 로드 | Must |
| F11 | Clear / Reset | 입력 비우기 | Must |
| F12 | 다크 모드 | 사이트 자체 다크 모드 (mermaid 테마와 별개) | Should |
| F13 | 키보드 단축키 | Ctrl+Enter (강제 재렌더), Ctrl+S (SVG download), Ctrl+K (clear) | Should |

### 5-2. Phase 2 (확장)

| # | 기능 | 설명 | 우선순위 |
|---|---|---|---|
| F14 | PNG 해상도 옵션 | 1× / 2× / 3× DPR | Must |
| F15 | 배경 옵션 | 투명 / 흰색 / 다크 | Must |
| F16 | 줄 번호 에디터 | CodeMirror 6 또는 monaco 경량 | Should |
| F17 | 다이어그램 타입별 cheat sheet | 11종 각 페이지에 살아있는 작은 예시 카드 | Should |
| F18 | PlantUML 실험 영역 | kroki.io 비공식 호출 또는 자체 wasm | Could |
| F19 | Print 친화 레이아웃 | 다이어그램만 인쇄용 페이지 | Could |

### 5-3. Phase 3 (백엔드 API)

| # | 기능 | 설명 | 우선순위 |
|---|---|---|---|
| F20 | 서버 렌더 API | `POST /api/v1/render` → `{ svg, png_base64 }`. mermaid-cli + headless chrome | Must |
| F21 | 단축 URL | `POST /api/v1/share` → `mermaid.aidalabs.kr/s/<id>` | Should |
| F22 | rate limit | IP 당 분당 30, key 당 분당 300 | Must |
| F23 | 갤러리 (옵션) | 로그인 없이 device-bound 로컬 저장 + 옵션으로 동기화 | Could |

### 5-4. 상시 요구사항

- 모든 도구 페이지는 **동일 UI 레이아웃** (좌 입력 / 우 미리보기, 모바일에서 상하 스택).
- 각 다이어그램 타입 페이지(`/flowchart/`, `/sequence/`, ...) 상단에 **1문단 요약 + 미니 cheat sheet + 도구 페이지 CTA**.
- 각 페이지 하단에 **연관 가이드 3편 + 연관 다이어그램 타입 2개** 추천 블록 (내부 링크 깊이 확보).

---

## 6. Non-Functional Requirements

### 6-1. 성능

| 지표 | 목표 | 측정 방법 |
|---|---|---|
| LCP | < 1.5s (목표), < 2.5s (허용) | PageSpeed Insights (모바일) |
| CLS | < 0.05 | PageSpeed Insights |
| INP | < 200ms | PageSpeed Insights |
| 초기 JS 번들 (gzip, 랜딩) | < 50KB | mermaid.js 는 도구 페이지에서만 dynamic import |
| 도구 페이지 초기 JS (gzip) | < 250KB (mermaid.js 자체가 ~200KB) | build artifact |
| 디바운스 후 렌더 (중간 다이어그램) | < 250ms | 실기 벤치 |
| 1000노드 flowchart 렌더 | < 1.5s, 메인스레드 블록 < 200ms | 실기 벤치, 필요 시 worker 로 이동 |

### 6-2. 프라이버시 / 보안

- **MVP 단계**: 모든 렌더링이 브라우저 내. 다이어그램 입력은 fetch/XHR 로 전송되지 않음.
- 도구 페이지 상단에 "Your diagram never leaves your browser." 고정 배지.
- mermaid.js 는 사용자 입력에 `<script>` 또는 임의 HTML 삽입을 허용하는 옵션이 있음 (`securityLevel`). **반드시 `'strict'` 또는 `'antiscript'` 로 고정** (XSS 방지).
- Phase 3 백엔드 도입 시 명시 동의 + 메모리 처리 (디스크 미기록), 로그는 IP/시각/상태코드만.
- CSP, HSTS, `Permissions-Policy` 기본 세팅.

### 6-3. 접근성

- 도구 페이지 textarea 에 ARIA label, 결과 SVG 에 `aria-label` 또는 `<title>` (mermaid 가 자동 삽입하는 것 + 보조).
- 키보드 단축키 (위 F13).
- 색상 대비 WCAG AA 이상 (다크/라이트).
- mermaid theme 변경이 사이트 다크 모드와 분리됨을 명시 (혼동 방지 툴팁).

### 6-4. SEO

- 각 페이지 고유 `<title>` / `<meta description>` / canonical.
- JSON-LD: 홈 = `WebSite` + `Organization`, 도구 페이지 = `SoftwareApplication`, 가이드 = `Article`, 다이어그램 타입 = `Article` + `HowTo`, FAQ = `FAQPage`.
- `/sitemap-index.xml` 자동 생성, Search Console 등록 + 색인 요청.
- 내부 링크 구조: 도구 ↔ 다이어그램 타입 ↔ 가이드 ↔ 용어 4방향 연결.

### 6-5. i18n

- MVP 는 **영문 단일 (`lang="en"`)**. Phase 5 이후 한국어 추가 검토 시 `hreflang` 세팅.

---

## 7. UI / UX Principles

### 7-1. 레이아웃 (도구 페이지)

```
┌──────────────────────────────────────────────────────┐
│ Header: Mermaid Preview | Diagrams ▾ | Guides | About │
├──────────────────────────────────────────────────────┤
│ [🔒 Your diagram never leaves your browser]          │
├────────────────────────┬─────────────────────────────┤
│ INPUT (mermaid syntax) │ PREVIEW (rendered SVG)      │
│ ┌────────────────────┐ │ ┌───────────────────────┐   │
│ │ graph TD           │ │ │   ┌─────┐             │   │
│ │   A --> B          │ │ │   │  A  │             │   │
│ │   B --> C          │ │ │   └──┬──┘             │   │
│ │   ...              │ │ │      ▼ ...            │   │
│ └────────────────────┘ │ └───────────────────────┘   │
│ [Examples ▾] [Clear]   │ [Copy SVG] [Download SVG]   │
│                        │ [Copy PNG] [Download PNG]   │
├────────────────────────┴─────────────────────────────┤
│ Theme: [default▾]  Share URL: [Copy link]            │
├──────────────────────────────────────────────────────┤
│ Error bar (only on error): "Parse error near line 5" │
├──────────────────────────────────────────────────────┤
│ Below-the-fold: What is Mermaid? + 11 diagram types  │
└──────────────────────────────────────────────────────┘
```

- **모바일**: 입력/프리뷰 세로 스택. 프리뷰가 입력 위.
- **초기 포커스**: 입력 textarea (placeholder 에 샘플 flowchart).
- **미리보기 영역**: 빈 상태에서는 "Start typing or pick an example" 안내.

### 7-2. 색상·테마

- 사이트 자체: light/dark, slate + accent indigo (`#4f46e5` 가안).
- mermaid 테마: 사용자가 별도 토글. UI 의 다크 모드와 별개임을 툴팁으로 안내.

### 7-3. 키보드 단축키

| 키 | 동작 |
|---|---|
| `Ctrl/Cmd + Enter` | 강제 재렌더 (디바운스 우회) |
| `Ctrl/Cmd + S` | SVG 다운로드 (브라우저 기본 저장 dialog 차단 + 우리 download 트리거) |
| `Ctrl/Cmd + Shift + S` | PNG 다운로드 |
| `Ctrl/Cmd + K` | 입력 초기화 |
| `Ctrl/Cmd + .` | 예시 갤러리 열기 |

### 7-4. 광고 배치 (AdSense 승인 후)

- **본문 위·아래 슬롯, 사이드바 1개**, 가이드 페이지 본문 중단 1개.
- **도구 화면 first fold 내 광고 금지** — 본 프로젝트의 차별점 유지.
- 다이어그램 타입 랜딩 페이지(`/flowchart/` 등) 는 본문 위쪽 1개 + 본문 중단 1개 허용.
- 자동광고는 가이드·다이어그램 타입 페이지에만 허용. 도구 페이지는 수동 슬롯 only.

---

## 8. Data & Privacy

- **클라이언트 처리 원칙 (MVP)**: 입력한 mermaid 텍스트는 페이지 세션 메모리에만 존재. fetch/XHR 외부 전송 없음.
- **Share URL**: 입력 텍스트를 LZ-string 압축 후 base64url 로 인코딩해 `#code=` fragment 에 넣음. fragment 는 서버로 전송되지 않으므로 우리 nginx access log 에도 다이어그램 내용이 남지 않음 (이 사실을 Privacy Policy 에 명시).
- **분석 툴**: GA4 (cookie consent 후 활성화) + Search Console. 사용자 입력은 절대 수집하지 않음.
- **mermaid.js securityLevel**: `'strict'` 고정. 사용자 입력에서 `<script>` / `<iframe>` / 임의 click 핸들러가 실행되지 않게 함.
- **쿠키 동의 배너**: GDPR/ePrivacy 대응. json-beautifier 와 동일한 패턴 (CookieBanner.astro 재사용).

---

## 9. Success Metrics

| # | 단계 | 지표 | 목표 | 측정 시점 |
|---|---|---|---|---|
| 1 | 승인 | AdSense 첫 신청 | ≤ 3개월 | Phase 5 이후 |
| 2 | 트래픽 | 월간 순방문자 (UV) | 승인 후 6개월 내 8,000+ | GA4 + GSC |
| 3 | 참여 | 평균 세션 시간 | 90초+ (도구 사이트 특성상 짧음) | GA4 |
| 4 | 이탈 | 도구 페이지 < 65%, 가이드 페이지 < 55% | | GA4 |
| 5 | 성능 | Core Web Vitals 전 페이지 Good | | GSC |
| 6 | 수익 | 월 광고 수익 | 승인 후 6개월 내 USD 50+ | AdSense |
| 7 | 색인 | Search Console 색인 페이지 | Phase 5 종료 시 30+ | GSC Coverage |

---

## 10. Out of Scope

v1 에서는 다음을 의도적으로 제외:

- 사용자 계정 / 로그인 / 클라우드 저장 갤러리
- 협업 편집 (실시간 동시 편집, 공유 워크스페이스)
- 유료 플랜 (Phase 3 이후 검토)
- 데스크톱·모바일 네이티브 앱
- 사내 SSO 통합
- mermaid 가 아닌 다이어그램 엔진 풀 지원 (Graphviz, PlantUML, BlockDiag 등 — Phase 2 에서 PlantUML 만 실험)
- AI 기반 "텍스트 → 다이어그램 자동 생성" (별도 프로젝트로 분리 검토)

---

## 11. Risks & Mitigations

| # | 리스크 | 영향 | 확률 | 대응 |
|---|---|---|---|---|
| R01 | mermaid.live 공식 사이트의 도메인 권위 | SEO 1위 진입 어려움 | High | 다이어그램 타입별 랜딩 + 가이드 깊이로 롱테일 키워드 점유. mermaid.live 가 SPA 단일 URL 인 점이 우리에게 유리 |
| R02 | mermaid.js 번들 크기 (~200KB gzip) | 도구 페이지 LCP 악화 | Med | `view-transition` + dynamic import. 도구 페이지에만 로드. CDN unpkg 캐시 활용 검토 |
| R03 | mermaid `securityLevel` 미설정 → XSS | 보안 사고, AdSense 정지 | Low | 코드에 `securityLevel: 'strict'` 하드코딩, 테스트 포함 |
| R04 | AdSense "value-added" 심사 반려 | 수익 모델 지연 | Med | 다이어그램 타입 랜딩 8 + 가이드 10 + 용어 10+ + 법적 4 = 30+ 페이지 확보 후 신청 |
| R05 | mermaid 새 버전 breaking change | 다이어그램 깨짐 | Med | mermaid 버전 핀 + roadmap 추적. 메이저 업데이트 시 사이트 전체 회귀 테스트 |
| R06 | 큰 다이어그램(1000+ 노드) 메인스레드 블록 | UX 저하 | Med | Phase 2 에 worker 또는 Phase 3 에 서버 렌더로 이동 |
| R07 | mermaid AI/AI-syntax 가 등장해 본 사이트가 시대에 뒤떨어짐 | 트래픽 감소 | Low | "텍스트로 직접 쓰는 mermaid" 자체가 "AI 가 출력한 mermaid 를 살펴봐야 하는 사람"의 도구가 됨. 오히려 수요 안정 |
| R08 | Content 중복 (AI 초안 그대로) | AdSense 반려 | High | 각 다이어그램 타입 가이드는 운영자가 실제 회사·문서 시나리오를 가공한 고유 예시 포함 |

---

## 12. Decision Log

| 일자 | 항목 | 결정 | 대안 | 사유 |
|---|---|---|---|---|
| 2026-05-01 | 도메인 전략 | `aidalabs.kr` 서브도메인 재사용 (`mermaid.aidalabs.kr`) | 신규 `.com` | 비용 0, 인프라 재활용 |
| 2026-05-01 | MVP 라이브러리 | mermaid.js v11 (npm) — dynamic import | wasm 자체 컴파일, kroki.io 호출 | 검증된 라이브러리, 단일 패키지로 11종 다이어그램 |
| 2026-05-01 | 문서 언어 | 한국어 (기획), 영문 (사이트 콘텐츠) | 전부 영문 | 내부 기획 속도 ↑ |
| 2026-05-01 | 아키텍처 | 정적 + (Phase 6+) 백엔드 하이브리드 | 100% 클라이언트 평생 유지 | Phase 3 의 서버 렌더·단축 URL 위해 백엔드 옵션 열어둠 |
| 2026-05-01 | 서브도메인 이름 | `mermaid.aidalabs.kr` | `diagram.aidalabs.kr` / `chart.aidalabs.kr` | 키워드 직접성 우선. mermaid 검색이 SEO 직결 |
| 2026-05-01 | mermaid securityLevel | `'strict'` (하드코딩) | `'loose'` / `'antiscript'` | XSS 방지·AdSense 컴플라이언스 |
| 2026-05-01 | 백엔드 스택 (Phase 6+) | FastAPI + Uvicorn + mermaid-cli (subprocess) | Node + Puppeteer | json-beautifier API 와 동일 스택, OCI VM Python 환경 재활용 |
| 2026-05-01 | API 서브도메인 | `mermaid-api.aidalabs.kr` (Phase 6 도입 예정) | — | 광고 도메인과 API 도메인 분리 원칙 |
| 2026-05-01 | 내부 포트 | `8002` 예약 | — | 포트 대장(`docs/01` §9, 루트 `CLAUDE.md` §5) 갱신 완료 |
| 2026-05-01 | VM | bidMaster/beautifier 와 공유 (OCI Always Free 단일) | 신규 VM | 비용 0, bootstrap 비파괴 모드 활용 |
| 2026-05-01 | 수익 모델 v1 | AdSense 단독 | + Pro 티어 / + Affiliate | MVP 는 승인 집중. 유료는 트래픽 확보 후 재검토 |
| 2026-05-01 | mermaid 테마 | UI 토글로 4종 노출 | 단일 default 만 | 다크 모드 문서 사용자 비중 무시할 수 없음 |

---

## 13. 부록 — 용어

- **Mermaid** = 텍스트 기반 다이어그램 정의 언어. 11종 다이어그램(flowchart, sequence, class, state, ER, gantt, pie, mindmap, timeline, gitGraph, journey 등) 지원.
- **SVG** = 벡터 이미지 포맷. mermaid 의 1차 출력.
- **PNG export** = SVG → canvas → toDataURL('image/png') 파이프라인.
- **Share URL** = 입력 텍스트를 압축·인코딩해 fragment(`#`) 에 담은 URL. 서버로 전송되지 않음.
- **securityLevel** = mermaid 의 출력 sanitization 정책. `strict` 가 가장 안전.
