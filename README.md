
Repo to illustrate TDD topics for future talks/blogs

o) gathering coverage stats from the server's container
   when system tests are being run from a different container
   without having to `docker-compose up ...' each time.
   ```
   docker exec ... "pkill SIGHUP -o gunicorn"
   ```

o) doing so without killing the server container

o) gathering coverage stats for code and for tests

o) using tests named with a GUID

o) contract/characterisation testing with decorators

o) running the server in a read-only container

o) runner the server as a non root user

```
$ source ./scripts/shortcuts.sh

$ tid  # generate a test id

$ rut          # run all unit tests in new xy server
$ rut a2189600 # run only unit test_a2189600 in new xy server

$ rst          # run all system tests in new xy server
$ rst 04692400 # run only system test_04692400 in new xy server

$ eut          # run all unit tests in existing xy server
$ eut a2189600 # run only unit test a2189600 in existing xy server

$ est          # run all system tests in restarted xy server
$ est 04692400 # run only system test 04692400 in restarted xy server

$ demo # run a demo server 
$ hup  # restart the demo server
```
