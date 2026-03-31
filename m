Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952C2472AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964649; cv=none; b=ZDWly+fBguqbuuRVXSaDp5pgb7RR1/J4XBFPAREXmAh/WTGz6dcSXoZHm+ms4yNYql3+gHQzNyn9K5ndfXt8Gu3D5u/kJnJGtA/uYX6deTWPXSU6aBNCU8l/ayxvfu8uHZG1+KipigCYOXBDy+wfuxJBsjobdP7ASnhw2uBH6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964649; c=relaxed/simple;
	bh=2K20XJ/gwG1IJLQsa/W5M4bLVpssMeZ6ebI1hXmyhUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kooI04oOnTDRmn4kqSM0QzZtzhPtx5ARc2D2kmuuMHItrMMRUR6bGlSrPip/6C5iMp+wYiuKWkldEPW7tu5kSNMkTeaC7AzkR90CLnLXHg1zV9KcmHxs5/0af5wYvC9XusF+FpX/P3f5D2bKT+hLeClGkmSj0fJe/GDScfnSjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b=bPH5FtEf; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b="bPH5FtEf"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4094b31a037so4072189fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20230601.gappssmtp.com; s=20230601; t=1774964643; x=1775569443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQ99ZO5QOycXZmDuvJz1p/CKA7WICxsOG1IqStLAtuk=;
        b=bPH5FtEfxBdStchc5SgtDHg1M3QrgYv5RZVm6nFMr+dc7dwWKsNiw3yLdL/C/tMjJq
         xf+BkdUcFcTHQQPHdew07/gs+AaJALL+SZsLE+Ody7CUI3Luc8YePLkGZg20/wYL0gsq
         8Ed7fXSLDhb1P1sh8BajnR6LYNWEQgCfFpB20VgT4aT1We738S7X8c3Fw+XLDHWSNXVY
         24uzgMpXj7p2K4FtJd8vzwwQeBaDB0Son/dIjahjii6ZyDIe86STeUHzOfwsgeiI/oxh
         ECQEgZ72ACtoOlvm1XGmmB6h2LjMw5lYmgElOShFYKc5BCeI9YiPv3NMWCcmqy0Tc+VC
         i3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774964643; x=1775569443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gQ99ZO5QOycXZmDuvJz1p/CKA7WICxsOG1IqStLAtuk=;
        b=a05pO3jPfgY14sZrSHyaRdMvhDzQ9ORBx2WZxCbEEl11QFEULgEP8LQxDyjeYRgVSf
         lC9V+tqnXcRlpjissH91nUoxPspuvg4OH9Pgn0PmXzNlkh8zZgq1QmlaSGRVbP6sb8gS
         i8GjpLEMgWjOzV61JH24iY1nWVsRM1krgWGxaPIGnMV12UOs7jMkHy4lVfBglh4VtCon
         35chQQD3MROGwX4lCyHEHOy+9N2cotNl4aXgQ1C7IHxe8m8WXIJfur5H6MI3NATJ7lDS
         iMJUmYvlVujJPVqH/rwalFIDYcdWNn5smLVbRwWQyFW43jTFL13Nkl0F/s0BkEFLF5Mt
         o/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGfORGuXZhQ0vUnZKXm7FctJa0iJwHx/aAYV56M07ZaYZNn0j06IZQ8HYU9mZjqI2tHSPra7oifxOyFNrK@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdPGm1PQUQ29sopI82pMmLDNesCU1+c7l/o2kmA0F2llXASMd
	30/PO080WsH97v1gGvTngNIJ4UnJCuOSw5BLjxFMncHsWgRLDaozE+NdyNkBcYucYGZo
X-Gm-Gg: ATEYQzz6og4WTQvAPZFdnMi0IO1rGUSLrloAXTe3JVP1QeEozXAAwwFPsMYcKrJ/qCE
	dom+kCVaNC35J7b0gTV4td1cCs9amDvMz78N1nsmb/oUJDpMU6qigXnRVv/Z9tmT1FAadD90mcr
	CT4tvkOJZfWOya1txHt3fyjpMQFw3bb+mVvHMkKgOOD4YH04EofbKudPKFbeZ2P0YxW8F4PPde4
	5wyFo9NqCAGBTed6Jl5DHLfpSF+YCRFmuz27vkvCw1hZKrgszOyUabFptfB6IiYFTKLuB+JC8Um
	r9hg4mzJiXuQWIzN49dbXvCD1w5q9oyzFo3gFFdBNOzILjOc7Ri9f1vMPnX0j4Av/H03zsnkihr
	GQW5gxCS9EF1hzuMF4s5Li+7VVCID1p4ErGgBsliWhSBY89WkVl2jMD8ggSEA9JWTgHD1+5eeEg
	NGnDTobU2nsPTzTLYCiDbu6ebB3QxZXOo6nRvX+8U5qIBx2k9dQh2uHnoP/xNJRavi5tID1OOx+
	ZNibsv/qJX8sncYfL+5rAEV
X-Received: by 2002:a05:6870:a552:b0:409:6227:d313 with SMTP id 586e51a60fabf-41cec31a53amr8250852fac.35.1774964643278;
        Tue, 31 Mar 2026 06:44:03 -0700 (PDT)
Received: from thesius.dot.cyphar.com (2403-5809-a2fc-2-a90-9fd7-aedd-d405.ip6.aussiebb.net. [2403:5809:a2fc:2:a90:9fd7:aedd:d405])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04d95bcasm7470456fac.17.2026.03.31.06.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:44:02 -0700 (PDT)
From: Aleksa Sarai <aleksa@amutable.com>
Date: Wed, 01 Apr 2026 00:43:32 +1100
Subject: [PATCH 2/3] selftests: openat2: switch from custom ARRAY_LEN to
 ARRAY_SIZE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-openat2-selftests-kunit-v1-2-5819ac6cadf5@amutable.com>
References: <20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>
In-Reply-To: <20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <aleksa@amutable.com>, Aleksa Sarai <cyphar@cyphar.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2991; i=aleksa@amutable.com;
 h=from:subject:message-id; bh=2K20XJ/gwG1IJLQsa/W5M4bLVpssMeZ6ebI1hXmyhUg=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSePj/9pJz3xo8KtwRPHP3m562hZjbxueKp8tCTqwu+q
 C95VuMzq2MiC4MYF4OlmCLLNj/P0E3zF19J/rSSDWYOKxPIEGmRBgYGBgYWBr7cxLxSIx0jPVNt
 Qz1DIx0jHSMGLk4BmOqPuxgZvkT9lO+9tiVabPK0qKIqk0wZF7V/jrmuXKc3yn1qKJe8xMhwrJ7
 Z0OkSD8vD8kOH/0lItEZo/k4ziWt25Tvo/uLImWd8AA==
X-Developer-Key: i=aleksa@amutable.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

For whatever reason, the original version of the tests used a custom
version of ARRAY_SIZE, but ARRAY_SIZE works just as well.

Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
---
 tools/testing/selftests/openat2/helpers.h      |  1 -
 tools/testing/selftests/openat2/openat2_test.c | 12 ++++++------
 tools/testing/selftests/openat2/resolve_test.c |  4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index 975de513af86..f56c0c6e3ad1 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -17,7 +17,6 @@
 #include <linux/unistd.h>
 #include "kselftest.h"
 
-#define ARRAY_LEN(X) (sizeof (X) / sizeof (*(X)))
 #define BUILD_BUG_ON(e) ((void)(sizeof(struct { int:(-!!(e)); })))
 
 /*
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0e161ef9e9e4..c6c26652ac1b 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -83,14 +83,14 @@ void test_openat2_struct(void)
 		  .size = sizeof(struct open_how_ext), .err = -E2BIG },
 	};
 
-	BUILD_BUG_ON(ARRAY_LEN(misalignments) != NUM_OPENAT2_STRUCT_VARIATIONS);
-	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_STRUCT_TESTS);
+	BUILD_BUG_ON(ARRAY_SIZE(misalignments) != NUM_OPENAT2_STRUCT_VARIATIONS);
+	BUILD_BUG_ON(ARRAY_SIZE(tests) != NUM_OPENAT2_STRUCT_TESTS);
 
-	for (int i = 0; i < ARRAY_LEN(tests); i++) {
+	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
 		struct struct_test *test = &tests[i];
 		struct open_how_ext how_ext = test->arg;
 
-		for (int j = 0; j < ARRAY_LEN(misalignments); j++) {
+		for (int j = 0; j < ARRAY_SIZE(misalignments); j++) {
 			int fd, misalign = misalignments[j];
 			char *fdpath = NULL;
 			bool failed;
@@ -241,9 +241,9 @@ void test_openat2_flags(void)
 		  .how.resolve = 0, .err = -EINVAL },
 	};
 
-	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_FLAG_TESTS);
+	BUILD_BUG_ON(ARRAY_SIZE(tests) != NUM_OPENAT2_FLAG_TESTS);
 
-	for (int i = 0; i < ARRAY_LEN(tests); i++) {
+	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
 		int fd, fdflags = -1;
 		char *path, *fdpath = NULL;
 		bool failed = false;
diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
index a76ef15ceb90..f7acb4300641 100644
--- a/tools/testing/selftests/openat2/resolve_test.c
+++ b/tools/testing/selftests/openat2/resolve_test.c
@@ -436,9 +436,9 @@ void test_openat2_opath_tests(void)
 		  .out.err = -ELOOP,		.pass = false },
 	};
 
-	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_OPATH_TESTS);
+	BUILD_BUG_ON(ARRAY_SIZE(tests) != NUM_OPENAT2_OPATH_TESTS);
 
-	for (int i = 0; i < ARRAY_LEN(tests); i++) {
+	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
 		int dfd, fd;
 		char *fdpath = NULL;
 		bool failed;

-- 
2.53.0

