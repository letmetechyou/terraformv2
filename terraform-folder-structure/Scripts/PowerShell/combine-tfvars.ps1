param (
    [Parameter(Mandatory = $true)][string] $FolderPathAndPattern,
    [Parameter(Mandatory = $true)][string] $OutputFileName
)

# Get a list of .tfvars files matching the pattern
$inputFiles = Get-ChildItem -Path $FolderPathAndPattern -File

if ($inputFiles.Count -eq 0) {
    Write-Host "No .tfvars files found matching the pattern: $FolderPathAndPattern"
    return
}
else {
        Write-Host "QTY:$($inputFiles.Count) - .tfvars files found matching the pattern: $FolderPathAndPattern"
}

# Initialize an empty array to store the lines of combined content
$combinedContent = @()

# Loop through each input file
foreach ($file in $inputFiles) {
    # Add a comment to indicate the source of this section
    $combinedContent += "# Start of $($file.Name)"

    # Read the content of the file and append it line by line
    $fileContent = Get-Content $file.FullName
    $combinedContent += $fileContent

    # Add a comment to indicate the end of this section
    $combinedContent += "# End of $($file.Name)"
}

# Save the combined content to the specified output file using Set-Content
$combinedContent | Set-Content -Path "$OutputFileName.tfvars" -Encoding UTF8 -Verbose

Get-ChildItem -Path "$OutputFileName.tfvars" -File

Write-Host "Combined content saved to $OutputFileName.tfvars"