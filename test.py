import re
from pygments import highlight
from pygments.lexers import PythonLexer
from pygments.formatters import TerminalFormatter

class Parser:
    """Base parser class."""
    def parse(self, expression):
        raise NotImplementedError("Subclasses should implement this method.")

class ArithmeticParser(Parser):
    """A parser for basic arithmetic expressions."""
    def parse(self, expression):
        pattern = re.compile(r'^[\d\s\+\-\*/\(\)]+$')  # Simple arithmetic regex
        if pattern.match(expression):
            return f"Valid expression: {expression}"
        return "Invalid expression!"

def highlight_code(code):
    """Highlights Python code using Pygments."""
    return highlight(code, PythonLexer(), TerminalFormatter())

if __name__ == "__main__":
    parser = ArithmeticParser()
    test_cases = [
        "2 + 2",
        "(3 * 4) - 5",
        "5 + x",  # Invalid case
        "10 / (2 + 3)"
    ]
    
    for expr in test_cases:
        print(highlight_code(f'Input: "{expr}"'))
        print(parser.parse(expr))
        print("-" * 40)
