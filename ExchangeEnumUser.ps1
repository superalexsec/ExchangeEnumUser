# Install and import ExchangeOnlineManagement module if not already installed
if (-not (Get-Module -Name ExchangeOnlineManagement -ListAvailable)) {
    Install-Module -Name ExchangeOnlineManagement -Force
}

# Import the ExchangeOnlineManagement module
Import-Module ExchangeOnlineManagement

# Replace these variables with the email and password you want to test
$testEmail = "victim@domainname.com"
$testPassword = "SafePassword123"

# Test the connection using the provided email and password
Test-Office365Connection -Email $testEmail -Password $testPassword

# Function to test the connection with provided credentials
function Test-Office365Connection {
    param (
        [string]$Email,
        [string]$Password
    )

    try {
        # Convert the password to a secure string
        $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

        # Create PSCredential object
        $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Email, $SecurePassword

        # Connect to Exchange Online using the provided credentials
        Connect-ExchangeOnline -Credential $Credential -ErrorAction Stop

        # If the connection is successful, write the result to the console
        Write-Host "Connection successful for email: $Email"
    }
    catch {
        # If the connection fails, write the error message to the console
        Write-Host "Connection failed for email: $Email. Error: $($_.Exception.Message)"
    }
}
