Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8110C3D904F
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038434; cv=none; b=aEA5HpyxiIQZvNTjZaawD5PRR8B1Ct3hJ+7DPwFiQ/4KE7c7Mruj3f1XbQlf5eoWHvu+AqFQXA5/UEWlEFkHSKeT2oIvG2cYKxiH+x+LBVYQrFNRYpAI/Nu1GS+1c6sEcGS+L53kHIQezbefLGd2dqnk/P2Vq/Zip82h2KUs+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038434; c=relaxed/simple;
	bh=eLxWYS2eBOgtytv9Rk3bRTpJL20RPQKjyCtixX8EBSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gzTB6L5Eq5VY0UncUhF3gImXbYjBpn0QQSo/EvrtI/ZfexRHho6xV6LJTG42qj+Uv/7UgSBuMNEdGXBhgenixZ/+nDDlVhFqu99olVNx2KEMwBcvlL4PrFJoFu/2wAE/ObEHTPgMf5vCh7GwHoO2Qv5bMdqZzoGgvTR6WZK9wR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiODQbMQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiODQbMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149DDC2BCB5;
	Fri, 24 Apr 2026 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038433;
	bh=eLxWYS2eBOgtytv9Rk3bRTpJL20RPQKjyCtixX8EBSY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oiODQbMQganbP8rFQz1KulnzkrDeLHxNSovEw9cghEZAH63X3yg+GnKCVi3nide8s
	 vcKJORQoi7q0Qu3K0/Uu5L2/AvazmfP3A5XGIHaNZ+0B9JJAnrX6/M/RlTVaYgATXh
	 IjreCLXzbM3cL76GvU3LHO/a0hMAnW65yQ82UqTtQ4+UeN26NWVpt4ap7EdjO3LEd7
	 jY+QrGegJkVjaBPzVnGUmkHnIUV6cRz0kgSdmLziewrakz+FKbsnYRyFgtJb1loaFe
	 R69LY/djAfDf+3kcVChs9byt6NOR0SP+EL7P9zwdPpfzPrtyyiBYnm8MS02hmbh/WV
	 zP2xjcsV2+J4g==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:44 +0200
Subject: [PATCH 13/17] eventpoll: extract lock dance from do_epoll_ctl()
 into ep_ctl_lock()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-13-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8423; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eLxWYS2eBOgtytv9Rk3bRTpJL20RPQKjyCtixX8EBSY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnF/p3wrlqtVi2f+ZvVrilp3vgUtnNbgvTFN1+/oh
 NueMRxpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5n87I8GPdbf/+Kb/+Rujv
 EwhnNFB/vmz984lhBxaz/mKVlJOeOJ+RYW6v0prgD99CTM1DWpRnpRu1HIl6M2Oz5ae7EXuEuht
 iWQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

do_epoll_ctl() interleaved three concerns in one body: input
validation, the ep->mtx + epnested_mutex acquisition dance for
EPOLL_CTL_ADD on potentially-nested topologies, and the op dispatch
with final unlock. The middle concern is the error-prone one; the
error_tgt_fput label existed mainly to orchestrate it.

Extract the acquisition as ep_ctl_lock() and the release as
ep_ctl_unlock(). ep_ctl_lock() always takes ep->mtx and, for
EPOLL_CTL_ADD on a topology that can change, additionally runs the
loop / path check under epnested_mutex. The return value is a
ternary:

   0        ep->mtx held.
   1        ep->mtx AND epnested_mutex held (full-check mode).
   -errno   failure, no locks held.

The non-negative value doubles as the @full_check argument to
ep_insert() and as the argument to ep_ctl_unlock(), so the caller
neither needs an out-parameter nor a separate boolean:

   full_check = ep_ctl_lock(ep, op, epfile, tfile, nonblock);
   if (full_check < 0)
       return full_check;
   ...
   ep_ctl_unlock(ep, full_check);

ep_ctl_unlock() drops ep->mtx and, if full_check == 1, clears
tfile_check_list, bumps loop_check_gen, and drops epnested_mutex --
mirroring the old error_tgt_fput block.

With that in place do_epoll_ctl()'s preconditions become direct
returns (no locks held, nothing to clean up), the acquisition is a
single call, the op dispatch is unchanged, and the epilogue is a
single ep_ctl_unlock() before return. The error_tgt_fput label goes
away.

The two loop_check_gen bumps (one at the start of the full check,
one after) are preserved inside ep_ctl_lock() / ep_ctl_unlock(),
keeping the invariant that ep->gen stamps left on per-eventpoll
caches never equal loop_check_gen after the check completes.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 152 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 91 insertions(+), 61 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 6d4167a347ab..d49457dc8c7f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2479,14 +2479,92 @@ static inline int epoll_mutex_lock(struct mutex *mutex, bool nonblock)
 	return mutex_trylock(mutex) ? 0 : -EAGAIN;
 }
 
+/*
+ * Acquire the locks required for do_epoll_ctl() on @ep for @op.
+ *
+ * Always takes ep->mtx. For EPOLL_CTL_ADD, additionally runs the
+ * loop / path check under epnested_mutex when the topology can
+ * change: @ep is already watched (epfile->f_ep non-NULL), @ep was
+ * recently loop-checked (ep->gen == loop_check_gen), or @tfile is
+ * itself an eventpoll.
+ *
+ * Return value encodes both outcome and lock state:
+ *
+ *   0        success; ep->mtx held.
+ *   1        success; ep->mtx held AND the full check ran under
+ *            epnested_mutex (which is also still held). The value
+ *            doubles as the @full_check argument to ep_insert().
+ *   -errno   failure; no locks held.
+ *
+ * The caller releases what was taken with ep_ctl_unlock(ep, ret).
+ *
+ * Holding epnested_mutex on add is what prevents two racing
+ * EPOLL_CTL_ADDs on different eps from building a cycle without
+ * either walker observing it.
+ */
+static int ep_ctl_lock(struct eventpoll *ep, int op,
+		       struct file *epfile, struct file *tfile,
+		       bool nonblock)
+{
+	struct eventpoll *tep;
+	int error;
+
+	error = epoll_mutex_lock(&ep->mtx, nonblock);
+	if (error)
+		return error;
+
+	if (op != EPOLL_CTL_ADD)
+		return 0;
+	if (!READ_ONCE(epfile->f_ep) && ep->gen != loop_check_gen &&
+	    !is_file_epoll(tfile))
+		return 0;
+
+	/* Full check needed: drop ep->mtx so we can take epnested_mutex. */
+	mutex_unlock(&ep->mtx);
+	error = epoll_mutex_lock(&epnested_mutex, nonblock);
+	if (error)
+		return error;
+
+	loop_check_gen++;
+
+	if (is_file_epoll(tfile)) {
+		tep = tfile->private_data;
+		if (ep_loop_check(ep, tep) != 0) {
+			error = -ELOOP;
+			goto err_unlock_nested;
+		}
+	}
+
+	error = epoll_mutex_lock(&ep->mtx, nonblock);
+	if (error)
+		goto err_unlock_nested;
+
+	return 1;
+
+err_unlock_nested:
+	clear_tfile_check_list();
+	loop_check_gen++;
+	mutex_unlock(&epnested_mutex);
+	return error;
+}
+
+static void ep_ctl_unlock(struct eventpoll *ep, int full_check)
+{
+	mutex_unlock(&ep->mtx);
+	if (full_check) {
+		clear_tfile_check_list();
+		loop_check_gen++;
+		mutex_unlock(&epnested_mutex);
+	}
+}
+
 int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		 bool nonblock)
 {
 	int error;
-	int full_check = 0;
+	int full_check;
 	struct eventpoll *ep;
 	struct epitem *epi;
-	struct eventpoll *tep = NULL;
 
 	CLASS(fd, f)(epfd);
 	if (fd_empty(f))
@@ -2506,76 +2584,34 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		ep_take_care_of_epollwakeup(epds);
 
 	/*
-	 * We have to check that the file structure underneath the file descriptor
-	 * the user passed to us _is_ an eventpoll file. And also we do not permit
+	 * The @epfd file must itself be an eventpoll, and we do not permit
 	 * adding an epoll file descriptor inside itself.
 	 */
-	error = -EINVAL;
 	if (fd_file(f) == fd_file(tf) || !is_file_epoll(fd_file(f)))
-		goto error_tgt_fput;
+		return -EINVAL;
 
 	/*
 	 * epoll adds to the wakeup queue at EPOLL_CTL_ADD time only,
 	 * so EPOLLEXCLUSIVE is not allowed for a EPOLL_CTL_MOD operation.
-	 * Also, we do not currently supported nested exclusive wakeups.
+	 * Also, nested exclusive wakeups are not supported.
 	 */
 	if (ep_op_has_event(op) && (epds->events & EPOLLEXCLUSIVE)) {
 		if (op == EPOLL_CTL_MOD)
-			goto error_tgt_fput;
+			return -EINVAL;
 		if (op == EPOLL_CTL_ADD && (is_file_epoll(fd_file(tf)) ||
 				(epds->events & ~EPOLLEXCLUSIVE_OK_BITS)))
-			goto error_tgt_fput;
+			return -EINVAL;
 	}
 
-	/*
-	 * At this point it is safe to assume that the "private_data" contains
-	 * our own data structure.
-	 */
 	ep = fd_file(f)->private_data;
 
-	/*
-	 * When we insert an epoll file descriptor inside another epoll file
-	 * descriptor, there is the chance of creating closed loops, which are
-	 * better be handled here, than in more critical paths. While we are
-	 * checking for loops we also determine the list of files reachable
-	 * and hang them on the tfile_check_list, so we can check that we
-	 * haven't created too many possible wakeup paths.
-	 *
-	 * We do not need to take the global 'epumutex' on EPOLL_CTL_ADD when
-	 * the epoll file descriptor is attaching directly to a wakeup source,
-	 * unless the epoll file descriptor is nested. The purpose of taking the
-	 * 'epnested_mutex' on add is to prevent complex toplogies such as loops and
-	 * deep wakeup paths from forming in parallel through multiple
-	 * EPOLL_CTL_ADD operations.
-	 */
-	error = epoll_mutex_lock(&ep->mtx, nonblock);
-	if (error)
-		goto error_tgt_fput;
-	if (op == EPOLL_CTL_ADD) {
-		if (READ_ONCE(fd_file(f)->f_ep) || ep->gen == loop_check_gen ||
-		    is_file_epoll(fd_file(tf))) {
-			mutex_unlock(&ep->mtx);
-			error = epoll_mutex_lock(&epnested_mutex, nonblock);
-			if (error)
-				goto error_tgt_fput;
-			loop_check_gen++;
-			full_check = 1;
-			if (is_file_epoll(fd_file(tf))) {
-				tep = fd_file(tf)->private_data;
-				error = -ELOOP;
-				if (ep_loop_check(ep, tep) != 0)
-					goto error_tgt_fput;
-			}
-			error = epoll_mutex_lock(&ep->mtx, nonblock);
-			if (error)
-				goto error_tgt_fput;
-		}
-	}
+	full_check = ep_ctl_lock(ep, op, fd_file(f), fd_file(tf), nonblock);
+	if (full_check < 0)
+		return full_check;
 
 	/*
-	 * Try to lookup the file inside our RB tree. Since we grabbed "mtx"
-	 * above, we can be sure to be able to use the item looked up by
-	 * ep_find() till we release the mutex.
+	 * Look the target up in ep's RB tree. We hold ep->mtx, so the
+	 * item stays valid until we release.
 	 */
 	epi = ep_find(ep, fd_file(tf), fd);
 
@@ -2610,14 +2646,8 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 			error = -ENOENT;
 		break;
 	}
-	mutex_unlock(&ep->mtx);
 
-error_tgt_fput:
-	if (full_check) {
-		clear_tfile_check_list();
-		loop_check_gen++;
-		mutex_unlock(&epnested_mutex);
-	}
+	ep_ctl_unlock(ep, full_check);
 	return error;
 }
 

-- 
2.47.3

