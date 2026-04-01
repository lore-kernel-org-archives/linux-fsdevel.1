Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093640DFD5
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003316; cv=none; b=DqV1f7LMJI71rcydfY/z5cu8lYKKEl9w56h+XZL4DyyeVv5wNfluGUAB9A5pQigA/JkU21urQp1e25jt45sRA6Ql70GU564fbvBGdvq2vGhTHsj2ImyCleEbeOImGo9AgtwL0tFAK0OiWC2WDTrVXD69GReM3NpS3QvwQMD09Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003316; c=relaxed/simple;
	bh=PpofUhHFeqNmF2EPmF0nTEHj8cWFrIuv18vLhSjs8c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XpzQjwLBHTZee+7iknpvRyhOqUPfPlnu5GRfVjAVRb9AhvPqk3kk52ZSfLg0cLDkK59KiHmyn/mb49s4nNL6rJK46e3WERlAq53KpuJsLfvaDZCYY/hoyGHLqMWfZSOmafIhsewSoo3yBzx+mvbpv9+VfjJrCaOaZ76GNrKXXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b=Ya0bOa0k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b="Ya0bOa0k"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a8fba3f769so25929335ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20230601.gappssmtp.com; s=20230601; t=1775003315; x=1775608115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xdtigM1MnP5nQv3PSNQ++1o7F4yals5CCvEBR8RONk=;
        b=Ya0bOa0kuuzoQ5vOCszGNOybkZ2dOnuJrXOpyFC1Y3JELAN+t2b0zwM0SwqP0Mmxvi
         XWRpXz0+7RL+Suu/LMaQFg2eZ+/OH5tXzLPkod/qpN0+Esqy3sEwJlzCOaq2Tjhc86Y4
         0l7lPxHO0FZHa+xklttApkP1icTw0JHf3BZrUOLcYOJ2FxzJ/jgnVsN/SytdtIDWgs+B
         1L1hJL6XX4LIXdTAk+lYaug4Lu7O7GTyl3WP2qkwzwV7gZ4z3b54RbcCWxxSWYoqOg21
         3OYgCt1KZSwGdlt0HktiBRRxo9RE7d18iDm6ZUj/1RznVhGYC9N0U4glSOJx8hX0no00
         +9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003315; x=1775608115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8xdtigM1MnP5nQv3PSNQ++1o7F4yals5CCvEBR8RONk=;
        b=WOvrkdYpYbWJiQUGdZFZU/wtpXP68lNir2Ab5ErdqKPagOkkb4IFLNbA9yo6DPuym9
         y23/fpPt4rrsMzQGRjyHuKcIU53qqvnrRKGJKxMsYRynRdjk218RY9zI/YzJws/PSaTO
         gVk6NSFXhvd0hoheYO29HLYpQQPxH+yfoad6mj4uPDCUqCYfJcOehATmVhTtLXRaIcvb
         x4fJlQ0NfCForaZUoOvmoEWCmbhwZGCG4/3htCDrQR8USD8kUaBNTaIUkygDgygJDmMe
         ykacqF0UXCPJe8/+OgsT1x0AQDH+jNtcvx7U+xrYhKTtzNqCW4KS0LHnXQ7Gk8fKVf4p
         e0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC68fuRepKIHoj53kFc5dSkY1xekIBGKmRAJE892Jjhvk89+v0GtzebgBf8qxLRYwHv6dX+STnBRZX5hxB@vger.kernel.org
X-Gm-Message-State: AOJu0YzN48Td82kV8Rk2zGikejswafcLqTw5dBuX5lvLhqi7CCDvHenC
	ymN6Rx/k96Z6AZlJHlhfJpP+yAzQrGqvCkNEQnxuXCvqyK9t7FmH3xDy5a//2/iUXDfY
X-Gm-Gg: ATEYQzzrAlWIihbBipxmGjVl5dS/xfDecYrW2QBJfxr+yv6BVUN8ryc+hohoMHEcbeg
	W22700G4tn/AqGFQdtmSG1yxAdslbBFJzyD5t3+6JxhfQ4LTIpIBUE8oa9a96GqGGqS4fMj6r6a
	F1JPQ3Lwbq79BlzTKPc3TP0qWtJGdp9GFw74fM7Z0V5UPxelepHcVhHMTF8nSrENacDcFL0n5pt
	a1HsghLmaeHgzQ+RlBnuQqisbfUcrP8YiwcwpHWNNeYCB2H7RZFvEAqjQAQvpHlWBqap/cQ8Q1U
	6eKPCycA51vb0KQg1scygD6Vt1cc/aK7HGWtwsSJxwYM7895dYcBz6Du0hYITcA6znFiYFbnzeQ
	Q8DIwWn20RzZtktaYHqZZlqPJAwQCx+jNeEyu0/G3BzEui5MqzNW2TRNZSrVDmHvwqzxsm3GIxX
	Klt4A8q5USz7zQZN1WSB4Q8MvtR3lChMMqTLH2ov1ChvSfNhSJKr0N25gl+Qqrgh7Px5Khg6Dhn
	ytBSkd7jCeKGYQXPnE3O4xQJQ==
X-Received: by 2002:a17:902:e551:b0:2b2:5840:8089 with SMTP id d9443c01a7336-2b269c42c9emr11858965ad.27.1775003314973;
        Tue, 31 Mar 2026 17:28:34 -0700 (PDT)
Received: from thesius.dot.cyphar.com (2403-5809-a2fc-2-a90-9fd7-aedd-d405.ip6.aussiebb.net. [2403:5809:a2fc:2:a90:9fd7:aedd:d405])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264264fsm157057825ad.2.2026.03.31.17.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:28:34 -0700 (PDT)
From: Aleksa Sarai <aleksa@amutable.com>
Date: Wed, 01 Apr 2026 11:28:04 +1100
Subject: [PATCH v2 3/4] selftests: openat2: switch from custom ARRAY_LEN to
 ARRAY_SIZE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-openat2-selftests-kunit-v2-3-ad153a07da0c@amutable.com>
References: <20260401-openat2-selftests-kunit-v2-0-ad153a07da0c@amutable.com>
In-Reply-To: <20260401-openat2-selftests-kunit-v2-0-ad153a07da0c@amutable.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>, Aleksa Sarai <aleksa@amutable.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3171; i=aleksa@amutable.com;
 h=from:subject:message-id; bh=PpofUhHFeqNmF2EPmF0nTEHj8cWFrIuv18vLhSjs8c4=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSeSVsSzr95Z/OdUyW7ph4XnbVwseiK4DfKh6Tlr3Qqb
 j6Tvu7xyY6JLAxiXAyWYoos2/w8QzfNX3wl+dNKNpg5rEwgQ6RFGhgYGBhYGPhyE/NKjXSM9Ey1
 DfUMjXSMdIwYuDgFYKo/XmRk6F4Zy7Vpz24nk37hii7T6d+1ll/gZygKXr10qoh666H/lxh+Moq
 ZT7nLtF9mgdnkpg+sNam8lx+IPDydmBejcEefMXEaNwA=
X-Developer-Key: i=aleksa@amutable.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

For whatever reason, the original version of the tests used a custom
version of ARRAY_SIZE, but ARRAY_SIZE works just as well.

Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
---
 tools/testing/selftests/filesystems/openat2/helpers.h      |  1 -
 tools/testing/selftests/filesystems/openat2/openat2_test.c | 12 ++++++------
 tools/testing/selftests/filesystems/openat2/resolve_test.c |  4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/filesystems/openat2/helpers.h b/tools/testing/selftests/filesystems/openat2/helpers.h
index 975de513af86..f56c0c6e3ad1 100644
--- a/tools/testing/selftests/filesystems/openat2/helpers.h
+++ b/tools/testing/selftests/filesystems/openat2/helpers.h
@@ -17,7 +17,6 @@
 #include <linux/unistd.h>
 #include "kselftest.h"
 
-#define ARRAY_LEN(X) (sizeof (X) / sizeof (*(X)))
 #define BUILD_BUG_ON(e) ((void)(sizeof(struct { int:(-!!(e)); })))
 
 /*
diff --git a/tools/testing/selftests/filesystems/openat2/openat2_test.c b/tools/testing/selftests/filesystems/openat2/openat2_test.c
index 0e161ef9e9e4..c6c26652ac1b 100644
--- a/tools/testing/selftests/filesystems/openat2/openat2_test.c
+++ b/tools/testing/selftests/filesystems/openat2/openat2_test.c
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
diff --git a/tools/testing/selftests/filesystems/openat2/resolve_test.c b/tools/testing/selftests/filesystems/openat2/resolve_test.c
index a76ef15ceb90..f7acb4300641 100644
--- a/tools/testing/selftests/filesystems/openat2/resolve_test.c
+++ b/tools/testing/selftests/filesystems/openat2/resolve_test.c
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

