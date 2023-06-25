set_environments:
	@echo '->> START - set_environments'
	cp ./environments/backend/.env ./backend
	cp ./environments/frontend/.env ./invenflow_app
	@echo '->> END - set_environments'

docker_compose_up:
	@echo '->> START - docker_compose_up'
	cd backend && docker compose up -d --build
	@echo '->> Waiting 1 minute to to be sure that all services are running'
	@sleep 120
	@echo '->> END - docker_compose_up'

execute_migrations:
	@echo '->> START - execute_migrations'
	cd ./backend && docker exec obligatorio--api-gateway npx knex migrate:latest
	@sleep 30
	@echo '->> END - execute_migrations'

setup_and_run_backend: docker_compose_up execute_migrations 

setup_and_run_frontend:
	@echo '->> START - setup_and_run_frontend'
	cd ./invenflow_app && flutter pub get && flutter run
	@echo '->> END - setup_and_run_frontend'

setup_and_run: set_environments setup_and_run_backend setup_and_run_frontend