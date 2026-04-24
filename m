Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBE3D6CAA
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038426; cv=none; b=ECT5Cq5+0guHZgSQj2irL/RIcUb4MKk3oybjLvVJPvnPNz2F1pkuZItBFQ+C/8gGqnjemglT7jrkc8XEswY8ty3VIpOtWLP6Z7fVpLRIGXpOkQjnqgAIL7bR/1pQ/XgU1wrzA+p42409S0VJ9L1q+i95amXyHGJMZoVV/qOHWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038426; c=relaxed/simple;
	bh=ou+vFfeCCWjdvdo3cV3GmW40y/3qk1BtNC4xQKkKFrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbn3lqqfbxlzeT8eWY6ZYTlFkGqSI0YaKyKSvJPMej6adSNUFBAWVvCZBvR4SKPI3Bj3oHCi5I+xGwS8WE9qQMI/pwzQB6WAhXFgv3ozioB9vDQynmgsl4vI6Cn5gdAS4l8Pu7aVUa8fZOQHi10CLvL07mCH0FU4cHs1tJwt054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYB72Ut5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYB72Ut5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9125FC2BCB5;
	Fri, 24 Apr 2026 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038426;
	bh=ou+vFfeCCWjdvdo3cV3GmW40y/3qk1BtNC4xQKkKFrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gYB72Ut5bAdHuQcKnnvJq/ieopbhW8OFaeOu9b+SKaSmTf7xjekIFcyDF8oBGD/jO
	 0io0QlACmCNWpHCHEGM1AeRsgg/4OdrEguu43+DciHYSkgwvt++ljYic/bb2S+ncip
	 dSIMk33Ax163WOLjRDWaKN3S+F7j/sWLqWbRVfjWZ+5Gy7fuozY7aVKosJkRtnQ7oQ
	 aeVht4zOMtQ4L7BUvD4z4rPHmuKCy9kfpEg8vzOF/N8TcaLicTYr2XrT96bjePaIj5
	 K9OPqEKYqiX60gKEoKsVtTPFIpiH/lLYg35BNKHhwAuczJmT5daTvcnyvxptnwb/c7
	 2+1dnD//clx1Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:40 +0200
Subject: [PATCH 09/17] eventpoll: relocate KCMP helpers near compat
 syscalls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-9-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3480; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ou+vFfeCCWjdvdo3cV3GmW40y/3qk1BtNC4xQKkKFrw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnFf094/3UJ2ybn2oCKXsP183GGvZu4+NpHdOT/z5
 p6ey+0xHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZU8vIMMf4+7WPC+XaT//1
 iblWH8U7c7rnRoWbD7kaZ/dk67bzFzD8L1bUltAUN2xc8Vxp+x/Gmv6lWWu0b8x1F9te4C84v/k
 xHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

ep_find_tfd() and get_epoll_tfile_raw_ptr() are only used when
CONFIG_KCMP=y. They implement the lookup side of the kcmp(2)
KCMP_EPOLL_TFD query. The helpers currently live between ep_find()
and ep_poll_callback(), interrupting the run of hot-path code
(callback, wait-queue setup, path check, insert, modify, send_events,
poll) with a feature-gated block.

Move the #ifdef CONFIG_KCMP block next to #ifdef CONFIG_COMPAT, which
is also a peripheral ABI extension. Hot-path code becomes a
contiguous span, and the userspace-adjacent extensions cluster at the
end of the file just before eventpoll_init().

Pure code movement; diff is 44 removed and 44 added, all within one
block. No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 88 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1fe9f1772a28..fde2396342b6 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1399,50 +1399,6 @@ static struct epitem *ep_find(struct eventpoll *ep, struct file *file, int fd)
 	return epir;
 }
 
-#ifdef CONFIG_KCMP
-static struct epitem *ep_find_tfd(struct eventpoll *ep, int tfd, unsigned long toff)
-{
-	struct rb_node *rbp;
-	struct epitem *epi;
-
-	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
-		epi = rb_entry(rbp, struct epitem, rbn);
-		if (epi->ffd.fd == tfd) {
-			if (toff == 0)
-				return epi;
-			else
-				toff--;
-		}
-		cond_resched();
-	}
-
-	return NULL;
-}
-
-struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
-				     unsigned long toff)
-{
-	struct file *file_raw;
-	struct eventpoll *ep;
-	struct epitem *epi;
-
-	if (!is_file_epoll(file))
-		return ERR_PTR(-EINVAL);
-
-	ep = file->private_data;
-
-	mutex_lock(&ep->mtx);
-	epi = ep_find_tfd(ep, tfd, toff);
-	if (epi)
-		file_raw = epi->ffd.file;
-	else
-		file_raw = ERR_PTR(-ENOENT);
-	mutex_unlock(&ep->mtx);
-
-	return file_raw;
-}
-#endif /* CONFIG_KCMP */
-
 /*
  * This is the callback that is passed to the wait queue wakeup
  * mechanism. It is called by the stored file descriptors when they
@@ -2733,6 +2689,50 @@ SYSCALL_DEFINE6(epoll_pwait2, int, epfd, struct epoll_event __user *, events,
 			      sigmask, sigsetsize);
 }
 
+#ifdef CONFIG_KCMP
+static struct epitem *ep_find_tfd(struct eventpoll *ep, int tfd, unsigned long toff)
+{
+	struct rb_node *rbp;
+	struct epitem *epi;
+
+	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
+		epi = rb_entry(rbp, struct epitem, rbn);
+		if (epi->ffd.fd == tfd) {
+			if (toff == 0)
+				return epi;
+			else
+				toff--;
+		}
+		cond_resched();
+	}
+
+	return NULL;
+}
+
+struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
+				     unsigned long toff)
+{
+	struct file *file_raw;
+	struct eventpoll *ep;
+	struct epitem *epi;
+
+	if (!is_file_epoll(file))
+		return ERR_PTR(-EINVAL);
+
+	ep = file->private_data;
+
+	mutex_lock(&ep->mtx);
+	epi = ep_find_tfd(ep, tfd, toff);
+	if (epi)
+		file_raw = epi->ffd.file;
+	else
+		file_raw = ERR_PTR(-ENOENT);
+	mutex_unlock(&ep->mtx);
+
+	return file_raw;
+}
+#endif /* CONFIG_KCMP */
+
 #ifdef CONFIG_COMPAT
 static int do_compat_epoll_pwait(int epfd, struct epoll_event __user *events,
 				 int maxevents, struct timespec64 *timeout,

-- 
2.47.3

