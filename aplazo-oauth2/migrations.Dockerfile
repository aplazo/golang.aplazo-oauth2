FROM oryd/hydra:v2.3.0

ENV DSN=

CMD ["migrate", "sql", "up", "--yes", "--read-from-env"]
