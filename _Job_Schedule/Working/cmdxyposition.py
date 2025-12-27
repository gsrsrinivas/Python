import subprocess

import win32gui
import win32process

from _Common_Functions.base_functions import *

processes = []
title = "test_cmd_window"
script = r"C:\Users\gsrsr\Documents\PythonProject\YahooFinance\stock_thumb_nails_All.py"  # Replace with your actual script path
# Launch your cmd/python
cmd = f'start /wait {title} cmd /c "python {script}"'
proc = subprocess.Popen(cmd, shell=True)
processes.append(proc)

# Get PID of the created console process
# (Popen.pid is the shell's PID when shell=True, so get child PID)
time.sleep(0.5)  # small delay
parent_pid = proc.pid

def find_child_console_hwnd(parent_pid):
    hwnds = []

    def enum_proc(hwnd, _):
        _, pid = win32process.GetWindowThreadProcessId(hwnd)
        if pid == parent_pid and win32gui.IsWindowVisible(hwnd):
            hwnds.append(hwnd)
    win32gui.EnumWindows(enum_proc, None)
    return hwnds[0] if hwnds else None

hwnd = None
for _ in range(50):
    hwnd = find_child_console_hwnd(parent_pid)
    if hwnd:
        break
    time.sleep(0.1)

if hwnd:
    x, y, w, h = 100, 200, 800, 400  # your desired x, y, width, height
    win32gui.MoveWindow(hwnd, x, y, w, h, True)

for proc in processes:
    if proc.poll() is None:  # The Process is still running
        proc.wait()
