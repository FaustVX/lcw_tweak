param (
    [parameter(Mandatory)]
    [String]$version,

    [parameter()]
    [String]$message
)

if (-not (Get-Content .\mod\changelog.txt)[1].Contains($version))
{
    echo "Invalid version in ``changelog.txt``"
    exit 1
}

$version = "v$version"

if ($PSBoundParameters.ContainsKey('message'))
{
    git commit -am "Bumped version ``$version```n$message"
}
else
{
    git commit -am "Bumped version ``$version``"
}

git tag $version
git push
git push --tags
