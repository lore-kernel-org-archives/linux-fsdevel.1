Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF129B8D0;
	Fri, 12 Jun 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277316; cv=none; b=PrKeLAsIuTgCkUezlvNLeOZPpBWDOJ5kQmZC1sTQu+XJrIl+BR7Cs5c6R8RvPtAVfo0olzfeoFtXYJMo4IWArlNrLqG1AuWSA7I8oNy9vxMULdZMXeUop6IBXSX0fEio/De+DrxL0Ahx9hNphpI9EdIQmJs/u8aYBLoWGkzwtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277316; c=relaxed/simple;
	bh=S/PDVhjm0Y1G0ygaHVqwvYFj0MDLnUMZeI3PvqDp+iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO3AK3de804HaDz4Hmq3IPfRIdmwvyhz7RITal8zfYczDS/J4CgFFuicU1zX4MD9dK6CQXcYxjQ4dtkVgisCYxqPuZw3tJe373JJIvbtnrNnna4WGVaPSccFwfyPyQsQ3xEKlVhN4hOE2Wo3nM/chZN0caHNMszgUR3X+7sFyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmhboyrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmhboyrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A721F000E9;
	Fri, 12 Jun 2026 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277315;
	bh=U4WivknHZjr2FaVBkqbqC2a3zJmdUvHAS3GKkWWby24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jmhboyrBQ7MMc7pYiNtG9RRVIgNHIjXME/0dAgOeQu8v6gHErTZptpXVNw6FFLdDD
	 fMOioJ2zfgdtidAC42kpNP56iib8Jyst4I1hgOHgoMYK84DvUr29Ax4MbmYO056DSm
	 TVQvCHuAjc3iPYOodKt19icKrWbsekTg8S4ggNM1BSWTHmr7qJjmXl9u6eJct0WAX3
	 hm/cg6unxOkT/5MWwT00D8hfzjCRK+X+wVcd9qMusrtlGtj5s1L9+N3jpzQWlVrfMk
	 g+drggpAFO5JWdn0v4lHpdKHt5CiLLlGO8l5+5XKh0TFLxt9z0BlrbmjUDCrifdtUL
	 yIca/ANGZ7eYQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 12/16 for v7.2] vfs eventpoll
Date: Fri, 12 Jun 2026 17:15:09 +0200
Message-ID: <20260612-vfs-eventpoll-v72-07f66407ee78@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6910; i=brauner@kernel.org; h=from:subject:message-id; bh=S/PDVhjm0Y1G0ygaHVqwvYFj0MDLnUMZeI3PvqDp+iI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKNW1x78/oa8qX3395Id9JTUZsSubWqS7kpesZFJ8W sTI1/K7o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKaFxgZllb/c0hadUVZ/PeC eC4PpbLDrF7mpSp3BZbbZDDlrK98wchw+8K9wrlt1YrcOz9deJG5rqxqly1fTlmScvyVo3LX7Vf yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the eventpoll changes for this cycle:

* eventpoll clarity refactor

  The recent eventpoll UAF fixes (a6dc643c6931 and follow-ups) rode on
  invariants in fs/eventpoll.c that were nowhere documented and had to
  be reverse-engineered from the code: the lifetime relationships
  between struct eventpoll, struct epitem, and struct file, the three
  removal paths coordinating via epi_fget() pins and ep->mtx, the
  ovflist sentinel-encoded scan state machine, the POLLFREE
  release/acquire handshake, and the loop / path check globals
  serialized by epnested_mutex. The fixes were correct but the next
  person to touch this code would hit the same learning curve.

  This series codifies those invariants in source and tightens the
  surrounding structure. No functional changes intended:

  - Documentation: a top-of-file overview with field-protection
    tables for struct eventpoll and struct epitem, a section
    gathering the loop-check / path-check globals next to their
    declarations, labelled comments on the two sides of the POLLFREE
    handshake, refreshed comments on epi_fget() and ep_remove_file(),
    and a docblock on ep_clear_and_put() that names its two-pass
    structure as load-bearing.

  - Mechanical renames: ep_refcount_dec_and_test() -> ep_put() to
    pair with ep_get(), attach_epitem() -> ep_attach_file() for
    ep_remove_file() symmetry, the unused depth argument dropped from
    epoll_mutex_lock(), and the CONFIG_KCMP block relocated next to
    CONFIG_COMPAT so the hot-path code is contiguous.

  - Helper extraction: ep_insert() splits into ep_alloc_epitem() and
    ep_register_epitem(), ep_clear_and_put()'s two passes become
    ep_drain_pollwaits() and ep_drain_tree() so the ordering
    invariant is enforced by the call sequence rather than
    convention, the per-event delivery loop body becomes
    ep_deliver_event(), and the ep->mtx + epnested_mutex acquisition
    dance lifts out of do_epoll_ctl() into ep_ctl_lock() /
    ep_ctl_unlock().

  - Sentinel and predicate cleanup: the EP_UNACTIVE_PTR overload is
    hidden behind named helpers (ep_is_scanning, epi_on_ovflist,
    ...), epi->next is renamed to epi->ovflist_next, and the boolean
    predicates return bool.

  - The per-CTL_ADD scratch state (tfile_check_list, path_count[],
    inserting_into) moves from file-scope globals into a
    stack-allocated struct ep_ctl_ctx plumbed through the loop / path
    check chain.

  Two follow-up fixes are included: missing kernel-doc for the new
  @ctx parameters, and restoring the EP_UNACTIVE_PTR sentinel for
  ctx->tfile_check_list - replacing it with NULL termination broke
  ep_remove_file()'s "never listed" check for the list tail, causing
  a syzbot-reported use-after-free.

* io_uring related epoll cleanups

  One of the nastier things about epoll is how it allows nesting
  contexts inside each other, leading to the necessity of loop
  detection and the issues that have come with that. There is no
  reason to support nesting on the io_uring side, so contain the
  damage and disallow nested contexts from there: eventpoll gains a
  file based control interface and struct epoll_filefd is renamed to
  epoll_key. The io_uring side proper goes on top of this through the
  block tree.

* Fix epoll_wait() reporting false negatives

  ep_events_available() checks ep->rdllist and ep_is_scanning()
  without a lock and can race with a concurrent scan such that
  neither check sees the events, causing epoll_wait() with a zero
  timeout to wrongly report no events even though events are
  available. A sequence lock closes the race and a reproducer is
  added to the eventpoll selftests.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.eventpoll

for you to fetch changes up to a1e9718b406bc4e6d0c63c7b999d06febbdc4091:

  eventpoll: restore EP_UNACTIVE_PTR sentinel for ctx->tfile_check_list (2026-06-04 13:53:50 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.eventpoll

Please consider pulling these changes from the signed vfs-7.2-rc1.eventpoll tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (20):
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
      Merge patch series "eventpoll: clarity refactor"
      Merge patch series "io_uring related epoll cleanups"
      Merge patch series "eventpoll: Fix epoll_wait() report false negative"

Jens Axboe (4):
      eventpoll: pass struct epoll_filefd through ep_find() and ep_insert()
      eventpoll: export is_file_epoll()
      eventpoll: add file based control interface
      eventpoll: rename struct epoll_filefd to epoll_key

Nam Cao (2):
      selftests/eventpoll: Add test for multiple waiters
      eventpoll: Fix epoll_wait() report false negative

Randy Dunlap (1):
      eventpoll: add missing kernel-doc for @ctx function parameters

Zhan Wei (1):
      eventpoll: restore EP_UNACTIVE_PTR sentinel for ctx->tfile_check_list

 fs/eventpoll.c                                     | 1275 +++++++++++++-------
 include/linux/eventpoll.h                          |    8 +
 .../filesystems/epoll/epoll_wakeup_test.c          |   45 +
 3 files changed, 886 insertions(+), 442 deletions(-)
