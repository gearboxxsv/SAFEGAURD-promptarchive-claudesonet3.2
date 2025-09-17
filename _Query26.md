check this issue, plugin-onboarding.sh: line 680: syntax error near unexpected token `}'


rebuild bash and powershell scripts correctly, also build a zsh version for Darwin.


examing and fix with a full rewrite of SafeguardPluginOnboardingScript.zsh
./SafeguardPluginOnboardingScript.zsh: line 17: setopt: command not found
./SafeguardPluginOnboardingScript.zsh: line 18: setopt: command not found
./SafeguardPluginOnboardingScript.zsh: line 21: print: command not found
./SafeguardPluginOnboardingScript.zsh: line 22: print: command not found
./SafeguardPluginOnboardingScript.zsh: line 23: print: command not found
./SafeguardPluginOnboardingScript.zsh: line 24: print: command not found
./SafeguardPluginOnboardingScript.zsh: line 25: print: command not found
./SafeguardPluginOnboardingScript.zsh: line 26: print: command not found
./SafeguardPluginOnboardingScript.zsh: line 27: print: command not found
./SafeguardPluginOnboardingScript.zsh: line 28: print: command not found
./SafeguardPluginOnboardingScript.zsh: line 114: syntax error near unexpected token `('
                                       ./SafeguardPluginOnboardingScript.zsh: line 114: `    python_files=(*.py(N))'
