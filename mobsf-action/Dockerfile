FROM opensecurity/mobile-security-framework-mobsf

WORKDIR /home/mobsf/Mobile-Security-Framework-MobSF

RUN apt-get update -y && \
  apt-get install -y jq

COPY "entrypoint.sh" "/home/mobsf/Mobile-Security-Framework-MobSF/entrypoint_github.sh"

RUN chown -R mobsf:mobsf /home/mobsf/Mobile-Security-Framework-MobSF

USER mobsf

ENTRYPOINT ["/Mobile-Security-Framework-MobSF/entrypoint_github.sh"]

CMD ["--help"]
