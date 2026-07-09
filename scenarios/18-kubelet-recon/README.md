# Scenario 18 — Kubelet API Unauthorized Reconnaissance

**MITRE**: Discovery / Endpoint Reconnaissance (T1526)

## Attack
Upon establishing a foothold inside a container, an attacker attempts lateral discovery by targeting node infrastructure management boundaries. The adversary maps network routes to the host node's loopback interface or local subnet gateway IP, looking specifically for the internal Kubelet API listening on ports `10250` (authenticated/HTTPS) or `10255` (unauthenticated/HTTP read-only). By querying endpoints like `/pods` or `/spec`, the attacker seeks to gather intelligence regarding active sister pods, internal pod execution variables, environment tokens, and namespace architectures to map the node's attack landscape.

## Scenario flow

| Step | Layer | What happens |
| :--- | :--- | :--- |
| **1. Attack** | Adversary / Pod | The attacker runs automated internal subnet discovery routines to determine the underlying host node gateway IP. |
| **2. Execution** | Network / Host | The container issues unauthenticated HTTPS requests targeting `https://<node-ip>:10250/pods` to scan for data leaks. |
| **3. Detection** | Tetragon / Falco | Tetragon monitors socket connectivity at the kernel layer, tracking process execution chains. Falco alerts on anomalous application connections to infrastructure endpoints. |
| **4. Response (current)** | Operator | Inspect Tetragon and Falco alerts; review Kubelet RBAC configurations and anonymizer variables to verify authentication states. |
| **5. Response (target state)** | SOAR Layer | SOAR pipeline coordinates with the CNI layer to dynamically inject a blocking egress network rule targeting node management ports from that pod namespace. |

## Run
```bash
./run.sh
