# sh-conventional-commits
A hook that locally validates commit messages, checking if they follow the conventional commit pattern. The project also includes a shell script for generating semantic versions through conventional commits.

## Prerequisites
Your computer must have the following technology(s) installed:
- git (https://git-scm.com/)

> [!IMPORTANT]
> If you are using Windows as your operating system, you must run all commands through the "git bash" application.

## Installing the hooks locally
If you wish to install the hook on your machine, run the following script inside this project folder:
```bash
chmod +x commit-msg
bash setup.sh
```
To verify if it was installed correctly, execute the command:
```bash
git config --global --list | grep .git-template && ls $HOME/.git-template/hooks/
```
Check if the lines with the keys `core.hookspath` and `init.templatedir` are displayed.
See the image below for an example of the expected response:

![print command line](https://github.com/joaobsjunior/sh-conventional-commits/assets/7514536/401baeaa-a1c6-4901-ba4f-c9772994c60a)

Great! You now have the hook installed on your machine and from now on, all your commits will be validated to see if they follow conventional commits. 🍾🎉

## Automated version generation execution
1. Copy file `generateVersion.sh` to your project
2. To check what the next release version will be, execute the command inside your project folder:
```bash
bash generateVersion.sh
```
3. To generate a new release version, creating a tag, execute the command with the parameter `true` (informs the script to generate a tag):
```bash
bash generateVersion.sh true
```
