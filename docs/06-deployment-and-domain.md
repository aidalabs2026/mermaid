# 06. Deployment & Domain (mermaid_preview 치환본)

> 상위 폴더 `docs/01-common-infrastructure.md` 의 정보를 본 프로젝트 변수로 치환. 공통 변경(예: VM 사양·DNS 정책) 은 상위 문서에서만 수정하고 본 문서는 변수만 갈아끼운다.

## 1. 변수

- `<PROJECT>` = `mermaid` (배포 디렉토리·Nginx conf 파일명)
- `<SITE_HOST>` = `mermaid.aidalabs.kr`
- `<API_HOST>` = `mermaid-api.aidalabs.kr` (Phase 6+ 예약)
- `<APP_PORT>` = `8002` (Phase 6+ 예약)
- `<EMAIL>` = `facered79@gmail.com`
- `<OCI_IP>` = (bidMaster/beautifier 와 공유 — 동일 VM 의 Reserved Public IP)

## 2. 배포 시퀀스

### Phase 4-1. DNS (사용자 액션, 5분)

1. registrar (가비아) 콘솔 → `aidalabs.kr` DNS 관리
2. A 레코드 추가:
   - `mermaid` → `<OCI_IP>` (Reserved Public IP)
3. 전파 확인:
   ```bash
   dig mermaid.aidalabs.kr +short
   # → <OCI_IP> 가 반환되면 OK (수 분~수십 분 소요)
   ```

### Phase 4-2. VM bootstrap (사용자 + Claude 협업, 15~30분)

VM 에 deploy/ 폴더를 업로드하고 비파괴 모드로 부트스트랩:

```bash
# 로컬에서 (Windows PowerShell)
scp -i <OCI_SSH_KEY> -r deploy ubuntu@<OCI_IP>:~/mermaid-deploy/

# VM 에서 (SSH 접속 후)
EMAIL=facered79@gmail.com sudo -E bash ~/mermaid-deploy/scripts/bootstrap.sh
```

bootstrap.sh 가 수행하는 일:
- nginx / certbot / fail2ban 등 패키지 설치 (이미 있으면 스킵)
- `/var/www/mermaid/` 생성 + placeholder index.html
- `deploy/nginx/mermaid.aidalabs.kr.conf` 를 `/etc/nginx/sites-available/` 에 복사 + sites-enabled 심볼릭 링크
- **default 사이트 / 다른 프로젝트의 conf 는 절대 건드리지 않음**
- `nginx -t && systemctl reload nginx`
- DNS 가 이 VM IP 를 가리키면 Let's Encrypt 자동 발급
- sudoers drop-in: GitHub Actions 가 무비번으로 `systemctl reload nginx` 가능

### Phase 4-3. GitHub Secrets + 첫 배포 (사용자, 10분)

GitHub repo (mermaid_preview 가 자체 repo 일 경우, 또는 monorepo 라면 공통) → Settings → Secrets and variables → Actions:

| Secret | 값 |
|---|---|
| `OCI_HOST` | VM Public IP |
| `OCI_SSH_USER` | `ubuntu` |
| `OCI_SSH_KEY` | private key 원문 (LF 줄바꿈, 끝에 빈 줄) |

> bidMaster·beautifier 와 같은 GitHub repo 가 아니라면 동일 secret 을 새로 등록해야 한다 (repo 간 공유 불가).

Actions 탭 → "Deploy Static Site" → Run workflow → main 브랜치 → 실행. 첫 빌드 ~2분, rsync ~10초, 200 응답 확인.

### Phase 4-4. Search Console + 색인

1. https://search.google.com/search-console → 속성 추가 → URL prefix → `https://mermaid.aidalabs.kr/`
2. 인증 방법: HTML tag → 토큰 복사 → `site/src/consts.ts` `GSC_VERIFICATION` 에 붙여넣기 → push → 재배포 → 검증 클릭
3. Sitemaps → `sitemap-index.xml` 제출
4. URL 검사 → 주요 페이지 (홈, /preview/, 다이어그램 타입 페이지 8) 색인 요청

## 3. Nginx conf (요약)

`deploy/nginx/mermaid.aidalabs.kr.conf` 는 정적 사이트 표준 템플릿(`docs/01-common-infrastructure.md` §4-1) 을 그대로 따른다. WebSocket 프록시 없음. Phase 6+ 에 `mermaid-api.aidalabs.kr` 가 추가되면 별도 conf 파일을 같은 디렉토리에 추가.

## 4. 운영 모니터링

- Uptime Robot: `https://mermaid.aidalabs.kr/` 5분 간격
- (선택) `/preview/` 페이지도 모니터에 추가해 도구 동작 보장
- Search Console: 매주 1회 Coverage / Core Web Vitals 확인
- Nginx access log: 주간 GoAccess 리포트 (수동)

## 5. Phase 6+ — 백엔드 추가 시 (참고)

서버 렌더 API 를 추가할 때:

1. systemd 유닛 작성 (`deploy/systemd/mermaid-api.service`) — bidMaster `bidmaster-app.service` 패턴 참고. mermaid-cli + headless chromium 실행에 메모리 ~300MB 필요 (Always Free 24GB 에 충분)
2. `deploy/nginx/mermaid-api.aidalabs.kr.conf` 추가 (`docs/01-common-infrastructure.md` §4-2 템플릿)
3. bootstrap.sh 에 새 conf 복사 라인 + systemd enable 라인 추가 (idempotent)
4. certbot 재실행: `certbot --nginx -d mermaid.aidalabs.kr -d mermaid-api.aidalabs.kr --keep-until-expiring`
5. CORS 헤더 — 도구 페이지에서 fetch 가능하도록 `Access-Control-Allow-Origin: https://mermaid.aidalabs.kr`

## 6. 자주 부딪히는 이슈 (mermaid 특화 추가분)

상위 `docs/07-claude-playbook.md` §5 의 일반 이슈 외에:

| 증상 | 원인 | 해결 |
|---|---|---|
| 빌드 시 `mermaid` 가 SSR 에서 `window` undefined 로 실패 | mermaid 가 브라우저 글로벌을 참조 | `import` 를 도구 페이지의 `<script>` 안에서 `dynamic import('mermaid')` 로 — Astro 의 client-only 패턴 |
| `Could not parse expression` (mdx 안에서 mermaid block 가공 시) | MDX 의 JSX 파서가 `{` 등을 해석 | mermaid 코드는 `<pre><code class="language-mermaid">...</code></pre>` 또는 fenced code (` ```mermaid `) 로만 사용. MDX 안에서 컴포넌트로 처리할 때 `{` `}` 이스케이프 |
| 빌드된 sitemap 에 도구 페이지의 `#code=` URL 이 색인됨 | sitemap 이 fragment 포함 | sitemap 은 fragment 무시. 별도 처리 불필요 |
| Share URL 이 너무 길어 Slack 에서 잘림 | LZ-string 압축이 충분하지 않음 | Phase 3 에 단축 URL 백엔드 도입 |
