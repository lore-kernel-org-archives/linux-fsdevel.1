Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098E38C2D4;
	Tue,  2 Jun 2026 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422719; cv=none; b=V5xGBgl8+G6BapnIM9DITgojCVcPGiHIDeNAydBvKbuZ9pyMR+hV96oCD9041e1S+MMztQWO9ETuk9mAJpixeAEfGOlMlkyPtBbpSURx6FSZXSvo+zWMxbkErMm+CBRZzZ4lrQEIhK2m9y7GVjEdlBuRD4spaIQ2WipYZdXsU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422719; c=relaxed/simple;
	bh=v/4CJcUStN50PTDnbTokihYoDohpPVW9HYDAhQOZ9Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLuxEscj5KXaZ9WfaIUTYRhIZENVy+hMaBjdTvP63Vx/vHPyxDuYUgMemSZfkvInNwHEW7AUlGy1edQw0KEVClixY5LJnoQhtKgp+t3LtSKUg5vXsbWsnFjxo2RFa1YnRGrtIaZKa0Bx/0sf4G/uIvmdzvop3itvyCpl9DKucyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bL/ZpX1C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7nB0zdJq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bL/ZpX1C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7nB0zdJq"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780422716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOV9CFQdy1cW/ZQKOWrmNzSWrzUTnWJVp4TtwbZFzTE=;
	b=bL/ZpX1CxVjXGWo3/QB5ctqpaowXtMtyIOnKSH7d/Axfb8dqlLnthFhEcLB0nTaw6hsOqm
	3qyowc/4r67uW6/DodatDMcaNaacZXk8EzSU7p055+wW+lYg5H7EtDi0haCyNzqLL9UPlU
	IBQ62FFxsMxJen+K5ViukxePi8KCFSNWQcAoiLdApUWKdXLneTYwvpKPCbt1YtDkpvINXY
	FvF5u/ghVBAAX0U50dR/QIMyNii4c6ZgW3X/R74KuGXOZ4+G2vxUqLf3QxanofgyRdncTl
	Q5arPB67XCMvUDe6lf6iFzh5OgOg39JkY0mLztIhLq1UqthC7VkhDfxEerJz6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780422716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOV9CFQdy1cW/ZQKOWrmNzSWrzUTnWJVp4TtwbZFzTE=;
	b=7nB0zdJqSXrAPUbtK0GiEQuwl5zuR70VKpu8TBGtYl6Oowjzv3LaUVmWFkzlW096Q3jmMZ
	iNYLWVdyRNPw3TAw==
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 2/2] eventpoll: Fix epoll_wait() report false negative
Date: Tue,  2 Jun 2026 19:51:46 +0200
Message-ID: <4363cd8e34a21d4f0d257be1b33e84dc25030fdf.1780422138.git.namcao@linutronix.de>
In-Reply-To: <cover.1780422137.git.namcao@linutronix.de>
References: <cover.1780422137.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ep_events_available() checks for available events by looking at
ep->rdllist and ep_is_scanning(). However, this is done without a lock
and can report false negative if ep_start_scan() or ep_done_scan() are
executed by another task concurrently. For example:
_________________________________________________________________________
                                   |ep_start_scan()
                                   |  list_splice_init(&ep->rdllist, ...)
ep_events_available()              |
  !list_empty_careful(&ep->rdllist)|
  || ep_is_scanning(ep)            |
	                           |  ep_enter_scan(ep)
___________________________________|_____________________________________

Another example:
_________________________________________________________________________
ep_events_available()              |
                                   |ep_start_scan()
                                   |  list_splice_init(&ep->rdllist, ...)
	                           |  ep_enter_scan(ep)
  !list_empty_careful(&ep->rdllist)|
                                   |ep_done_scan()
                                   |  ep_exit_scan(ep)
                                   |  list_splice(..., &ep->rdllist)
  || ep_is_scanning(ep)            |
___________________________________|_____________________________________

In the above examples, ep_events_available() sees no event despite
events being available. In case epoll_wait() is called with timeout=3D0,
epoll_wait() will wrongly return "no event" to user.

Introduce a sequence lock to resolve this issue.

Measuring the time consumption of 10 million loop iterations doing
epoll_wait(), the following performance drop is observed:

   timeout  #event  before    after    diff
     0ms      0     3727ms   3974ms   +6.6%
     0ms      1     8099ms   9134ms    +13%
     1ms      1    13525ms  13586ms  +0.45%

Considering the use case of epoll_wait() (wait for events, do something
with the events, repeat), it should only contribute to a small portion of
user's CPU consumption. Therefore this performance drop is not alarming.

Fixes: c5a282e9635e ("fs/epoll: reduce the scope of wq lock in epoll_wait()=
")
Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 fs/eventpoll.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index baa97d0edade..df364a8783b5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -38,6 +38,7 @@
 #include <linux/compat.h>
 #include <linux/rculist.h>
 #include <linux/capability.h>
+#include <linux/seqlock.h>
 #include <net/busy_poll.h>
=20
 /*
@@ -312,6 +313,9 @@ struct eventpoll {
 	/* Lock which protects rdllist and ovflist */
 	spinlock_t lock;
=20
+	/* Protect switching between rdllist and ovflist */
+	seqcount_spinlock_t seq;
+
 	/* RB tree root used to store monitored fd structs */
 	struct rb_root_cached rbr;
=20
@@ -590,7 +594,10 @@ static inline void epi_clear_ovflist(struct epitem *ep=
i)
 /* True iff @ep has ready events that epoll_wait() might harvest. */
 static inline bool ep_events_available(struct eventpoll *ep)
 {
-	return !list_empty_careful(&ep->rdllist) || ep_is_scanning(ep);
+	unsigned int seq =3D read_seqcount_begin(&ep->seq);
+
+	return !list_empty_careful(&ep->rdllist) || ep_is_scanning(ep) ||
+		read_seqcount_retry(&ep->seq, seq);
 }
=20
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -947,8 +954,12 @@ static void ep_start_scan(struct eventpoll *ep, struct=
 list_head *scan_batch)
 	 */
 	lockdep_assert_irqs_enabled();
 	spin_lock_irq(&ep->lock);
+	write_seqcount_begin(&ep->seq);
+
 	list_splice_init(&ep->rdllist, scan_batch);
 	ep_enter_scan(ep);
+
+	write_seqcount_end(&ep->seq);
 	spin_unlock_irq(&ep->lock);
 }
=20
@@ -979,6 +990,9 @@ static void ep_done_scan(struct eventpoll *ep,
 			ep_pm_stay_awake(epi);
 		}
 	}
+
+	write_seqcount_begin(&ep->seq);
+
 	/* Back out of scan mode; callbacks target ep->rdllist again. */
 	ep_exit_scan(ep);
=20
@@ -986,6 +1000,9 @@ static void ep_done_scan(struct eventpoll *ep,
 	 * Quickly re-inject items left on "scan_batch".
 	 */
 	list_splice(scan_batch, &ep->rdllist);
+
+	write_seqcount_end(&ep->seq);
+
 	__pm_relax(ep->ws);
=20
 	if (!list_empty(&ep->rdllist)) {
@@ -1405,6 +1422,7 @@ static int ep_alloc(struct eventpoll **pep)
=20
 	mutex_init(&ep->mtx);
 	spin_lock_init(&ep->lock);
+	seqcount_spinlock_init(&ep->seq, &ep->lock);
 	init_waitqueue_head(&ep->wq);
 	init_waitqueue_head(&ep->poll_wait);
 	INIT_LIST_HEAD(&ep->rdllist);
--=20
2.47.3

