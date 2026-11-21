Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795286539;
	b=F/en5MkM6H9fdmpFh83giEQwofUKStASxT26LM/1wn8fRan8Rzlq8Tytx0F5iprFVpmH
	 /7ojHpOtzluSb1ihTggkgRpWrteg1fMIbOp8Vf8euPSIidQRw/+LtPQ6UH6DnaxMEffC0
	 fCrLNW9mupeEu60nvLgSmavSZhfXTa7F/SQr3mwSGKlRncWXYxxNq9pJnT8ePcor0bXEh
	 qag51/Ty8G6rMD0AmeDrYZB08cPJG09DXRBV+LASw0VMXSIq7JxTvR+fRddsBmaBh2xz3
	 WkyRQLpBDxEBA/B08akLhhJk9O3MneagkJpM2TCmlL26wyD0kvZpsDSOHkwKL/pFwZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795286539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GjLpY1CKPj0eCFHlrRrrfFi/jmOkP03r0FnUiwT8DXQ=;
	b=yvPoV/CN1HN2Co0E+0RavKVOKujZoRgcPDNrycwAHScYL91mUrBGN0ouBWwt6V9zHWPH
	 8JPvxnUcHdnj/q3yAczs5V8SNokh/0v0RjDs1XTPgm/n+4MQa9zVNjJHvG+i2R0Av8tMa
	 VVTWtC3xLDTlXRaiEKOm/kHJokxWDHlXGYoqFwArC4Y9bWY0udWjJlUn6iYHxNQHi301V
	 tfVNbVogrbCw3gCKyQ0QcZzbyDkqkByLqHy/XXVoE91AZVjQ+4USjzFC+dJ/UsnKfJeEd
	 ZqZOMGy/GiXIVHMPvvWnWsBtPPtbh57Ji4+1hSY2s/XK8I6nFEtKIi+fvrYPVf0LZDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd5ZrevY;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDDA606A32A
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 18:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CDDA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd5ZrevY
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-55c35262674so15876511cf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 10:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795286538; x=1795891338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GjLpY1CKPj0eCFHlrRrrfFi/jmOkP03r0FnUiwT8DXQ=;
        b=yd5ZrevYNJ5vwHoAtXXlSYrLtSWp/xktYV9c34TMqrfVWU53FFVucnseLiHnbzER/k
         M2jqu/wKGNI8qvabv6LsBOY4T1t/LdwtXX02Z4fjF+EB0Q3O3Huo7kOQBxoTo2sQFAnQ
         fPojYU9K+LMMHAikgXoNNxHIZpSftGRIbxuOgI/i71694ad6e081XFbF6SdvTPKpgw07
         jMWsSJqqrId3lsM75lDJCuWeC3ieQ+6FCC9+/uMKPdIKd5gheSWXotwT4Ap3X47HpJaM
         QBJJxkhSZwbsLEsFxdJyR04KCsOxO41Bba8vKwGXBGphVzwFIpaJPMDUjVwHV5BNCA+g
         8SAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795286538; x=1795891338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GjLpY1CKPj0eCFHlrRrrfFi/jmOkP03r0FnUiwT8DXQ=;
        b=P718QhVoLHBKT38GsL0KgGyW1/4qgTSQ5qOBzdGQ1EQLujHAqObyghwVc6XHQp2NuH
         PBr8tjLQzkLLykeyzRFc1U9ccP8HeXxign8NHPDvZ9XGJYhq7onuWAZH4OLf4ffd4Dyl
         8aSPYYsC7KyufeabrCT2P/usuIhJ/jQWvaNW+L97zBprAWE4MirTyuiMqZaTNYNfFuNg
         rcELcToAIhGL+W72hbv5U+uPxT/jjxQ17S1DWz+5QFH58VOM5i8SNYkVrIJjgrKJEmf3
         D44GP5MvYRJfKiVmbNqMMtvsVPpypeImRxpjPj20LivijjAuOAxqyqJn6ArjwTcg8TDv
         o+gA==
X-Forwarded-Encrypted: i=1; AL+hErFTUuramaAFw32YKg0T4DpzyYViqDE9Wm4krahM/W/Z7qUN2MLj+GtVZir/VICiHUj4bLgQkvFcqtMySOSJ@vger.kernel.org
X-Gm-Message-State: APuU4Z96bWSBnb0aQ/fiQxrJHZnYKTJZJLKxAGCZnOs6FGRiVJyuzUF1
	xvwZXztbFw6oxMzyYDQxDsc/BBZ4tk63XHsEdJ93S7+z3XhyBOrYio6i
X-Gm-Gg: AZFdTZd/4ylX+ZHutfdrepuzAaVwo7K/It8vUwyE4f0JcKxLRyQI5wQhd7+doMKz/T/
	4ClTlqV0ziw/P5fvxu8GMN/3XGSpYNshim/qDsMSy0tTiUAMzInllXNQ5a1xnA1p3hqxXYwuNeu
	swsAiitK6s68PSaLImPRzoSy8JLeH5/6XLggXCVuTJ4N5Sutpk/H2Ua5Svar6cwudB5hNz+8OSV
	F/PN/vem/3stTBhi0Fa0pIltB8yCPqFvUD38mgR8wkpw+Tm/j+lAliHrPNQkamkv8TQVXrATzv7
	tmfFaa4Upkh2k40DrEnrUG48XlRTOrfPg7fo+dSmXooXjkYn/NHM8IFhke/hu51gGX5brZv9TIs
	Hm4ntduxAuBuqb6I/FapcdYZyPYLAkZXHCalfcwJqEQJazcCInD5FJEZYDTvJ5ogdBVa2gHg9i9
	McGPBE+xgqyqRg375P6OeK4Ch1wxw9KmAHHcPUjt6GeIJJx3kb/1H5AGBsEfl8hLlh7/gFPwsdJ
	CB8byivmsFYRgI5HOHFxjL7HJ0IpvMxDiXln0EnyG1HXv24w9c/5Pvc/lWOxCfrO+zQuyk/LG6u
	BoOAaPymg0fj8GhWAtbtM9jueQ0GYhO8eYucMXp8By83KiAF933A0+6ZJ1929CHFMbHL4BxFm2X
	tP87tekujiGpMhG28zvin0i8=
X-Received: by 2002:a05:622a:5c1b:b0:55c:abad:a72c with SMTP id d75a77b69052e-55d76a6260dmr122239201cf.56.1795286538132;
        Sat, 21 Nov 2026 10:42:18 -0800 (PST)
Received: from localhost ([143.198.29.12])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a16754sm59458726d6.39.2026.11.21.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 10:42:17 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] selftests/filesystems: move kernel UAPI includes after libc headers
Date: Sat, 21 Nov 2026 21:42:15 +0300
Message-Id: <20261121184215.90813-1-ndokutovich@gmail.com>
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

<linux/fs.h> includes <linux/mount.h>, which defines the MS_* flags as
macros.  <sys/mount.h> declares the same flags as enum constants, so
including <linux/fs.h> first makes the macros expand inside the enum
declaration and the build fails:

  /usr/include/x86_64-linux-gnu/sys/mount.h:35:3:
  error: expected identifier before numeric constant

Seen with glibc 2.35 on Ubuntu 22.04.

Move the two kernel UAPI includes after the libc headers.

Fixes: 073d71c5118f ("selftests/filesystems: add a test for freezing a shared block device")
Signed-off-by: Nikolai Dokutovich <ndokutovich@gmail.com>
---
 tools/testing/selftests/filesystems/freeze/shared_bdev_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/freeze/shared_bdev_test.c b/tools/testing/selftests/filesystems/freeze/shared_bdev_test.c
index 0ee352268a97..6454cabce83f 100644
--- a/tools/testing/selftests/filesystems/freeze/shared_bdev_test.c
+++ b/tools/testing/selftests/filesystems/freeze/shared_bdev_test.c
@@ -14,8 +14,6 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <ftw.h>
-#include <linux/dm-ioctl.h>
-#include <linux/fs.h>
 #include <sched.h>
 #include <stdbool.h>
 #include <stdint.h>
@@ -29,6 +27,8 @@
 #include <sys/sysmacros.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <linux/dm-ioctl.h>
+#include <linux/fs.h>
 
 #include "../../kselftest_harness.h"
 #include "loop_util.h"
-- 
2.34.1

