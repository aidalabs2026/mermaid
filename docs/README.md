# mermaid_preview docs 인덱스

`PRD.md` 가 원본 소스 (source of truth). 본 디렉토리의 문서는 PRD 의 각 섹션을 실행 수준으로 풀어낸 파생 문서입니다. PRD 와 충돌 시 PRD 우선.

| 경로 | 역할 |
|---|---|
| `01-vision-and-scope.md` | 비전·범위·필터 통과 근거 |
| `02-roadmap.md` | Phase 0 → Phase 5 단계별 일정 |
| `03-architecture-decision.md` | 옵션 A/B/C 비교 후 확정안 + 변수 표 |
| `04-content-plan.md` | 가이드 10+ / 용어 10+ / 다이어그램 타입 8 페이지 콘텐츠 플랜 |
| `05-adsense-checklist.md` | AdSense 승인 직전 체크리스트 (프로젝트 로컬판) |
| `06-deployment-and-domain.md` | DNS·OCI·Nginx·Let's Encrypt·GitHub Actions 단계 |
| `07-claude-playbook.md` | Claude 가 이 프로젝트에서 따라야 할 작업 지침 |

## 진행 상태 (2026-05-01)

- Phase 0 스캐폴드 완료 (PRD + docs + Astro 골격 + deploy + workflow)
- 다음 단계: 콘텐츠 작성 (Phase 5 진입 전 가이드 10+편 + 다이어그램 타입 8 랜딩)
- VM 부트스트랩·DNS 등록은 사용자 액션 대기

## 상위 폴더 문서와의 관계

`../docs/` (포트폴리오 공통 docs) 는 모든 프로젝트가 공유하는 인프라·플레이북. 프로젝트별 결정·콘텐츠는 본 폴더에 둔다. 공통 인프라 변경(예: VM, 도메인) 은 상위 폴더 docs 에서만 수정.
