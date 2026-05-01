# 07. Claude Playbook (mermaid_preview 로컬 지침)

> 상위 폴더 `docs/07-claude-playbook.md` 의 일반 지침을 따르되 본 프로젝트 특화 사항을 여기에 추가한다. Claude 가 이 폴더에서 작업할 때 먼저 읽을 것.

## 1. 우선 순위

1. **PRD.md 가 source of truth**. 충돌 시 PRD 우선.
2. 사이트 자체 콘텐츠 언어는 **영어**. 본 docs/ 와 PRD 는 한국어 (운영자 작성 속도).
3. 인프라 결정(포트·서브도메인·VM)은 상위 폴더 `docs/01-common-infrastructure.md` 와 `CLAUDE.md` §5 표를 우선 확인. 본 프로젝트가 점유한 자원: **포트 8002, 서브도메인 mermaid.aidalabs.kr, mermaid-api.aidalabs.kr**.

## 2. mermaid 특화 보안 규칙

- mermaid 초기화 코드에 `securityLevel: 'strict'` 가 **항상** 있어야 한다. 코드 변경 시 `Grep "securityLevel"` 로 확인.
- 사용자 입력 텍스트는 절대 `innerHTML` 로 직접 렌더하지 않는다 (mermaid 가 만든 SVG 만 삽입).
- click 핸들러 / 외부 링크가 들어간 다이어그램은 syntax 자체는 허용하나 `securityLevel: 'strict'` 가 sanitize 한다는 가정.
- XSS 회귀 테스트 입력 (PRD §11 R03):
  ```
  graph LR
    A[<img src=x onerror=alert(1)>] --> B
    A --> B[<script>alert(2)</script>]
  ```
  결과 SVG 에 `<script>` / `onerror` 가 살아있으면 안 됨.

## 3. 의존성 관리

- mermaid 메이저 버전은 PRD §11 R05 에 따라 **고정**. `package.json` 에 `"mermaid": "11.x.x"` (캐럿 `^` 사용 — 마이너 업데이트 허용).
- 메이저 업그레이드는 별도 commit 으로, 11종 다이어그램 모두 회귀 테스트 후.
- lz-string 은 안정적이라 latest minor 허용.

## 4. 디렉토리 컨벤션

```
mermaid_preview/
├── PRD.md
├── README.md
├── docs/                 # 한국어 기획·결정·플레이북
├── site/                 # Astro SSG (영문 콘텐츠)
│   ├── src/consts.ts     # 사이트 메타데이터 (변경 시 BaseLayout 자동 반영)
│   ├── src/content/      # 가이드 / 용어 / FAQ 마크다운
│   └── src/pages/        # 정적 페이지 + /preview/ 도구
├── deploy/               # nginx, bootstrap (운영자가 VM 에서 실행)
└── .github/workflows/    # CI/CD
```

## 5. 새 가이드·용어·FAQ 추가 절차

1. `docs/04-content-plan.md` 의 인벤토리에서 슬러그 확정
2. `site/src/content/<collection>/<slug>.mdx` (가이드는 mdx, 용어·FAQ 는 md)
3. frontmatter 작성 (스키마는 `site/src/content.config.ts`)
4. 본문 1500자+ (가이드) / 200자+ (용어) / 150자+ (FAQ)
5. 다른 페이지에서 내부 링크 추가 (도구 ↔ 다이어그램 타입 ↔ 가이드 ↔ 용어)
6. `npm run build` 로 sitemap 갱신 확인
7. push → workflow 자동 배포 → Search Console URL 검사 → 색인 요청

## 6. 도구 페이지 작업 시

- mermaid.js 는 도구 페이지에서만 dynamic import. 절대 BaseLayout 이나 홈에서 import 하지 말 것 (LCP 손해).
- 키보드 단축키 충돌 주의: `Ctrl+S` 는 브라우저 기본 저장 dialog 차단 + 우리 SVG download 트리거. textarea 에 포커스 있을 때만.
- 디바운스 300ms. 너무 짧으면 입력 중 매 키스트로크 렌더, 너무 길면 반응성 저하.
- 에러 메시지: mermaid parse error 메시지를 그대로 노출하지 말고 첫 줄 + (가능하면) 라인 번호만 표시.

## 7. 작업할 일이 아닌 것 (이 폴더에서 금지)

- 다른 프로젝트(`bidMaster/`, `json-beautifier/`, `markdown_preview/`) 파일 수정
- 상위 폴더 `docs/` 의 일반 지침 임의 수정 (포트 표 갱신은 예외)
- 새 외부 의존성 도입 (`docs/05-research-methodology.md` 에 사유 기록 후만)
- 광고 스니펫·자동광고 코드 (AdSense 승인 전까지)

## 8. 작업 완료 시 확인 (PR 또는 commit 직전)

- [ ] `npm run build` 통과
- [ ] mermaid `securityLevel` 검색해 `'strict'` 인지 확인
- [ ] 새 페이지가 추가됐다면 NAV_ITEMS / FOOTER_LINKS / sitemap 에 노출되는지 확인
- [ ] 새 컬렉션 항목이 추가됐다면 frontmatter 가 스키마와 일치하는지
- [ ] 텍스트 콘텐츠가 영어로 작성됐는지 (한국어 잔재 없음)
