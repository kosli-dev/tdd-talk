from coverage import Coverage


def post_worker_init(worker):
    #print(f"post_worker_init(): {worker.pid=}", flush=True)
    cov = Coverage.current()
    if cov:
        cov.start()


def worker_exit(server, worker):
    #print(f"worker_exit(): {server.pid=}, {worker.pid=}", flush=True)
    cov = Coverage.current()
    if cov:
        cov.stop()
        cov.save()  # pragma: no cover
