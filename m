Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372393FE655
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767719; cv=none; b=o6fQgM04V6BIKwLa7KdALA4Aby0x1S1PNPhDQKQy969iK8QcawFFXV1THCWxUHCVGdF/acwK1l07RpB4Dt3gLA3pxXXMfU8NIvnsMCl5vK4d7+oR7Bn6ZbeqCpRIJx+U05vp7BzeCochjcbuPyfomPoll6AEKqZLVD/JkLo8/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767719; c=relaxed/simple;
	bh=MfxGf4k9bzg3mLwup0IaKiUGOVMqKY8RKOnZjm/Zlgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doMBV6+2tFzMXy7eRiNVT6Sju0H+y3nsDiWB7N2B2Nd1+R3WX0d6TJKxf7tEidx0TknJnCT9mOgsbN64y9NpBIyLPuuyA5oJoERCTb6hz4ZvdHPBc5IdMoFlOsze97/6UoHMMbtId5dpSlw+gizdA6ZGhbx+iE+xlfJTU1pKALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=LF63ddbf; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="LF63ddbf"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479f7e75a6bso3338313b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778767708; x=1779372508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9SCnljrhoN+CFUXYWb37sIdHn7+8JTxl2AQOURl0Sw=;
        b=LF63ddbfmB4R5UkEKckGSSZTawauXrBMOMLHr2I/wqi2QhhxzH0ZG8wNS8ikT0s0bE
         eqEJyLhBB7LH1lBlEtfEf4eMPVvWISPgGW1xNg2nHgUjFXzmP01lGFz9Np1w8+gnIZH8
         m61+zs8vYwKhZiZa+7q+vKN3nw2mTbjKdo20ZfbH8Hb2CooTOUJqPW3Q4PeeTEmwUZ9h
         8e18RLz3p21LYj0RCHMUSufbx6SnhVpbg53byv61piFbkc1bf2LczHyqyZCKWqwqhfTF
         R7MSeSxr0JVBRDxQpXkKVipWMjXns6bHE9RpZlGoW8573NK9mrjJ0WQeuTot9sMZUHWS
         qjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767708; x=1779372508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f9SCnljrhoN+CFUXYWb37sIdHn7+8JTxl2AQOURl0Sw=;
        b=n/HEGjdYLSmUJxquJ8LGW1Le3u6LigF3bBJJgRBUjfNocaOFH/kTmF90+XGRTKXUPq
         bdlGQUzLd2dxsFgsro49JzvtrdQ2gQ/1TTM0cWVpNx4/pwyVFSA/lotoTS0UhnavODR/
         Zkg2rl2IuNJy1KcPla9XO7G6CWFV04Vus78lMItONwHS+jcZQnetDr5GfZlUUXgV2MCh
         Ff1PPxLwnAaJg8Vg93+LvV4vSJYAp+xmuLfv7Llg2ybS2ASbzyYCV7ESzpY/Kh0CZbUt
         GjFbsVgHAZvwcIrH06Ms1p04YApXTnomWOK61ocX1rgineL/8uigyZkwQgthyM1v3KCO
         N7aA==
X-Gm-Message-State: AOJu0YzhAy+TgX+NolhRfQOpm4X7viveiiOIcnEVNImSVcNOucjPdLG7
	pLuSDy+MZEgWlBb+UMDEB9GkIs5z9t/MDMB4vCNkU4bW7gFWMqiKdspySn+gAS1rzBQ=
X-Gm-Gg: Acq92OE69WtwtYdrUz6keZ9k2+zSxT1+8JW/T5HfAevnfdF4sc+B2sjf0jTArKWzUh2
	m29N+H1Rggm5LWsrp9MabUzEKuCLigijHUWFS8Da6vgonQazPrcQts8JRuKdn8ftPaWOoaKZTx3
	HJVQZ1nk0yuAOU7ws64e/8lkdXMW57nvYt2fNLEu0zz/aFUZd6XjTd+Fq+4yw+7OqQm3B9H0FS6
	zOsqYEEy7V2KEIx9eO/fzGGGV5wLDhhoVfJ+sT76WDtHVRPvwWOuRUx8E4hAn1gu3JAPFJLzL20
	eoDty0z+EUGQYynOMPQvv7+oCnaw1Sx39WwZrj/nIkLkSeEdWc8JKNCD+4mp9S98l9Y+XViU4nm
	RdSl/WQ/wFYAO4oJ09RVco8QA/jq2rIUazJ7GARnwTKA2FIQPKJgoYEKzAx/UkiaB2b4v0mqV6H
	Fv9P8wkZ+CCQAURPm9vqetNf9Hv+8E6/gWbvwR0eGv80V58cEnjgX5LKo2/RnrmH2WqMQKxCuz+
	rKwgg==
X-Received: by 2002:a05:6808:14d0:b0:479:f928:44d9 with SMTP id 5614622812f47-482b25bdae6mr5017604b6e.0.1778767708007;
        Thu, 14 May 2026 07:08:28 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482d379f062sm1394956b6e.6.2026.05.14.07.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:08:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] eventpoll: rename struct epoll_filefd to epoll_key
Date: Thu, 14 May 2026 08:07:20 -0600
Message-ID: <20260514140817.623026-5-axboe@kernel.dk>
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

This more accurately describes what purpose this structure serves, as
a lookup key.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c            | 13 ++++++-------
 include/linux/eventpoll.h |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1c7001866340..7535b10f8c6a 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -141,7 +141,7 @@ struct epitem {
 	struct epitem *next;
 
 	/* The file descriptor information this item refers to */
-	struct epoll_filefd ffd;
+	struct epoll_key ffd;
 
 	/* List containing poll wait queues */
 	struct eppoll_entry *pwqlist;
@@ -335,8 +335,7 @@ int is_file_epoll(struct file *f)
 }
 
 /* Compare RB tree keys */
-static inline int ep_cmp_ffd(struct epoll_filefd *p1,
-			     struct epoll_filefd *p2)
+static inline int ep_cmp_ffd(struct epoll_key *p1, struct epoll_key *p2)
 {
 	return (p1->file > p2->file ? +1:
 	        (p1->file < p2->file ? -1 : p1->fd - p2->fd));
@@ -1160,7 +1159,7 @@ static int ep_alloc(struct eventpoll **pep)
  * are protected by the "mtx" mutex, and ep_find() must be called with
  * "mtx" held.
  */
-static struct epitem *ep_find(struct eventpoll *ep, struct epoll_filefd *tf)
+static struct epitem *ep_find(struct eventpoll *ep, struct epoll_key *tf)
 {
 	int kcmp;
 	struct rb_node *rbp;
@@ -1549,7 +1548,7 @@ static int attach_epitem(struct file *file, struct epitem *epi)
  * Must be called with "mtx" held.
  */
 static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
-		     struct epoll_filefd *tf, int full_check)
+		     struct epoll_key *tf, int full_check)
 {
 	int error, pwake = 0;
 	__poll_t revents;
@@ -2220,7 +2219,7 @@ static inline int epoll_mutex_lock(struct mutex *mutex, int depth,
 	return -EAGAIN;
 }
 
-int do_epoll_ctl_file(struct file *f, int op, struct epoll_filefd *tf,
+int do_epoll_ctl_file(struct file *f, int op, struct epoll_key *tf,
 		      struct epoll_event *epds, bool nonblock)
 {
 	int error;
@@ -2357,7 +2356,7 @@ int do_epoll_ctl_file(struct file *f, int op, struct epoll_filefd *tf,
 int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		 bool nonblock)
 {
-	struct epoll_filefd efd;
+	struct epoll_key efd;
 
 	CLASS(fd, f)(epfd);
 	if (fd_empty(f))
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 4a6fe989810b..c214c374fefc 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -61,12 +61,12 @@ static inline void eventpoll_release(struct file *file)
 	eventpoll_release_file(file);
 }
 
-struct epoll_filefd {
+struct epoll_key {
 	struct file *file;
 	int fd;
 } __packed;
 
-int do_epoll_ctl_file(struct file *f, int op, struct epoll_filefd *tf,
+int do_epoll_ctl_file(struct file *f, int op, struct epoll_key *tf,
 		      struct epoll_event *epds, bool nonblock);
 int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		 bool nonblock);
-- 
2.53.0

