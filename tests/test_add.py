import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PROGRAM = ROOT / "build" / "add"


class AddProgramTests(unittest.TestCase):
    def run_program(self, input_text):
        return subprocess.run(
            [PROGRAM],
            input=input_text,
            text=True,
            capture_output=True,
            check=False,
        )

    def test_adds_positive_numbers(self):
        result = self.run_program("12 30\n")
        self.assertEqual(result.returncode, 0)
        self.assertEqual(result.stdout, "42\n")

    def test_adds_negative_and_positive_numbers(self):
        result = self.run_program("-9 4\n")
        self.assertEqual(result.returncode, 0)
        self.assertEqual(result.stdout, "-5\n")

    def test_accepts_signed_64_bit_boundary(self):
        result = self.run_program("9223372036854775807 0\n")
        self.assertEqual(result.returncode, 0)
        self.assertEqual(result.stdout, "9223372036854775807\n")

    def test_rejects_invalid_input(self):
        result = self.run_program("12 text\n")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("introdu doua numere intregi", result.stdout)

    def test_rejects_signed_overflow(self):
        result = self.run_program("9223372036854775807 1\n")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("depaseste intervalul", result.stdout)


if __name__ == "__main__":
    unittest.main()
