Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541244;
	b=VhndWoCz0DsihLrvj4G363fIswFaG6Abjm/TrEsz+2RFUwQWoFehv3/BufxQwz66Dfv8
	 1eA7e/GzrviKGTm8OkAzab3XugdP4MGWAicLPr62koLvSm0HVzd3w9xEQP9zGXbsJIdS2
	 tmHcl1GY0lnMnWP9I4FgGAoFXpHDhFIf6gSYETU3k2ppDh8kWIbaDNMebfYQ3smF7teDO
	 HNbWIQaKWqjOM0PqYa9mUqYSHEHM5T7Iz57Cu7LDnR3J3kG/d4p9joNV2lctmjuoktvfh
	 kV56R1xk4Y0yldBVM1HCamInhgSjTljtj7BDNiTJSoZv3wSlq4iXYr5fE0zdeKrYXbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JURDH1Ef+kAXVQHZ24OyOfHYXwmX/CvYK84q+N+pCZ4=;
	b=u8wyr28SSo+B8v4lvqK0Rv+OW/BGTUr1A0Cf2xqqLs5j4UVfuGdDMn/+D2lJX1okZaSO
	 eW2S+plfyBRl+BgvNRxMiJ9NAcYFFGKD9BW+0PTxXCxxlCvINCCElFwXrPe+LCvGiRDGT
	 8mdiCHkH53M8hsclvVdp2WnIbusSVAAPJARYcW5QbNP0KQ2TmESWYn01epy1QbzDKnCQK
	 9sH33A1Qtcjxv56Ycy14lCmRUEHKSzO8Hb53z6xxtE7xEORpCOAQNmnYTlTAqudu4l+5/
	 El1LYgzq4nOfTI/BOpt2qCIToilIQGESHaMjtqRvD0gNxf3GxA8bGA6irtIeImDToPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=korea.ac.kr;
	spf=pass smtp.mailfrom=korea.ac.kr;
	dkim=pass header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=LsMerxoG;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D48606A326
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 13:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37D48606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=LsMerxoG
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b0d91601bdso24790547b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 05:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea.ac.kr; s=google; t=1793541242; x=1794146042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JURDH1Ef+kAXVQHZ24OyOfHYXwmX/CvYK84q+N+pCZ4=;
        b=LsMerxoGBqiqKoBcaGCNO1mksPlEOZfWi5ztLYpPxmeCrpVRtpUfYHxJxX60YQhQMY
         Rdg74suCUJhuAaQgfcnpGi3mXhOsV+dYuANTy99gTkec5kXmYlGIS6rdIAjvc/Rtuo8R
         ohDb3SVnEu1SxL6C9GtswQ4LQfxaJduzRiwH4oKd+9R6ntYN9TM/XMAg7Fdfo4FDOZlB
         TEvufIe6lJLgQY5fCBSeI3f1x9Vf9Qr/MprMgi751gDD7wxxLQGy0HvryVjCsfpYrXIt
         zbfaJzeEtvLtWK56BdWfq+PfTPWXmIeIWenze80NDxYk4J3yBOf14xPfp85ci06s3BMZ
         OTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793541242; x=1794146042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JURDH1Ef+kAXVQHZ24OyOfHYXwmX/CvYK84q+N+pCZ4=;
        b=kGV3b/gtpKZpE+8U7nv4LH0pxIPUIWUJSSTFSQ619EgxI7gPVBEck8Lb0X+I5J/d77
         8ymdpOElvEUhCGb939uuxoUVuua3HV7rXJTPOlu6+PginnbNd1et+DaKF9dbIvRyadUs
         vchSzFjWKDhEVbsRaxSIgmCrOX9POj2Th4V+zvxdKdrtIX3j1+tNzzvUQtdQ2a2GtVy0
         Uirj47btTz6L95SWQty3poCryjo0i+ui8DYlIMZBCRh2YcimvHmm/LIoLEaNsJM07MG/
         St5D+Sq3sgfPWCmrEtJd8NPOUpl4vHg9QVKpRglajyh7tLGXcJY1npiPXCnG0tD/Hftd
         WNrA==
X-Forwarded-Encrypted: i=1; AKwUvByX3UeqH6sKSKL10+0Qe3U/c7IiacC0KsUMdhR+QW00C/n58gNyORJCGJyEjX6mZH6bGTHm93zXpwK2ijH0@vger.kernel.org
X-Gm-Message-State: APuU4Z9SPDAaiNZ0tH3GFmMIHNKyCanLCBw7xzHCVHxQD8KV1qYI19l/
	zEylY51v86ingVyJnpHkcfJmR08eLAy7w/zcVDcJ4/LOEF7yZ7ZL1kjmYC7w4od2YA==
X-Gm-Gg: AYBFou2Nf1ePT1OtN4HToZ7vxbO6DiG/MQoyLpPyv2epHky0p+6pJc66IShhg07L/vb
	emhtXncT35rqf7Prk6A4XfouPnNP+csUt+yVq/yJ4k53wCHGEwazs/HXgaG08wWZ/sXa+yLwUe8
	oWLBpP3o84zXLij27jXvDmx7FSb6phExwlF5mor5DM6ihVuWfHiFQJqm5dhuIDFU4SEijoJjrRC
	F49/dC8JYRZvVs2fwFBiIc5wZS3ZUdtxOpJwvoSbW7Uc9ENYWsmoR6lS8gJsnQmfynaIs3Axjh4
	22U0CDuceZroCIo+WCFjPVgg4Z1/JLETH+s/xCb0AV8qjl0KyXhVuOQ/gc0qoN2/J8ZNQn0pO/C
	NkIp1PbE3jfn7Q1H56MsuN+T4iAq2q2EoDxQvKrwNUuHDUNl6XTNnPQX3IH1Jr9cVpujkLf+z7D
	DllyiaGh6Ai02OMhEKy08i0z3wHYKKdE7Rhzcl97H1t9XAJiUp+zF6ohgTBkj6y5XfNOymQS6rH
	LW663vMh5CBy/HFXtsJofuNAm34jWwJ60B6UV09M1hxiiK4GNWcpahpsaitqdwCjXkeR8o=
X-Received: by 2002:a05:690c:e3c9:b0:8ac:c329:682d with SMTP id 00721157ae682-8b2b66cb3c9mr55705407b3.11.1793541242323;
        Sun, 01 Nov 2026 05:54:02 -0800 (PST)
Received: from s2lab05.. ([163.152.163.130])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b714bd57sm36440147b3.23.2026.11.01.05.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 05:54:01 -0800 (PST)
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [PATCH v2 RESEND] ufs: Defensively handle NULL return from ufs_get_locked_folio()
Date: Sun,  1 Nov 2026 22:53:56 +0900
Message-Id: <20261101135356.2204803-1-ingyujang25@korea.ac.kr>
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

ufs_get_locked_folio() may return either an error pointer (when
read_mapping_folio() fails) or NULL (when a concurrent truncate has
detached the folio from its mapping). In ufs_alloc_lastblock() the
NULL path cannot be reached in practice because the only caller,
ufs_truncate(), holds i_rwsem and so serialises against other
truncates. Still, the current IS_ERR()-only check does not match the
documented contract of ufs_get_locked_folio() and is fragile against
future callers.

Use IS_ERR_OR_NULL() to match the helper's return contract.

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
Reviewed-by: Jan Kara <jack@suse.cz>
---
Resending, as there has been no response since 2026-05-19.
Rebased onto current mainline; no other changes.

Changes in v2:
- Rewrote changelog per Jan Kara's review feedback to clarify that the
  NULL path is unreachable in practice (i_rwsem in ufs_truncate()), and
  framed the change as matching the helper's return contract / future-
  proofing rather than fixing an active race.
- Diff unchanged.

Link to v1: https://lore.kernel.org/all/20260514193256.2556905-1-ingyujang25@korea.ac.kr/

 fs/ufs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index c9ff8673fa668..fec701330d67f 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -1051,7 +1051,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 
 	folio = ufs_get_locked_folio(mapping, lastfrag >>
 				       (PAGE_SHIFT - inode->i_blkbits));
-	if (IS_ERR(folio)) {
+	if (IS_ERR_OR_NULL(folio)) {
 		err = -EIO;
 		goto out;
 	}
-- 
2.34.1

