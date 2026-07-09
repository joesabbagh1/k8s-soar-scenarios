# Scenario 17 — Cloud Metadata Exfiltration

**MITRE**: Credential Access / Unauthenticated Endpoint Access (T1552)

## Attack
An attacker exploits an application-layer vulnerability (e.g., Server-Side Request Forgery - SSRF or remote code execution) to execute network commands inside a running pod. The adversary attempts to query the cloud provider instance metadata service (IMDSv1/IMDSv2) at the well-known link-local IP address `169.254.169.254`. If successful, the attacker can harvest temporary cloud provider access tokens, IAM role credentials, user-data startup scripts, and private cluster configuration metadata to launch a broader privilege escalation attack against the cloud provider subscription.

## Scenario flow

| Step | Layer | What happens |
| :--- | :--- | :--- |
| **1. Attack** | Adversary / Pod | A malicious curl or wget request targeting `http://169.254.169.254/latest/meta-data/` is executed from the web app container boundary. |
| **2. Block** | Cilium | A strict Cilium egress network policy matches the request path and drops all non-whitelisted packets heading to the link-local range. |
| **3. Detection** | Falco | Falco runtime rules flag the outbound socket creation targeting the metadata IP block originating from an internal namespace. |
| **4. Response (current)** | Cilium Enforce | The connection is immediately dropped or reset at the eBPF layer, resulting in a network timeout and protecting IAM tokens. |
| **5. Response (target state)** | SOAR Automated | The network policy drop triggers an automated playbook that quarantine-labels the pod and notifies security teams via webhook. |

## Run
```bash
./run.sh
