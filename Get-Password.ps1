function Get-Password
{
   <#
   .Synopsis
      Generate random password
   .DESCRIPTION
      Generate a random password. You can specify how many characters should be included.
   .EXAMPLE
      PS T:\> Get-Password
      C%2#beMQ

      (Default is 8 characters)
   .EXAMPLE
      PS T:\> Get-Password 10
      e@PA2?0jkM
   .EXAMPLE
      PS T:\> Get-Password -length 15
      jhF4!f3YzU0Bxot
   #>

    [CmdletBinding()]
    Param
    (
        # How long should be the password
        [Parameter(Position=0)][int]$length = 8
    )

    Begin
    {
       if ($length -lt 8) {
          Write-Warning "Password length incorrect (min 8 characters)"
          Break Script
          #throw "Password length incorrect (min 8 characters)"
       }
    }
    Process
    {
        [string]$Password = ""
        $Alphabet = 'abcdefghjkmnopqrstuvwxyz' # chars 'i' and 'l' are excluded
        [string[]]$Pool = 0..9
        $Pool += '!#$%?'.ToCharArray() # @ sign excluded since it cause problems with sending SMS
        $Pool += $Alphabet.ToCharArray()
        $Pool += $Alphabet.ToUpper().ToCharArray()
        While (($Password -cmatch '(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)') -eq $false) {
            $Password = ""
            Get-Random -InputObject $Pool -Count $length | ForEach-Object { $Password += $_}
        }
        $Password
    }
    End
    {
    }
}