Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7D0401A2D
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767712; cv=none; b=jjQ30nwWJBeC55FMkEq9hNyh/E6xjdK8UUu1C4Po5LQ2iqk4rLunpmMHPpqsSjtVpIhHRmyi6R2g3zDVDJ2xS3wDqbi/sLmXSbFLmvcs/hlKgDQdqLpLs642xF8TbvAQfovb4y2+9Zu+hCHFz5j9Uvx27hd/oNEMalkQZrrYT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767712; c=relaxed/simple;
	bh=mGofTVBMLaO3SwuK3/vHb5n4xSUGiFi1EQXOYob1u64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY3kzDXAKK+Mx8yKEbSzOslN+fCXB4CUgZtbKmlCsrtOoIarR/4HN4lDoe4Fu7/p4MspLIh45mZZHKJKxmTe6M086591umRsK2yAnCFjzYppI0SWAGdCGgiaIZel6jEk8xPemZLgyImo3tTFM4+TayuLKScIDEy0MuvV4+TNEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=kk7DGwKV; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="kk7DGwKV"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479f7e75a6bso3338275b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778767704; x=1779372504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6YdvPNRh3rTXt0GrZkLf0D/oOpREg9FdkwWTXZhhJ4=;
        b=kk7DGwKVGhdcCPtLcRNEGptNYL0onyuHY03j/MEzfTCGM8Qq7lFq50ifCR0SzXHqD3
         lO/RV2ELxip7ycvypSPXqBwVU5RANSgn5ZKE5pw3S30Zz/p7xwFk0/D7wJ1omdQrkZOu
         ER/DA9UAQ64/rXneXOjK/fMAjDXkEhyEx8smXquh7LfJ6pUIkFMwNA9l33tPwGwSFAf2
         0A7iDWn9qR/zmhpzG1gOi/xAdzpnZk+uUPz0boQpax987RGZuBeXmLhIV7hG/fd9ddLN
         u6MTiZYG5RPqikETv8lm3+vP1BukAzU9/72y2VYrf7dhv6qTUhIiWj0c0ZSAGFr+LTHf
         OllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767704; x=1779372504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6YdvPNRh3rTXt0GrZkLf0D/oOpREg9FdkwWTXZhhJ4=;
        b=R/ERgLonwP11a88nUN5c6doFqm6LzcAL0jaSUtS+AJCAvcaOR5OYRCceCp+8TPjU75
         GuaymfxOdAXqZIPYgwdw+0jlfl147Q2w5+GMURxv7YgkfRqzmXDFWsi2VIDzinkUyJUx
         l7piJw7h0X+0+ECYt8Cqb/NvCljXhONAvgik/yrkr6V7s/n1EHnxosuUjr7/VLiAvzbw
         EIs3qRL19PARQNiUxzi5N3Fax0qBJnYMdXe9lqRf1lWNJCi8tgBzQc7GTiVOWyKGlIG8
         o4Q+eXnn7rN6Aibre3wbkjbd6J7jeHk2AQa3QrGYzeSgWqn/PVBw28b5CDOP8+qX0+ik
         XiIg==
X-Gm-Message-State: AOJu0YxkljALEyU/p5gJ0h5wCgaM3S0v2piI+37UoomH5mT4K/dICYiy
	a4Jnq79CPcRArrTrtD9E1OFiMOf4GbXCltp8REWDfAc75n5EfJtQtnJnfPAhm6irvtMuXPAjJCA
	jDcZa
X-Gm-Gg: Acq92OE5bBXOtUBWaE2tzhq+109bHOKvOC2a3sstYTbJj2psvNnxaNlqHZhDiWd6r/J
	FnG0pVXI1GdDwT3QB/OaGmGrZMw5kurrUs8lQCQmrpgWCBytKZU07AnSdFPiwxhPXNzT3Nix6Nd
	wXF9yN8g/4Zta8gssqNNLAoDHI8ORPN+OfF+0HFaJnC/fLqoBQusiMbIE735m+75zaSYc3Pe4kj
	i1uvCfQBJXWK4GNCf0caRJjYPi+YC0ARCrLHhwFIB28ViHiV+UaL6BlXu7AC9oDlWRj8PaPW/sL
	1+ei2+n/cVZQUgFM7wa+akHC6/9K6P1ssF2Cb0Q1GGr5C6ef2lXbMwd4jPVe47KhP3J50ZeueVq
	e8hRmFV7kx+zD511cg94RBdXIvlmQUqvIFNia1dqe8f2/eTIKJ1PLyyh6WmX29gLmX6GEhVCZzv
	GeA/6uPuDODh8AKo70/XmLxZ6qKhGsHomo1+DKfDRp4nkfAZVeFq2d9xnf8s0ZZAIxyQc9p7Dbn
	GF+Zw==
X-Received: by 2002:a05:6808:6d86:b0:45f:8be:d983 with SMTP id 5614622812f47-482b2af40c0mr5228136b6e.12.1778767704119;
        Thu, 14 May 2026 07:08:24 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482d379f062sm1394956b6e.6.2026.05.14.07.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:08:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] eventpoll: pass struct epoll_filefd through ep_find() and ep_insert()
Date: Thu, 14 May 2026 08:07:17 -0600
Message-ID: <20260514140817.623026-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514140817.623026-1-axboe@kernel.dk>
References: <20260514140817.623026-1-axboe@kernel.dk>
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

