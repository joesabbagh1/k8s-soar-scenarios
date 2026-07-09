# Scenario 13 — File and Directory Discovery

**MITRE:** T1083 — File and Directory Discovery

## Attack

After compromising a Kubernetes container, an attacker explores the file system to understand the environment and identify important directories. This reconnaissance helps locate configuration files, application data, and other resources that may be useful for later stages of an attack.

## Scenario flow

| Step | Layer | What happens |
|------|-------|--------------|
| 1. **Attack** | Adversary | A pod named **`scenario-13-file-discovery`** is deployed in the **`security-lab`** namespace. |
| 2. **Discovery** | Container | The pod lists common directories such as `/`, `/etc`, `/var`, and `/tmp` to understand the file system structure. |
| 3. **Detection** | Runtime Security | Runtime security tools can detect directory enumeration and suspicious file access inside the container. |
| 4. **Response (manual demo)** | Operator / SOAR | Review the pod logs, investigate the activity, and isolate or remove the suspicious workload if necessary. |

This scenario demonstrates the discovery phase of a Kubernetes attack. The information collected can help an attacker understand the container environment before attempting additional actions.

## Run

```bash
./run.sh
```

## Expected evidence

| Tool | Expected |
|------|----------|
| Kubernetes | Pod `scenario-13-file-discovery` is created successfully |
| Pod Logs | Lists the contents of `/`, `/etc`, `/var`, and `/tmp` |
| Runtime Security (optional) | Alerts for directory enumeration activity |
| SOAR | Manual investigation and containment demonstration |

## Manual investigation

```bash
kubectl logs -n security-lab scenario-13-file-discovery
```

```bash
kubectl exec -it -n security-lab scenario-13-file-discovery -- sh
```

```bash
kubectl describe pod -n security-lab scenario-13-file-discovery
```

## Capture

```bash
kubectl get pod -n security-lab scenario-13-file-discovery -o wide
```

```bash
kubectl logs -n security-lab scenario-13-file-discovery
```

```bash
kubectl describe pod -n security-lab scenario-13-file-discovery
```