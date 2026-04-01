FROM golang:1.23-alpine AS build
RUN apk add --no-cache curl
RUN curl -fsSL https://raw.githubusercontent.com/kilnx-org/kilnx/main/install.sh | sh
COPY app.kilnx .
RUN kilnx build app.kilnx -o /app

FROM alpine:3.19
COPY --from=build /app /app
EXPOSE 8080
CMD ["/app"]
