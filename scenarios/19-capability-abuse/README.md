# Scenario 19 — Container Capability Exploitation (CAP_SYS_ADMIN)

**MITRE**: Privilege Escalation / Exploitation for Privilege Escalation (T1068)

## Attack
An attacker gains a foothold inside an application pod that has been misconfigured with dangerous Linux runtime privileges, specifically `CAP_SYS_ADMIN`. This excessive capability weakens container isolation boundaries drastically. The adversary leverages this privilege to execute administrative-level system tasks from inside the unprivileged namespace, such as executing arbitrary storage mount commands (`mount --bind /proc /mnt`) to expose the host node's underlying root partition and sensitive system configurations.

## Scenario flow

| Step | Layer | What happens |
| :--- | :--- | :--- |
| **1. Attack** | Adversary / Pod | The attacker compromises the container web application and runs `capsh --print` to list active process capabilities. |
| **2. Execution** | Host Kernel | Attacker issues direct system calls to mount raw infrastructure devices or host directories inside their isolated folder workspace. |
| **3. Detection** | Tetragon / Falco | Tetragon's eBPF sensors capture the raw `sys_mount` kernel execution layer event. Falco simultaneously flags the dangerous capability utilization. |
| **4. Response (current)** | Operator | Investigate the runtime capability violation; isolate the pod manually and trace execution logs for lateral host access signs. |
| **5. Response (target state)** | Kyverno Enforce | Kyverno admission controller blocks deployments containing unapproved entries inside the `securityContext.capabilities.add` array. |

## Run
```bash
./run.sh
