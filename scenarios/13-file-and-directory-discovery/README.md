# Scenario 12 — File and Directory Discovery

**MITRE:** T1083 — File and Directory Discovery

## Attack

After compromising a Kubernetes container, an attacker explores the file system to identify important directories and configuration files. This information can help the attacker understand the environment and prepare for later stages of an attack.

## Scenario flow

| Step | Layer | What happens |
|------|-------|--------------|
| 1. **Attack** | Adversary | Deploy a pod in the **`security-lab`** namespace. |
| 2. **Discovery** | Container | List common system directories such as `/`, `/etc`, `/var`, and `/tmp`. |
| 3. **Detection** | Runtime Security | File enumeration activity can be monitored by runtime security tools. |
| 4. **Response** | Operator / SOAR | Investigate the pod, review logs, and remove or isolate suspicious workloads. |

## Run

```bash
./run.sh
```

## Expected evidence

| Tool | Expected |
|------|----------|
| Kubernetes | Pod `scenario-12-file-discovery` is created |
| Pod Logs | Directory listings are displayed |
| Runtime Security | File enumeration activity may be detected |
| SOAR | Manual investigation and response |