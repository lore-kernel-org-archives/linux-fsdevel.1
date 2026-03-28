Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993F15C14F
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712845; cv=none; b=I3LTisv27X+INd5VLuNdUSbRRSs43nkR/W2Tnr9FuAWl7AndLdaoe6V7zuOcaEC/aQBTkgT0IDgT37E+i1Sz4+RukjHdo8BL/mcbfEcgKZ+EbhLU1fF0HAaf0xHC7VsblIzNWnzYKDqgHsZgp7pPBXGcFqjy7TW92pjWsAN4ejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712845; c=relaxed/simple;
	bh=jKFU9ClukmgrQPWCuZbiDz6loGcaVsfq+0devSW3yqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJISgTGdcUiowdtgOPOV0v5UDeiL58MWCoUeGBu200f/ACCU48bHsP8sDe51IV5ATBNCM9KDqDI7/RhSxRblkPnvg9rMQBT2FVmnpvU7Vh4z72IS9/I9MgJw7hqqPFblO0/x7abHRqvNIXejRKyNtcK7VzyG2mdMy8OsUPaqCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5GmkdFj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5GmkdFj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48541edecf9so39320065e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774712842; x=1775317642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSDysc2SqFR5k0dxgouFFuDk3xltDf+gaI9kO7u+6DU=;
        b=h5GmkdFjYCFVbrmTejFKLXUfTCIR3jMpIk+333b7OrPiBE/0d+EXACBU7b5l6JmNeA
         hszXEckf+QPIxRgfG7lxUgZVgvMTZQTRW12qlX9p+PGms14vMC2gGgMMINVRfik8lmnP
         w1jsqlgPo0WOMhkepmqNUh+8cSerF5h/Hpq7y6di+8v0EkeB07+xiTsyclvm9NgSfovQ
         qasTWE5UkO2BkjoV4QqliZF6sZsjmkuNEKpyufByKO+5XLRb+22rfbaArWMmTQtwnr75
         vIWH4Z1TM9i7vn4iHE5xnCrSzXKFBm/slDZrD6yc+ojShyYKMOPzqBPdITxym6QoyGSl
         AGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712842; x=1775317642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VSDysc2SqFR5k0dxgouFFuDk3xltDf+gaI9kO7u+6DU=;
        b=Kwt9j/J2uUhm3TJnEyFcpdQxTbrL/1bPcR6mWA0Z5omCOygfYE6e+7RoU6VOFZghE1
         MexNwY/zHloC8erNhFobr5lNhVqXD0w0ews5mYlrsT9+cwXF09hL9V+b82Ugf2/T6FuC
         cko3kJlyoJINqJwwmAwaA4DQS5HC03UjAG3yTZRXkl4IrSj9QdXaYjsTi4T2SgvBy/0x
         b844zEWCOQpWkyAgXH/F7GBzecnW3ki7lfWwRDYS2BduSDSj4htuqZHMF2A8sAWVCdxc
         RPSOacyG61ITH1eqHwsVXbkIo4qnPWYivRZouwrhTojelnuRF+u50cq22W3jiRFnCV8C
         XJSg==
X-Forwarded-Encrypted: i=1; AJvYcCWcEqWIu0v/ioIPZ4GWvir7O50jKlJRwgDF3GdDHJvoX54O+xYmhmIsdBmmaGwUHNCPiJFOJyYF/obkjVW6@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ5nIPXLaNWcyshKn845Vlb9KyHHBm8kJW+V8kYouXXpV0ZCzS
	l67sBEOi6OlpjLy4lhY3Npus7nvYtrpv0ANCPwRJ17GTYsojAfhtI9ZI8NnOKA==
X-Gm-Gg: ATEYQzyJar6ptfYj8BdPlT1AbFWU3OsUNQavGeqOSs9MzdsPHFF8Xq2TWrK3d/a8/hx
	WADRdSTBoUjohbkb3RXZsZrumnpUxdjVY65KDRHdZS/ZE4RkHuUVnCU09BnKPWcsJQp7fV+9z/R
	ubxjswiKfXaNVVlD7jG/l5SDsktzF/swnt8mm/OWUGi8deC/Nil4mmNzmmp+ShV/Wsuti5MA0lO
	U0hehI7B817ZSqjFTGbBDbIVt6A3gY1Jx0UKpfgg3n0XjPiE9VbA4NsvtfFpSYC1A66h4pTD7Ov
	rZfL7MTpTueKzjBlc1WB1JrxEkOAnq6gYux9vy+CtRoveTMcTR2KlIbND8h+Rozpvf8EBplYnf+
	oNGZbiPv55S160A9wyD04in2us/2URFk5nPU+8Rp6udXXuRawPDqIJGnfpTN2a7l4jRupz9ZFly
	2kFYPxjmRqgFeArwYycCspHG9AdQzdOMw782pAIAjjFQKN9mRnRXddJG7yIYYVlhpmNq6m/Abo1
	A==
X-Received: by 2002:a05:6000:26d3:b0:439:ba4d:bf40 with SMTP id ffacd0b85a97d-43b9ea62f50mr10725997f8f.43.1774712306142;
        Sat, 28 Mar 2026 08:38:26 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247102dsm7196887f8f.27.2026.03.28.08.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:38:25 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 4/5] fs: handle hypothetical filesystems hich use I_DONTCACHE and drop the lock in ->drop_inode
Date: Sat, 28 Mar 2026 16:38:06 +0100
Message-ID: <20260328153807.3368975-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328153807.3368975-1-mjguzik@gmail.com>
References: <20260328153807.3368975-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs and ntfs play games where they transitiong the refcount 0->1 and release
the inode spinlock, allowing other threads to grab a ref of their own.
They also return 0 in that case, making this problem harmless.

Should they start using the I_DONTCACHE machinery down the road while
retaining the above, iput_final() will get a race where it can proceed
to teardown an inode with references.

Future-proof it.

Developing better ->drop_inode and sanitizing all users is left as en
exercise for the reader.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1f5a383ccf27..fc6045e6d43f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1933,20 +1933,29 @@ static void iput_final(struct inode *inode)
 	else
 		drop = inode_generic_drop(inode);
 
-	if (!drop &&
-	    !(inode_state_read(inode) & I_DONTCACHE) &&
-	    (sb->s_flags & SB_ACTIVE)) {
+	/*
+	 * XXXCRAP: there are ->drop_inode hooks playing nasty games releasing the
+	 * spinlock and temporarily grabbing refs. This opens a possibility someone
+	 * else will sneak in and grab a ref while it happens.
+	 *
+	 * If such a hook returns 0 (== don't drop) this happens to be harmless as long
+	 * as the inode is not marked with I_DONTCACHE. Otherwise we are proceeding with
+	 * teardown despite references being present.
+	 *
+	 * Damage-control the problem by including the count in the decision. However,
+	 * assert no refs showed up if the hook decided to drop the inode.
+	 */
+	if (drop)
+		VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
+
+	if (icount_read(inode) > 0 ||
+	    (!drop && !(inode_state_read(inode) & I_DONTCACHE) &&
+	    (sb->s_flags & SB_ACTIVE))) {
 		__inode_lru_list_add(inode, true);
 		spin_unlock(&inode->i_lock);
 		return;
 	}
 
-	/*
-	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
-	 * Note we only execute this if the verdict was to drop the inode.
-	 */
-	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
-
 	if (drop) {
 		inode_state_set(inode, I_FREEING);
 	} else {
-- 
2.48.1

