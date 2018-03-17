FROM my-kali-linux

MAINTAINER Mickey

ARG USER_NAME
ARG VERSION
ARG PASSWORD

ENV TERM=xterm-color
ENV GROUP_NAME=default
ENV PG_USER=postgres
ENV SHELL_THEME=user
ENV HOME_DIR=/home/${USER_NAME}
ENV PROFILE='profile'
ENV CODE='code'
ENV BASHRC='.zshrc'
ENV ENV_FILE='.env.sh'
ENV ALIAS_FILE='.alias.sh'
ENV GIT_CONFIG='.gitconfig'

LABEL version=${VERSION}

#unrar x -r
RUN apt-get update -y
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/US/Mountain /etc/localtime

# Allow sudo without password
COPY sudoers.d /etc/sudoers.d

# Create Group/User
RUN groupadd -r ${GROUP_NAME} \
    && useradd -m -r -g ${GROUP_NAME} ${USER_NAME} \
    && usermod -aG sudo ${USER_NAME} \
    && usermod -aG sudo ${PG_USER} \
    && echo root:${PASSWORD} | chpasswd \
    && echo ${USER_NAME}:${PASSWORD} | chpasswd \
    && echo ${PG_USER}:${PASSWORD} | chpasswd

COPY entry.sh ${HOME_DIR}
COPY user/${PROFILE} ${HOME_DIR}/${PROFILE}
COPY user/${CODE} ${HOME_DIR}/${CODE}

# User Own Home
RUN sudo chown -R ${USER_NAME}:${GROUP_NAME} ${HOME_DIR}


# Setup PSQL Server
RUN sudo /etc/init.d/postgresql start \
		&& su - postgres -c "createuser ${USER_NAME} --createdb --superuser" \
		&& su - postgres -c "createdb ${USER_NAME}" \
		&& sudo /etc/init.d/postgresql stop


USER ${USER_NAME}
WORKDIR ${HOME_DIR}

# Install Oh My Zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
    && cp ${PROFILE}/zsh-theme .oh-my-zsh/themes/${SHELL_THEME}.zsh-theme


# Modify Profile
RUN printf "\nsource ~/profile/${ENV_FILE}\n" >> ${BASHRC} \
    && printf "\nsource ~/profile/${ALIAS_FILE}\n" >> ${BASHRC} \
    && sed -i "/^ZSH_THEME/c\ZSH_THEME=${SHELL_THEME}" ${BASHRC} \
    && find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; >> .nanorc \
    && printf "\nset tabsize 2\nset tabstospaces\n" >> .nanorc

RUN chmod +x entry.sh
RUN chmod +x code/sql/*

ENTRYPOINT ["./entry.sh"]

EXPOSE 22
CMD [ "${USER_NAME}" ,"/bin/zsh"]