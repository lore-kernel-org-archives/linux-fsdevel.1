Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891F3D88F5
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038413; cv=none; b=Gd8VaG/eHPotcfG9V8atOiJ6o9OTXm1O022JYAbOLTOcivBxUml5pVyfNWBXfzoW3v6Etxhp2E2NChtrXlSC4tq1XTtJZMZB1tB8fnKDzZQD8SVH/JEQC/7ELHzl14ZrBvVEQFlh50jSYvH1K4WCnrdvmskxHcVdePSF2xiToQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038413; c=relaxed/simple;
	bh=zM4fLNLSumEB0pkHdV0Zg+85Gu2QHV02b6hd5xUi2ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iGUgpTluNPMmUAzfEbfv2ndm1gJWI50+9kID87F9PbYdtIOPzCyVumsFnOq7DBeD0adzACgB5s6MPmMReH6ebnVZ8BnB3p2woyJ/wSCu86Ual7bAfTzcQ+jxb1edVbCW4/A2b287MfFuVHYa+qBijw2a3iLHaUJ9hkhUqyLWa9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfCy2FjW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfCy2FjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D651DC2BCB2;
	Fri, 24 Apr 2026 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038413;
	bh=zM4fLNLSumEB0pkHdV0Zg+85Gu2QHV02b6hd5xUi2ak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mfCy2FjWOzEjeqeK+yxV9UEB3ggkt/FsGWZFBm9kc+6e4UkOTCGBDM7mZHfZ7l2cx
	 2yF1QvIxJtIEKk0ISnBKcTf1qkqv/BI5Bjl4a2V/NBE/1e5eV64K6k46KRcu/sV8oU
	 rKVWvfO8mRAD5/C2vltJDo0U5KqpNs3ju9f+k/0LI8UHrjeZqc4apt0iDoJvrr6s22
	 8UKeSMXUP1a5BoY6AxuLzHVpkf3eV46f/ygNyY6LbBivtEoj49c6kFgL55rz912q6F
	 jRXQXmxbA63FJ78iz+WQkpkyLCn7y8E76OzM4MTbaqZ0JEfr+bH8HS09pz9ycqSUqW
	 mozFeKY2aDkZA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:33 +0200
Subject: [PATCH 02/17] eventpoll: document loop-check / path-check globals
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-2-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5108; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zM4fLNLSumEB0pkHdV0Zg+85Gu2QHV02b6hd5xUi2ak=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnEL31cx/Y7QPUufLY0Hll5yXLB8Vn7oCZ/f3Q8k5
 M6Lh9i3dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzky3uG/3FJp2NShffM7He6
 WXn3bYmp9azpTZvZnxaosATxTpm/xoThnwpvqkD4e0etPn9VR+7bCsvsfqwq3Bq7ks8h+MVpyb9
 srAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The globals that support EPOLL_CTL_ADD's cycle and path-length checks
are scattered: epnested_mutex, loop_check_gen, inserting_into, and
tfile_check_list sit at the top of the file; path_count[] and
path_limits[] are declared inline with the path-check code further
down. Their interaction -- the "ep->gen == loop_check_gen" trigger in
do_epoll_ctl(), the two loop_check_gen++ bumps that sandwich a check,
the EP_UNACTIVE_PTR sentinel on tfile_check_list, the -ELOOP back-edge
detection via inserting_into -- is not documented anywhere.

The area has had three recent fixes (CVE-2025-38349, the unbounded
recursion fix, and the overflow fix) whose logic depends on these
invariants. Collect the description in one block alongside the
declarations, cross-reference the path_count[] declaration that lives
with the path-check code, and name the fix commits so future readers
can find the context.

Also add a short comment on struct epitems_head describing its
dual use (wrapper for non-epoll file->f_ep versus pointing into
&ep->refs for the epoll-watches-epoll case), which the old comment
on tfile_check_list had accidentally attached to the struct.

Comment-only; no functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 5896f705a3ac..477fcbc8e95e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -372,12 +372,54 @@ struct ep_pqueue {
 /* Maximum number of epoll watched descriptors, per user */
 static long max_user_watches __read_mostly;
 
-/* Used for cycles detection */
+/*
+ * Cycle and path-length checks at EPOLL_CTL_ADD
+ * ---------------------------------------------
+ *
+ * When EPOLL_CTL_ADD creates a link that either targets an eventpoll
+ * file or extends an existing chain of eventpolls, two checks run:
+ *
+ *   1. no cycle is being formed -- ep_loop_check() walks downward
+ *      from the candidate target, and ep_get_upwards_depth_proc()
+ *      walks upward from the outer ep, both bounded by EP_MAX_NESTS.
+ *   2. no file accumulates more than path_limits[depth] wakeup paths
+ *      of a given length -- reverse_path_check().
+ *
+ * Both need a global view of the epoll topology and must be atomic
+ * with the insertion, so the scratch state below is all serialized by
+ * one global mutex, epnested_mutex. Non-nested inserts skip this
+ * machinery entirely and take only ep->mtx.
+ *
+ *   epnested_mutex     Serializes the whole check; also protects every
+ *                      other variable in this block plus path_count[]
+ *                      (declared with the path-check code further
+ *                      down).
+ *   loop_check_gen     Monotonic stamp, bumped once at the start of a
+ *                      check and once at the end. ep->gen caches the
+ *                      value under which ep was last visited by
+ *                      ep_loop_check_proc() or
+ *                      ep_get_upwards_depth_proc(); the post-check
+ *                      bump ensures those cached stamps can no longer
+ *                      equal loop_check_gen, so the
+ *                      "ep->gen == loop_check_gen" trigger in
+ *                      do_epoll_ctl() only fires while another check
+ *                      is in flight.
+ *   inserting_into     Outer eventpoll pointer for the lifetime of one
+ *                      ep_loop_check(); ep_loop_check_proc() fails
+ *                      with -ELOOP if the downward walk reaches it.
+ *   tfile_check_list   Singly-linked list of epitems_head objects
+ *                      collected by ep_loop_check_proc() during the
+ *                      walk, consumed by reverse_path_check()
+ *                      afterwards. Sentinel EP_UNACTIVE_PTR means no
+ *                      check is in flight.
+ *
+ * Commits fdcfce93073d ("eventpoll: Fix integer overflow in
+ * ep_loop_check_proc()") and f2e467a48287 ("eventpoll: Fix
+ * semi-unbounded recursion") hardened the walk; any refactor must
+ * preserve both bail-outs.
+ */
 static DEFINE_MUTEX(epnested_mutex);
-
 static u64 loop_check_gen = 0;
-
-/* Used to check for epoll file descriptor inclusion loops */
 static struct eventpoll *inserting_into;
 
 /* Slab cache used to allocate "struct epitem" */
@@ -387,8 +429,10 @@ static struct kmem_cache *epi_cache __ro_after_init;
 static struct kmem_cache *pwq_cache __ro_after_init;
 
 /*
- * List of files with newly added links, where we may need to limit the number
- * of emanating paths. Protected by the epnested_mutex.
+ * Wrapper anchor for file->f_ep when the watched file is not itself an
+ * eventpoll; for the epoll-watches-epoll case, file->f_ep points at
+ * &watched_ep->refs directly. The ->next field threads
+ * tfile_check_list during one EPOLL_CTL_ADD path check.
  */
 struct epitems_head {
 	struct hlist_head epitems;

-- 
2.47.3

