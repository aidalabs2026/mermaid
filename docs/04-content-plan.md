# 04. Content Plan

> AdSense 승인 기준 30+ 페이지 충족이 목표. 도구 1 + 다이어그램 타입 8 + 가이드 10 + 용어 10 + FAQ 10 + 법적 4 + 홈 1 = 44 페이지.

## 1. 페이지 인벤토리

### 1-1. 코어 (4)
| URL | 타입 | 상태 |
|---|---|---|
| `/` | 홈 | Phase 0 골격 → Phase 1 보강 |
| `/preview/` | 도구 | Phase 1 |
| `/about/` | 법적 | Phase 0 ✅ |
| `/contact/` | 법적 | Phase 0 ✅ |

### 1-2. 법적 (2 추가, 위 about/contact 와 합쳐 4)
| URL | 상태 |
|---|---|
| `/privacy/` | Phase 0 ✅ (mermaid 특화 fragment·securityLevel 문구 포함) |
| `/terms/` | Phase 0 ✅ |

### 1-3. 다이어그램 타입 (8)
| URL | mermaid keyword | 우선순위 |
|---|---|---|
| `/flowchart/` | `graph` / `flowchart` | 1 |
| `/sequence/` | `sequenceDiagram` | 1 |
| `/class/` | `classDiagram` | 2 |
| `/state/` | `stateDiagram-v2` | 2 |
| `/er/` | `erDiagram` | 2 |
| `/gantt/` | `gantt` | 3 |
| `/pie/` | `pie` | 3 |
| `/mindmap/` | `mindmap` | 3 |

각 페이지 공통 구조는 PRD §UI-7 + roadmap Phase 2 참고.

### 1-4. 가이드 (10+)
| URL slug | 카테고리 | 키워드 |
|---|---|---|
| `why-text-based-diagrams` | strategy | "diagrams as code", "text-based diagram" |
| `mermaid-in-github-readme` | format-guide | "mermaid github", "mermaid readme" |
| `mermaid-in-notion-obsidian-gitbook` | format-guide | "mermaid notion", "mermaid obsidian" |
| `mermaid-in-hugo-jekyll-vuepress` | format-guide | "mermaid hugo", "mermaid jekyll" |
| `flowchart-vs-sequence-when` | comparison | "flowchart vs sequence diagram" |
| `mermaid-theme-customization` | format-guide | "mermaid theme", "mermaid dark" |
| `common-parse-errors-and-fixes` | troubleshooting | "mermaid syntax error", "mermaid parse error" |
| `mermaid-syntax-style-guide` | basics | "mermaid syntax style" |
| `whiteboard-photo-to-mermaid` | strategy | "whiteboard to diagram" |
| `sharing-mermaid-diagrams-in-pr-review` | strategy | "mermaid pull request", "mermaid pr review" |

### 1-5. 용어 (10+)
| 슬러그 | 설명 |
|---|---|
| `flowchart` | 노드와 화살표로 절차를 표현 |
| `sequence-diagram` | 시간 축 따라 actor 간 메시지 |
| `class-diagram` | 객체지향 클래스·관계 |
| `state-diagram` | 상태 머신 |
| `er-diagram` | 엔티티-관계 |
| `gantt-chart` | 시간축 작업 |
| `pie-chart` | 비율 |
| `mindmap` | 트리형 아이디어 정리 |
| `mermaid-theme` | mermaid 의 4종 빌트인 테마 |
| `security-level` | mermaid 의 sanitization 정책 |
| `viewport` | SVG 의 보기 영역 |
| `svg-vs-png` | 출력 포맷 비교 |
| `directive` | mermaid `%%{init: ...}%%` 메타 지시 |

### 1-6. FAQ (10+)
| 카테고리 | 예시 질문 |
|---|---|
| using-the-tool | "How do I share a diagram with my team?" |
| using-the-tool | "Why is my diagram cut off?" |
| privacy | "Do you store my diagram on the server?" |
| privacy | "What about analytics cookies?" |
| limits | "What's the maximum diagram size?" |
| limits | "Can I export at 4K resolution?" |
| formats | "Which Mermaid version do you use?" |
| formats | "Why doesn't my flowchart render?" |
| ads | "Why are there ads?" |
| ads | "Can I disable ads?" |

## 2. 톤 / 스타일

- 영어, plain English, 6th-grade 가독성 목표.
- 1인칭 plural ("we") 또는 2인칭 ("you"). 1인칭 단수 회피.
- 코드 블록: mermaid live 예시 + 렌더된 SVG 이미지(또는 동봉 mermaid block 을 GitHub 가 자동 렌더하는 형태) — 빌드 시 SVG 미리 생성해서 정적 이미지로 노출 가능 (Phase 2+)
- 각 가이드는 **고유 시나리오 1개** + **흔한 실수 1개** + **유사 가이드 링크 3개** 포함 (AI 초안의 평준화된 문체 회피)

## 3. 내부 링크 매핑 (4방향)

```
[도구 /preview/] ─┬─→ 다이어그램 타입 8 (각 페이지의 "Try it now" CTA 가 prefilled #code= 로 도구 진입)
                  ├─→ 가이드 10+ (관련 가이드 추천 블록)
                  └─→ 용어 (글 안 인라인)

[다이어그램 타입] ─┬─→ 도구 (CTA)
                   ├─→ 같은 카테고리 다른 다이어그램 타입 2 (cross-link)
                   └─→ 관련 가이드 3

[가이드] ─┬─→ 도구 (CTA, 본문 내부 자연스럽게)
          ├─→ 관련 다이어그램 타입 1~2
          └─→ 관련 용어 (인라인)

[용어] ─┬─→ 가이드 (관련 가이드 링크 1~2)
        └─→ 다이어그램 타입 (관련 시 1)
```

## 4. 콘텐츠 작성 순서 (AdSense 승인 전 권장)

1. 법적 4종 — 이미 Phase 0 완료 ✅
2. 도구 페이지 + 홈 — Phase 1
3. 다이어그램 타입 8 — Phase 2 (각각 본문 600~1000자 + 5+ 시나리오)
4. 가이드 핵심 5편 (`mermaid-in-github-readme`, `flowchart-vs-sequence-when`, `common-parse-errors-and-fixes`, `mermaid-theme-customization`, `why-text-based-diagrams`) — Phase 3
5. 가이드 추가 5+편 — Phase 3
6. 용어 10+ — Phase 3 마지막
7. FAQ 10+ — Phase 3 마지막

## 5. 페이지별 SEO 메타 가이드

- 모든 페이지 고유 `<title>`, 50~60자.
- `<meta description>`: 140~160자, 페이지 핵심 가치 + CTA 단어 ("preview", "render", "compare").
- canonical: 자기 자신.
- `<title>` 패턴: `<주제> | Mermaid Preview` 또는 `Mermaid Preview — <주제>`.
- og:image: Phase 4 부터 페이지별 다이어그램 미리보기 이미지 (자동 생성 스크립트 또는 수동).

## 6. 콘텐츠 품질 자가 점검

발행 전 체크:
- [ ] 1500자+ (가이드) / 600자+ (다이어그램 타입) / 200자+ (용어)
- [ ] 고유 시나리오 1개 이상 (다른 사이트 복붙으로 발견 안 되는 예시)
- [ ] 흔한 실수 1개
- [ ] 내부 링크 3개 이상
- [ ] 이미지 alt 텍스트 (mermaid SVG 의 경우 `<title>`)
- [ ] meta description 작성
- [ ] last updated 날짜 갱신
