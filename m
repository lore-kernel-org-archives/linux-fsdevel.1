Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795217456;
	b=2w343UC8XrJa/FI/x0c+GpZ9f8OdmRlwoRZ6dGrLIbV2mmRb5M7siYfQc/TwD10kBPdO
	 g1LZlCPRiQPFtR0toD8A4n0sIS5pagBePNTiNHl5a5k2Pp2VGcMdgIJ8q+5iwaHBuF2b4
	 g/2fmLbwAvEiorBS3meTnWVp9+Uhk+KjJrnq5n22TKYBqoUv63xYxbdZ9Mq0Uhyc4lqTW
	 ZCi/TPxQlfOYRmk46njGkznTf5YfTWPTa8r+A+dhiCFpNVKZSLM/GlYzdt/EOXx4cjnZf
	 DsyZ6lw+HFeuUbgmcVZAaqXitB1EhesUOzuw8an1fY5IMacQMHQNsdnHepGpXz4JDrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795217456;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=B+6ByUcjURpNjzZST2kaiznJJr40itmwjmJvfBoxcvU=;
	b=RzKJUi+6bw9MasmAkRgPz6LHnMdUx8PmQRK/M9BTBCRPyazm2doLbaDS35tRLDeKQIl8
	 3hWZ4G9+bHwvhlfVic22YV5Fhl9QC/aZ6L3WWMLHv16q8Qvzj455Vg4UDKiF/FDEEwYcj
	 EN3bekfLzFtmTVyPfxbj4nLLh6oEkWZ0spGiz7aWcKG/zepgFJCoOLZVW7+2N+A0mNLxO
	 ZQoJLFMlrCASr3nJd0t6OBnljR/7KcjEB0Vw0gIxX5R0WLgCr4HG8lxMl4MA5NC5Z1oHp
	 hrnNvJQFwJwxbIFy6L8gsQhkfztKhCijyiMjsTTK9PM2IeSNn4O6cVu3MPEEclx3t3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HbD5Ngvu;
	arc=none smtp.remote-ip=91.218.175.101
Received: from mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3114606A6B2
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 23:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3114606A6B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HbD5Ngvu
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cSQOE2NVyuln2UnuN/N+rqAZnRGw2/CreGt801pMlTI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795217448; v=1; x=1795822248;
 b=HbD5Ngvu/Jj6rigd02fsg7u4g++Hjmw9/SNdH+nQyVI6xz+04gby9YSBuo5XZdvi0z5FXUNE
 XGVenMUvS5G9pGkpV/JsxCK7MOhBqCJM6k7TbBFZ1DhX15xNdUoGN2btbkttvgbsaavBBJ0yxnm
 Kay2mtuD7kHmI9Ans8nRd4Wk=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9ccb25fd294b94ea;
	Fri, 20 Nov 2026 23:30:48 +0000
X-Mizu-Trace-ID: 9ccb25fd294b94ea
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] eventpoll: check the event mask before taking ep->lock
Date: Sat, 21 Nov 2026 07:30:36 +0800
Message-ID: <20261120233037.124956-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ep_poll_callback() takes ep->lock and only then checks whether the
event matches epi->event.events. But epi->event.events is not protected
by ep->lock, ep_modify() and the EPOLLONESHOT disarm update it under
ep->mtx.

So a wakeup for an event nobody asked for takes and releases ep->lock
for nothing. E.g. a UDP socket registered with only EPOLLIN still gets
EPOLLOUT wakeups when its tx skbs are freed.

Check the mask first and return early if the event is not wanted. The
comment in ep_modify() counts on ep_poll_callback() taking ep->lock, so
do smp_mb() and read the mask again before dropping the event, and
update that comment. Wanted events take the lock as before.

ep_set_busy_poll_napi_id() is still called for a dropped event, now
without ep->lock, so use READ_ONCE()/WRITE_ONCE() for the remaining
plain accesses to ep->napi_id.

Benchmark, based on stress-epoll.c [1]: N threads share one epoll, each
thread registers its own eventfd with EPOLLPRI, which eventfd never
raises, and loops on write() + read(). Both call ep_poll_callback(),
with EPOLLIN and EPOLLOUT. 12 vCPU VM, ops/ms:

  threads   before    after
        1      396      402
        4     1514     1604
       12     1264     4817

The original stress-epoll.c hits this path too: the poller read()s the
eventfds, and eventfd_read() wakes with EPOLLOUT while they are
registered with EPOLLIN. 32 vCPU VM, events/ms, average of 6 runs:

  threads   before    after
        8     1293     1315
       16     1407     1422
       32     1304     1431

Real case, udp rr over veth with 1000 connected sockets registered with
EPOLLIN: _raw_spin_lock_irqsave drops by ~1%.

[1] https://github.com/rouming/test-tools/blob/master/stress-epoll.c

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---

v2:
 - update the comment in ep_modify()
 - keep calling ep_set_busy_poll_napi_id() for dropped events
v1:https://lore.kernel.org/linux-fsdevel/20261106044624.278356-1-jiayuan.chen@linux.dev/
---
 fs/eventpoll.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index b959af04772c..ba61f362eb08 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -687,7 +687,7 @@ static bool ep_busy_loop(struct eventpoll *ep)
 		 */
 		if (prefer_busy_poll)
 			napi_resume_irqs(napi_id);
-		ep->napi_id = 0;
+		WRITE_ONCE(ep->napi_id, 0);
 		return false;
 	}
 	return false;
@@ -720,11 +720,11 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 	 *	or
 	 * Nothing to do if we already have this ID
 	 */
-	if (!napi_id_valid(napi_id) || napi_id == ep->napi_id)
+	if (!napi_id_valid(napi_id) || napi_id == READ_ONCE(ep->napi_id))
 		return;
 
 	/* record NAPI ID for use in next busy poll */
-	ep->napi_id = napi_id;
+	WRITE_ONCE(ep->napi_id, napi_id);
 }
 
 static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
@@ -1495,8 +1495,24 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	struct eventpoll *ep = epi->ep;
 	__poll_t pollflags = key_to_poll(key);
 	unsigned long flags;
+	__poll_t events;
 	int ewake = 0;
 
+	/*
+	 * epi->event.events is updated under ep->mtx, not ep->lock, so an
+	 * event nobody asked for can be dropped without taking ep->lock.
+	 */
+	events = READ_ONCE(epi->event.events);
+	if (pollflags && !(pollflags & (events | POLLFREE))) {
+		/* Pairs with smp_mb() in ep_modify(). */
+		smp_mb();
+		events = READ_ONCE(epi->event.events);
+		if (!(pollflags & events)) {
+			ep_set_busy_poll_napi_id(epi);
+			return !(events & EPOLLEXCLUSIVE);
+		}
+	}
+
 	spin_lock_irqsave(&ep->lock, flags);
 
 	ep_set_busy_poll_napi_id(epi);
@@ -2016,8 +2032,9 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 *    we do not miss events from ep_poll_callback if an
 	 *    event occurs immediately after we call f_op->poll().
 	 *    We need this because we did not take ep->lock while
-	 *    changing epi above (but ep_poll_callback does take
-	 *    ep->lock).
+	 *    changing epi above.  ep_poll_callback either takes
+	 *    ep->lock before it checks epi->event.events, or does
+	 *    smp_mb() before it drops an event without the lock.
 	 *
 	 * 2) We also need to ensure we do not miss _past_ events
 	 *    when calling f_op->poll().  This barrier also
-- 
2.43.0

