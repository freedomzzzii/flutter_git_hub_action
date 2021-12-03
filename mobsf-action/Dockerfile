FROM opensecurity/mobile-security-framework-mobsf

LABEL version="1.0.0"
LABEL repository="https://github.com/inm-certi/mobsf-action"
LABEL homepage="https://github.com/inm-certi/mobsf-action"
LABEL maintainer="Ian Koerich Maciel <inm@certi.org.br>"

LABEL com.github.actions.name="GitHub Action for MobSF"
LABEL com.github.actions.description="Wraps the MobSF docker to enable common commands."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="gray-dark"

COPY LICENSE README.md /
COPY "entrypoint.sh" "/Mobile-Security-Framework-MobSF/entrypoint_github.sh"

ENTRYPOINT ["/Mobile-Security-Framework-MobSF/entrypoint_github.sh"]
CMD ["--help"]
