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
kilnx run app.kilnx
```

## Seed demo data

Populates 15 users, 8 channels, 70+ messages, threads, reactions, and DMs:

```bash
./seed.sh
```

## Demo accounts

| Email | Password | Role |
|-------|----------|------|
| `alice@xpto.dev` | `demo123` | admin |
| `carol@xpto.dev` | `demo123` | member |

All 15 seeded users share the same password (`demo123`).

## Deploy

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/template/kilnx-chat)

## License

[MIT](https://github.com/kilnx-org/kilnx/blob/main/LICENSE)
