# Kilnx Example: Chat

A Slack-style team chat built with [Kilnx](https://kilnx.dev) in a single `.kilnx` file. No JavaScript frameworks, no ORM, no package manager. One file, one binary.

## What it does

A team of 15 developers at a fictional company (XPTO Inc.) uses this chat to coordinate across projects. Channels like `#engineering`, `#project-atlas`, and `#random` contain real conversations about architecture decisions, deploy incidents, and variable naming debates.

## Features

- **Channels** with descriptions, favorites, and pinning
- **Threads** with reply counts
- **Direct messages** between users
- **Emoji reactions** on messages
- **Message editing** with (edited) indicator
- **File attachments** via multipart upload
- **Typing indicators** via WebSocket
- **Markdown** with @mentions and link unfurl
- **Search** across all channels
- **User profiles** with message stats
- **Rate limiting** (30 msgs/min, 5 channels/min)
- **Forgot password** with email or console fallback
- **Tailwind CSS** dark theme with Slack-style 3-column layout

## Run locally

```bash
# Install Kilnx
curl -fsSL https://raw.githubusercontent.com/kilnx-org/kilnx/main/install.sh | sh

# Clone and run
git clone https://github.com/kilnx-org/kilnx-example-chat.git
cd kilnx-example-chat
kilnx run app.kilnx

# Seed demo data (15 users, 8 channels, 70+ messages)
./seed.sh
```

Open http://localhost:8080 and log in with a demo account.

## Demo accounts

| Email | Password | Role |
|-------|----------|------|
| `alice@xpto.dev` | `demo123` | admin |
| `carol@xpto.dev` | `demo123` | member |

All 15 seeded users share the same password (`demo123`).

## License

[MIT](https://github.com/kilnx-org/kilnx/blob/main/LICENSE)
