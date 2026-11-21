Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288424;
	b=EiCU7MOjIeG5nlb/0FgwcdD91Kzjwpz1d3BClGfaR02tFWmVcnEI/dYBjhyhJDiKiOsu
	 BCUwiSOnehO8fIdZDLUeWnNt6/D5R3pufkPqoy91l+so7Xgr1EdVInJpdnHMOlMFX9w8o
	 06aPQtF72CwD9x28sD1rUimHvhHwGoaEnDki1LuxKevMwTix+Xe+6H4EUUpsgAgJtFgf+
	 NgGnPNq2ZQ0VPr7xFBr1eAL9wRBcUM84gjhGoOPpvb9u+KIBBbjPlnWIoJQqPnD9svALJ
	 QXXhstWSsXs2gjcjnnpJZEs2hzlurBf3iSVvKOtT6XKOkXhHqfkY6OY3bG8r3PUjajg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XckOn5FCGtnClD4l5C6V81UfiN1tJJnMtgHtot5cyoM=;
	b=f3SbjRLAusVwXzChy9s2lWcvs8jGXhvVbeV//4/oqdjgfKrBZVkI4sJVOZd8ZB4RoEy5
	 Dc0EWkYKV6azE8LUIvK2sb/+zbCvTjW2PEjYCf2FwC0808R2acnX+8IeVH/IcZnsnaNgK
	 kF8fjNlCl89T1BifhqG13SgRa7vpsRV1wxQ/BljzTehFMWV+5u9myEJsqH7Cp5m+W37NE
	 1lDwb9pTjhmS7kv9ntQDwuZbujVywNsD3ShUqwGHzRJtEtOMavkxrc9cTmT9USjjba9Pz
	 WtegB1Ld0EjOcFMZUsmD1wN8v8WpDq2Z7+0tnJXhMlfu2lCNHJ8VMEmtIf/laAi6nkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pkkKtbZh;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676F606A320
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 19:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4676F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pkkKtbZh
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9210f2622ccso26303806d6.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 11:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288423; x=1795893223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XckOn5FCGtnClD4l5C6V81UfiN1tJJnMtgHtot5cyoM=;
        b=pkkKtbZhKOTUxbL/OCg0rZi/Fby1Q3GGB14+TYR3BvwX2H7baGAy1qnMQc+3Rrpwc5
         jRupK60BOCUOIEQ5EEwQWG9ErP2r2qlvt4Tjxwk4NqHxttt4QztGPJ/5+6x+0GqY6py9
         Eus16HMneHQz2lj0tNHosb4EPg/g2ikgKQTyPrY60HbR0cujYIn7q6pYMKBqK6VCn5Yd
         K6VPMcxeVX4JhG3lSok+yubtPd0J/ibVBp/+CYn4vJm69WOAB1d5Za531uqqnrnGd5eR
         5/bPYosgwO+m8duZJnJW3LYblKY2wTMXEtB58gdhy1idGokmn4qaF4GTgzqHSGPhclRM
         Sciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288423; x=1795893223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XckOn5FCGtnClD4l5C6V81UfiN1tJJnMtgHtot5cyoM=;
        b=yKvC8AL7SDeVewrcgpD8R/xUzhV8oq9IuwsI/wF5DN7t+Yc+QS9If932xbjQnvbRMy
         eP4KFTZvLruWde/BKaybBiGDLDRpV3j/coMtWlJwYdDoNA5VfyppYvVyM2cRd2sYK1ud
         UUKkByJ/qjN2TJtKkMmsD1OIeRi5mFzUldi26LdSW88EQxASjeObOx/kE9JW9JYsVaRj
         GC66v0wMIrEokxsiOhodwV3ym187+uXV3huEC8Av6XgcU+E/X/Xig5ludPZTxFE/UTV/
         Fu/H7zuhSzRBQS6JjtX0f5Th8tEobs5Nv/SlmLFcgFyvIsarL7Z9Lqc+0uFe0a5DZjKM
         Hg2A==
X-Forwarded-Encrypted: i=1; AL+hErFZPsGqiHf6IlgC7llnyk8FmDVwZBaC+y4uZJYSGLgr1yWgJEwr8+E1bZdD4Cb6ZE3lyjYRlnKNvKnu6lrh@vger.kernel.org
X-Gm-Message-State: APuU4Z9esCy1ojqfbbGXZzfdusvPCGjyyHRbx2xur5vpMpa7AuDstPQL
	jppaf4W0cTP0gzGXBf02croD32u76NLAWTjcw0dE0+3cxFKglW30tN5w
X-Gm-Gg: AZFdTZcKQyVafaB4YRMvRbVhGwtPL+ZAq7bl48hnio3VUx8K2eIPmKIbFux4F7ymTbn
	GonStk/xSmrNia+U9C11bXfZ0cIRY54cAzRVqFOPgP99T1E/9l7pkCbawY4SQiheRkYmp+Y3gX8
	ip5AzlWNe1NHekMAG+rCj95q0NNIHctFimQdljwr2173aaiiL9RDZJGKN/0ET+kzt3EeQuIW4YW
	zlQX1quNpz4HNoLL750apeUxxDq0Hja+2uYX19iBAzYTipUb9zxZ7nHVtyHAeniKosf7SkNbK4D
	BV+HzfYtAsQmwviVLWnPN1Q3Sg8IJ5jvKx9/k9Dh3SBlhGsLnsh2xIIThUXv3YDJLjMI/8IiNLt
	SwNeT9wBEUDerqBwBS2OhHoySozV0xi8yglBBUzgvcyb48O2/IENeRyaA4h5PQ6azpij7bLdfyT
	bDAxf8qXRTVUjLgO+tjJLAHfmcbuWOMr7Jca7EnvwCXqdI4nNllOcfV0O2MYUQPdqfpdA/CN+ew
	c8IWgBde0GxZZVTg6d194UYYtAS07SG5n445Z4n/83PF1fj+QmXxzT0g4jtaCspGDyVfZGbEXzB
	hBD+arl6wAgL69cE0ZfYHgqIqOlKZYl6KygvwrUddZ4yn9Mk80dVKoY3w7CoA2KKVuhkFQSPpG0
	k/g==
X-Received: by 2002:a05:6214:1c0e:b0:921:41fa:7601 with SMTP id 6a1803df08f44-92141fa7702mr67137086d6.17.1795288423188;
        Sat, 21 Nov 2026 11:13:43 -0800 (PST)
Received: from localhost ([143.198.29.12])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a24aa8sm60285076d6.42.2026.11.21.11.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:13:42 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] selftests/coredump: drop unused <linux/fs.h> include
Date: Sat, 21 Nov 2026 22:13:39 +0300
Message-Id: <20261121191340.91952-1-ndokutovich@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<linux/fs.h> pulls in <linux/mount.h>, which defines the MS_* flags as
macros.  <sys/mount.h> declares the same flags as enum constants, so
having <linux/fs.h> earlier in the file makes the macros expand inside
the enum declaration and the build fails:

  /usr/include/x86_64-linux-gnu/sys/mount.h:35:3:
  error: expected identifier before numeric constant

The include is not used by this test.  Drop it.

Seen with glibc 2.35 on Ubuntu 22.04.

Fixes: 59cd658eaf40 ("selftests/coredump: add coredump server selftests")
Signed-off-by: Nikolai Dokutovich <ndokutovich@gmail.com>
---
 tools/testing/selftests/coredump/stackdump_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index 1ec88937a1c2..8a681e486c3e 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -6,7 +6,6 @@
 #include <libgen.h>
 #include <limits.h>
 #include <linux/coredump.h>
-#include <linux/fs.h>
 #include <linux/limits.h>
 #include <pthread.h>
 #include <string.h>
-- 
2.34.1

