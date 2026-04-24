Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB003537DF
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038410; cv=none; b=F1AQPTfehNjRrr40oebEbwCb33XDZ52xVx1kkv+JoO+xJ9Y0W8WfsCou0mLcOXP2k7pQWugDKjiTO3kPEntcUUaVwrEfh67paStu1P9tQF5zRnsmRQfB7snPX0ZP5VbU17sIrhErZs2ti6WrXln8kCrBHqA8sFSLQxitBa2VK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038410; c=relaxed/simple;
	bh=hhhCJYSaJZTYNIZ6ttfeVVH02/GFHo91RRBI/hPKlvM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W1uQaoJzfJ1yQybLp2d5GLGc+OBLoC1fRh6RbTcHFsvZpMEqxzxnvqnyBluG5Q73ZZfYxOvvwkoJO0eEo6HU3fNqOs8lME3R65FzKHCS1kngpr+T/A8CVqEShS0ZeSEb9thmIYx/c5tvN9bwJWkxjBg+kEIyls0LuyFM9dqAIAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZ6Y4bDk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZ6Y4bDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31499C19425;
	Fri, 24 Apr 2026 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038409;
	bh=hhhCJYSaJZTYNIZ6ttfeVVH02/GFHo91RRBI/hPKlvM=;
	h=From:Subject:Date:To:Cc:From;
	b=tZ6Y4bDk0ku0ONYaBcSK9wPHPDmyYfTMaU8IPaZoxah/fgMesUVtpk8WvCMQwCPkt
	 4bpIeofYgBAsbAby8HSlAs9LIjV1DlAFsRCxV4iySX6cjygXJLcDTHlZ+uTIWBZAcJ
	 xzch7qL3hJCVgkyZ4sP8jxh2LhVT7s3P/PMSN+0lKi88VS7kwmX8Ba0Q+feV650qbq
	 ljjbB9yZMmA3J5anFlhd2uEHcZWTn+fjKq0/OyKCJglN+YyG0DE2D73+D12E0ifw86
	 bNvTIlUyYknd5IyMm2gzcUQmuKV7C5qJLKSi3hD9el4NQvgnkPFRi9Vrpx6G+0tlFy
	 qLICnpnuI6Q2Q==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/17] eventpoll: clarity refactor
Date: Fri, 24 Apr 2026 15:46:31 +0200
Message-Id: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADd062kC/yXM2w6CMBAE0F8h+2xNaReK/orxoZetVBHIFi8J4
 d8FfDyTmZkhEyfKcC5mYHqnnIZ+RXkowLe2v5FIYTUoqWqJCsVn4Iegceg6wbTDSqW1NFgGhbD
 uRqaYvvvn5fp3frk7+Wk72hrOZhKObe/bLXraPBEfQ6g96sZrqtFWMUpXBUOmiSaeHFVoGqkpl
 g6W5QflCn10twAAAA==
X-Change-ID: 20260424-work-epoll-rework-a02330741d24
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5138; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hhhCJYSaJZTYNIZ6ttfeVVH02/GFHo91RRBI/hPKlvM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnH7tf1I4Kf9Uae3xq9NY1oUtthMVP+ljKaf4T2Do
 t1P0hbHdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkwFKG/+FbuTluZSRzpigz
 rw9aEyv37SJbvhT3jxjuYy8lfz/y+M3IsH2+ipXuHFXN6Zd2NZ9bFtHAJWrTLblq+/+5P2TS3v7
 9xwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The recent UAF series (a6dc643c6931 and follow-ups) rode on
invariants in fs/eventpoll.c that were nowhere documented and had
to be reverse-engineered from the code: the lifetime relationships
between struct eventpoll, struct epitem, and struct file, the three
removal paths coordinating via epi_fget() pins and ep->mtx, the
ovflist sentinel-encoded scan state machine, the POLLFREE
release/acquire handshake, and the loop / path check globals
serialized by epnested_mutex. The fix was correct but the next
person to touch this code will hit the same learning curve.

This adds a bunch of documentation (a bunch of swearwords were removed
by having an llm go over it) and refactors. The end goal is hopefully a
bit more pallatable than what this is right now. No functional changes
intended yet.

This series codifies those invariants in source and tightens the
surrounding structure.

First there are a couple of pure documentation changes. A top-of-file
overview with field-protection tables for struct eventpoll and struct
epitem, a section gathering the loop-check / path-check globals next to
their declarations, labelled comments on the two sides of the POLLFREE
handshake, refreshed comments on epi_fget() and ep_remove_file() (whose
contract the UAF fix re-shaped), and a docblock on
ep_clear_and_put() that names its two-pass structure as load-bearing.

Next are a couple of mechanical naming cleanups.
ep_refcount_dec_and_test() -> ep_put() to pair with ep_get(); the unused
depth argument dropped from epoll_mutex_lock() (all three callers passed
zero); attach_epitem() -> ep_attach_file() for ep_remove_file()
symmetry; and the CONFIG_KCMP block relocated next to CONFIG_COMPAT so
the hot-path code is contiguous.

Next are a couple of changes that extract long bodies into named
helpers. ep_insert() splits into ep_alloc_epitem() and
ep_register_epitem(); ep_clear_and_put()'s two passes become
ep_drain_pollwaits() and ep_drain_tree() so the ordering invariant is
enforced by the call sequence rather than convention; the per-event
delivery loop body extracts from ep_send_events() as ep_deliver_event();
and the ep->mtx + epnested_mutex acquisition dance lifts out of
do_epoll_ctl() into ep_ctl_lock() / ep_ctl_unlock(), with a return value
that doubles as the @full_check argument to ep_insert().

Next are a couple of changes that address sentinel and predicate sprawl.
The EP_UNACTIVE_PTR overload (meaning "no scan in progress" on
ep->ovflist and "epi not on ovflist" on epi->next) is hidden behind
named helpers (ep_is_scanning, epi_on_ovflist, ...); epi->next is
renamed to epi->ovflist_next and the local txlist to scan_batch; and
is_file_epoll(), ep_is_linked(), ep_events_available() are converted to
return bool to match their already-boolean bodies.

And last we move the per-CTL_ADD scratch state (tfile_check_list,
path_count[], inserting_into) from file-scope globals into a
stack-allocated struct ep_ctl_ctx plumbed through the loop / path check
chain. loop_check_gen stays at file scope because the stamp it leaves on
ep->gen across calls must not collide with a future walk.

The load-bearing invariants the UAF series closed are preserved
verbatim: the epi_fget() pin in ep_remove(), the ordering of
ep_unregister_pollwait() before ep_remove_file() / ep_remove_epi()
in all three removal paths, kfree_rcu(epi) and kfree_rcu(ep), the
POLLFREE smp_store_release / smp_load_acquire pair on pwq->whead,
ep->lock IRQ-safety, the mutex_lock_nested() subclass arithmetic
in ep_insert (subclass 0 outer, 1 for tep) and __ep_eventpoll_poll
/ ep_loop_check_proc (depth-based), and the WARN_ON_ONCE contract
on ep_put() in ep_remove().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (17):
      eventpoll: expand top-of-file overview / locking doc
      eventpoll: document loop-check / path-check globals
      eventpoll: clarify POLLFREE handshake comments
      eventpoll: refresh epi_fget() / ep_remove_file() comments
      eventpoll: document ep_clear_and_put() two-pass pattern
      eventpoll: rename ep_refcount_dec_and_test() to ep_put()
      eventpoll: drop unused depth argument from epoll_mutex_lock()
      eventpoll: rename attach_epitem() to ep_attach_file()
      eventpoll: relocate KCMP helpers near compat syscalls
      eventpoll: split ep_insert() into alloc + register stages
      eventpoll: split ep_clear_and_put() into drain helpers
      eventpoll: extract ep_deliver_event() from ep_send_events()
      eventpoll: extract lock dance from do_epoll_ctl() into ep_ctl_lock()
      eventpoll: wrap EP_UNACTIVE_PTR in typed sentinel helpers
      eventpoll: rename epi->next and txlist for clarity
      eventpoll: use bool for predicate helpers
      eventpoll: hoist CTL_ADD scratch state into struct ep_ctl_ctx

 fs/eventpoll.c | 1183 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 778 insertions(+), 405 deletions(-)
---
base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
change-id: 20260424-work-epoll-rework-a02330741d24

