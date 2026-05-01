# 03. Architecture Decision

> 본 문서는 mermaid_preview 의 핵심 기술 결정을 한 페이지로 모은다. 결정이 바뀌면 PRD §12 Decision Log 에 먼저 추가한 뒤 여기를 동기화.

## 1. 변수 표 (프로젝트 식별자)

상위 폴더 `docs/02-new-project-template.md` Step 2 의 양식을 채운 결과:

| 변수 | 값 |
|---|---|
| `<PROJECT>` | `mermaid` (디렉토리는 `mermaid_preview/`, 배포 경로는 `/var/www/mermaid/` — 짧게) |
| `<PROJECT_NAME>` | `Mermaid Preview` |
| `<SITE_HOST>` | `mermaid.aidalabs.kr` |
| `<API_HOST>` | `mermaid-api.aidalabs.kr` (Phase 6+ 예약) |
| `<APP_PORT>` | `8002` (Phase 6+ 예약, 현재 미가동) |
| `<SITE_LOCALE>` | `en` |
| `<EMAIL>` | `facered79@gmail.com` |
| `<OCI_IP>` | (bidMaster/beautifier 와 공유 — 동일 VM 의 Reserved Public IP) |

> 상위 `CLAUDE.md` §5 + `docs/01-common-infrastructure.md` §9 + 메모리 `port_registry.md` 모두에 반영 완료.

## 2. 옵션 비교 (3개 축)

### 2-1. 렌더링 위치

| 옵션 | 설명 | 장점 | 단점 | 채택 |
|---|---|---|---|---|
| A. 100% 클라이언트 | 브라우저에서 mermaid.js 가 SVG 생성 | 비용 0, 프라이버시, 즉시 | 큰 다이어그램에서 메인스레드 블록 가능 | ✅ MVP |
| B. 100% 서버 (kroki) | 서버에서 SVG 생성해 응답 | 큰 다이어그램에 강함, mermaid 외 엔진도 가능 | 서버 비용·프라이버시 우려·응답 latency | ❌ |
| C. 하이브리드 | MVP 는 A, Phase 6+ 에 옵션 B 추가 (대용량·고해상 PNG) | A 의 장점 + B 의 확장성 | 두 코드패스 유지 | ✅ Phase 6+ 부터 |

### 2-2. mermaid.js 로딩 전략

| 옵션 | 설명 | 장점 | 단점 | 채택 |
|---|---|---|---|---|
| A. CDN `<script>` (unpkg) | 도구 페이지에서 `<script src="...mermaid.min.js">` | CDN 캐시, npm 의존성 없음 | 외부 도메인 요청 → 프라이버시 약점, ad-block 가능 | ❌ |
| B. npm 빌드 시 번들 | `import mermaid from 'mermaid'` | 자체 호스팅, 외부 요청 없음 | 빌드 산출물에 ~200KB 추가 | ❌ (랜딩 LCP 손해) |
| C. npm + dynamic import (도구 페이지에서만) | 코드 분할, 도구 진입 시에만 chunk 로드 | 랜딩 LCP 영향 없음, 자체 호스팅 | 약간 복잡 | ✅ |

### 2-3. Share URL 인코딩

| 옵션 | 설명 | 장점 | 단점 | 채택 |
|---|---|---|---|---|
| A. Plain query (`?code=`) | URL-encoded 원문 | 단순 | URL 길이 한계, 로그에 남음 | ❌ |
| B. Base64 query | base64 인코딩 후 query | 약간 짧음 | 여전히 query → 로그에 남음 | ❌ |
| C. LZ-string + base64url + fragment (`#code=`) | 압축 후 fragment | 짧음, fragment 는 서버로 전송 안 됨 (privacy) | client-only 구현 | ✅ |
| D. 단축 URL (서버) | 서버에 키-값 저장 후 짧은 슬러그 | 매우 짧음, 안전 | 백엔드 필요 | Phase 3 |

> Phase 1 는 C, Phase 3 에 D 를 추가해 매우 큰 다이어그램이나 짧은 링크 요구를 보완.

## 3. 채택 스택 (확정)

```
[브라우저]
   ├── Astro 5 SSG (HTML/CSS, no hydration except 도구 페이지)
   ├── 도구 페이지: vanilla TS (svelte/react 도입 안 함)
   ├── mermaid v11 (npm) — dynamic import
   ├── lz-string (npm) — Share URL 압축
   └── 클립보드 / canvas / Blob — 브라우저 기본
        │
        ▼ (Phase 6+ 만)
[OCI VM]
   ├── Nginx (mermaid.aidalabs.kr → /var/www/mermaid/)
   └── (Phase 6+) FastAPI @ 8002 → mermaid-cli subprocess + headless chromium
```

## 4. 보안 결정 (XSS 차원)

mermaid 는 다이어그램 노드의 `click` 핸들러나 `<a>` 링크 등을 syntax 로 직접 정의할 수 있다. 사용자 입력 → 임의 HTML 삽입 통로가 될 수 있어, 다음 옵션을 **하드코딩** 한다:

```ts
mermaid.initialize({
  startOnLoad: false,
  securityLevel: 'strict',  // 사용자 입력의 모든 HTML 을 sanitize
  theme: themeFromState,
  // 다른 옵션은 사용자 토글 허용
});
```

`securityLevel` 을 `'loose'` / `'antiscript'` 로 바꾸는 UI 토글은 **추가하지 않는다** (XSS 게이트가 됨).

## 5. 모니터링·관찰 (Phase 4 부터)

- Search Console — 색인·CWV
- GA4 (cookie consent 통과 후) — 페이지뷰·이탈률
- Uptime Robot — `mermaid.aidalabs.kr` HTTPS 200 5분 간격
- Nginx access log — 다이어그램 fragment(`#`) 는 서버에 도달하지 않으므로 로그에 입력 텍스트가 남지 않음 (Privacy Policy 에 명시)

## 6. 변경 이력

- 2026-05-01 v0.1 — 초안. PRD v0.1 와 동기화.
