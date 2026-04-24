Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6B73D88F5
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038415; cv=none; b=B3dQqgthFHUApErWgPSSt1DEwQFP292ILHWhe+Q2Os1tttHQpaYcMjdxyWCAHbnLS44+txQT1aWSXw2ZJFvKVr3jukVvXAP2TxIZof/2oY63DliOLsMb5tSubijvBpXPrnHRMe1VyciW7WbNOmytwa5B2hhVwD5ROY2SJ9xJfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038415; c=relaxed/simple;
	bh=7YfwKn0skni5AaweIUAjIwSd8vLxNzTyOBaSXN6Piu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MU1K0sFvddZlFU9lVwlKSEkQKO7W51VkZEvz1qN77PiyIULqnW/vrSpRCpcyASeVK+YMFU1UVUhDEflmXz0HECjEQHvqyRWJyzgaM488o0ay3FUJ19UVM+ETmZHCk+9bVhU8OKSlpgbgMLz+xE21/mevghj0zNGR0tTsgaVLs2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJvmPaoR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJvmPaoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D41FC2BCB6;
	Fri, 24 Apr 2026 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038415;
	bh=7YfwKn0skni5AaweIUAjIwSd8vLxNzTyOBaSXN6Piu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vJvmPaoROxOF/uHg5d2ktqVCyucuBbA+mc3xBrSS4iWQktaA9B0tubPpnh6++ZITa
	 f8XFzWiJGidNXIOyhlVAwVK1aTqbFaHnx3ifExG2VT/jnRDMzEJZNHzx4tpjw7o7J7
	 DXOQVB+HrP4nEUQvu6yLwtwWoGPCqgm0eTAFVyDeLXKeBxx0kWsvbE1iOEvVbXUqnc
	 NQ0ZLW7Ux5WJHW/zp0NIElMdWDdVvjJ0rkexZqzshyzORrfVXiC2Zw3HPVCN4bqtla
	 jCiWv5rEjdmZq2jhQ2XedGw8a1ayShiZS0mrmv9+QdhO5HuJPxFRXd9d/dsn/MPVb+
	 85AOrMnY9YzXw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:34 +0200
Subject: [PATCH 03/17] eventpoll: clarify POLLFREE handshake comments
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-3-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3611; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7YfwKn0skni5AaweIUAjIwSd8vLxNzTyOBaSXN6Piu4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnHbvletMmfvJYHX4VdOmpVse2MpterX5KKp+c4yK
 XMYLr9Z3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR/KOMDHv+z/qafPVTl6sS
 956o1K663ywLNVSZDxZ+SpVdNm1u6T+G/4HMLco/9xfeN/6lUyi0WalpaWGjZdrKSxUL9uvr+n0
 U4wMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

ep_remove_wait_queue() and the POLLFREE branch of ep_poll_callback()
are the two halves of a release/acquire handshake that lets a
subsystem (binder, signalfd, ...) tear down a wait-queue head from
under a registered epitem. The existing local comments documented the
race but did not name the protocol or refer readers from one side to
the other. After the previous commit added a "POLLFREE handshake"
section to the top-of-file banner, these sites can point at the
banner and at each other.

Rework the two comment blocks so that each side is labelled
"acquire side" or "release side", references the banner, and
explains its role in the protocol. On the release side fuse the two
former comments into one narrative: list_del_init() tolerates a
second delete from a racing ep_remove_wait_queue(), and the
smp_store_release() is what lets that racing remover discover the
teardown.

Comment-only; no functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 477fcbc8e95e..1d1fd6464c38 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -828,10 +828,15 @@ static void ep_remove_wait_queue(struct eppoll_entry *pwq)
 
 	rcu_read_lock();
 	/*
-	 * If it is cleared by POLLFREE, it should be rcu-safe.
-	 * If we read NULL we need a barrier paired with
-	 * smp_store_release() in ep_poll_callback(), otherwise
-	 * we rely on whead->lock.
+	 * POLLFREE handshake, acquire side; see "POLLFREE handshake"
+	 * at the top of this file.
+	 *
+	 * A NULL load is paired with the smp_store_release(&whead, NULL)
+	 * in ep_poll_callback()'s POLLFREE branch: the teardown is
+	 * complete and we must not touch whead again. On a non-NULL load
+	 * rcu_read_lock() keeps the waitqueue memory alive (POLLFREE
+	 * firers RCU-defer the free) and whead->lock inside
+	 * remove_wait_queue() serializes us against the store side.
 	 */
 	whead = smp_load_acquire(&pwq->whead);
 	if (whead)
@@ -1505,17 +1510,24 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 
 	if (pollflags & POLLFREE) {
 		/*
-		 * If we race with ep_remove_wait_queue() it can miss
-		 * ->whead = NULL and do another remove_wait_queue() after
-		 * us, so we can't use __remove_wait_queue().
+		 * POLLFREE handshake, release side; see "POLLFREE handshake"
+		 * at the top of this file.
+		 *
+		 * Unlink our wait entry with list_del_init rather than
+		 * __remove_wait_queue: a concurrent ep_remove_wait_queue()
+		 * that already loaded a non-NULL whead may still call
+		 * remove_wait_queue() after us, and list_del_init() tolerates
+		 * the second delete.
+		 *
+		 * smp_store_release(&whead, NULL) publishes the teardown to
+		 * ep_remove_wait_queue()'s smp_load_acquire(). Before this
+		 * store, a racing ep_clear_and_put() / ep_remove() reaches
+		 * ep_remove_wait_queue() which sees whead != NULL and takes
+		 * whead->lock -- the same lock held by our caller, so it
+		 * serializes behind us. Once whead is zeroed, nothing else
+		 * protects ep / epi / wait.
 		 */
 		list_del_init(&wait->entry);
-		/*
-		 * ->whead != NULL protects us from the race with
-		 * ep_clear_and_put() or ep_remove(), ep_remove_wait_queue()
-		 * takes whead->lock held by the caller. Once we nullify it,
-		 * nothing protects ep/epi or even wait.
-		 */
 		smp_store_release(&ep_pwq_from_wait(wait)->whead, NULL);
 	}
 

-- 
2.47.3

