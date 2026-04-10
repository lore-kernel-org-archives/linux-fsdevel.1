Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23543AEF22
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775832599; cv=none; b=sMAA34NBvlq9nUHdbnRRXBL8BEFo+1gB/Wj0ID7PrH40cR9nqoahpUuUmqs0jZL9U0VAbFkHGFDRDIa0WqqBFP0ClkvFaDkSMyFV+v7IBj5JfclbegACKGkVrHn6LKqbkrJRzsQLww1Lbg1e/ZVp3eg2eNO2fQvs6dMcUWKFOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775832599; c=relaxed/simple;
	bh=Sdbr4cELzdW6V0mfj7oppqg9e+F4zuFlHdZJ2iA9RCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGQlxKmlZmMLEnl876EVU4NR7izRGf80+YmE4HkFQjq27Lnomfg8yRov+C3VWOuUku7nQwWgh8bmbQXhtFArsaexdXppUJx953FMSh3LVq7qLugTQmcEIqoZyV8TElYU+olug+2Coi8lo46k0cPbJl17PnKYkx54VIBwcIQnuy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6+FmOTt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqwqrmHE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6+FmOTt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqwqrmHE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775832594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vzsN/bSoaREoII9wzXB8/9JQKF2EExNHrOr8cD5ifYI=;
	b=Z6+FmOTtyCHwSULyzttfcZepyX9gx3u2HBcV1eRiWXg9IbqzbsAAS0Kl/smzjruGuCIjFw
	G6Svr1m7BzCxYJRITcmKPDWzTcNb67mJiqq9MFwsX9pLuo8heBHV6sI1o7Yzxtjzm4vgxd
	7E0Z0Za2e3b1MJS50OIP2DbYOqlk8es=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-u5yhkp9qMlSjp2BE5ukDjw-1; Fri, 10 Apr 2026 10:49:53 -0400
X-MC-Unique: u5yhkp9qMlSjp2BE5ukDjw-1
X-Mimecast-MFC-AGG-ID: u5yhkp9qMlSjp2BE5ukDjw_1775832593
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d1dfad98so12786375e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775832592; x=1776437392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vzsN/bSoaREoII9wzXB8/9JQKF2EExNHrOr8cD5ifYI=;
        b=XqwqrmHEzP8UOXfNGRcKoB2FF8CavedzUDSTACZHJFcD4SpGSxoQdGit3GHwTDwtps
         Ez2lirT0MAwyggJTIWfVaKSFGbWWDNzjYhqezlarEDSgDqDZFohDWpuIRGkFTZXf7hsd
         lZujGaG8w6J5XamQB7EuH095xS1GBbO9k8hoXUVe+ftc0NUisuU0Nn5H4BGo1knAuk+b
         OqPe1cGHLDMsDbF4IkHAjrUOJRRzL1sEDnAiGTzuBofLP7U2Dem/SJXj9as+h3lP/JaQ
         thRPESNzoaJafWB2zUMyfhJ1+lQc4B8PYKzduZMo9tsnScCV5AzEP25oW15EBqeZ/szt
         rtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775832592; x=1776437392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzsN/bSoaREoII9wzXB8/9JQKF2EExNHrOr8cD5ifYI=;
        b=MqsbbJxfIIGDPBYtt8B/7GJoyGGu0jbRYMsCjZluuCNfirQl9kEiMkysFXDpActsbk
         BEWU1mEr7zgfXfaUewzmEEU6NtQOpNCr1KJc9mCxQwJApLEsIBFwNcg4OqqAl5dIuo0F
         VuWaTt+loJPXVtVUE9VoCyqSx3UpUVLyT9Nvr0e1w/swTTGOAo0M7+AsL2OQkZMkjTZ/
         HISJQ6QE4rxEfNR8l4s6nZY1lFHJtXSjlZu7EqXcY5/78MVSeliRN2IEeuLlp5lwI5za
         vdj80h266MvrDlMSpQ7lVewysPp756U+mL2y3GAdxxxV1HR/IgPpf9t3liTHxfqPdfVQ
         8g9A==
X-Gm-Message-State: AOJu0YygEDaA4/UNcOaC0fJVMx6lTRZJqmtmwug2CWCNTh1xlne82jtg
	vRX2KYCtW4OKZ1AGjOfHYJvhT2020+iHWPE9UBLxZzW9ZLm4g+NI/nCOlZnTi77KCO/q1eetF7b
	aEktf7pu8ys3E9mqyg1gNsMKliL1t3aIbQU+uk6CkThpfgnLMCUaqpx/FFnK3Jb3vnTPtswMhcq
	NurGPF075kzWhOxoIoh6c/Ns9Y763erTN3ch8DKzwezIfusI7TQlM=
X-Gm-Gg: AeBDieuiK0/2z8SBbv71KKfYXubEOQr5BaGBhen8CinW6hjzagxcbjSeSkos1CZl9V3
	gM7L/mRrCXuMtDnKzaYn1Y3YU/ab7/Oqwo0bcsTzIKubWOcTD2a8ylHY8z07iC8AcMmhktbHkeY
	1IvBjsKOb22Bm8rMzpfwberCN+a2OPfbzaon1xAj2GbOAOI7oxsIOCQKWZKRvBld2ROHEfMSiwU
	0a+hNs+LrpstKzmVwWpt4LxlibUlSGGrKp69InBmCEh+hG01N6E1QVs44rMtd8fvjdfNviB6ueb
	WzWhGUBZCx5bu6KC/pIi4dP3oc2J6Tg9Hf9pCNVszkaeT18fKP7eJ3va9SdfI9n2tw4CMcNCs8W
	8AXDHOJYeg5TfJI3IGIn4OkclUQkAKZm7uKC1wVz07Z5yF6Hqks3iqKWluFGJGLO2iOZRILN3aO
	vRt2KlWg==
X-Received: by 2002:a05:600d:d:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-488d67b8da2mr35713255e9.5.1775832592268;
        Fri, 10 Apr 2026 07:49:52 -0700 (PDT)
X-Received: by 2002:a05:600d:d:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-488d67b8da2mr35712825e9.5.1775832591791;
        Fri, 10 Apr 2026 07:49:51 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-245-158.pool.digikabel.hu. [193.226.245.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3cbb2sm79898415e9.13.2026.04.10.07.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:49:51 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] fanotify: fix false positive on permission events
Date: Fri, 10 Apr 2026 16:49:47 +0200
Message-ID: <20260410144950.156160-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsnotify_get_mark_safe() may return false for a mark on an unrelated group,
which results in bypassing the permission check.

Fix by skipping over detached marks that are not in the current group.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/notify/fsnotify.c             |  2 +-
 fs/notify/mark.c                 | 18 +++++++++++-------
 include/linux/fsnotify_backend.h |  1 +
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 9995de1710e5..b646a861a84c 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -388,7 +388,7 @@ static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector
 	return hlist_entry_safe(node, struct fsnotify_mark, obj_list);
 }
 
-static struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
+struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
 {
 	struct hlist_node *node = NULL;
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c2ed5b11b0fe..622f05977f86 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -457,9 +457,6 @@ EXPORT_SYMBOL_GPL(fsnotify_put_mark);
  */
 static bool fsnotify_get_mark_safe(struct fsnotify_mark *mark)
 {
-	if (!mark)
-		return true;
-
 	if (refcount_inc_not_zero(&mark->refcnt)) {
 		spin_lock(&mark->lock);
 		if (mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED) {
@@ -500,15 +497,22 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
 	int type;
 
 	fsnotify_foreach_iter_type(type) {
+		struct fsnotify_mark *mark = iter_info->marks[type];
+
 		/* This can fail if mark is being removed */
-		if (!fsnotify_get_mark_safe(iter_info->marks[type])) {
-			__release(&fsnotify_mark_srcu);
-			goto fail;
+		while (mark && !fsnotify_get_mark_safe(mark)) {
+			if (mark->group == iter_info->current_group) {
+				__release(&fsnotify_mark_srcu);
+				goto fail;
+			}
+			/* This is a mark in an unrelated group, skip */
+			mark = fsnotify_next_mark(mark);
+			iter_info->marks[type] = mark;
 		}
 	}
 
 	/*
-	 * Now that both marks are pinned by refcount in the inode / vfsmount
+	 * Now that all marks are pinned by refcount in the inode / vfsmount / etc
 	 * lists, we can drop SRCU lock, and safely resume the list iteration
 	 * once userspace returns.
 	 */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 95985400d3d8..e5cde39d6e85 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -915,6 +915,7 @@ extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 					  unsigned int obj_type);
 extern void fsnotify_get_mark(struct fsnotify_mark *mark);
 extern void fsnotify_put_mark(struct fsnotify_mark *mark);
+struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark);
 extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
 
-- 
2.53.0

