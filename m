Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78293D564B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339597; cv=none; b=e2LKPgcPEzosVxIe5NJ30RR8WvAaimdSPY8Z5M1HUhWHJ/9AjEDiXd6Ww4nCo+9QjYWbNL04fk88JCibh/Nyy6YpZNIKHPkbijpDiEwyPzM4uxZJcBXmV0TenN/nDuRHIP5+UPEU50L/nfiNsGTF2MGJpFaM/qO4qaSQH6aJcqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339597; c=relaxed/simple;
	bh=Gw1SCSlNuMse+SG+zQJpWkpT8cU8C87HSDevmWU523A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P7uO/K5sggXHbiJUqtvjWV1XlGp/aRyAhkDISpLk/Iam2GTOP+BIrD5L2W/GPlT0N8ZLwTAw1Q9fcAMBeHJWhWvQU7Cr7VMSyNDeoHfEefRAfFptUKVYrRBP18n+uyW4gF9DLr4o2T3eSXhd+AC9G8fYCLB8B+QqcjDmoK+XASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vv5O2oLR; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv5O2oLR"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so1242496e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773339590; x=1773944390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bd82W9EWXsyf1ygE+4E7KIjySZctQNSmqHpy+W+OXjg=;
        b=Vv5O2oLRi04YEaLNAiOsI4UkolO2jcGto0HPepE54Mbai+qIfxhwCw1jh4v2ZPBuX3
         XdDLSPDFqzaqjOYqj6pINhbupOSzYjYALWB/r8wsY4bbGSYA9FmzwNxcidLOb+bcCdD0
         uZon8wM/Z1lDsNpDfX2pIR4xXDAYUMp/NYEibSlApV1keuIAnjYGzrCwB345v83gtPwI
         ayskDvNHOQXRvumWla92kChrawP+hQz+8spCNT+JbuFhf3wXiqofYqEDc2Yo57p10nN9
         cznDTug12bg1a1YbrtumomQS9WzERb0EwyXe0N0DFR+bzamd61cpU7OrKmYjGtEjBjmm
         838Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773339590; x=1773944390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bd82W9EWXsyf1ygE+4E7KIjySZctQNSmqHpy+W+OXjg=;
        b=lY18zKxZkiutKknTbIWacp7W7RcHMBzIDrwf8NVrYIvmuysJvwd3K0Ux1U8bLV/VCs
         2gWiKoGfLiDbfeuNwHSsyUcBP3oq1pPfo/3vQF3hOStd7I8E5q/7GFY+HHh736bT640j
         KBZnsiqy85/nrDNpM7gWBe2zaWFwEjA4vSZXa/uyVlGJ/hHajwFHUMX/dDNaSc+V02nc
         33UHe8EqKvrs2t10UgMXP5YkwSnESWGj9O73fmR5y2OywAz44OMQe+BBysHKZy6SmpTi
         kbOYcBOUq3iF1tHFwaQ5pjA/qe8JvzWStHkN7KPJz+kxw2bpwSmq4ZKI3xXScmr+zHjc
         fsIA==
X-Gm-Message-State: AOJu0YyZxVNuq29F/Yf9+uSuwdVYTJKUbNgImdjgLcrbTgwYErV3OPnS
	HFukxz0xRKKLQyrBuDAEytmtZIxSCNTzRQBkUKu5nvxLodQw0H2b2a70
X-Gm-Gg: ATEYQzzN0cncL70rAZuFesxL7mbayW03Luw7X8LkKxjo39oIQKaVF2MI91+7+vJrkcH
	PIef+Q3OvXJfWmK9tl9fVn/CiHBzw5Q5k0kzch/7kBUkg+YWW6djWMK8viNTWzpcKGGjiUbkNCO
	pJJ5PTttD/ZX44qjOJj46P4iSs/BinEGwBkn9778RtBMIV2VXSi6s3bPhqF2p7T4Jfx4V1NRZOx
	EWx5aACti1UO/N2JlG4eEvchEc617QyqADOHsxFdEpz64BJySofJkSnHi6wR982dVzuV0JwfciL
	L0K1CVyMlsOQSbYmrUmsz8mDId2qSHaM2M5+tjMHCpVNQY+St9n8eXqDt9UbzEn1Fqk6eZ6PcpK
	Mg0XdiscShOUjJtd8CBpSMDhhPpf7dHrYXDU1Xc3WqV5muOov0igLhD8W9z/vArGMUdvcjjtzYA
	7sXPUgkQ/xp4ADev0h5Lepa0gNK+AX8X9MauZl7LapbB83hHdN2KcrvjzrTfy5JmDsUxFJJHVYc
	izjynvw4Q==
X-Received: by 2002:ac2:51d6:0:b0:5a1:3fa6:8c62 with SMTP id 2adb3069b0e04-5a162b0c0e7mr217244e87.24.1773339589410;
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
Subject: [PATCH v3 1/2] lib/idr: fix infinite loop in idr_get_next()
Date: Thu, 12 Mar 2026 18:19:47 +0000
Message-Id: <20260312181948.20020-2-objecting@objecting.org>
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

In idr_get_next(), if the returned id from idr_get_next_ul() is greater
than INT_MAX, the function issues a warning and returns NULL without
updating the *nextid pointer. This causes a soft lockup for any caller
iterating over an IDR (e.g. via idr_for_each_entry) because they will
receive NULL, fail to advance their index, and repeatedly query the same
state forever.

Fix this by setting *nextid to INT_MAX when the bounds check fails,
ensuring the caller's iteration will terminate.

Also update the idr_get_next() test case in the radix-tree test suite
to expect INT_MAX instead of 0 when hitting this condition.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/idr.c                           | 4 +++-
 tools/testing/radix-tree/idr-test.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/idr.c b/lib/idr.c
index f25bd2b9e9a4..07098eb4ddc3 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -268,8 +268,10 @@ void *idr_get_next(struct idr *idr, int *nextid)
 	unsigned long id = *nextid;
 	void *entry = idr_get_next_ul(idr, &id);
 
-	if (WARN_ON_ONCE(id > INT_MAX))
+	if (WARN_ON_ONCE(id > INT_MAX)) {
+		*nextid = INT_MAX;
 		return NULL;
+	}
 	*nextid = id;
 	return entry;
 }
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 945144e98507..bf6a0da6a50a 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -213,7 +213,7 @@ void idr_u32_test1(struct idr *idr, u32 handle)
 	ptr = idr_get_next(idr, &sid);
 	if (id > INT_MAX) {
 		BUG_ON(ptr != NULL);
-		BUG_ON(sid != 0);
+		BUG_ON(sid != INT_MAX);
 	} else {
 		BUG_ON(ptr != DUMMY_PTR);
 		BUG_ON(sid != id);
-- 
2.34.1

