import json
import sys
from base64 import b64encode
from nacl import encoding, public

def encrypt(public_key: str, secret_value: str) -> str:
    """Encrypt a Unicode string using the public key."""
    public_key = public.PublicKey(public_key.encode("utf-8"), encoding.Base64Encoder())
    sealed_box = public.SealedBox(public_key)
    encrypted = sealed_box.encrypt(secret_value.encode("utf-8"))
    return b64encode(encrypted).decode("utf-8")

def main():
    input_data = sys.stdin.read().strip()
    data = json.loads(input_data)
    
    if 'public_key' not in data or 'value' not in data:
        print("JSON input must contain 'public_key' and 'value' fields", file=sys.stderr)
        sys.exit(1)

    public_key = data['public_key']
    secret_value = data['value']
    encrypted_value = encrypt(public_key, secret_value)
    
    # Output the encrypted value as JSON
    output = {'encrypted_value': encrypted_value}
    print(json.dumps(output))

if __name__ == "__main__":
    main()