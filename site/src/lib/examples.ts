export interface MermaidExample {
  key: string;
  label: string;
  category: 'flow' | 'sequence' | 'class' | 'state' | 'er' | 'gantt' | 'pie' | 'mindmap' | 'journey' | 'gitGraph' | 'timeline';
  code: string;
}

export const MERMAID_EXAMPLES: MermaidExample[] = [
  {
    key: 'flowchart-basic',
    label: 'Flowchart — basic',
    category: 'flow',
    code: `flowchart TD
  A[User opens app] --> B{Logged in?}
  B -- Yes --> C[Show dashboard]
  B -- No --> D[Show login]
  D --> E[Authenticate]
  E --> C
`,
  },
  {
    key: 'sequence-api-call',
    label: 'Sequence — API call',
    category: 'sequence',
    code: `sequenceDiagram
  participant U as User
  participant W as Web App
  participant A as Auth Service
  participant D as Database
  U->>W: Submit login form
  W->>A: POST /token
  A->>D: SELECT user by email
  D-->>A: user row
  A-->>W: { access_token }
  W-->>U: redirect /dashboard
`,
  },
  {
    key: 'class-orders',
    label: 'Class — orders domain',
    category: 'class',
    code: `classDiagram
  class Customer {
    +int id
    +string email
    +list~Order~ orders
    +placeOrder(items) Order
  }
  class Order {
    +int id
    +Date placedAt
    +string status
    +addItem(item)
  }
  class LineItem {
    +int qty
    +Money unitPrice
  }
  Customer "1" --> "*" Order : has
  Order "1" --> "*" LineItem : contains
`,
  },
  {
    key: 'state-checkout',
    label: 'State — checkout',
    category: 'state',
    code: `stateDiagram-v2
  [*] --> Cart
  Cart --> Address: continue
  Address --> Payment: continue
  Payment --> Review: continue
  Review --> Placing: confirm
  Placing --> Placed: success
  Placing --> Payment: payment failed
  Placed --> [*]
`,
  },
  {
    key: 'er-blog',
    label: 'ER — blog schema',
    category: 'er',
    code: `erDiagram
  USER ||--o{ POST : writes
  USER ||--o{ COMMENT : writes
  POST ||--o{ COMMENT : has
  POST }o--|| CATEGORY : belongs_to
  USER {
    int id PK
    string email
    string display_name
  }
  POST {
    int id PK
    string title
    string body
    int author_id FK
    int category_id FK
  }
`,
  },
  {
    key: 'gantt-launch',
    label: 'Gantt — product launch',
    category: 'gantt',
    code: `gantt
  title Product launch
  dateFormat YYYY-MM-DD
  section Engineering
  Auth refactor   :a1, 2026-05-01, 7d
  Billing module  :a2, after a1, 10d
  section Marketing
  Landing page    :b1, 2026-05-04, 5d
  Press kit       :b2, after b1, 3d
  section Launch
  Soft launch     :milestone, 2026-05-22, 0d
  GA              :milestone, 2026-06-05, 0d
`,
  },
  {
    key: 'pie-traffic',
    label: 'Pie — traffic sources',
    category: 'pie',
    code: `pie title Traffic sources (last 30 days)
  "Organic search" : 58
  "Direct" : 17
  "Referral" : 14
  "Social" : 8
  "Email" : 3
`,
  },
  {
    key: 'mindmap-launch',
    label: 'Mindmap — launch checklist',
    category: 'mindmap',
    code: `mindmap
  root((Launch))
    Engineering
      Auth
      Billing
      Logging
    Marketing
      Landing page
      Press kit
    Support
      Help center
      Status page
    Compliance
      Privacy
      Terms
`,
  },
  {
    key: 'journey-onboarding',
    label: 'Journey — onboarding',
    category: 'journey',
    code: `journey
  title New user onboarding
  section Sign up
    Visit landing: 5: User
    Click "Try free": 5: User
    Submit email: 4: User
    Verify email: 3: User
  section First session
    Pick template: 5: User
    Complete tour: 4: User
    Invite teammate: 3: User
`,
  },
  {
    key: 'gitgraph-feature',
    label: 'Git — feature branch',
    category: 'gitGraph',
    code: `gitGraph
  commit id: "init"
  commit id: "setup CI"
  branch feature/login
  commit id: "form"
  commit id: "tokens"
  checkout main
  commit id: "fix typo"
  merge feature/login
  commit id: "release"
`,
  },
  {
    key: 'timeline-startup',
    label: 'Timeline — startup year 1',
    category: 'timeline',
    code: `timeline
  title Startup year one
  Q1 : Idea : Customer interviews
  Q2 : MVP : Closed beta
  Q3 : Public launch : First 100 customers
  Q4 : Series Seed : Hire engineering
`,
  },
];
