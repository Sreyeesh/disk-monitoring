include .env
export

.PHONY: up down restart logs status clean open check help reload-grafana

# Check that docker-compose is available
check:
	@command -v docker-compose >/dev/null 2>&1 || { echo "❌ docker-compose is not installed."; exit 1; }

up: check ## Start all monitoring services
	docker-compose up -d
	@echo "✅ $(PROJECT_NAME) started."

down: ## Stop all monitoring services
	docker-compose down
	@echo "🛑 $(PROJECT_NAME) stopped."

restart: down up ## Restart the stack

logs: ## Tail logs for all services
	docker-compose logs -f

status: ## Show status of all monitoring containers
	docker ps --filter "name=prometheus" --filter "name=grafana" --filter "name=node-exporter"

clean: ## Tear down and remove volumes
	docker-compose down -v --remove-orphans
	@echo "🧹 Cleaned up containers and volumes."

open: ## Show service URLs
	@echo ""
	@echo "🌐 Monitoring Stack URLs"
	@echo "-------------------------"
	@echo "🔗 Grafana:        http://localhost:3000"
	@echo "🔗 Prometheus:     http://localhost:9090"
	@echo "🔗 Node Exporter:  http://localhost:9100/metrics"
	@echo ""

reload-grafana: ## Restart only Grafana
	docker-compose restart grafana

help: ## Show this help menu
	@echo ""
	@echo "📖 Makefile Commands for $(PROJECT_NAME)"
	@echo "----------------------------------------"
	@grep -E '^[a-zA-Z_-]+:.*?## ' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "🔹 %-18s %s\n", $$1, $$2}'
	@echo ""
