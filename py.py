import os
from datetime import datetime

def main():
    # Zwraca nazwę bieżącego katalogu
    current_dir = os.getcwd()

    # Formatuje datę
    current_time = datetime.now()
    print(f"Current directory: {current_dir}")
    print(f"Current time: {current_time.strftime('%Y-%m-%d %H:%M:%S')}")

if __name__ == "__main__":
    main()
