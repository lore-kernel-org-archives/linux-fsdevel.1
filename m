Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936743;
	b=3GID6Il9IyeSoClo8XfubiYrirLUAmDL6jK3on0L+E/jmHf0ceG4y8ZqwPj/wBd0m201
	 Mawd3yVwU+soICjPnmi2ri0HvCTJS7sQRjFrmndHxqMlHiRY2fPNtSsVl0K6XKFpQwWcY
	 gqCfo9WexvssMtPPd2aBb64zIvRWibo1qQoOW9bVs/IEO8CA40Lmp0oAOrXy3SyD+LnxR
	 mp7kgzSvGoPB9dR6sfK0pvzx9SCA3v5i8ULW86a18WTb2YApLfGt3eM7zaYEfmRqZrUOb
	 XB2veLJFM2uIPTRQnEfbbxkDGW1CKtZvxKkMtLINKmMk/FtdGjhCmur7PTwEyp/qSPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oC4Xm4Ftyd/KVEfH4kMfevGPXxcxUVZ8t5slQlGpuNY=;
	b=pBD6Ex2kxo8s8bFXnCAfGxL7RQ6HtShz7kxMfBJCK7CUQhsXVHjNB0RIKYu8PwR2AIq/
	 qqs0ETyJBCIEx3+QN2GPj/XZ1HWPRS8VHCo7RhQNYyvOn91pebG1Mnrz6bKAW3hlYyq4k
	 FnzLnwWOeFJ+ZGcbtEm6gWPwS1h4sRmUy72jwxoEwkr3+/pHJ8Q9BCCuHERDnLG1V1Q6M
	 bFwlsRHwV2x60y4WmGHXzPW/zgMZpYSsCFgRnUpBwMOWMAHmo09nDTDU4a1SiZFMHDDhL
	 u/BcX7pFvQFvtuFh9jZ0wG9eLddCxBNYLNIC1/W1etVWotFBxV5S1ktLCS+PLD/Lpew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4yH0jhH;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46E606A334
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E46E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4yH0jhH
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3acec6677so85869c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936742; x=1795541542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oC4Xm4Ftyd/KVEfH4kMfevGPXxcxUVZ8t5slQlGpuNY=;
        b=x4yH0jhH3nyyevBqTucgrxPsS9NXT498DNNe5pZLBy2rzBSWYRfUT7EVniWtQ7BSzF
         c6dK6mYKzpk2s74lqd6Acw/Kgz1yfLE42RUEPs5NxCEOIKWLDEyfFPlXCYEaxIYvVerF
         faBhvptbOJoUoDKrChD7RWrRNUnD5utZng6GBYFjR3cX7e9ohqIS0QF16hV8tosHM77V
         RgC/iEBtlhnJsTSijntRIUwTBwyMkwjKiy7XbXWsp9sKWYu27dDIXoQQ+BdfPpXSuwII
         m3bKcC8NcFiNT9tm4SNd740HctImZV8HstiLhIEo3SOVqJs3JoE3j/hSU0AZ6cKYf65z
         UHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936742; x=1795541542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oC4Xm4Ftyd/KVEfH4kMfevGPXxcxUVZ8t5slQlGpuNY=;
        b=NpQidIxmd47HdhR+WN8TakAg9nZAgcuF4eTnJpTbSUM0HxWDZ9QtaTez3UPNde1ZIf
         W9YmftjHflooAVTVWNXJjfZFL/aVRyryClCDV6z8WpBZFjH0/fSSLbr7S3bOQHTNihoj
         cCCAJRDD02xBxXQk+govdxjyFEF0yInlZtakY+QlXsukGMOAKTwfGQjlT/Cq4l88dV1u
         FHGPNakwVLs1IAOsimg0l5ubOO/rJ9cNozWh2rphfFfeJ1PK3VC/n9tRcYoixIFAlccP
         YS0levrW/00yiYSxEy7gPNiwbsp5DvtESTLRi85j+oZzN4681XNhHIBKwZGb9thUEsTE
         gKvg==
X-Forwarded-Encrypted: i=1; AL+hErENheJ+e/+zK5mJ5Zty3+2H9zAzeb7soRu4R73KS50dbW7OvFn0LgrVeLe+TwniusjNQSUNU7tuepsZ3asE@vger.kernel.org
X-Gm-Message-State: APuU4Z8NrU7q3SOjpk3APEowlynRwv3p4EWzVHJt3eApG+NdXz6+bmno
	30pGJ3a+KqetqJ7wT28tVpte50HtCw9rZfvBvf3GHVBITEL3cbYipr75
X-Gm-Gg: AYBFou09nQqwLGAXyEqDaJCfzUbYuJui8d+gqMN4ZvYrxpBnHMsdNw1LwkMCB0mKJuP
	C9hmjwIL4yznyTn9iCvGb6PCQjE8k0k/j/EiXR7ttIA9B+4NdXUa6jc83JfMINJ6YI5IThr1ic6
	2ua8oMTEs+I9DXYykBKT0lP2gUc1n9BLhesmakulFC0HqoiE8Fj2RhRQ3IWsph8mLH0ZY4avcJI
	aXlvrBeTFT5jpAsZSak9u4OYDJhARzzeUVG2eZQla7qvhnfilwtfzbOwU9IL8WzKsF2yAqZsr03
	aI6WDp4WnczYrNi+ACc/rNP3EShnzDxfNYyvvoFoJgYiVf5l3KY3pkpeoJyF2emHWEjl6UIB5e/
	iXtANgffJjidKGdiOqk4wRjwvB0yEaqXcFJvEI+6GN+HdkNmfyk8yAWwBYtsQ3H+Sw35yGn/TY1
	m1sfnumHV8Oe840s+sYy615DFzJUEN7SsvetissBzDUtXbiPLIwH25iqANaDh6cxxSWisB/DdO7
	6iQORJ0Bll/p5l5jelTh7Pjq8PKgvIShnpPIbs3FCm1IgDdZCC3cKwvXT7/G3bionyRFffH5sHP
	htXxyTDuo1KQEoWERT+lY8cgTVS+Tiolr+MqrSgOWq0Sfg==
X-Received: by 2002:a05:7022:b0c5:b0:1b2:4cc7:7db2 with SMTP id a92af1059eb24-1b543d5e983mr212080c88.47.1794936742350;
        Tue, 17 Nov 2026 09:32:22 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319d40asm43450247c88.11.2026.11.17.09.32.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 09:32:19 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlemoal@kernel.org,
	naohiro.aota@wdc.com,
	jth@kernel.org,
	Ding Feng <dingf3ng@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] zonefs: ignore RLIMIT_FSIZE above LLONG_MAX in zonefs_write_check_limits()
Date: Wed, 18 Nov 2026 01:31:29 +0800
Message-ID: <20261117173129.61028-3-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117173129.61028-1-dingf3ng@gmail.com>
References: <20261117173129.61028-1-dingf3ng@gmail.com>
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

zonefs_write_check_limits() follows generic_write_check_limits() and
has the same problem: it stores rlimit(RLIMIT_FSIZE), an unsigned long,
in a loff_t, so a soft limit between 2^63 and RLIM_INFINITY is negative
and every write fails with -EFBIG and raises SIGXFSZ.

Keep the limit unsigned and apply it only when it is at most LLONG_MAX,
as the generic helper now does.

Fixes: ebfd68cd0c1e ("zonefs: Fix O_APPEND async write handling")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 Frama-C
Signed-off-by: Ding Feng <dingf3ng@gmail.com>
---
 fs/zonefs/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 319d950..ea9582e 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -399,15 +399,16 @@ static loff_t zonefs_write_check_limits(struct file *file, loff_t pos,
 {
 	struct inode *inode = file_inode(file);
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
-	loff_t limit = rlimit(RLIMIT_FSIZE);
+	unsigned long limit = rlimit(RLIMIT_FSIZE);
 	loff_t max_size = z->z_capacity;
 
-	if (limit != RLIM_INFINITY) {
-		if (pos >= limit) {
+	/* No file position reaches a limit above LLONG_MAX. */
+	if (limit != RLIM_INFINITY && limit <= LLONG_MAX) {
+		if (pos >= (loff_t)limit) {
 			send_sig(SIGXFSZ, current, 0);
 			return -EFBIG;
 		}
-		count = min(count, limit - pos);
+		count = min(count, (loff_t)limit - pos);
 	}
 
 	if (!(file->f_flags & O_LARGEFILE))
-- 
2.55.0

