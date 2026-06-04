FROM oryd/hydra:v26.2.0

ENV DSN=

CMD ["migrate", "sql", "up", "--yes", "--read-from-env"]
