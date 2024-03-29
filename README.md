# conventional-commits
Hooks and script for generating semantic versioning through conventional commits

## Prerequisites
Your computer must have the following technology(s) installed:
- git (https://git-scm.com/)

> [!IMPORTANT]
> If you are using Windows as your operating system, you must run all commands through the "git bash" application.

## Installing the hooks locally
If you wish to install the hook on your machine, run the following script inside your project folder:
```bash
bash setup.sh
```
To verify if it was installed correctly, execute the command:
```bash
git config --global --list | grep .git-template
```
Check if the lines with the keys `core.hookspath` and `init.templatedir` are displayed.
See the image below for an example of the expected response:

![image](https://github.com/joaojuniormail/conventional-commits/assets/7514536/0697faca-a702-458f-97d8-ca4360faac1b)

Great! You now have the hook installed on your machine and from now on, all your commits will be validated to see if they follow conventional commits. 🍾🎉

## Automated version generation execution
To check what the next release version will be, execute the command:
```bash
bash generateVersion.sh
```
To generate a new release version, creating a tag, execute the command with the parameter `true` (informs the script to generate a tag):
```bash
bash generateVersion.sh true
```
