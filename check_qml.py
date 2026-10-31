with open('app/ui/Main.qml', 'r') as f:
    content = f.read()

# Check for common issues
issues = [
    ('import QtQuick', 'import QtQuick' in content),
    ('import QtQuick.Window', 'import QtQuick.Window' in content),
    ('Window {', 'Window {' in content),
    ('FramelessWindowHint', 'FramelessWindowHint' in content),
    ('WindowStaysOnTopHint', 'WindowStaysOnTopHint' in content),
    ('transparent color', 'color: "transparent"' in content),
]

for name, found in issues:
    print(f'{name}: {"Found" if found else "NOT FOUND"}')

# Check balance
lines = content.split('\n')
balance = 0
for i, line in enumerate(lines, 1):
    for ch in line:
        if ch == '{':
            balance += 1
        elif ch == '}':
            balance -= 1
print(f'Brace balance: {balance}')
print(f'Total lines: {len(lines)}')
"