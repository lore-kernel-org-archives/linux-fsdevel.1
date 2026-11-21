Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288427;
	b=D98hlWAQTxnL9kc/RFmb/ehPpcS8E8Mmb3qK9L4UPzrZj5foQxVLMV+QnUYcuOuQJOnl
	 cCvfg3KIP++GsrCxC4qXowWsWRrUyXyyXU3wMNU+eQL1L6Li+V1z99qGGBKx6yBvOV2MY
	 KkaOUBlbfbFKG6witRwE2WUhuaE1+hAl+FbQDYZqmi8TSKihhi9VqvLjiNIYrxH9EHsyi
	 kYI1xapb0ghCXhlYdzQ9qu0bRhMPkGuoXE8UyEAXgO9MV/zzwU07yX7J1c+iVmPr+bLD6
	 +LE3VlqaUsEgc/h3UYBJzFmlymry7wKQIc0GWWDURKWwWiZeTb+XEsCbz7Ou6fgn8+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0p5SdW2QUlP6oc7GBXyTSmsNARTVU7xBP/EBePnLS70=;
	b=wkpINnLp9oJCcQpCLxOicG8NUv+RoYcTeX7d7yKvKP/15vTXrDycG09tSGIpo3QkYFsx
	 U6MtfulRDO25yrxj4/tj4VR3tYe1teafdy2FG+X45wyiX3FRJfJPtNXqugK0lHIAs17xA
	 wOVCqMc7Flx93u+7HJOTGim8X3sz1EgTe4uB3yC7a0lUcCC+CATA/REcxrr0ii8F8N8UV
	 dMJlfZgVDfM1BR9PtqP/VUhV7QVHNtLVvz4S+Y0l4UNLThXNArXAGCjOQUsHZLYT7suZo
	 M1UIrVyAMAofmVPOxKOO0zQvtRznsQptdREvoJKntYDEMte7qZ0EXala9n74R6zAAvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FmBAFmh2;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA21606A32A
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 19:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA21606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FmBAFmh2
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9210f2622ccso26304066d6.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 11:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288426; x=1795893226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0p5SdW2QUlP6oc7GBXyTSmsNARTVU7xBP/EBePnLS70=;
        b=FmBAFmh2+uqLuJpfyQ35HUYP24JwjMRdBeGnnIEXuNsAIA2FIlxAD5RmRPuSCtxDUj
         IyqC7cn9KbDxXtcuxHL1LCEqQmys6Ag0ZRDW7Qf1tMFi8g+0oCJ5HR9QH+jtu0yoM8Dw
         AuCzMApnrfrYQ43Du7gKqDwoqc/HbYtZAppNkMIS8DL/3alQwqr8X5pydo9R8stijy+y
         ZWQn3kjjcpGj9C6MEdJvE9+T+inKR5PBTYoUTvZjd5zaiO3bIjnDQj0FsTtN4T7cRgBr
         16qSOzrDIo3letvoeY8SHXrqfJE/4mPzNlXsFYv1kpaxR8fNMST75owQf1vw04xjA44K
         QW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288426; x=1795893226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0p5SdW2QUlP6oc7GBXyTSmsNARTVU7xBP/EBePnLS70=;
        b=uleh5NpTh7jUWc6v3TIlckproHcr7hyjgTOcmWatFtSmt2qZ58t+SC76i7ACUQxOJo
         COo57IQy1aRZ2BSuA8NU8UOstfKJ0vX1/tV2FrCT9HYdiFpMFf+MqgQo3IeyjKTdhHvs
         EiPcI5R1cvfX95cfdOYTw0DM/T/kFCC+SU5DcsqUBYdLiSVKBwtIItGX3RXJ4pnt7L5T
         jgk5b/bXqKnOWTohO0eayVBrcthvfzVIyEa+7kIIMbNkMY9xbOBZnKIpy8d603eprP+/
         FA+V+s7+UdGJKTUK6JFUuVCYtFX9mg/XzFx3eA4QYFXpTnju4omjZc9SqGOrNzm4uk5u
         uAzQ==
X-Forwarded-Encrypted: i=1; AL+hErHGjXUwz06IJy4u99kV6qPexsnXKFun6d2VBGlJGDN11hw+YnLJu6BHqWnmCVK++RB/A2nO8psmSXjrD/cA@vger.kernel.org
X-Gm-Message-State: APuU4Z9BTqvr9xKVKnBv8oaoKIJbvgl9gZy+ZFkwc5OkXCFI2gJgtj7J
	K10wZOQrCXxlZ/M8CYrwh4cqbfcoz5s1JiarXi5iW0OsUrvoRGhPwsu6
X-Gm-Gg: AZFdTZd2fc3nOIe6/DN02af6aGt28f1bzNW0iV43j8Tb9f3bMbNwXxroT+0sYWk99s3
	TzDAmaAuGyr25P9ZqXFLKkREMEShWbTtnpMRd4yW/DRuf49cgn8jFZpFQbRGYK154Wrdw3ZDeWM
	sk3ebDJLdUDXNybNhR9pKd3nKQ5IVVT4RAEKK8khFEPaGJZTjByO8q2DWz//hhd1tbhly2nE2lU
	r4gPRn0wjwK891+2NH3I7rb393nFQiQhYvCdRxdF8mLLHpbZ0xF4B6rNI6oIRK8CJysdbtquMc5
	ePXAHKcdXLo12flDB358hOvU15MC8uCOlWFsVqowQArtoC89nQVCCmTwvey3dOKhAPwkw7eZ8X/
	xdhfr37Q0nJTC83M5/yqdSZjWXXlXEvN8h8/RJ2WCTns2aUdH2g/QJXDLobaWN1nLQ3DfB5qOkY
	k6dUSq9D9t7rObT2aaFPxx2aLS81ecFclWBGT5IT1oLE2Kvzir2PBWCLGoFxoGZb9irSKjkKr95
	x5rUuOAkN9UcGwSQMQDb3Kf2/tayo71sccxX0Np+mlxoJXWFF9ez2p7QrV6amaU+QkjjWZitjRS
	AmYjRe1wa47ixWX8+Yap2zfU1BGy/vDLu6PAOG8ehSZXlXnw2gewC3j4m+A9WUptbNkihZZb4vC
	+dA==
X-Received: by 2002:a05:6214:8504:20b0:921:2245:73c2 with SMTP id 6a1803df08f44-92134abe315mr91505836d6.20.1795288425845;
        Sat, 21 Nov 2026 11:13:45 -0800 (PST)
Received: from localhost ([143.198.29.12])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349ee175sm62359706d6.26.2026.11.21.11.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:13:45 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] selftests/coredump: include <stddef.h> for offsetof
Date: Sat, 21 Nov 2026 22:13:40 +0300
Message-Id: <20261121191340.91952-2-ndokutovich@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121191340.91952-1-ndokutovich@gmail.com>
References: <20261121191340.91952-1-ndokutovich@gmail.com>
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

Both files use offsetof() without including <stddef.h>.  offsetof() is a
macro; without the header it is not expanded, so its first argument is
parsed as a function argument and the type name fails to compile:

  coredump_test_helpers.c:1309:26:
  error: expected expression before struct

Include <stddef.h> in the two files that use offsetof().

Fixes: c71147f42bff ("selftests/coredump: split out common helpers")
Fixes: c09ea6659e50 ("selftests/coredump: split out coredump socket tests")
Signed-off-by: Nikolai Dokutovich <ndokutovich@gmail.com>
---
 tools/testing/selftests/coredump/coredump_socket_test.c  | 1 +
 tools/testing/selftests/coredump/coredump_test_helpers.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
index ec73bb690bbc..c17f3c88a00b 100644
--- a/tools/testing/selftests/coredump/coredump_socket_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <stddef.h>
 #include <sys/stat.h>
 #include <sys/epoll.h>
 #include <sys/socket.h>
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 072ab8624808..85bf5cdf4c4a 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -15,6 +15,7 @@
 #include <poll.h>
 #include <pthread.h>
 #include <stdbool.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.34.1

