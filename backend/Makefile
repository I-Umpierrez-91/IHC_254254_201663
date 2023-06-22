migrate-latest:
	docker exec obligatorio--backend npx knex migrate:latest

create-certificate:
	openssl genrsa 2048 > private_key.pem
	openssl req -new -key private_key.pem -out csr.pem
	openssl x509 -req -days 365 -in csr.pem -signkey private_key.pem -out public.crt

upload-certificate:
	aws acm import-certificate --certificate fileb://public.crt --private-key fileb://private_key.pem --region us-east-1
