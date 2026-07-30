Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E0540DFC6
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424981; cv=none; b=SWDEnL5avFtpd2wEesWfHnihDPN04Jzx6Ou5B5P1aRtyqXFzAZlK9bGykG430Ba55/jFFXqx+Sdow54UTVyM/lNC2OYQYMBOCLx03FIdHvs+tS6L466uM63cxOsArrGBFpktPKXK20+S/Pv5SzTYoQNeO+nnnhbFNqZuNZjzQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424981; c=relaxed/simple;
	bh=fu02ZqAH6lSLwaynlijzUGde2pYIBnjWQknKytijo4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4EY6YVU1lEWnnoHRwM7zbEWB3CaRQUmyGdRjgGF3coyeksHkC+zzWAm9zwcr0vu1dVH8/pgQdGrwjaGh7euEAewAd3c01/Hg3iwVmeGPyiQsAQSuMi8l2GIjIAvGco1KofxDiw/POLVmCbnIPzQp8XnZCupWBJ8aMBCHAsET/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=WXtjm171; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="WXtjm171"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceaf8a1265so28482555ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785424976; x=1786029776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q9N/xBNRfsFXsnatt+u3psflJJ1kQifwOoTJGMZ+3bY=;
        b=WXtjm171OcS0QguRCyobzkc60CmQE+2dLtqr8zP0fgXCBCg+1Ert0YyTAGpyETLPni
         bWcGfVNzc9aKA6gpxkl1a23zCQ73Xh8H9DzSMdWX5qG2RYgvZQ3G0HRYGKlgStBzdXTe
         4SD8c6FGL+iIHgHcw01RDL7JgWNQZOsn+bmYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785424976; x=1786029776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q9N/xBNRfsFXsnatt+u3psflJJ1kQifwOoTJGMZ+3bY=;
        b=Rue6v3h5+Bal+vmOaxHY9K1XCThO3luj5M0v6YJwnCt9eCAUIJkRXjhzuMJloTpL8k
         z9kLZ832WSk3MYeW3j4HWszBLHjL5vrgF9TD2yIfYoimFIaeqmcdNBn8vovEJmSLzyJ8
         tIhO1+IlWBTqLsuM7gg8fcdcN2HG//aNrMm/DeDLgZoT6AC57EnWvHG0ylTJxm3z4uoF
         IU/2yJQnx9u9croaJkNSU+tqFk22YMJ2i4HNUUfGR+ejKrlntapits+GOKUHOp5hG9o/
         rDY06XSaGO9hUqGwdvANC+rd8ipo7ty67gzILFlNzdh516lAD/qDtu69ILGfc7io5e9r
         ttLA==
X-Forwarded-Encrypted: i=1; AHgh+RqRyULT8xqtaGWLLXQ69oLQz59fL3ojRTW63kY4QCR30NwnTaHgUuyMYfpxlHocYRiorAcupmaZpLhdEm7h@vger.kernel.org
X-Gm-Message-State: AOJu0Yy68KcIKAOgDYzZOxtwR60i7txIqrSFq0rM0Hvqu0CA8G0jH46M
	hIyKK0f76F6tleZOjh5ZxsXVeYMi7WDbCdEkaqg5+fVrXr3+f6gUdCX32sVpiSU3/oM=
X-Gm-Gg: AR+sD11e6Exlg4BWPOhST1IN8K4EWfvtgcwSVSNZLbfLPjlStL7mSOchgYIvBNXEC0d
	jWuqzWD3+tcnN6WptsLq3Be2ZdF4Ytrfd/wPpHC5wdEVP5/g5bn75jNAaN3olHRBFVD96i3wG26
	5ibF154AYT8hzn5UUO+Ia+a7ZWZh7D6KX0FrbJWryBPWqN9zXSrunSl/o6Z9HsRiTQ+RLxXQiu/
	D3b/w+M3UCPxXYd8RwWpi9PDImUmvwM4u3J7Dmrgh8l3AXpamB+GPucqzcwj9OnGxy0Jk/HBybm
	BiI9HcPdDSf2p6/mvzTP33YhMWVBgwgEwoO2MA4airUJtCAn0JJitI1AqXqsCp1UEsecoblKPd/
	wVtd8j2OaOyKBwFhJiaL7zp5xRQpczigv23PpsYUF0Ad5gXjDGxKhQJ3acBYCn/ec/CEfsI3r1o
	quRjJ1LCyu/J/cNOP2l0C9KQBdTvC3Yys6aczfehJtmallrK9g+5STsvcZC1rl8gxFOMZcdpqcz
	IczgWuu4ew=
X-Received: by 2002:a17:902:d483:b0:2ca:53e1:b915 with SMTP id d9443c01a7336-2d035c20259mr29160795ad.14.1785424975781;
        Thu, 30 Jul 2026 08:22:55 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a468f7sm28711745ad.28.2026.07.30.08.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:22:55 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] fsnotify: Fix stale object mask after concurrent mark updates
Date: Fri, 31 Jul 2026 00:22:41 +0900
Message-ID: <20260730152241.444632-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com>
References: <CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a mark gets a new event bit, fanotify and inotify avoid recalculating
the object mask if the cached aggregate already contains that bit. This is
racy with a recalculation triggered by a concurrent update to another mark
on the same connector.

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

Always request recalculation when an existing mark's calculated mask
actually changes. For fanotify, compare fsnotify_calc_mask() before and
after normal-mask, ignore-mask, and flag updates. Keep the cached aggregate
check for unchanged updates, and keep the flag helper's inode-reference
handling.

Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com/
Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask in fanotify_add_mark")
Cc: stable@vger.kernel.org # needs adjustments for <= 7.0
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
---
I will send backports for stable kernels through 7.0.y after this lands.

 fs/notify/fanotify/fanotify_user.c | 10 ++++++----
 fs/notify/inotify/inotify_user.c   | 13 ++-----------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9ee373ff5..f7080fd61 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1321,18 +1321,20 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 				      __u32 mask, unsigned int fan_flags)
 {
+	__u32 old_mask, new_mask;
 	bool recalc;
 
 	spin_lock(&fsn_mark->lock);
+	old_mask = fsnotify_calc_mask(fsn_mark);
 	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
 		fsn_mark->mask |= mask;
 	else
 		fsn_mark->ignore_mask |= mask;
 
-	recalc = fsnotify_calc_mask(fsn_mark) &
-		~fsnotify_conn_mask(fsn_mark->connector);
-
-	recalc |= fanotify_mark_update_flags(fsn_mark, fan_flags);
+	recalc = fanotify_mark_update_flags(fsn_mark, fan_flags);
+	new_mask = fsnotify_calc_mask(fsn_mark);
+	recalc |= old_mask != new_mask;
+	recalc |= new_mask & ~fsnotify_conn_mask(fsn_mark->connector);
 	spin_unlock(&fsn_mark->lock);
 
 	return recalc;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index ed37491c1..c44f2daa1 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -565,17 +565,8 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	new_mask = fsn_mark->mask;
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
+	if (old_mask != new_mask)
+		fsnotify_recalc_mask(fsn_mark->connector);
 
 	/* return the wd */
 	ret = i_mark->wd;
-- 
2.50.1
