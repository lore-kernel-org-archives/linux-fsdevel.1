Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D463ACA75
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798276; cv=none; b=YVyyeUEMdP5NUHmLTwc3b2/TBXDIxtRWov2/vEOSlPG8gV4CUmzW+k8KVi6fSMNL36e4RTQ0HdzE9n6wJaEEpo4TaaRFkKCaFpSPZT6uRMG8T0b6mPAYqoOlduO2f4/fqrxu4kQG5mFfJD6xjowQIFH+Cjo6Igbzr80nAQGVomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798276; c=relaxed/simple;
	bh=mGofTVBMLaO3SwuK3/vHb5n4xSUGiFi1EQXOYob1u64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCgJ6ALBtuZvI8YpXG3rmzaP+6i70lfgv0LAvD1u1wT5diTj50hrUay+qx1srQHi5NmIU4+VnvNR5m+jtkEshe2AHh9Ix4u/JfMsOR798iekPDJTC7pM0luaVjCEZKZBdU08JMOhoeSeakZeUYmeKmCPpGq50ycvfKTqSOCw/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=mDjeIja9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="mDjeIja9"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67b6a6bd7b8so4666615a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777798273; x=1778403073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6YdvPNRh3rTXt0GrZkLf0D/oOpREg9FdkwWTXZhhJ4=;
        b=mDjeIja9QU7WGKtSiwnhqn4m4qxkpnB9LPvUvx7ROQrGBJByMc1MZ5ifg6Dw5ec8gw
         byVIcR7/+PhXs6SVuw5rj2ynivtVK2VwSRe1GWSgp+CxVI7hZCP6x+vEcJp27S1gCT/A
         u83C/X34TRGScBmxVJJsISo41Js1F1q0RilD1c2ICUVox3ZrS1PMR+GPL0j8LqqHF1Ty
         KEkLTgTI1DAz7YU/mTGWRjCEqpa9jwZF29ih1BY253VtOzhpPMp6o95un819ADn+AccP
         2StGFOKVAWbEqj0Lk8g1wxTLhhh/53MW/TcsmHVFqWyBmRUaoZ/oJIcWbeAGSHYAYLIP
         O92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777798273; x=1778403073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6YdvPNRh3rTXt0GrZkLf0D/oOpREg9FdkwWTXZhhJ4=;
        b=kDkOzzS9Z2Os7ewvhZOehFTdh+JI63UyFG061VnYhW7suYJKoMU49YL0Xldn35XM0l
         oN4+WEWvIrBk7G6V5IxxZIIh1vGjNn80k6jSK+WuPx6T3PY6jGGMj4E0rISXm2HhHRtZ
         udt//KxTktTeIqNDYF+SjJ7gAXiacOvW062N4wLDQkaEKHD5V0kyx7mHmdP3hQpMqlA2
         DChIfQN4s5m+XdTB8s800IGq94swLLijM5MBEB7AHUzS5XmVC6oheJXuFNLGebWNq72w
         TfZ7ZJp11+q+u5NFbcrsAPkSylCzD5wZsF4KYCXLX6/e8Cc6qVFdStKei8Eu1BstVbPN
         qZuA==
X-Gm-Message-State: AOJu0YzkEb6OCmIi4kFJAvoUfxvr2iG94I7gFiPyL0V1790EMQCjxZLe
	pSnsXzhoZeyjCt5eWG4/nqRrEMNP8aCqZRa9XgIDZLedthUGjVrvja64aZvow1wlFtk=
X-Gm-Gg: AeBDiesra2Qou1egSeoWqhHuDgR8iZv/2y+Rl25gjNxQ7hKR5UIMYG+mRwlKcdl+WKl
	JUPEPt+DQaz57ENpleZLxQbXV10q0tdsJCWDxPocrED2/vKwoKbCzWPsC8Bi34YmjYMp5UzJoc6
	mI0wY46vf/sF4BPRugNkgs5d3GJ59XXLHB26q2dlyXrHrle2Uub6BPj9rlYtzkhTdSuE6eRH1ud
	ITuaRkZHKkvRP0UFyHOGJ081fgnEyEzvFAEvPGIXF2XbJrM/hniz2veY3skVkaN5KxbvZywwCjU
	8kz9xoajx8mOBdhi/eiOLts2TN7Yos1te5XQYU2gTSrae9EuRqUDfaP2xl7ikkqcg6BGX71eeWC
	scmpcGDInSGx2PE86haNTKZ8CcD2z2FrG69ShInAxlikx5elhANhRrX3rqvioyXzLLNRk5gXG8e
	GjVEuFXKFEcxeSIe2EDs58GBxjwbq2IeHZzrd+aJUgE5MCResDzCbZRN8Kz6CphYBVBgeIkPaUG
	MAWpYxKfo1oDw5zyS3D
X-Received: by 2002:aa7:d798:0:b0:67b:f62c:b5a5 with SMTP id 4fb4d7f45d1cf-67bf62cb748mr1664158a12.3.1777798272450;
        Sun, 03 May 2026 01:51:12 -0700 (PDT)
Received: from m2max ([77.241.229.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e292c2sm2368936a12.1.2026.05.03.01.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 01:51:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] eventpoll: pass struct epoll_filefd through ep_find() and ep_insert()
Date: Sun,  3 May 2026 02:49:12 -0600
Message-ID: <20260503085101.112698-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503085101.112698-1-axboe@kernel.dk>
References: <20260503085101.112698-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have ep_find() and ep_insert() take a struct epoll_filefd rather
than a file/fd tuple. Kill off ep_set_ffd() as it's now no longer
needed.

No functional change. This is a prep patch for adding a file based
do_epoll_ctl() variant.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a3090b446af1..f464f2f39e0e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -339,14 +339,6 @@ static inline int is_file_epoll(struct file *f)
 	return f->f_op == &eventpoll_fops;
 }
 
-/* Setup the structure that is used as key for the RB tree */
-static inline void ep_set_ffd(struct epoll_filefd *ffd,
-			      struct file *file, int fd)
-{
-	ffd->file = file;
-	ffd->fd = fd;
-}
-
 /* Compare RB tree keys */
 static inline int ep_cmp_ffd(struct epoll_filefd *p1,
 			     struct epoll_filefd *p2)
@@ -1173,17 +1165,15 @@ static int ep_alloc(struct eventpoll **pep)
  * are protected by the "mtx" mutex, and ep_find() must be called with
  * "mtx" held.
  */
-static struct epitem *ep_find(struct eventpoll *ep, struct file *file, int fd)
+static struct epitem *ep_find(struct eventpoll *ep, struct epoll_filefd *tf)
 {
 	int kcmp;
 	struct rb_node *rbp;
 	struct epitem *epi, *epir = NULL;
-	struct epoll_filefd ffd;
 
-	ep_set_ffd(&ffd, file, fd);
 	for (rbp = ep->rbr.rb_root.rb_node; rbp; ) {
 		epi = rb_entry(rbp, struct epitem, rbn);
-		kcmp = ep_cmp_ffd(&ffd, &epi->ffd);
+		kcmp = ep_cmp_ffd(tf, &epi->ffd);
 		if (kcmp > 0)
 			rbp = rbp->rb_right;
 		else if (kcmp < 0)
@@ -1564,7 +1554,7 @@ static int attach_epitem(struct file *file, struct epitem *epi)
  * Must be called with "mtx" held.
  */
 static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
-		     struct file *tfile, int fd, int full_check)
+		     struct epoll_filefd *tf, int full_check)
 {
 	int error, pwake = 0;
 	__poll_t revents;
@@ -1572,8 +1562,8 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	struct ep_pqueue epq;
 	struct eventpoll *tep = NULL;
 
-	if (is_file_epoll(tfile))
-		tep = tfile->private_data;
+	if (is_file_epoll(tf->file))
+		tep = tf->file->private_data;
 
 	lockdep_assert_irqs_enabled();
 
@@ -1590,14 +1580,14 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	/* Item initialization follow here ... */
 	INIT_LIST_HEAD(&epi->rdllink);
 	epi->ep = ep;
-	ep_set_ffd(&epi->ffd, tfile, fd);
+	epi->ffd = *tf;
 	epi->event = *event;
 	epi->next = EP_UNACTIVE_PTR;
 
 	if (tep)
 		mutex_lock_nested(&tep->mtx, 1);
 	/* Add the current item to the list of active epoll hook for this file */
-	if (unlikely(attach_epitem(tfile, epi) < 0)) {
+	if (unlikely(attach_epitem(tf->file, epi) < 0)) {
 		if (tep)
 			mutex_unlock(&tep->mtx);
 		kmem_cache_free(epi_cache, epi);
@@ -1606,7 +1596,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	}
 
 	if (full_check && !tep)
-		list_file(tfile);
+		list_file(tf->file);
 
 	/*
 	 * Add the current item to the RB tree. All RB tree operations are
@@ -2243,6 +2233,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	struct eventpoll *ep;
 	struct epitem *epi;
 	struct eventpoll *tep = NULL;
+	struct epoll_filefd efd;
 
 	CLASS(fd, f)(epfd);
 	if (fd_empty(f))
@@ -2253,6 +2244,9 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	if (fd_empty(tf))
 		return -EBADF;
 
+	efd.file = fd_file(tf);
+	efd.fd = fd;
+
 	/* The target file descriptor must support poll */
 	if (!file_can_poll(fd_file(tf)))
 		return -EPERM;
@@ -2333,14 +2327,14 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	 * above, we can be sure to be able to use the item looked up by
 	 * ep_find() till we release the mutex.
 	 */
-	epi = ep_find(ep, fd_file(tf), fd);
+	epi = ep_find(ep, &efd);
 
 	error = -EINVAL;
 	switch (op) {
 	case EPOLL_CTL_ADD:
 		if (!epi) {
 			epds->events |= EPOLLERR | EPOLLHUP;
-			error = ep_insert(ep, epds, fd_file(tf), fd, full_check);
+			error = ep_insert(ep, epds, &efd, full_check);
 		} else
 			error = -EEXIST;
 		break;
-- 
2.53.0

