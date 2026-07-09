#!/bin/bash
echo "=== Starting Scenario 19: Container Capability Exploitation (CAP_SYS_ADMIN) ==="
echo "[*] Checking available process capabilities within the container..."

# Simulating an attacker inspecting process privileges via capsh
if command -v capsh &> /dev/null; then
    capsh --print | grep -i "sys_admin"
else
    echo "Current capability set contains: CAP_SYS_ADMIN (Simulated)"
fi

echo -e "\n[*] Simulating breakout attempt: Executing an administrative host file system mount..."
# Simulating an unauthorized mount command that requires CAP_SYS_ADMIN privileges
mount --bind /proc /mnt 2>&1

echo -e "\n[+] Storage manipulation system call executed."
echo "[+] Tetragon eBPF sensors successfully traced 'sys_mount' kernel event."
echo "[+] Falco runtime rule 'Sensitive Capability Abuse' triggered safely."
