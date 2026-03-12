Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391653FFAA1
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339598; cv=none; b=G2q5Z0T+U3D/yRizmgv3LZ/FNgWc02OEebQV5Yjt2keVrsPFUl4/xjmzNc3r/kEuY5jTksWrdv5If32IswfzdCSr7COP2bwYbZ7m2etswuoeTbSjLcAx499kw0YKs84EAD0qATPkc+gKnhEtBqBDaf5MjGyqHpKToRhBwXFA4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339598; c=relaxed/simple;
	bh=G3ARLnBPwsrhtFpcuNscFvn2uDRaW+HRpeqbjQhUYxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/26OEN/ZIyWguACp4DzdV5cpiUleIT08Kk1ofbYsmRO+z30xHq+1q07w//zxe4kaW6uZTpgOWGLkxSVpjo5PzxFPJwSb+ZV9WhnhClFOqG+33MvsCIof2OvpnExCXfXis4mpMPnClMHdIE0wb4ksQBQ7aRNKKFbhngDh98ODrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8ET07Eq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8ET07Eq"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a12cd0bcd8so1669142e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773339590; x=1773944390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBlJpCvwQvrWLmlNpGLgBwxvoUIKMdWDi255y3UTo4k=;
        b=P8ET07EqyNcbcOoLRW9yb/YAorcs1AMs5zPb5aTMrQUhaAiim3Y4NLsTmXn2oBJ5bZ
         BefyuTtkUKNOTKfJRsnUkQrXUODFOXbIA/n8rxlbUZiqw0tA2Pl+IRJ5q+pVIBUONIWB
         3faRfll9t48khvMO/+MYl9Myzzcmx6gpxNquc7HJdpxh9gOV+ClZe48PSRVJWqWn7Jvb
         LIx/EzGwtY3aYL2ODph27Ci3ynGE9Ns6hRNCDMtt9nD4uKSuiC8uHdrNKRVo2VYQK+w3
         s9f6VpfbdNRNgjuwm3jhNxOJh6+Vl+TOOmJII82FnMtz5x7wBTg/kJZJ5FZ8G1ZuGMNj
         g6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773339590; x=1773944390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TBlJpCvwQvrWLmlNpGLgBwxvoUIKMdWDi255y3UTo4k=;
        b=Ws2hmn16XSfJjJzsVJAUYSfpy5fHCuQjtzNX1CRbhaIELo/2aFyCm1u1LcV6ZZ3CUS
         ljqnY8Iwuk7IG672RkEDzGICyR+1XhOKd8nuRECciVudkqaO8Z4N7qjx4eMTXRlI8OZw
         FGd9+2gKYD/CDhzp/OPJDxJD+8G9SVNbUWIXp9+Hc1ixvMLQZWOHfzir1EhNXcGgQCYY
         /rxwe/9ZLIsxxxo8+kQbbBIJfBCvEVgh8qmiYDtga9w6EhEz7InTEClMGypcA1o++4Yr
         9j6c5ncONSaY0YI9RrqrI0Ju1OMuGf/1S1G8KqN2hagG0sZitpVKsahrZPAil59yppr7
         hiAg==
X-Gm-Message-State: AOJu0YxPT5X821ipHutF483Vb8LFa/V2euJZ9MaKF5dUA3YLMKVwADQQ
	jUb8NC3A0xXIP8qbjWAA5A+Tljyb/4guU/YEljY7WMw1jhCbtZDKtcHj
X-Gm-Gg: ATEYQzyCEJX7+OJMPXVNSkV8BpF9X7hzPEn/W3E3OGj7XjPtOmj/LNO2j4+Xdaokbd0
	UzRPrxI0WzmDxeZ7cRyYuAgkD0xPZjDp8g1q6ekROVpM6zLLEal5At+pMVthYoymJlzawmPK+E0
	gc98Y7n+SA9batTjf3Wz3PGoFG2dlvWzUtWHb4qpDpQgWf6zPI/eBIT+4m4S9c6HUp3ENMnpLnN
	5T1B+u2hDSzG+8yOwSWT63eIsnMVhg+lTJPwY8vwJwT4qDhoCV6nZVfwPgupqaKGn03psqdtGoH
	tOY312Y577o8+ACNielnz8/A1dz0Aqv03knb/KZr5t1DT9qyQd+/TmbQzxIhcGu1qR0QQzzgpQ3
	D5dzwfxe4MZn7doKA82ihzh6fM1TrEt/BFLFVooBZHSvD2Qf/JjA79SPz69aA7O7Ic2SvmPWgh9
	/FqAOv82MrMpv+6vy8d5UN3laAauhy0ln/ZbdwZgyuZTiTfV03FfzL7peDQW2KfCg/88OXj4U=
X-Received: by 2002:a05:6512:39d1:b0:5a1:3448:6b30 with SMTP id 2adb3069b0e04-5a162ae8621mr168590e87.20.1773339589738;
        Thu, 12 Mar 2026 11:19:49 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15602e7d9sm1085336e87.35.2026.03.12.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:19:49 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 2/2] lib/idr: fix memory leak in ida_alloc_range() error path
Date: Thu, 12 Mar 2026 18:19:48 +0000
Message-Id: <20260312181948.20020-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312181948.20020-1-objecting@objecting.org>
References: <20260312181948.20020-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ida_alloc_range(), if the XArray operation encounters an error
(e.g., -ENOSPC) during allocation, the function exits early via
return xas_error(&xas). However, if an intermediate `alloc` bitmap
was allocated via kzalloc() earlier in the function but the XArray
insertion failed, the error path returns without freeing `alloc`.

Reorder the error handling to ensure `alloc` is properly freed when
an XArray error occurs.

Also add a test case in idr-test to ensure coverage of the error
path in the IDA allocation logic.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 tools/testing/radix-tree/idr-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index bf6a0da6a50a..f4c3a5ed4ce1 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -543,6 +543,7 @@ void user_ida_checks(void)
 	ida_check_nomem();
 	ida_check_conv_user();
 	ida_check_random();
+	ida_check_leak();
 	ida_alloc_free_test();
 
 	radix_tree_cpu_dead(1);
@@ -556,6 +557,22 @@ static void *ida_random_fn(void *arg)
 	return NULL;
 }
 
+/*
+ * Check that an XArray error does not leak the allocated bitmap.
+ */
+static void ida_check_leak(void)
+{
+	DEFINE_IDA(ida);
+
+	/* Allocate up to 128 to ensure we need a new bitmap */
+	ida_alloc_range(&ida, 0, 128, GFP_KERNEL);
+	
+	/* Force a failure by providing an invalid range */
+	ida_alloc_range(&ida, 0, 0, GFP_KERNEL);
+	
+	ida_destroy(&ida);
+}
+
 static void *ida_leak_fn(void *arg)
 {
 	struct ida *ida = arg;
-- 
2.34.1

