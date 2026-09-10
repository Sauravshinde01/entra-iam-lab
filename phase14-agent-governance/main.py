from fastapi import FastAPI, Header, HTTPException
import yaml
import json
from datetime import datetime, timezone

app = FastAPI(title="AccessDenied Sec Inventory Tool")

# Our pretend inventory "database"
inventory = ["Laptop", "Monitor", "Keyboard"]

# --- Load the policy-as-code file ---
def load_policy():
    with open("policy.yaml", "r") as file:
        return yaml.safe_load(file)

# --- Immutable audit logging: append one line per decision ---
def write_audit_log(agent_id: str, action: str, decision: str, reason: str):
    log_entry = {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "agent_id": agent_id,
        "action": action,
        "decision": decision,
        "reason": reason
    }
    # "a" = append mode: we only ever add lines, never overwrite
    with open("audit.log", "a") as log_file:
        log_file.write(json.dumps(log_entry) + "\n")

# --- The governance check: is this agent allowed to do this action? ---
def check_authorization(agent_id: str, action: str):
    policy = load_policy()   # re-read the policy on every call (enables immediate revocation)

    # Unknown agent - deny and log
    if agent_id not in policy["agents"]:
        write_audit_log(agent_id, action, "DENIED", "Unknown agent")
        raise HTTPException(status_code=403, detail=f"Unknown agent '{agent_id}' - access denied")

    agent_rules = policy["agents"][agent_id]

    # Action explicitly allowed - permit and log
    if action in agent_rules.get("allowed_actions", []):
        write_audit_log(agent_id, action, "ALLOWED", "Action permitted by policy")
        return True

    # Otherwise - deny and log
    write_audit_log(agent_id, action, "DENIED", "Action not in allowed_actions")
    raise HTTPException(status_code=403, detail=f"Agent '{agent_id}' is not allowed to perform '{action}'")

# Health check
@app.get("/")
def read_root():
    return {"status": "Tool endpoint is running"}

# TOOL ACTION 1: Read inventory - governed + logged
@app.get("/inventory")
def read_inventory(x_agent_id: str = Header(...)):
    check_authorization(x_agent_id, "read_inventory")
    return {"action": "read_inventory", "items": inventory}

# TOOL ACTION 2: Write inventory - governed + logged
@app.post("/inventory")
def write_inventory(item: str, x_agent_id: str = Header(...)):
    check_authorization(x_agent_id, "write_inventory")
    inventory.append(item)
    return {"action": "write_inventory", "added": item, "items": inventory}