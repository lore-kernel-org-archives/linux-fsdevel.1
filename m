Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940426;
	b=2RC/yK3IXJkYIS9Rde3iutOs6VXOORMbtepoq/QfD/xhRdjDmC5QHmAqv8lKWJ/6HUE+
	 aiDN4LRpRKvfMdZC4f+olZutytqzmLOhtrU9zm+V0Nt3ymV1QqbGjlO/KKqteD4OcdRWx
	 ubfjzOaeFO1dbWogJSERK3j9TWmr6fi9MOaHzcg/gsRVwEd2L6ccZbgojhHPYm2xtyfiP
	 I5x8LrOPhDK9CZu2KzSGKEnYRy8tPJK9LBfioIEBOGh66F0exgW8KVcbdXYGf/CPQI1Wc
	 bvgt6K55kcQxYyHmdmW8iM6556LDT3TUQv4RXxFmWoJkvR0eXS33fyXFdBrNfHCEjDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940426;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nT8GsGl9ylVIBcndChf2G1+bvGTn9s7An5P12CIB7to=;
	b=TsuqS/n1I8RAP26qrcA5gVUsF/ZrVgVfgFXjIHvFfVNFLNFM9W1tnr9Cf4gmQnTh2SM2
	 FkOQt9BLxaH21xidSM6Jb6AEOWe6ak+u2ZYW+0MI93H9W835idjIvIfCFFuPQnBGGfeQ+
	 IT771E746zP6wOIlZAzdW4MjXZBBs1/OoJoEXrzB8FuU+1ORGoB2xO56vYa6JKGewVM2L
	 lvqdUrpPVlGo32MfqBWt1w8f/V1wTLSyQWnmel5QoHkr+tmleJqBrW3qje2rxmyquHMZ9
	 r4gKvhMlnia6NNU+uVVrnjSJ2Rcl4ONPbmMgIjSL3XyuC5PZnYU5eGcgEEKhOvLOLDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iO2nZl6q;
	arc=none smtp.remote-ip=95.215.58.59
Received: from mta1.migadu.com (out-59.mta1.migadu.com [95.215.58.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB6606A31B
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 04:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FCB6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iO2nZl6q
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JaY48vU82NpgXndow1t+yYyeEA70Dvrc3FgWUyhC1LQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793940418; v=1; x=1794545218;
 b=iO2nZl6qyBzhoePfyqFBlVtZKcDfW9+p1u2Bu0CQ1+Dk2zZ+G++eol6MT1rDrLtIFmprt8+R
 xgHulVSkNjRNhiWE3m7TWPiFJ7AgkZ5cJExArE4pnIp+8R7c8ry7cxeLAolxJblFkNlfeuHvDi0
 YTGpoItu6jISRF5u0J3bflkA=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5b9226a0469bd136;
	Fri, 06 Nov 2026 04:46:58 +0000
X-Mizu-Trace-ID: 5b9226a0469bd136
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] eventpoll: check the event mask before taking ep->lock
Date: Fri,  6 Nov 2026 12:46:23 +0800
Message-ID: <20261106044624.278356-1-jiayuan.chen@linux.dev>
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
for nothing. E.g. a UDP socket registered with EPOLLIN only gets an
EPOLLOUT wakeup for every freed tx skb.

Check the mask first and return early if the event is not wanted. The
comment in ep_modify() counts on ep_poll_callback() taking ep->lock, so
do smp_mb() and read the mask again before dropping the event. Wanted
events take the lock as before.

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
 fs/eventpoll.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e0c4bf88a838..29e034e3a295 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1495,8 +1495,22 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
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
+		if (!(pollflags & events))
+			return !(events & EPOLLEXCLUSIVE);
+	}
+
 	spin_lock_irqsave(&ep->lock, flags);
 
 	ep_set_busy_poll_napi_id(epi);
-- 
2.43.0

