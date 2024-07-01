# Function to start the Ollama server
function Start-OllamaServer {
    param (
        [int]$Port = 4444
    )

    $env:OLLAMA_HOST = "localhost:$Port"

    Start-Job -ScriptBlock { & /usr/local/bin/ollama serve } | Out-Null

    Write-Output "Ollama server started on port $Port"
}

# Function to stop the Ollama server
function Stop-OllamaServer {
    param (
        [int]$Port = 11434
    )
    $process = Get-Process -Name "ollama" -ErrorAction SilentlyContinue
    if ($process) {
        $process | Stop-Process -Force
        Write-Output "Ollama server stopped on port $Port"
    }
    else {
        Write-Output "Ollama server not found on port $Port"
    }
}

function Test-OllamaServer {
    /usr/local/bin/ollama ps
}

function Send-OllamaServerQuery {
    param (
        [string]$Query,
        [int]$Port = 8000
    )
    $url = "http://localhost:$Port/api/query"
    $body = @{ query = $Query } | ConvertTo-Json
    $response = Invoke-WebRequest -Uri $url -Method Post -Body $body -ContentType "application/json"
    return $response
}

Export-ModuleMember -Function `
    Start-OllamaServer, `
    Stop-OllamaServer, `
    Test-OllamaServer, `
    Send-OllamaServerQuery
