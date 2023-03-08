FROM ctezlifrn/moodle:4.1.1-php8.0-014
#FROM localmoodle
ENV DEBIAN_FRONTEND noninteractive



# Configures php.ini and extra languages
USER root
COPY php-extra.ini /usr/local/etc/php/conf.d/extra.ini
COPY locale.gen /etc/locale.gen
RUN locale-gen && dpkg-reconfigure locales
ADD docker-php-entrypoint /usr/local/bin/



USER www-data

# Install modules plugins
WORKDIR /var/www/html/mod
RUN curl -o d.zip https://moodle.org/plugins/download.php/27960/mod_checklist_moodle41_2022111900.zip && unzip d.zip \
    && curl -o d.zip https://moodle.org/plugins/download.php/27934/mod_coursecertificate_moodle41_2022111500.zip && unzip d.zip \
    && rm d.zip

# Install blocks plugins
WORKDIR /var/www/html/blocks
RUN curl -o d.zip https://moodle.org/plugins/download.php/27962/block_checklist_moodle41_2022111900.zip && unzip d.zip \
    && curl -o d.zip https://moodle.org/plugins/download.php/28412/block_xp_moodle41_2022112610.zip && unzip d.zip \
    && rm d.zip

# Install course format plugins
#WORKDIR /var/www/html/course/format
#RUN curl -o d.zip https://moodle.org/plugins/download.php/28461/format_tiles_moodle41_2023013000.zip && unzip d.zip \
#    && curl -o d.zip https://moodle.org/plugins/download.php/26671/format_remuiformat_moodle40_2022120500.zip && unzip d.zip \
#    && rm d.zip

# Install theme plugins
WORKDIR /var/www/html/theme
RUN curl -o d.zip https://moodle.org/plugins/download.php/28087/theme_moove_moodle41_2022112801.zip && unzip d.zip \
    && rm d.zip

# Install enrol plugins
WORKDIR /var/www/html/enrol
RUN curl -o d.zip https://moodle.org/plugins/download.php/21447/enrol_xp_moodle41_2020042901.zip && unzip d.zip \
    && rm d.zip

# Install book tools plugins
WORKDIR /var/www/html/mod/book/tool
RUN curl -o d.zip https://moodle.org/plugins/download.php/11995/booktool_exportepub_moodle31_2016081500.zip && unzip d.zip \
    && curl -o d.zip https://moodle.org/plugins/download.php/15925/booktool_importepub_moodle34_2018020100.zip && unzip d.zip \
    && rm d.zip

# Instal text filters plugins   
WORKDIR /var/www/html/filter
RUN curl -o d.zip https://moodle.org/plugins/download.php/24270/filter_syntaxhighlighter_moodle41_2021052101.zip && unzip d.zip \
    && rm d.zip

# Install Atto plugins, fix morebackcolors and morefontcolors directory name
WORKDIR /var/www/html/lib/editor/atto/plugins
RUN curl -o d.zip https://moodle.org/plugins/download.php/17168/atto_justify_moodle40_2018041600.zip && unzip d.zip \
    && rm d.zip

# Install admin tools plugins
WORKDIR /var/www/html/admin/tool
RUN curl -o d.zip https://moodle.org/plugins/download.php/23370/tool_ribbons_moodle310_2021020400.zip && unzip d.zip \
    && curl -o d.zip https://moodle.org/plugins/download.php/27931/tool_certificate_moodle41_2022111500.zip && unzip d.zip \
    && rm d.zip

# Install availability condition plugins
WORKDIR /var/www/html/availability/condition
RUN curl -o d.zip https://moodle.org/plugins/download.php/22786/availability_xp_moodle41_2020110900.zip && unzip d.zip \
    && curl -o d.zip https://moodle.org/plugins/download.php/27907/availability_relativedate_moodle41_2022111100.zip && unzip d.zip \
    && rm d.zip

# Install report plugins
WORKDIR /var/www/html/report
RUN curl -o d.zip https://moodle.org/plugins/download.php/25665/report_extendedlog_moodle311_2021121302.zip && unzip d.zip \
    && rm d.zip

# Install local plugins
WORKDIR /var/www/html/local
RUN curl -o d.zip https://moodle.org/plugins/download.php/28172/local_mailtest_moodle41_2022121100.zip && unzip d.zip \
    && curl -o d.zip https://moodle.org/plugins/download.php/27251/local_maintenance_livecheck_moodle40_2022071200.zip && unzip d.zip \
    && rm d.zip

# Install grade export plugins
WORKDIR /var/www/html/grade/export
RUN curl -o d.zip https://moodle.org/plugins/download.php/27963/gradeexport_checklist_moodle41_2022111900.zip && unzip d.zip \
    && rm d.zip

# Install custom profile fields plugins
WORKDIR /var/www/html/user/profile/field
RUN curl -o d.zip https://moodle.org/plugins/download.php/27125/profilefield_autocomplete_moodle311_2022071900.zip && unzip d.zip \
    && rm d.zip

# The Moodle image use this instruction by default, we repeat here for your knowledge
USER www-data
WORKDIR /var/www/html
EXPOSE 80
ENTRYPOINT ["docker-php-entrypoint"]
