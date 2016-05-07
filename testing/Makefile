PARENT=$(dir $(PWD))
VOLS= -v $(PARENT)/salt:/srv/salt -v $(PARENT)/pillar:/srv/pillar
.PHONY: run_fedora run_ubuntu run_arch
all: fedora_salt ubuntu_salt
fedora_salt: DockerfileFedora
	sudo docker build -t fedora_salt -f DockerfileFedora .
	touch fedora_salt
run_fedora: fedora_salt
	sudo docker run -it --rm $(VOLS) fedora_salt /bin/bash
ubuntu_salt: DockerfileUbuntu
	sudo docker build -t ubuntu_salt -f DockerfileUbuntu .
	touch ubuntu_salt
run_ubuntu: ubuntu_salt
	sudo docker run -it --rm $(VOLS) ubuntu_salt /bin/bash
arch_salt: DockerfileArch
	sudo docker build -t arch_salt -f DockerfileArch .
	touch arch_salt
run_arch: arch_salt
	sudo docker run -it --rm $(VOLS) arch_salt /bin/bash
