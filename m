Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE04353EEB
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038439; cv=none; b=A4c7Qv8g/B/yXfrw4F5WR3l2v5yyu2bFLqlQVdE3SBTVjWlC3Mh61RnFHWyn1ogFcobr66wY1TKIlI44Rv8YZjIs8ijKOkGEasPd3lN9jXuGEJc1PcqMIwhbFxepjJ5RH8zrvjmG0P8hvbnr0e0KZ8/KA7cuXad9uOSB4dNw0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038439; c=relaxed/simple;
	bh=qSJ91NgLLFmn8b8xG4nIX3D6Hg8K3mY7oRsjLpPRVJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=anqvzZDUofFATfsDWKTHAFutWixltCTj5AYBdsdFXkxhT4gePmTqa5nG9YaQ1KPPMCd+A+BKTsckqMHoh5XqdexK6GkL+Ont8D/mFcw/nwH/h2ZygABHBCIOONdeHDNZ9vgS7be8s6kcm1I7Pqg28wHhONW75Fazj8vvgpSDIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVuf8Vrd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVuf8Vrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5D1C19425;
	Fri, 24 Apr 2026 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038439;
	bh=qSJ91NgLLFmn8b8xG4nIX3D6Hg8K3mY7oRsjLpPRVJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OVuf8Vrd8YiNvZfiPS7K+Pimm+EQbkfHVrxhdqafqnzWVaJ4apivUvOoeR9hMMaVu
	 aJf6UI3UKjRe4C4jnn8Vxh/TNeMEDFZlkFbyrqd2h+tjgOcAavKretlrnv2Q6wntpW
	 8EQy/WPTK7pfcaQzVZivWB/uSQ184HEIOCRuwMe8EnDbTPbLWX6rJzuQRw3S7dKtzT
	 JwuTWz00zRp1yU8sI+8HXlkFNfJo8Kj1CbOyb44NbP5UgXaQzFhuZZJnQJ5GTqpz3c
	 5+fHld1cC2qlRK5aDlfYtQDgMmMSF/ZgG3oNJT8g7+kEdGt9ll7MIH5854Sr/od9s4
	 1ulz2RPREr/5A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:47 +0200
Subject: [PATCH 16/17] eventpoll: use bool for predicate helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-16-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3117; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qSJ91NgLLFmn8b8xG4nIX3D6Hg8K3mY7oRsjLpPRVJk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnG/0C5outDzT7jxuY98ZbZmXx7Kn9kzQ2Fv6amtN
 gWemrG7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi85OR4cz3R8HOcyPneq/3
 ff+ES+JC5IZlx45MqTpssXpfCdMq3hSGv1J639/c2Vr3eUVE9+q3GT/i5p+7/GTjRqHAySwLbMx
 Dy1gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Three inline predicates -- is_file_epoll(), ep_is_linked(),
ep_events_available() -- were declared to return int even though
their only use is as a truthy test and their bodies are already
boolean expressions. ep_has_wakeup_source(), in the same file,
returns bool, so the convention was already inconsistent.

Convert all three to return bool. Rewrite ep_events_available()'s
verbose kerneldoc to the same one-line style the rest of the
predicates use now.

ep_poll()'s local eavail variable stores the result of
ep_events_available() (already boolean), ep_busy_loop() (returns
bool), and list_empty() (int but tested as boolean). Split it out
of the combined int declaration and give it bool type; replace the
one "eavail = 1" after a wakeup with "eavail = true" to match.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7ed4b47279ff..201e688304b3 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -505,7 +505,7 @@ static void __init epoll_sysctls_init(void)
 
 static const struct file_operations eventpoll_fops;
 
-static inline int is_file_epoll(struct file *f)
+static inline bool is_file_epoll(struct file *f)
 {
 	return f->f_op == &eventpoll_fops;
 }
@@ -526,8 +526,8 @@ static inline int ep_cmp_ffd(struct epoll_filefd *p1,
 	        (p1->file < p2->file ? -1 : p1->fd - p2->fd));
 }
 
-/* Tells us if the item is currently linked */
-static inline int ep_is_linked(struct epitem *epi)
+/* True iff @epi is on its owning ep's ready list. */
+static inline bool ep_is_linked(struct epitem *epi)
 {
 	return !list_empty(&epi->rdllink);
 }
@@ -580,15 +580,8 @@ static inline void epi_clear_ovflist(struct epitem *epi)
 	epi->ovflist_next = EP_UNACTIVE_PTR;
 }
 
-/**
- * ep_events_available - Checks if ready events might be available.
- *
- * @ep: Pointer to the eventpoll context.
- *
- * Return: a value different than %zero if ready events are available,
- *          or %zero otherwise.
- */
-static inline int ep_events_available(struct eventpoll *ep)
+/* True iff @ep has ready events that epoll_wait() might harvest. */
+static inline bool ep_events_available(struct eventpoll *ep)
 {
 	return !list_empty_careful(&ep->rdllist) || ep_is_scanning(ep);
 }
@@ -2218,7 +2211,8 @@ static int ep_schedule_timeout(ktime_t *to)
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		   int maxevents, struct timespec64 *timeout)
 {
-	int res, eavail, timed_out = 0;
+	int res, timed_out = 0;
+	bool eavail;
 	u64 slack = 0;
 	wait_queue_entry_t wait;
 	ktime_t expires, *to = NULL;
@@ -2316,7 +2310,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * If timed out and still on the wait queue, recheck eavail
 		 * carefully under lock, below.
 		 */
-		eavail = 1;
+		eavail = true;
 
 		if (!list_empty_careful(&wait.entry)) {
 			spin_lock_irq(&ep->lock);

-- 
2.47.3

