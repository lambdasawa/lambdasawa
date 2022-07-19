.PHONY: healthcheck
healthcheck:
	env PGPASSWORD=password psql -h 127.0.0.1 -p 5432 -U postgres -c 'select 1'
