import os
import sys

def test_groq():
    try:
        from groq import Groq
    except ImportError:
        print("Groq library is not installed.")
        return

    # Check env var
    env_key = os.environ.get("GROQ_API_KEY")
    default_key = "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"
    
    print(f"GROQ_API_KEY from environment: {env_key}")
    print(f"Default fallback key: {default_key}")
    
    key_to_use = env_key if env_key else default_key
    print(f"Using API Key: {key_to_use[:12]}...{key_to_use[-4:] if key_to_use else ''}")
    
    if not key_to_use or len(key_to_use) < 10:
        print("API Key is empty or too short!")
        return

    try:
        print("Attempting to connect to Groq and generate a chat completion...")
        client = Groq(api_key=key_to_use, timeout=10.0)
        completion = client.chat.completions.create(
            model="llama-3.1-8b-instant",
            messages=[
                {"role": "user", "content": "Hi, reply with exactly the word 'SUCCESS' if you read this."}
            ],
            temperature=0.1,
            max_tokens=10
        )
        response = completion.choices[0].message.content.strip()
        print(f"Response from Groq: {response}")
        if "SUCCESS" in response.upper():
            print("\n>>> SUCCESS: The Groq API key is valid and working! <<<")
        else:
            print(f"\n>>> WARNING: Response did not contain SUCCESS. Response: {response} <<<")
    except Exception as e:
        print(f"\n>>> ERROR: Groq request failed! Details: {e} <<<")

if __name__ == "__main__":
    test_groq()
