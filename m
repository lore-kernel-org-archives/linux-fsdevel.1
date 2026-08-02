Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B6F245019
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 01:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635908; cv=none; b=ZG3/fSy2bWKQa/JrV2pieZxsxvfDR1MwrcHws1JVukxrI3Xp7uPmqjhEphKsYQ+UGXmm2ZR7UvA1ygNBcq5kTDDhPIa2aGCeizzjqnCaugtblGFSARk7mKuV31CFE6KhrvbHViPPWL3SlPY0YQ+jxRDUxu0lJot3Mo+PntbY7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635908; c=relaxed/simple;
	bh=wzxiYwfhRVsXnx+8W3VlocOi0kLSzn35bJPGn2RwSig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnSAmBCAPltNEkDdns5kXPJZTLLat6cZNSGv7kSJ2kNS23OHyfrugCZC2/pF8gjMG7oVzUIAqxaa3TKyE0VaSY2efKN/6AGemCOjFtXfYKXnJYIShdvEfU5I0hdxY0GWSzoqb1aXpQrDO1QXR8m3lojp1vZ8nLjl32ua+m/XTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=CVCxKkcX; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="CVCxKkcX"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38deea72eebso2165462a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 18:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785635904; x=1786240704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWMj4cY9ERrlADJCWaDaHn0JuAGU3fGMGPKTyvlQjWk=;
        b=CVCxKkcXs65Z2Q5yUj7QFa6g1/STqDvwXlqXaexWs+g6/PfzmTaAgEbiW5+NSCb8uN
         mxrkhSZu8ZGGj7J6g+5pmXq+Y/tTsE2448k9unwe+AKWTi/QfxmqRtezwtx3KNtghh9T
         oooV09dP0EYkLHDHHnd80+YevidHcNbe3jSrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785635904; x=1786240704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWMj4cY9ERrlADJCWaDaHn0JuAGU3fGMGPKTyvlQjWk=;
        b=auzZuMNZr62Pcu5ZUsTRaFnV+HIDqS9ixB1z0QIwwRT/VGwIOkPWWYTRx23av1xhrv
         bsLEjZkCh6j3RlANnjYiwt8WCaTgokyOxydj5upNk78Z2fMYDht9p4IuIowCkGCIG/tu
         pXoQrNJNtSwO0y3LMocnHBn7rJTUqSMmiKeLHoQINgk/Sxeodc1yl4vxGzA8g2tKdBWt
         n5B7C2xj2darFQdK+xxwccEkSMDIid1j24exWIDiY6IVGtt6SoPozfvlsJHfeU+XUyVC
         TXr5PP44KI9Qx++kLf9OMd8rhh5Gu1SylCNTprtpe9OHdh7btWfX53zK9bORJbdyrjsA
         080w==
X-Forwarded-Encrypted: i=1; AHgh+RrE6TfjHTo4tDFGAzEGjCit4E3VhVOSFI1goBnv20gBJ2//jnjnxKtr5Ck4tdpK/1LKTeDlbqfHuShPUnfv@vger.kernel.org
X-Gm-Message-State: AOJu0YypcVA1nzyb8CO3WtH4Xl7aXc5u53Jd8pLE8CPD5hHq+ACoAkNM
	WGW1MeX4bHNJtxMrGCPhziG8ZPV3IlY6ClDkaItOKElWCjPBlS5ibouKy/kOadTPzh8=
X-Gm-Gg: AR+sD124fXR95cKXNMBubEvM1EDxGsv672b9z9Q2297mHnE7vVHjYxcMn2pjb/IRVxZ
	F0erB7Bkb1RjIYb2Jip5udIfikoTmyrPDG4gC+ZjfZLCUurq2Jg23gLsD+ElaPRq0OeUjk/Cks2
	5lN1PPG6y9d5mx0nbPYFWraeqs/qGbcQddmtQiqJS2aPVaj6ng/CF6x10QCKo+xoWWRR8b5asCs
	ycNrt297rda2mCdDekva+48SvJ+zDyNcePG9kWY/DXDengA6uNT2T+8bmIqb0swLV7ctqFuqdMW
	/daydt8cIZy08Lfm9h8nK9ThjrvtjGd8z4EeGcpxtongrUBKlwHnh5wYAC8HPrItevL7OV2T/93
	YCkjbPhAqP+3TPrznNUE1M4ZuMcQ4nAjWV2uaihjD209MgVgTT5/ljCPiCigaX1pfWrtcZlngE4
	1VRNuHhvt7gFCaC20heh3zmGeJohn75BTI1fMFldKk+Xk94a+byTNGKHayf0ZchtMgh7I89R5Yf
	u29S2RphtE=
X-Received: by 2002:a17:90b:4b87:b0:38e:3fdc:62e5 with SMTP id 98e67ed59e1d1-38fbc498642mr4250323a91.19.1785635904104;
        Sat, 01 Aug 2026 18:58:24 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2f6539fsm2393663a91.5.2026.08.01.18.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 18:58:22 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v3] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sun,  2 Aug 2026 10:58:00 +0900
Message-ID: <20260802015801.2426818-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260801055704.2663156-1-yjkwon0026@snu.ac.kr>
References: <20260801055704.2663156-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a mark gets a new event bit, fanotify and inotify may avoid
recalculating the object mask if the cached aggregate already contains that
bit. This is racy with a recalculation triggered by a concurrent update to
another mark on the same connector.

The concurrent scan can read the mark before the new bit is added, while
the updater reads the old aggregate before that scan publishes its result.
The updater then skips recalculation and the scan publishes a mask without
the bit, leaving the object mask stale after both updates complete.

This can be reproduced with two fanotify groups watching the same inode:
one thread removes FAN_MODIFY from one existing mark while another thread
adds FAN_MODIFY to the other mark. After both fanotify_mark() calls return,
writes can fail to produce FAN_MODIFY for the group whose mark now contains
the bit. This was reproduced on an unmodified v6.12.95 kernel. The
equivalent inotify interleaving loses IN_MODIFY events.

For normal fanotify additions, recalculate whenever the raw mark mask
changes. The normal mask is not cleared asynchronously, so an unchanged
addition cannot introduce missing interest. Always recalculate ignore-mask
updates because FS_MODIFY handling may clear the ignore mask without taking
mark->lock, making snapshot comparisons unreliable.

Always recalculate after updating an existing inotify watch. Its replace
path temporarily sets mark->mask to zero, so a concurrent scan can observe
zero even when the old and final masks are equal. Assigning the replacement
mask directly would avoid the transient zero, but existing-watch updates
are infrequent, so unconditional recalculation is simpler.

Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com/
Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask in fanotify_add_mark")
Cc: stable@vger.kernel.org # needs adjustments for <= 7.0
Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
---
Changes in v3:
- Preserve the normal fanotify duplicate-add fast path by recalculating
  only when the raw normal mask actually changes.
- Recalculate fanotify ignore-mask updates unconditionally because the
  ignore mask may be cleared concurrently without mark->lock.
- Keep v2's unconditional recalculation for existing inotify watch updates.

I will send backports for stable kernels through 7.0.y after this lands.

 fs/notify/fanotify/fanotify_user.c | 12 +++++++-----
 fs/notify/inotify/inotify_user.c   | 15 +--------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9ee373ff5..9c27db2b7 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1321,16 +1321,18 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 				      __u32 mask, unsigned int fan_flags)
 {
+	__u32 old_mask;
 	bool recalc;
 
 	spin_lock(&fsn_mark->lock);
-	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
+	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS)) {
+		old_mask = fsn_mark->mask;
 		fsn_mark->mask |= mask;
-	else
+		recalc = old_mask != fsn_mark->mask;
+	} else {
 		fsn_mark->ignore_mask |= mask;
-
-	recalc = fsnotify_calc_mask(fsn_mark) &
-		~fsnotify_conn_mask(fsn_mark->connector);
+		recalc = true;
+	}
 
 	recalc |= fanotify_mark_update_flags(fsn_mark, fan_flags);
 	spin_unlock(&fsn_mark->lock);
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index ed37491c1..5f19c24ec 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -539,7 +539,6 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 {
 	struct fsnotify_mark *fsn_mark;
 	struct inotify_inode_mark *i_mark;
-	__u32 old_mask, new_mask;
 	int replace = !(arg & IN_MASK_ADD);
 	int create = (arg & IN_MASK_CREATE);
 	int ret;
@@ -555,27 +554,15 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	i_mark = container_of(fsn_mark, struct inotify_inode_mark, fsn_mark);
 
 	spin_lock(&fsn_mark->lock);
-	old_mask = fsn_mark->mask;
 	if (replace) {
 		fsn_mark->mask = 0;
 		fsn_mark->flags &= ~INOTIFY_MARK_FLAGS;
 	}
 	fsn_mark->mask |= inotify_arg_to_mask(inode, arg);
 	fsn_mark->flags |= inotify_arg_to_flags(arg);
-	new_mask = fsn_mark->mask;
 	spin_unlock(&fsn_mark->lock);
 
-	if (old_mask != new_mask) {
-		/* more bits in old than in new? */
-		int dropped = (old_mask & ~new_mask);
-		/* more bits in this fsn_mark than the inode's mask? */
-		int do_inode = (new_mask & ~READ_ONCE(inode->i_fsnotify_mask));
-
-		/* update the inode with this new fsn_mark */
-		if (dropped || do_inode)
-			fsnotify_recalc_mask(fsn_mark->connector);
-
-	}
+	fsnotify_recalc_mask(fsn_mark->connector);
 
 	/* return the wd */
 	ret = i_mark->wd;
-- 
2.50.1
