Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A06D3FFACE
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767718; cv=none; b=mllQRQGRj80h9yuEZiQohJRWpqeIBCTO6OxwkJK6SVjXl7fOkbTw3iheJFrsVBpAUbwJrMahYv5/m1VMuI4IsdgAnQfeDKuI6t9hCxewLdgTya1nMVJYidd0y3+JsoFs1kNp7eJvRdIDFMsmZd9oqYZkhwI3t03Vqf4S+16cgGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767718; c=relaxed/simple;
	bh=Nc+WVvDte2mveIsO0K6wCo0rdU0u+HckbZJiXE1v2ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFBcIKbuccZbRkOEowoFuZwj7bZUDVv3ABWKwe9uJeXqXlPlh/kK1kklMWycXuXz63arqZVxY0aR1vMr8B5FdN0bh85DSjktSwfYmEUqXsmYLbqnglCLbGRmdOwp34tz0Yqw3MyWysqe7JSQ1r8MWPq91TuiQGIuWqv+t9Q84PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=VIpR1JYE; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="VIpR1JYE"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-464bba3a9easo4321457b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778767707; x=1779372507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe11u6t4Qq4bwvnqoZIg8PmIgRIRXQGcxkxrBifqzak=;
        b=VIpR1JYEdqbWvSiSOIPhuU7CchI8ZbZzDY+AoRHbtCxqTn45NiAPkfK6qCCSwVkJMF
         q3I8jh6ntoC9Rtwla6TwubzsUWSH8504VPA7cjIcnu4yKJV9ndLVByB2lGrkYFYqYNJ4
         wQiDAe5vOLN6VGS72QsqTc+KmG/A+qvn9GJsXGVBUFpdKIlCQG22O78XRn1gZgpc3/q+
         EuolwU4XYn2uyPOu2zdpfeIA7O1g0Dm4BVE9bRn/MXbs6ST5jVbzLh57NRnVf10UAkh+
         0K7MtJj3dzHN6dmkSbIXUcPVi1yTpxEavd1dwZ1pZjYPrT0agkUFeTICpwGFjCmeJxjW
         gM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767707; x=1779372507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pe11u6t4Qq4bwvnqoZIg8PmIgRIRXQGcxkxrBifqzak=;
        b=fdK4nX4WnSmQ4as0SdCKNVtHvKpiMJlQJkyI9uKblCR96EBkdLIxN3x4RQlaCXnHjG
         Hq8WlnepM1jCOPXrQUHxFXfWDBf090XYQBNll2o6/cHJZHUAjYo916pJ6qZpzFIyWrxE
         vyHDBHJJIdSzttnqH2R2XqLe5gvCc/dab0XmUfJHCBmHJrradgAso+8xcr3cPX2Fk9yl
         /kw7XkKchtsi8b/i602bM20O2u8TBqbtz4fFKxotMSfV4+jLgB4F2QuDqjoHJk86jStM
         nfaJz3YpCORFWleKPYZ8BdA6B0S0IC867KEkbqU56hKp3RbkP9zivBqe3z0C40de/6eR
         WKdw==
X-Gm-Message-State: AOJu0Yz26yw+40pLP0Zesei8M+RqVxrgzgqzX4vpqIoPD1QaN0/DKdhS
	wUNe23Uc0DOClpBDyDHsiqTq83XYyZeYhQfmMOIbRP0ppHSg7zXt3WpfuyCY7bdN+6c=
X-Gm-Gg: Acq92OEPQLfK2P+ETUsQbyd1zlTke116FilLDe3oLJ7+8RZNxOsCFxtVUwBkosBl1wX
	HcIiYhyruQS11elM5wrr2BkmT4V0hlEfZkEBF6KKWMfl3j2QvJuGuNu44tGTJIoSTLMh6JIkhou
	oBucJmUcRzcUIFgZghM713dKuvzPHG52SneUDkqwOXs8UFBWffg9RsVPJVNl6EEpgUueN2kFUMP
	csgIUI08MRoYAy59mNWBg729QZBjIdPKK0l9mBE6JIkPitm/Gs5An5P6TRd7U+8S3m7AxZbWdZw
	LqJT6V14WLdQ4buZevMJzhWfPrjILGKsjJrSG2EF99zgVcLfZMQWyJr0jKuWkBq67/fJprPNjjA
	a/p1w9Z1lGkJnStc78bm9z2dMZxfjcUTytWI7qmU0RW+iI0DUQH9pcuvuS1h5kmKMB3t8yFWAOZ
	DyJKig624wl+GGEyRKc77ghBtcgP+c+xDEp/rZdBGG3euyw9OgzMMtVGvkQi01yoX71+a3UskUx
	kfy+A==
X-Received: by 2002:a05:6808:1816:b0:479:ffcf:52d7 with SMTP id 5614622812f47-482b2dd218bmr5026680b6e.46.1778767706744;
        Thu, 14 May 2026 07:08:26 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482d379f062sm1394956b6e.6.2026.05.14.07.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:08:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/6] eventpoll: add file based control interface
Date: Thu, 14 May 2026 08:07:19 -0600
Message-ID: <20260514140817.623026-4-axboe@kernel.dk>
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

Add do_epoll_ctl_file(), which takes a pre-resolved epoll file and a
struct epoll_filefd for the target rather than two integer file
descriptors. do_epoll_ctl() remains as a thin wrapper.

In preparation for using the file based interface from io_uring.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c            | 62 ++++++++++++++++++++-------------------
 include/linux/eventpoll.h |  7 +++++
 2 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9ea6a2bd3d87..1c7001866340 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -99,11 +99,6 @@
 
 #define EP_ITEM_COST (sizeof(struct epitem) + sizeof(struct eppoll_entry))
 
-struct epoll_filefd {
-	struct file *file;
-	int fd;
-} __packed;
-
 /* Wait structure used by the poll hooks */
 struct eppoll_entry {
 	/* List header used to link this structure to the "struct epitem" */
@@ -2225,30 +2220,17 @@ static inline int epoll_mutex_lock(struct mutex *mutex, int depth,
 	return -EAGAIN;
 }
 
-int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
-		 bool nonblock)
+int do_epoll_ctl_file(struct file *f, int op, struct epoll_filefd *tf,
+		      struct epoll_event *epds, bool nonblock)
 {
 	int error;
 	int full_check = 0;
 	struct eventpoll *ep;
 	struct epitem *epi;
 	struct eventpoll *tep = NULL;
-	struct epoll_filefd efd;
-
-	CLASS(fd, f)(epfd);
-	if (fd_empty(f))
-		return -EBADF;
-
-	/* Get the "struct file *" for the target file */
-	CLASS(fd, tf)(fd);
-	if (fd_empty(tf))
-		return -EBADF;
-
-	efd.file = fd_file(tf);
-	efd.fd = fd;
 
 	/* The target file descriptor must support poll */
-	if (!file_can_poll(fd_file(tf)))
+	if (!file_can_poll(tf->file))
 		return -EPERM;
 
 	/* Check if EPOLLWAKEUP is allowed */
@@ -2261,7 +2243,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	 * adding an epoll file descriptor inside itself.
 	 */
 	error = -EINVAL;
-	if (fd_file(f) == fd_file(tf) || !is_file_epoll(fd_file(f)))
+	if (f == tf->file || !is_file_epoll(f))
 		goto error_tgt_fput;
 
 	/*
@@ -2272,7 +2254,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	if (ep_op_has_event(op) && (epds->events & EPOLLEXCLUSIVE)) {
 		if (op == EPOLL_CTL_MOD)
 			goto error_tgt_fput;
-		if (op == EPOLL_CTL_ADD && (is_file_epoll(fd_file(tf)) ||
+		if (op == EPOLL_CTL_ADD && (is_file_epoll(tf->file) ||
 				(epds->events & ~EPOLLEXCLUSIVE_OK_BITS)))
 			goto error_tgt_fput;
 	}
@@ -2281,7 +2263,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	 * At this point it is safe to assume that the "private_data" contains
 	 * our own data structure.
 	 */
-	ep = fd_file(f)->private_data;
+	ep = f->private_data;
 
 	/*
 	 * When we insert an epoll file descriptor inside another epoll file
@@ -2302,16 +2284,16 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	if (error)
 		goto error_tgt_fput;
 	if (op == EPOLL_CTL_ADD) {
-		if (READ_ONCE(fd_file(f)->f_ep) || ep->gen == loop_check_gen ||
-		    is_file_epoll(fd_file(tf))) {
+		if (READ_ONCE(f->f_ep) || ep->gen == loop_check_gen ||
+		    is_file_epoll(tf->file)) {
 			mutex_unlock(&ep->mtx);
 			error = epoll_mutex_lock(&epnested_mutex, 0, nonblock);
 			if (error)
 				goto error_tgt_fput;
 			loop_check_gen++;
 			full_check = 1;
-			if (is_file_epoll(fd_file(tf))) {
-				tep = fd_file(tf)->private_data;
+			if (is_file_epoll(tf->file)) {
+				tep = tf->file->private_data;
 				error = -ELOOP;
 				if (ep_loop_check(ep, tep) != 0)
 					goto error_tgt_fput;
@@ -2327,14 +2309,14 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	 * above, we can be sure to be able to use the item looked up by
 	 * ep_find() till we release the mutex.
 	 */
-	epi = ep_find(ep, &efd);
+	epi = ep_find(ep, tf);
 
 	error = -EINVAL;
 	switch (op) {
 	case EPOLL_CTL_ADD:
 		if (!epi) {
 			epds->events |= EPOLLERR | EPOLLHUP;
-			error = ep_insert(ep, epds, &efd, full_check);
+			error = ep_insert(ep, epds, tf, full_check);
 		} else
 			error = -EEXIST;
 		break;
@@ -2369,6 +2351,26 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		mutex_unlock(&epnested_mutex);
 	}
 	return error;
+
+}
+
+int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
+		 bool nonblock)
+{
+	struct epoll_filefd efd;
+
+	CLASS(fd, f)(epfd);
+	if (fd_empty(f))
+		return -EBADF;
+
+	/* Get the "struct file *" for the target file */
+	CLASS(fd, tf)(fd);
+	if (fd_empty(tf))
+		return -EBADF;
+
+	efd.file = fd_file(tf);
+	efd.fd = fd;
+	return do_epoll_ctl_file(fd_file(f), op, &efd, epds, nonblock);
 }
 
 /*
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 7bf30e9f90d7..4a6fe989810b 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -61,6 +61,13 @@ static inline void eventpoll_release(struct file *file)
 	eventpoll_release_file(file);
 }
 
+struct epoll_filefd {
+	struct file *file;
+	int fd;
+} __packed;
+
+int do_epoll_ctl_file(struct file *f, int op, struct epoll_filefd *tf,
+		      struct epoll_event *epds, bool nonblock);
 int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		 bool nonblock);
 int is_file_epoll(struct file *f);
-- 
2.53.0

