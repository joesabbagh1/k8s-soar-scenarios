# Scenario 16 — Host IPC Namespace Bypass

**MITRE**: Privilege Escalation / Exploitation for Privilege Escalation (T1611)

## Attack
An attacker gains a foothold inside a container that has been misconfigured with `hostIPC: true`. This misconfiguration breaks container isolation, allowing the adversary to interact directly with the host node's Inter-Process Communication (IPC) mechanisms, such as shared memory segments and message queues.

## Scenario flow

| Step | Layer | What happens |
| :--- | :--- | :--- |
| **1. Attack** | Adversary / Pod | The attacker exploits the application, gains shell access, and probes the host IPC namespace. |
| **2. Execution** | Host Kernel | Attacker attempts to read or write to shared host memory segments to steal sensitive process data. |
| **3. Detection** | Tetragon / Falco | Tetragon's eBPF probes intercept the `shmat` or `shmget` system calls. |
| **4. Response (current)** | Operator | Alerts are logged; however, manual intervention is required to isolate the rogue process. |
| **5. Response (target)** | SOAR Pipeline | Falco/Tetragon triggers an automated Argo workflow to cordon the node and capture volatile memory using CRIU. |

## Run
```bash
./run.sh
