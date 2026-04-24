Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77330ACF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038417; cv=none; b=jpYZni2Zcaw9s8HEmc/KL+qwMOKMGmJ2HUZtg4VgQDINdjNUctcMf1gVYcIm5DjgWiUQxnmIPXxNb1JbsgmW7owGTdnKrCmNuINaGTpZk6K045Cl7YXfvh1wUXtXuHr8O2u1p0xX/SSmGlmWz9GgmU6NTzUeU6bsJEXkzGnfMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038417; c=relaxed/simple;
	bh=tmkCo+0KUNz+oIRxZlSBnUaaV0yFbiqtt4qptRMav6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvabXDxeO0mNYW1/bGDwZB4+MJR6nsqeWqXdHTHX1LpMtdKpCVOZJ5L9eL2UsWi80HjmNPQX5rnscnRbe8LBXZVUcu7nefI6IsQ8yldSt9A5V4JdiGvmQLU8KpGzc0CbAJYXOMNrNUmgg5cOGl3Rj1elLOISc3OgxsZSdt5PMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENb3JYpZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENb3JYpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF97C2BCB6;
	Fri, 24 Apr 2026 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038416;
	bh=tmkCo+0KUNz+oIRxZlSBnUaaV0yFbiqtt4qptRMav6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ENb3JYpZwzwyxYTv9xBNFmqRqf0FtlFNABLtz1acLDa34n+LhqGrKB1VAg6oVK+m5
	 RMN6jzSIDi+XRWlRCgQ6ecvtbWb9ES81u6yfYcKbK7sbDcjLWxUINe9+cdMv9yprp1
	 xXEZWJEU+PheH3UczCTqyKaW2ejjd54jmEcEG7lt/z3jBHvdzoKs8CjTtbifvU5Y13
	 OAlzw/6OKh4YjEF3W71gUmBgClWCb2Yyj9ua58AWnecZSMcsLKjnNA3r9RP+0QOwHZ
	 zLwuDryF881brjZpDvMBfibNT2F8La0fjcWwWENph5Lt+6YdbVu6zm7pTNxaqF80Hi
	 yQvmuQtCDEr3A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:35 +0200
Subject: [PATCH 04/17] eventpoll: refresh epi_fget() / ep_remove_file()
 comments
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-4-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4008; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tmkCo+0KUNz+oIRxZlSBnUaaV0yFbiqtt4qptRMav6Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnFnqtktZvRJ+O5nEYVO/WyeY66/biZJz+9xlY+4q
 hPcysjSUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJH19xj+l/5y4A+trG+ur/iz
 dUodv8k2mZLFlwuP1Nh4v96TPjlqLyPD5pnuSirrYhs/LQta+pJVv5j/S6VU2zLH9jkeqq+361h
 xAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Two comments drifted from the code they sit on.

epi_fget()'s block comment still referenced atomic_long_inc_not_zero,
which has been file_ref_get() for a while, and described only one of
the function's two roles: safe dereference of epi->ffd.file under
ep->mtx. Since commit a6dc643c6931 ("eventpoll: fix ep_remove struct
eventpoll / struct file UAF") the refcount bump also serves as a pin
that blocks __fput() from starting, which is what lets ep_remove()
touch file->f_lock and file->f_ep without racing
eventpoll_release_file(). Update the block to name both roles and the
commit that introduced the pin role.

ep_remove_file()'s one-line "See eventpoll_release() for details"
pointed at an inline in include/linux/eventpoll.h but said nothing
about what those details were. Replace it with a short explanation:
we publish NULL so the eventpoll_release() fastpath can skip the slow
path, and this is safe because every f_ep writer either holds a pin
via epi_fget() or is __fput() itself.

Comment-only; no functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1d1fd6464c38..1039d9737ce9 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -991,22 +991,23 @@ static void ep_free(struct eventpoll *ep)
 }
 
 /*
- * The ffd.file pointer may be in the process of being torn down due to
- * being closed, but we may not have finished eventpoll_release() yet.
+ * Pin @epi->ffd.file for operations that require both safe dereference
+ * and exclusion from __fput().
  *
- * Normally, even with the atomic_long_inc_not_zero, the file may have
- * been free'd and then gotten re-allocated to something else (since
- * files are not RCU-delayed, they are SLAB_TYPESAFE_BY_RCU).
+ * struct file uses SLAB_TYPESAFE_BY_RCU, so a freed slot can be
+ * reassigned at any time. The bare load of epi->ffd.file is safe here
+ * because the caller holds ep->mtx and eventpoll_release_file() blocks
+ * on that mutex while tearing down the epi, so the backing file
+ * allocation cannot be freed and reused under us. An rcu_read_lock()
+ * is therefore unnecessary for the load.
  *
- * But for epoll, users hold the ep->mtx mutex, and as such any file in
- * the process of being free'd will block in eventpoll_release_file()
- * and thus the underlying file allocation will not be free'd, and the
- * file re-use cannot happen.
- *
- * For the same reason we can avoid a rcu_read_lock() around the
- * operation - 'ffd.file' cannot go away even if the refcount has
- * reached zero (but we must still not call out to ->poll() functions
- * etc).
+ * A successful file_ref_get() additionally blocks __fput() from
+ * starting on this file: once the refcount has reached zero it cannot
+ * come back. ep_remove() relies on that to touch file->f_lock and
+ * file->f_ep without racing eventpoll_release_file() (see commit
+ * a6dc643c6931). A NULL return means __fput() is already in flight;
+ * the caller must bail without touching the file, and
+ * eventpoll_release_file() will clean the epi up from its side.
  */
 static struct file *epi_fget(const struct epitem *epi)
 {
@@ -1032,7 +1033,13 @@ static void ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 	spin_lock(&file->f_lock);
 	head = file->f_ep;
 	if (hlist_is_singular_node(&epi->fllink, head)) {
-		/* See eventpoll_release() for details. */
+		/*
+		 * Last watcher: publish NULL so the eventpoll_release()
+		 * fastpath in include/linux/eventpoll.h can skip the slow
+		 * path on a future __fput(). Safe because every f_ep writer
+		 * either holds a pin on @file via epi_fget() or is __fput()
+		 * itself -- see the comment in eventpoll_release().
+		 */
 		WRITE_ONCE(file->f_ep, NULL);
 		if (!is_file_epoll(file)) {
 			struct epitems_head *v;

-- 
2.47.3

