# استفاده از یک ایمیج پایه که JDK 11 را فراهم می‌کند
FROM openjdk:11-jdk

# نصب git و curl به عنوان وابستگی‌های ضروری
RUN apt-get update && apt-get install -y git curl zip

# نصب SDKMAN برای مدیریت ابزارهای توسعه
RUN curl -s https://get.sdkman.io | bash && \
    source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk install gradle

# ایجاد پوشه کاری
WORKDIR /app

# کلون کردن ریپازیتوری شما از گیت‌هاب (URL باید از compose.yaml تنظیم شود)
ARG REPO_URL
RUN git clone ${REPO_URL} /app

# وارد شدن به دایرکتوری پروژه پس از کلون کردن
WORKDIR /app

# اجرای ساخت پروژه با استفاده از Gradle
RUN ./gradlew build

# اجرای آنالیز Checkstyle
RUN ./gradlew checkstyleMain

# استخراج گزارش Checkstyle به پوشه گزارش در هاست
VOLUME /report
RUN cp build/reports/checkstyle/main.html /report/

# نصب ابزارهای لازم برای اجرای اپلیکیشن (در صورت نیاز)
CMD tail -f /dev/null
