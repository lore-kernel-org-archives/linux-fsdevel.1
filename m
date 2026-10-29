Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234988;
	b=AyapQO1X6WXprVVkfAj+S8VEWpZ/dBmbNVz7fYl23fqWixu+Xh4TyRd0y9s48kc5RVdO
	 ZWRgIwsDUpbsnaMRv4BKBny11TKSeZMa9yR5GNoXREiSjSuqyAPXkDRrH34SUr9Rjve+F
	 g8Q3OIoRGbGrajmJLhTWcJ2e8C+aYTNjv8zCQtP+8HHCRjy+kZmjiN4hpfIqtGYSQFFec
	 3dh7Ipf5EZXpk20IyqQYlFp3NE+mFxjlVmxTMpXUNnY7iePouhO1BlBmJK+w+6GgVv9dh
	 JD5QzjF0jUsJY8hZ9lbSPkI6UNjpefjTIuCMM9LxBtAgbaoajvy010MDpjYkPaX3rxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ln037Pf3YbKMICLinA76e7sVprd2bC8Oq7bCHhU7/t4=;
	b=3N/fbnDuFcOmGWxFffsOIEaTMwbkQUQFVK61CJZQ//tV2NQEXQVkQSW2Kl0JoquSbc0N
	 Nrb59hh2zeF23ui7kElXgx4gAJZUoIWU/xwuVNBBq02uCbB+MHrDlmlgqlP74SQLUdT6F
	 SLEbiDl1ti/M6w5XAXXLU7ntLoCx3TOJ+SCMsUrvGOsvh+YdOHPeScDSlaB0CuC3QQqFb
	 WUbfn8OzkE+jibr0TrObVIGqey5Oo/UKdtdcB+yPYyLKLwHO9aALhR03BBb2eHt/S1Zfh
	 5BRHlpPIGH6PGK5hnB/7Kg0CpoOArgBItvg4fdU54X3SCj0IxOSAk9LyUl221YGlDPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNxVS+EB;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6B0606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 00:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B6B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNxVS+EB
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36888ae05e7so485461eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793234986; x=1793839786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ln037Pf3YbKMICLinA76e7sVprd2bC8Oq7bCHhU7/t4=;
        b=oNxVS+EBLQTXgN9ZgA9vhh/UjS0dd/L1o2EJbRCC6paxeQ1iJpTs7nACX0fUu5MJBB
         CcT5+ty6Viq2+DD1q51ZxYnAWGCRTpVMo/cfWF9TMjBy7xlYAQ2xE+oqlnkh0PHiyDfu
         UpbnY25WeXn8awtDp6O2fY8hp8vEwv+sfckLii7jjTw5sqTQdUW84iK2Posnxr3pXgMn
         BjTJX450ZUXQVfO1JEn+MiYalrtfc6BXBEYsthV7S0QGrtP8aUgkXfi9CIvuLQwtcQkS
         0p5Sw91IuSnqvKlawWbKVhNz9nWgvdY831aucFWtQ0/yyKG8EuzMr1xRxC817atMmMKo
         JBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793234986; x=1793839786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ln037Pf3YbKMICLinA76e7sVprd2bC8Oq7bCHhU7/t4=;
        b=W151XtJYvYg7UPLZ5AMk55zH/2dswhxMDhzQncujHltw5e+dEoiVsnOHtG9rhri36j
         iJvSI7H50JSN9Jk5jpXFWIZq+vHmIt5//bX5fqdIYSNhGxNM8FWJxBK++CkamRNRaoQO
         8nolKAiIMfTprC2FXwAaxiX23di2wNAjcc9z2V0rO1HtfAVVGHdOIjNnsz0hKV0Ty08X
         YQyUH8tOa3kPq5IqwZxgdkT485p7NDg57CkGZfLJjepXAU67UTjumIR2O5BNQtQODDok
         S+c2eG10PxD5qVm61r6GvkJ9b8MspIHr4ErucU0Y/1MQ/u42Wc0EicHkrVYMKXKshwoV
         4dhg==
X-Forwarded-Encrypted: i=1; AKwUvBzJgyZOFeHH4jHB7Prc/2POijRBp77YnybjU+vgBFBUvD2MZaDokr5wBSArRUDGW5VizX1EZQLZ6ne/OKYE@vger.kernel.org
X-Gm-Message-State: AFq9FYLcF5vAVG2n76qpK612N0zBR98s0J3nuMS6A+c8V1VSQMu3s0BB
	LNtJneIZvhf9FqHbjSA1ATN2zvRwx25rK7tC27EmSAgY9CWOWPjyqrbh
X-Gm-Gg: AYBFou3IWb/tPRQVQa4OeS5tLmPtiLf0Qcv4J0QpeYn9fT6bUmBlGmruxSWVSh/aNfz
	xxRK0O9XbjkeF943C9lLBOyoWjj8GzNMGDNKwDHxlzrWjoZ/R8wsO6t6cgwRy8G/9BWIopsMngN
	4v682prnqebsPNbb+4NS3eSi0bjKGAfhVw2u86XiriPUlWfGjz7cNBD1cL9UkGG1cDEyM4tYOWV
	N2x/mM3e2uIeN6yD95lMdDZ3Y3kICVNdiX9VwgxnJFrEw5A0DhQojChymZRyS8VrOUmbJVYCXIX
	T5V9OPx7vk1uz4+cJNOdiwcKiy7jmt0EvmvzENadFIjSEECTebH49pi+9d2vg4e7MUqvG5A9Ghd
	3NgZ8YOkDSkHXN465HTGQbIq/6/aNuMSPO+apmAC7UiCQrYd8y01/Sh751bTWepTBM1qfShq6hs
	LW29gB5LSvn5mZ5BL4YYy60UxA+P9tvscpnUDL68PbBn9IzxZ5c3x9/WU8CDWYlIfHkxAw1I2hq
	U6F8fIsfk3Op909nHhaC15ffplD3UTjK/arYxK3J0Mt1gsKAlk2dAC1IG3UTF80CY7jOWQs/toA
	MvaQghrEVUBbdpdBR71Qy/qUWHiJG3aEdL4OUN+nj0fPvddlPzM5q7a1
X-Received: by 2002:a05:7300:d101:b0:369:5583:bf4c with SMTP id 5a478bee46e88-36a200c8c63mr4761503eec.28.1793234986083;
        Wed, 28 Oct 2026 17:49:46 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2399b05dsm11195789eec.25.2026.10.28.17.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:49:44 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jack@suse.cz
Cc: sortie@maxsi.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] isofs: handle Rock Ridge long-form dates before 1900
Date: Thu, 29 Oct 2026 00:49:02 +0000
Message-ID: <20261029004902.76944-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

iso_date() stores the year relative to 1900 and rejects negative values.
Rock Ridge LONG_FORM timestamps encode calendar years from 1 to 9999,
so valid years before 1900 are returned as seconds since the Unix epoch
equal to zero instead of their recorded dates. For example, an 1899
timestamp on an image produced by xorriso is reported as 1970 by stat,
and cp -p preserves that incorrect time.

Use the calendar year for both timestamp formats and pass it directly
to mktime64(). Keep the epoch fallback for year zero, while allowing
valid long-form years before 1900. Short-form dates are unchanged.

Fixes: 5ea45f54c8d6 ("isofs: fix Y2038 and Y2156 issues in Rock Ridge TF entry")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/isofs/util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/isofs/util.c b/fs/isofs/util.c
index 42f479da0b28..6f9a90e58a89 100644
--- a/fs/isofs/util.c
+++ b/fs/isofs/util.c
@@ -25,7 +25,7 @@ struct timespec64 iso_date(u8 *p, int flags)
 		year = (p[0] - '0') * 1000 +
 		       (p[1] - '0') * 100 +
 		       (p[2] - '0') * 10 +
-		       (p[3] - '0') - 1900;
+		       (p[3] - '0');
 		month = ((p[4] - '0') * 10 + (p[5] - '0'));
 		day = ((p[6] - '0') * 10 + (p[7] - '0'));
 		hour = ((p[8] - '0') * 10 + (p[9] - '0'));
@@ -34,7 +34,7 @@ struct timespec64 iso_date(u8 *p, int flags)
 		ts.tv_nsec = ((p[14] - '0') * 10 + (p[15] - '0')) * 10000000;
 		tz = p[16];
 	} else {
-		year = p[0];
+		year = p[0] + 1900;
 		month = p[1];
 		day = p[2];
 		hour = p[3];
@@ -45,10 +45,10 @@ struct timespec64 iso_date(u8 *p, int flags)
 		tz = flags & ISO_DATE_HIGH_SIERRA ? 0 : p[6];
 	}
 
-	if (year < 0) {
+	if (year < 1) {
 		ts.tv_sec = 0;
 	} else {
-		ts.tv_sec = mktime64(year+1900, month, day, hour, minute, second);
+		ts.tv_sec = mktime64(year, month, day, hour, minute, second);
 
 		/* sign extend */
 		if (tz & 0x80)
-- 
2.43.0

