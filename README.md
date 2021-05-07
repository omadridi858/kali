name: macOS
on: 
  workflow_dispatch:
defaults:
  run:
    shell: bash

jobs:
  build:
    runs-on: macos-latest
    steps:
    - uses: actions/checkout@v2
    - name: Setting the Environment Up.
      env:
        NGROK_AUTH_TOKEN: ${{ secrets.NGROK_AUTH_TOKEN }}
      run: source setup.sh "Alone215" "Alone215" "$NGROK_AUTH_TOKEN"
    - name: ngrok is now listening to VNC connections on...
      run: curl --silent http://127.0.0.1:4040/api/tunnels | jq '.tunnels[0].public_url'
    - name: Setup tmate Session
      uses: mxschmitt/action-tmate@v2
