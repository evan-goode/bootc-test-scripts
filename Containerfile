FROM quay.io/centos-bootc/centos-bootc:stream9 

COPY id_ed25519.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys
RUN echo 'root:password' | chpasswd

RUN dnf -y install openssh rsync strace vim gdb && \
    systemctl enable sshd

RUN dnf -y install dnf-plugins-core && \
	dnf -y copr enable dcantrell/dnf-bootc && \
	dnf -y config-manager --set-enabled crb && \
	dnf -y upgrade && \
	dnf -y distro-sync --repo copr:copr.fedorainfracloud.org:dcantrell:dnf-bootc

COPY ./rpms /root/rpms
RUN dnf -y install /root/rpms/*.rpm

EXPOSE 22
