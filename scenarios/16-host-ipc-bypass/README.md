# Scenario 16 — Host IPC Namespace Bypass

**MITRE**: Privilege Escalation / Container Breakout (T1611)

## Attack
An attacker compromises a container configured with `hostIPC: true` in its pod specification. This misconfiguration allows the container to break out of standard IPC isolation and access the host's Inter-Process Communication (IPC) namespace mechanisms. The adversary leverages this shared surface to inspect, monitor, or inject data directly into host-level shared memory segments (POSIX/System V `shm`), message queues, and semaphores. This can be exploited to sniff sensitive data from adjacent host processes or execute local cross-process communication manipulation.

## Scenario flow

| Step | Layer | What happens |
| :--- | :--- | :--- |
| **1. Attack** | Adversary / Pod | The attacker gains an interactive shell inside the container and checks `/proc/1/ns/ipc` to verify namespace mapping identity with the underlying node. |
| **2. Execution** | Host OS | The attacker runs the binary utility `ipcs -m` or maps custom memory bindings to scan active shared memory segments used by system processes. |
| **3. Detection** | Tetragon / Falco | Tetragon traces the underlying `shmat`, `shmget`, and `shmdt` kernel system calls via eBPF. Concurrently, Falco triggers a high-severity alert for unauthorized host namespace access behavior. |
| **4. Response (current)** | Operator | Review eBPF syscall telemetry from the node; manually terminate the offending pod and isolate container processes. |
| **5. Response (target state)** | Kyverno Enforce | Kyverno admission controllers intercept incoming manifests and reject any pod requiring `hostIPC: true` prior to schedule allocation. |

## Run
```bash
./run.sh
