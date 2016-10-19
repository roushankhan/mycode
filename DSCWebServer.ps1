#********Roushan Khan , Date: 10/10/2016 ************
<#This is a DSC Configuration for a Web server with copying website files from a source/Repo to a destination/web server location.
All need to be done is run the below commands.
Start-DscConfiguration -Path 'C:\Users\UserName\Desktop\' -ComputerName $ComputerName -Force -Wait
You can use a Pull Server for Enterprise or a Push server less recommended with HTTPS type
PullServer ref: https://msdn.microsoft.com/en-us/powershell/dsc/pullserver#>

$SourceFile = 'C:\Temp\WebCodes' # change this as its just an example
$DestinationFile = 'C:\Websites\'  # change this as its just an example
$ComputerName = $env:COMPUTERNAME
Configuration WebServerNode
{
    Node $ComputerName
    {
        WindowsFeature IISRoleDSC
        {
            Name = 'Web-Server'
            Ensure = 'Present'
            IncludeAllSubFeature = $true
            
            
        }
        File CopyWesiteCode      
        {          
            Ensure = 'Present'         
            Type = 'Directory'       
            SourcePath = $SourceFile      
            DestinationPath = $DestinationFile
            Recurse = $true
            Force = $true
        } 
    }
}

WebServerNode -OutputPath 'Output Path'

#then start the desired state configuration on a target machine as below.

Start-DscConfiguration -Path 'MOF File path' -Wait -Force -Verbose -ComputerName -Credential
