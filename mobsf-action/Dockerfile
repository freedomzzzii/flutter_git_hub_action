FROM opensecurity/mobile-security-framework-mobsf

RUN groupadd -g 9901 mobsf

RUN adduser mobsf --shell /bin/false -u 9901 --ingroup mobsf --gecos "" --disabled-password

WORKDIR /home/mobsf/Mobile-Security-Framework-MobSF

COPY "entrypoint.sh" "/home/mobsf/Mobile-Security-Framework-MobSF/entrypoint_github.sh"

# Expose MobSF Port and Proxy Port
EXPOSE 8000 8000 1337 1337

RUN chown -R mobsf:mobsf /home/mobsf/Mobile-Security-Framework-MobSF

USER mobsf

ENTRYPOINT ["/home/mobsf/Mobile-Security-Framework-MobSF/entrypoint_github.sh"]

CMD ["--help"]
