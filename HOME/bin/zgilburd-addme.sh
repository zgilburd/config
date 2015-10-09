#!/bin/bash
username=zgilburd
shell=zsh
pubkey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZ1BDMH0lyRR72y7sM4h+nf3zkBewn773uCs+6LPYnjXJ2gbl/Vd4WlhWZuqgjkrAP47pxi4akRuiYAuiAH2kIG2foLJG8gbIzvjBg+DeiXNnm87m8x/YcQLhK4zp766S6mUDDGwAd/O4iVKnEq/Kg/KIdiMpjKdWwsx58OqX933MBPo6jyareU/Q2FOZtNSkSxU83Tle6VW1f8ORtPwu0jL7jFj8FTU28L6VQWBEIuGgduWyfbodb9E+Upl+GMcxwr/vJrER0aOw1Kz9vp8uT9KolEz8/fIByZGF3uwYwa4HSf1pXQ7ttzEQ19jVZr9VNODjzsiAMGN3JJGE03wpc7YkgLelql3BqBVOIoVN3DNF5zgW6j1PLTE/GdxdiE0EAyPdksC3bHm4LWaAgYB0CmncAHw/lrer0fGEImWxdmXQRWfS1RZ1SIigCyCdtn3MWsMDEGhJ88A4yf9HtKNutybQTgZ7mhEvP9kI1qtTNav417rag/tr5xM7++/yV2IE= gpg-card-zgilburd-uid-E1D6480F-subkey-A043B55F\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYuGBeNbHP6VvMqcl/S28aMEPBuT50bpu/V3EOA7pjkahPvVwFD+AUX6jwinzhnUb9ve1KzDYB3G4QjeS7cGVs6O/mjKz2OWBiD/5lWYUQFy+4NIyPjy6WcvNEhh75kjzRGNTIj3MKr4ShlM394sPPo81bEO2V03Al7RrBvhBYW7PFjSyUlAxp8RxM4V62AKyxT9mfHJWfQ70ir1iYY4DyW1n0dYp79YCMvJLAnVBqyxIw+dwCWHnZCaGRBCLYMfMDp/9jv9CpWCo+efGAyNfw9sF6F3ou9Zfo4xxdl3YTktx29m9+JPXlqCyYQmku7tjEymp3ztU8owTuJBoaJta2IlH+I72UserqFH8LEmnTA/icMQny4gpwKI8fqmXyVAF3M9QOgPS31wRKhZcOwbd/fj9HZpXR9NzMCDwOhQ0SNp+vVGkhYumPRqeBGd7g6/jNEj3gZFjOIJjJ/jRWrPOUTL9rS8l6wezAgY/JF8mjViQPEXlqbvZBtlA67opt7/+O0i9VtJf6Xyl5wwcVkFTEFIsUkJW381r193GxeUWX8840/8Pe760yWZquRYN2ICuMV5vOp+z72LaJFrLziwQQEnUogUvK8ogkJrsMV4dQ8HTuBsTkNPR1x75AVKVJpxjqD8lHiVNQ9pQo+HVc+VwHLmf0mO/oKx/qXH63xkb7Sw== zgilburd-4096r-cardno:000500002212\n"
if [[ -x `which apt-get 2>/dev/null` ]]; then
	DISTRO=debian
	command="apt-get install -y"
	echo "apt based distro detected"
elif [[ -x `which yum 2>/dev/null` ]]; then
	DISTRO=rpm
	command="yum install -y"
	echo "rpm distro detected"
else
	echo "unsupported distro"
fi
if [ `grep -c $username /etc/passwd` -lt 1 ]; then
	useradd -m -s /bin/$shell $username
	mkdir -p /home/$username/.ssh/
	echo -e $pubkey > /home/$username/.ssh/authorized_keys
	chown -R $username:$username /home/$username
	echo -e "$username\tALL=(ALL:ALL)\tNOPASSWD:ALL" >> /etc/sudoers
	if [ ! `which $shell`]; then
		$command $shell
	fi
else
	echo "user exists"
fi
if [[ ! `which vim 2>/dev/null` ]]; then
	$command vim
fi

