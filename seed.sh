#!/bin/bash
# Seed script for Kilnx Chat demo
# Creates 15 dev users for XPTO Inc., channels, and conversations
#
# Demo accounts:
#   alice@xpto.dev / demo123
#   bob@xpto.dev   / demo123
#   (all 15 users share the same password: demo123)
#
# Usage: ./seed.sh [database.db]

set -e

DB="${1:-chat.db}"

if [ ! -f "$DB" ]; then
  echo "Database not found: $DB"
  echo "Start the app first: kilnx run app.kilnx"
  exit 1
fi

echo "Seeding $DB..."

# Users (hash is bcrypt of "demo123" cost 12)
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Alice Nakamura', 'alice@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'admin', '#6366f1');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Bob Ferreira', 'bob@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'admin', '#e64a19');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Carol Zhang', 'carol@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#2bac76');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('David Kim', 'david@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#0891b2');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Elena Popov', 'elena@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#7c3aed');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Frank Osei', 'frank@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#db2777');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Grace Liu', 'grace@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#ca8a04');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Hugo Santos', 'hugo@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#059669');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Iris Andersson', 'iris@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#dc2626');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Jake Patel', 'jake@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#4f46e5');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Kira Novak', 'kira@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#0d9488');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Leo Moreau', 'leo@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#c026d3');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Maya Reeves', 'maya@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#ea580c');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Nina Costa', 'nina@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#2563eb');"
sqlite3 "$DB" "INSERT OR IGNORE INTO user (name, email, password, role, avatar_color) VALUES ('Omar Diallo', 'omar@xpto.dev', '\$2a\$12\$FDH3HcKMgDk0uk8iHd5Z.OS.JrNck/4D7sDsuVx2u5310xUfsLtBe', 'member', '#65a30d');"

# Channels and messages (no bash interpolation needed)
sqlite3 "$DB" << 'SEED'

INSERT OR IGNORE INTO channel (name, description, creator_id) VALUES
  ('general', 'Company-wide announcements', 1),
  ('engineering', 'Backend, infra, architecture', 2),
  ('frontend', 'UI, components, CSS', 4),
  ('devops', 'Deploys, monitoring, incidents', 8),
  ('design', 'Product design and UX', 6),
  ('project-atlas', 'Atlas: new customer portal (Q2)', 1),
  ('project-beacon', 'Beacon: internal analytics platform', 3),
  ('random', 'Off-topic, memes, food', 5);

-- #general
INSERT INTO message (body, author_id, channel_id, created) VALUES
  ('Welcome to XPTO Inc. chat. Ground rules: be kind, use threads, no reply-all energy.', 1, 1, datetime('now', '-7 days')),
  ('Who broke the coffee machine on 3rd floor?', 2, 1, datetime('now', '-7 days', '+5 minutes')),
  ('Not me. I exclusively drink tea.', 3, 1, datetime('now', '-7 days', '+8 minutes')),
  ('All-hands Thursday at 3pm. Agenda going out today.', 1, 1, datetime('now', '-6 days')),
  ('Will it be recorded? Dentist appointment.', 7, 1, datetime('now', '-6 days', '+20 minutes')),
  ('Yes, recording in #general after.', 1, 1, datetime('now', '-6 days', '+25 minutes')),
  ('New hire starting Monday: Omar Diallo, backend team.', 1, 1, datetime('now', '-5 days')),
  ('Welcome Omar! Ping me if you need help with dev setup.', 8, 1, datetime('now', '-5 days', '+30 minutes')),
  ('Thanks. Already got my first PR rejected by the linter. Feeling right at home.', 15, 1, datetime('now', '-5 days', '+45 minutes')),
  ('That is the official onboarding experience.', 2, 1, datetime('now', '-5 days', '+50 minutes'));

-- #engineering
INSERT INTO message (body, author_id, channel_id, created) VALUES
  ('We need to rethink the migration strategy for Atlas. Current approach has no rollback.', 2, 2, datetime('now', '-6 days')),
  ('What exactly is risky? Comparison-based migrations have worked fine so far.', 4, 2, datetime('now', '-6 days', '+10 minutes')),
  ('If a migration corrupts data, we are stuck. I want versioned migrations with dry-run.', 2, 2, datetime('now', '-6 days', '+15 minutes')),
  ('v0.1.1 just shipped --dry-run and --status flags. Have you tried them?', 3, 2, datetime('now', '-6 days', '+20 minutes')),
  ('Just tested. kilnx migrate --dry-run shows the SQL without executing. Solves 80% of the problem.', 2, 2, datetime('now', '-6 days', '+30 minutes')),
  ('Still no rollback. We should snapshot the DB before migrating in CI.', 8, 2, datetime('now', '-6 days', '+35 minutes')),
  ('Agreed. Adding cp app.db app.db.bak to the deploy pipeline.', 2, 2, datetime('now', '-6 days', '+40 minutes')),
  ('The fetch keyword landed. We can call external APIs server-side now. No more proxy hacks for Stripe.', 3, 2, datetime('now', '-4 days')),
  ('What does the syntax look like?', 10, 2, datetime('now', '-4 days', '+5 minutes')),
  ('fetch payment: POST https://api.stripe.com/charges with header and body blocks. Clean and declarative.', 3, 2, datetime('now', '-4 days', '+8 minutes')),
  ('How does error handling work?', 10, 2, datetime('now', '-4 days', '+12 minutes')),
  ('Fails silently for now. Template field stays empty. We need on error blocks. Filed an issue.', 3, 2, datetime('now', '-4 days', '+15 minutes')),
  ('Anyone benchmarked WebSocket performance? Planning real-time for Beacon.', 15, 2, datetime('now', '-3 days')),
  ('500 concurrent connections on a $5 VPS. Held fine. Goroutine-per-connection scales well for us.', 8, 2, datetime('now', '-3 days', '+20 minutes')),
  ('500 is modest. What about 5000?', 15, 2, datetime('now', '-3 days', '+25 minutes')),
  ('At that point you want a message broker. Kilnx WebSockets are for app-level real-time, not infra-level pub/sub.', 2, 2, datetime('now', '-3 days', '+30 minutes'));

-- #frontend
INSERT INTO message (body, author_id, channel_id, created) VALUES
  ('The Tailwind class strings in the chat layout are getting absurd. 200+ chars on a single element.', 4, 3, datetime('now', '-5 days')),
  ('Welcome to utility-first CSS.', 6, 3, datetime('now', '-5 days', '+10 minutes')),
  ('I know the tradeoff. But it buries the Kilnx logic in HTML noise.', 4, 3, datetime('now', '-5 days', '+15 minutes')),
  ('Extract common patterns into the layout. Keep pages minimal. Layout already supports queries.', 3, 3, datetime('now', '-5 days', '+20 minutes')),
  ('Right. Sidebar, topbar, footer in the layout. Pages are just content.', 4, 3, datetime('now', '-5 days', '+25 minutes')),
  ('The markdown filter works for basic stuff. Bold, code, links render correctly. Nested lists break.', 11, 3, datetime('now', '-3 days')),
  ('Known limitation. The implementation covers the 80% case. No tables or nested structures.', 3, 3, datetime('now', '-3 days', '+10 minutes')),
  ('The unfurl filter is nice though. Paste a GitHub link, OG card shows automatically.', 6, 3, datetime('now', '-3 days', '+15 minutes'));

-- #devops
INSERT INTO message (body, author_id, channel_id, created) VALUES
  ('Deploy pipeline green. v0.1.2 in production. Zero downtime.', 8, 4, datetime('now', '-4 days')),
  ('Single binary deploy is beautiful. scp and done. No Docker needed for staging.', 10, 4, datetime('now', '-4 days', '+5 minutes')),
  ('Still using Docker for prod. The Dockerfile is 8 lines. Hard to beat that.', 8, 4, datetime('now', '-4 days', '+10 minutes')),
  ('Where do slow query logs go on Railway?', 9, 4, datetime('now', '-3 days')),
  ('Railway captures stdout. Set KILNX_LOG_SLOW_QUERY_MS=100 for anything over 100ms.', 8, 4, datetime('now', '-3 days', '+15 minutes')),
  ('Incident last night. WAL file grew to 2GB. A schedule job was inserting without checkpointing.', 8, 4, datetime('now', '-2 days')),
  ('Fix: added PRAGMA wal_checkpoint to the cleanup schedule. Should Kilnx auto-checkpoint?', 8, 4, datetime('now', '-2 days', '+5 minutes')),
  ('Filed an issue. Auto-checkpoint should be in the runtime.', 2, 4, datetime('now', '-2 days', '+10 minutes'));

-- #project-atlas
INSERT INTO message (body, author_id, channel_id, created) VALUES
  ('Atlas kickoff. Replace legacy customer portal by end of Q2. Stack: Kilnx + htmx.', 1, 6, datetime('now', '-7 days')),
  ('Requirements: customer dashboard, invoice history, support tickets, SSO.', 1, 6, datetime('now', '-7 days', '+5 minutes')),
  ('SSO is the hard part. Kilnx auth is password-only. OIDC needs runtime work.', 2, 6, datetime('now', '-7 days', '+15 minutes')),
  ('Can we use fetch to validate tokens against the identity provider?', 3, 6, datetime('now', '-7 days', '+20 minutes')),
  ('Possible but hacky. OIDC needs redirect flows, token refresh, JWKS. Runtime-level.', 2, 6, datetime('now', '-7 days', '+25 minutes')),
  ('MVP: password auth + invite-only. SSO in phase 2.', 1, 6, datetime('now', '-7 days', '+30 minutes')),
  ('Works for me. Sketching the data model today.', 4, 6, datetime('now', '-7 days', '+35 minutes')),
  ('Data model: Customer, User (belongs to Customer), Invoice, Ticket. PR is up.', 4, 6, datetime('now', '-6 days')),
  ('Reviewed and approved. Clean schema. Dashboard page next.', 1, 6, datetime('now', '-6 days', '+45 minutes')),
  ('Dashboard live on staging. Invoice totals, open tickets, recent activity. 45 lines of Kilnx.', 4, 6, datetime('now', '-4 days')),
  ('45 lines for a full dashboard with auth. I love this language.', 7, 6, datetime('now', '-4 days', '+10 minutes'));

-- #project-beacon
INSERT INTO message (body, author_id, channel_id, created) VALUES
  ('Beacon spec: internal analytics. Page views, API latency, error rates. Real-time via SSE.', 3, 7, datetime('now', '-5 days')),
  ('Plan: stream /metrics polling every 5s, frontend renders with Chart.js.', 3, 7, datetime('now', '-5 days', '+10 minutes')),
  ('Which chart lib? Please not D3.', 4, 7, datetime('now', '-5 days', '+15 minutes')),
  ('Chart.js. 60KB, good enough.', 3, 7, datetime('now', '-5 days', '+20 minutes')),
  ('Webhook ingestion ready. /hooks/events with HMAC verification.', 15, 7, datetime('now', '-3 days')),
  ('Query performance with thousands of events per hour?', 2, 7, datetime('now', '-3 days', '+15 minutes')),
  ('SQLite + WAL handles it. Aggregates run in under 10ms.', 15, 7, datetime('now', '-3 days', '+20 minutes')),
  ('Add a cleanup schedule. Delete events older than 90 days.', 8, 7, datetime('now', '-3 days', '+25 minutes')),
  ('Done. schedule cleanup every 24h with a DELETE query. Three lines.', 15, 7, datetime('now', '-3 days', '+30 minutes'));

-- #random
INSERT INTO message (body, author_id, channel_id, created) VALUES
  ('Best lunch spot near the office?', 5, 8, datetime('now', '-6 days')),
  ('Kome Sushi on 5th. Bento box is solid.', 7, 8, datetime('now', '-6 days', '+10 minutes')),
  ('Taco truck on Market. Cash only but worth it.', 9, 8, datetime('now', '-6 days', '+15 minutes')),
  ('Anyone tried the new standing desks?', 11, 8, datetime('now', '-4 days')),
  ('Got one last month. Week to adjust, worth it. Ask facilities.', 12, 8, datetime('now', '-4 days', '+20 minutes')),
  ('Friday fun: worst variable name in production?', 13, 8, datetime('now', '-2 days')),
  ('data2_final_REAL_v3', 4, 8, datetime('now', '-2 days', '+5 minutes')),
  ('temp. In the codebase since 2019.', 8, 8, datetime('now', '-2 days', '+8 minutes')),
  ('doStuff. The function was 400 lines.', 15, 8, datetime('now', '-2 days', '+12 minutes')),
  ('I found a comment: TODO fix this before release. Dated 2017. Product live for 4 years.', 2, 8, datetime('now', '-2 days', '+15 minutes'));

-- Threads
INSERT INTO message (body, author_id, channel_id, reply_to, created) VALUES
  ('Snapshot before migrate is smart. Also test against prod data copy in CI.', 3, 2, (SELECT id FROM message WHERE body LIKE '%snapshot the DB%' LIMIT 1), datetime('now', '-6 days', '+45 minutes')),
  ('Setting up a nightly job for that. Sanitized prod dump + migration run.', 8, 2, (SELECT id FROM message WHERE body LIKE '%snapshot the DB%' LIMIT 1), datetime('now', '-6 days', '+50 minutes')),
  ('Can we get it in Docker Compose for local testing too?', 10, 2, (SELECT id FROM message WHERE body LIKE '%snapshot the DB%' LIMIT 1), datetime('now', '-6 days', '+55 minutes')),
  ('Phase 2 SSO makes sense. No point blocking MVP.', 2, 6, (SELECT id FROM message WHERE body LIKE '%invite-only. SSO in phase 2%' LIMIT 1), datetime('now', '-7 days', '+40 minutes')),
  ('Ship the core, add SSO when customers ask.', 7, 6, (SELECT id FROM message WHERE body LIKE '%invite-only. SSO in phase 2%' LIMIT 1), datetime('now', '-7 days', '+50 minutes'));

-- Reactions
INSERT INTO reaction (emoji, author_id, message_id) VALUES
  ('👍', 3, 1), ('🔥', 5, 1),
  ('👍', 1, 9), ('🔥', 4, 9), ('❤️', 7, 9),
  ('👍', 2, (SELECT id FROM message WHERE body LIKE '%45 lines for%' LIMIT 1)),
  ('🔥', 3, (SELECT id FROM message WHERE body LIKE '%45 lines for%' LIMIT 1)),
  ('👍', 1, (SELECT id FROM message WHERE body LIKE '%Three lines%' LIMIT 1)),
  ('👍', 5, (SELECT id FROM message WHERE body LIKE '%doStuff%' LIMIT 1)),
  ('🔥', 9, (SELECT id FROM message WHERE body LIKE '%doStuff%' LIMIT 1)),
  ('❤️', 11, (SELECT id FROM message WHERE body LIKE '%TODO fix this%' LIMIT 1)),
  ('🔥', 13, (SELECT id FROM message WHERE body LIKE '%TODO fix this%' LIMIT 1));

-- Favorites
INSERT INTO favorite (user_id, channel_id) VALUES (1, 6), (1, 1), (2, 2), (2, 6), (3, 7), (3, 2), (4, 3), (4, 6);

-- DMs
INSERT INTO direct_message (body, sender_id, recipient_id, created) VALUES
  ('Can you review the Atlas data model PR?', 4, 2, datetime('now', '-6 days', '+15 minutes')),
  ('Looking at it. Add a due_date timestamp to Invoice. Otherwise we cannot sort by upcoming payments.', 2, 4, datetime('now', '-6 days', '+25 minutes')),
  ('Good catch. Adding now.', 4, 2, datetime('now', '-6 days', '+28 minutes')),
  ('Welcome to the team! Ask me anything about the codebase.', 2, 15, datetime('now', '-5 days', '+35 minutes')),
  ('Thanks Bob. Quick question: why do some queries use :current_user.id and others :current_user_id?', 15, 2, datetime('now', '-5 days', '+40 minutes')),
  ('Same thing. Dot notation is newer and more consistent. Use dot going forward.', 2, 15, datetime('now', '-5 days', '+45 minutes')),
  ('The fetch keyword is amazing. Used it for the Beacon monitoring API. Three lines.', 15, 2, datetime('now', '-4 days')),
  ('Q2 deadline for Atlas is tight. Cut support tickets, ship in fast-follow?', 2, 1, datetime('now', '-3 days')),
  ('Let me check with CS. If they can wait 2 weeks, yes.', 1, 2, datetime('now', '-3 days', '+30 minutes')),
  ('CS is fine with it. Core portal with invoices is the priority.', 1, 2, datetime('now', '-3 days', '+120 minutes')),
  ('Perfect. Updating roadmap and letting the team know.', 2, 1, datetime('now', '-3 days', '+125 minutes'));

-- Pins
UPDATE message SET pinned = 1 WHERE body LIKE 'Atlas kickoff%';
UPDATE message SET pinned = 1 WHERE body LIKE 'Beacon spec%';
UPDATE message SET pinned = 1 WHERE body LIKE 'Deploy pipeline green%';

SEED

echo ""
echo "Done. Seeded:"
echo "  $(sqlite3 "$DB" 'SELECT COUNT(*) FROM user') users"
echo "  $(sqlite3 "$DB" 'SELECT COUNT(*) FROM channel') channels"
echo "  $(sqlite3 "$DB" 'SELECT COUNT(*) FROM message WHERE reply_to = 0') messages"
echo "  $(sqlite3 "$DB" 'SELECT COUNT(*) FROM message WHERE reply_to != 0') thread replies"
echo "  $(sqlite3 "$DB" 'SELECT COUNT(*) FROM reaction') reactions"
echo "  $(sqlite3 "$DB" 'SELECT COUNT(*) FROM direct_message') DMs"
echo ""
echo "Demo accounts (all share password: demo123):"
echo "  alice@xpto.dev  (admin)"
echo "  bob@xpto.dev    (admin)"
echo "  carol@xpto.dev  carol@xpto.dev  david@xpto.dev  elena@xpto.dev"
echo "  frank@xpto.dev  grace@xpto.dev  hugo@xpto.dev   iris@xpto.dev"
echo "  jake@xpto.dev   kira@xpto.dev   leo@xpto.dev    maya@xpto.dev"
echo "  nina@xpto.dev   omar@xpto.dev"
