#!/usr/bin/env bash
# check_secure_input.sh — Diagnose which app has macOS Secure Input enabled.
# Secure Input prevents Logitech Options/Options+ (and other input-monitoring
# tools) from working. Usually the culprit is a browser or terminal that
# grabbed Secure Input for a password field and never released it.
#
# Reference: https://support.logi.com/hc/en-us/articles/360023189334

set -euo pipefail

verify_secure_input() {
    echo
    echo "Verifying Secure Input status..."
    sleep 2

    local recheck
    recheck=$(ioreg -l -d 1 -w 0 | grep -i SecureInput || true)
    local recheck_pid
    recheck_pid=$(echo "$recheck" | grep -oE 'kCGSSessionSecureInputPID"?=\s*[0-9]+' | grep -oE '[0-9]+' || true)

    # Clear if no PID, PID is 0, or the PID is stale (process no longer running)
    if [[ -z "$recheck_pid" ]] || [[ "$recheck_pid" == "0" ]] || ! ps -p "$recheck_pid" > /dev/null 2>&1; then
        echo "Secure Input is no longer active. You're all clear!"
    else
        local recheck_name
        recheck_name=$(ps -p "$recheck_pid" -o comm= 2>/dev/null || echo "(unknown)")
        echo "WARNING: Secure Input is still active!"
        echo "  PID: $recheck_pid"
        echo "  Process: $recheck_name"
        echo "  You may need to deal with this process as well."
    fi
}

secure_line=$(ioreg -l -d 1 -w 0 | grep -i SecureInput || true)

if [[ -z "$secure_line" ]]; then
    echo "Secure Input is NOT active. Nothing to worry about."
    exit 0
fi

pid=$(echo "$secure_line" | grep -oE 'kCGSSessionSecureInputPID"?=\s*[0-9]+' | grep -oE '[0-9]+' || true)

if [[ -z "$pid" ]] || [[ "$pid" == "0" ]]; then
    echo "Secure Input is NOT active. Nothing to worry about."
    exit 0
fi

# The ioreg entry can linger with a stale PID after the process exits
if ! ps -p "$pid" > /dev/null 2>&1; then
    echo "Secure Input is NOT active (stale PID $pid in ioreg, process no longer running)."
    exit 0
fi

echo "Secure Input is active."
echo "Raw ioreg output:"
echo "  $secure_line"
echo
echo "PID holding Secure Input: $pid"

# Resolve the PID to a process name and full path
if ps -p "$pid" > /dev/null 2>&1; then
    proc_name=$(ps -p "$pid" -o comm= 2>/dev/null || echo "(unknown)")
    proc_args=$(ps -p "$pid" -o args= 2>/dev/null || echo "(unknown)")
    echo "Process name: $proc_name"
    echo "Full command: $proc_args"

    # On macOS, try to get the .app bundle name for GUI apps
    is_gui_app=false
    bundle=""
    if [[ "$proc_name" == *".app/"* ]]; then
        bundle=$(echo "$proc_name" | sed 's|\.app/.*|.app|')
        is_gui_app=true
        echo "Application:  $bundle"
    fi

    echo
    echo "What would you like to do?"
    echo "  [t] Terminate the process"
    echo "  [r] Restart the process (terminate, then relaunch with same arguments)"
    echo "  [n] Do nothing"
    echo
    read -rp "Choice [t/r/n]: " choice

    case "$choice" in
        t|T)
            echo "Terminating PID $pid..."
            if $is_gui_app; then
                # Use osascript for a graceful quit of GUI apps
                app_name=$(basename "$bundle" .app)
                osascript -e "tell application \"$app_name\" to quit" 2>/dev/null || kill "$pid"
            else
                kill "$pid"
            fi

            # Wait briefly for the process to exit
            for i in $(seq 1 10); do
                if ! ps -p "$pid" > /dev/null 2>&1; then
                    break
                fi
                sleep 0.5
            done

            if ps -p "$pid" > /dev/null 2>&1; then
                echo "Process didn't exit gracefully. Force killing..."
                kill -9 "$pid"
            fi
            echo "Done."
            verify_secure_input
            ;;
        r|R)
            echo "Restarting..."

            # Capture the full command line before killing
            saved_args="$proc_args"

            # Terminate
            if $is_gui_app; then
                app_name=$(basename "$bundle" .app)
                osascript -e "tell application \"$app_name\" to quit" 2>/dev/null || kill "$pid"
            else
                kill "$pid"
            fi

            for i in $(seq 1 10); do
                if ! ps -p "$pid" > /dev/null 2>&1; then
                    break
                fi
                sleep 0.5
            done

            if ps -p "$pid" > /dev/null 2>&1; then
                echo "Process didn't exit gracefully. Force killing..."
                kill -9 "$pid"
                sleep 1
            fi

            # Relaunch
            if $is_gui_app; then
                echo "Reopening $bundle ..."
                open "$bundle"
            else
                echo "Relaunching: $saved_args"
                nohup $saved_args > /dev/null 2>&1 &
                disown
            fi
            echo "Done. New PID: $(pgrep -f "$proc_name" | head -1 || echo '(pending)')"
            verify_secure_input
            ;;
        n|N|"")
            echo "No action taken."
            ;;
        *)
            echo "Unrecognized choice. No action taken."
            ;;
    esac
else
    echo "PID $pid is no longer running — Secure Input may have been released."
    echo "Re-run this script to confirm."
fi
