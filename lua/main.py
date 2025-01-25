# Przykładowy kod z różnymi problemami do diagnostyki

# Błąd: zmienna niezdefiniowana
print(undeclared_variable)

# Ostrzeżenie: nieużywana zmienna
unused_variable = 42

# Błąd: brakujący dwukropek w definicji funkcji
def missing_colon()
    pass

# Błąd: brak importu
os.listdir(".")

# Ostrzeżenie: funkcja bez ciała
def empty_function():
    ...

# Błąd: nieprawidłowa składnia
if True
    print("Syntax Error")

# Ostrzeżenie: nieużywane importy
import math

# Ostrzeżenie: niezgodna konwencja nazw
MyVariable = 10

# Ostrzeżenie: zmiennej przypisano wartość, ale jej nie użyto
another_unused_variable = 100

# Problem: przekazanie zbyt wielu argumentów do funkcji
def example_function(a, b):
    return a + b

example_function(1, 2, 3)

