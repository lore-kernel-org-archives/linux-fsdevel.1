Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684A331A5E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442141; cv=none; b=ZZIW7/PRA+MOdHLN99pYfQh//fpx0BLg9DBqB148ZOnL+y2aG9PgzBvjOR7y6Abotg5f3XBqhIfOpt/zfdLPyRh5qVG9IlS1ozb4sI3WWKfvGGIG//nHN8WgAO8PILPytIflWSlk69hJygDljCOuTU8EJcI1djW7ucc7D2GniMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442141; c=relaxed/simple;
	bh=tqewIhbRqq1adswiVbpduoDW8JX3z3VKvL2i1Kqr57I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ED5xnk2DcKMpfXWI+Kfa/WwBbfwZZ45O84QRrW9zTnbU1wRtr/FqgcDjLioEtl6b7PFBz/UOQ05wJcXSzX5Fez4G0Xkglt9WL+sw3U7iF+MVC4+6SR4+WXh5Dh/YrYINBkctCD125HnHMv2vu+XyJ3SYB/paZ2mPsq40XHS3Ggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bePWme8q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bePWme8q"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c2af7d09533so2929857a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 07:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769442139; x=1770046939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFHTE7+4vut1ZBbXi2BaQWFLCQQCwb8j1cvQskcZkjo=;
        b=bePWme8qPU39g65mrF5KWvwERR0PvniLQwnyJWyokZP3mWNwFl32zxMcwVwZKlrBUu
         Ft1QUwKr2Jk1goOBfpENojDRUjlvKaMq2YBPZEdvK2ztrytV8l/XLlxI9Yca/dr/o7XV
         2bt1f9xijzV/HJvBp3AuivgNJd1AA3s2t7XY9KqpWaEwWfvMwYmTEtgD9/v7YuKAUNDT
         u1GarTfANyacMt1rLF2GO3wWYFdtgwbhqCKfzo1g0AOrilxhnuLP/aNr8NUWGOOzrRwJ
         +hwJeB0P2OmtAmvBsUUKq7zd6HrlVt1zwONAWf0RADCAZHD8kDGwRYITTrGBc2Ivd2yv
         3xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769442139; x=1770046939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EFHTE7+4vut1ZBbXi2BaQWFLCQQCwb8j1cvQskcZkjo=;
        b=UCIc7Ri0smSeF9/PYqYaFDx2DcruWdtmKYvQaopJMId4s2t2xs9pg+DmiX7SP8LV67
         4er5TRsP3WUiEF4UkP50a6Clgrxeu8x72jAJKNcCbcmqsgP2/mwozcSfKmscjhQ820f1
         24NJ4v/Sb2xHSLr9o/e5kxwZrbKNtxK39Vc3SNReB1zLnlhQTn8vpMFOgBu8uI4dviQk
         5tDU8Fk8cXYr+4YrtpjCoYWjUV98AoUePpViEp9kXmW4mZtbiSDcoKG5EG/rOA+Aoo8n
         y3YSjZ+bF1oDpPJ/4xh2TMmrQiebG8ZUWjN/Gv1nHVTPm6SKivI6Tm3WjEnhXGfE4Dul
         M/JA==
X-Gm-Message-State: AOJu0Yx6ymtRaG6A1gJY59F926MDwuS3oj6wls2n5KGw2Dfu1PL4Vkvu
	MZbRPuEPDWGsgf9TK9VttELlbdBnfm0VTWtTuyC1clGWumqfXkd7Jzjvu95tZw==
X-Gm-Gg: AZuq6aJUSuonaxiG/fo7VuxCc6FDJxcNrEwfFxKf+iNUMh/+c+Dqd7hX/FSvN4cjDHr
	CYWmD1zrmv4FOThIySPOu+xpu43AG9opXfJkEvAgZrLz6l01tL3Y/aG3/Lb88hXwZDdzbPP0d9b
	JfIMfMmkISfmnIWWAY4Z+D2zwZAp0bb9ObggPdT8KNPL+rppj1ZtApBFwl9cWR2dTRrqsL5GbtF
	vmL3xbEqQxdRWoxYFpIORxh0NrMRH33oXFUiNvjEy3wK4p/CrEw24fJdcvle6XgeXwNUvp+pyV1
	akyIgXLypSiex2Z1LNOFJJJCNHGDcXApneSbyy+68LCdk5J0M/smcq1uk256016h6WmGtCxXhPf
	s4D1wun+g5HR0yLd1UQSxEIwDBk8K8w85vxMPpJm7msA9RT3CLWG9ji8HOWDUxdITYaUb7QAojC
	sXK+49gPSzeAeBlJ11xFBynBW7F4goWfVN0GZ69e3mgp9FN+BwlIMo3A==
X-Received: by 2002:a17:90b:3a4d:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-353c40b88f3mr4065706a91.7.1769442139114;
        Mon, 26 Jan 2026 07:42:19 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536d88b098sm8649100a91.3.2026.01.26.07.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 07:42:18 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de
Subject: [PATCH v2 2/2] kselftest/openat2: test for O_REGULAR flag
Date: Mon, 26 Jan 2026 21:39:22 +0600
Message-ID: <20260126154156.55723-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126154156.55723-1-dorjoychy111@gmail.com>
References: <20260126154156.55723-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a happy path test.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0e161ef9e9e4..011ebc9af4e5 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -320,8 +320,42 @@ void test_openat2_flags(void)
 	}
 }
 
+#ifndef O_REGULAR
+#define O_REGULAR 040000000
+#endif
+
+#ifndef ENOTREG
+#define ENOTREG 134
+#endif
+
+void test_openat2_o_regular_flag(void)
+{
+	if (!openat2_supported) {
+		ksft_test_result_skip("Skipping %s as openat2 is not supported\n", __func__);
+		return;
+	}
+
+	struct open_how how = {
+		.flags = O_REGULAR | O_RDONLY
+	};
+
+	int fd = sys_openat2(AT_FDCWD, "/dev/null", &how);
+
+	if (fd == ENOENT) {
+		ksft_test_result_skip("Skipping %s as there is no /dev/null\n", __func__);
+		return;
+	}
+
+	if (fd != -ENOTREG) {
+		ksft_test_result_fail("openat2 should return ENOTREG\n");
+		return;
+	}
+
+	ksft_test_result_pass("%s succeeded\n", __func__);
+}
+
 #define NUM_TESTS (NUM_OPENAT2_STRUCT_VARIATIONS * NUM_OPENAT2_STRUCT_TESTS + \
-		   NUM_OPENAT2_FLAG_TESTS)
+		   NUM_OPENAT2_FLAG_TESTS + 1)
 
 int main(int argc, char **argv)
 {
@@ -330,6 +364,7 @@ int main(int argc, char **argv)
 
 	test_openat2_struct();
 	test_openat2_flags();
+	test_openat2_o_regular_flag();
 
 	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
 		ksft_exit_fail();
-- 
2.52.0

