Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A947887B
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529492; cv=none; b=dIepv0GIk7mgq/yuODNddIcHZ/q97QTH7dwEKNNOD+NVCUujGYKrSIzaWQvKI2s+kCrg5NFLZeO3p4ZcU+WoC3DGPKmW6C+h/djaCYSzi7BS+gIGkrbILeRZihBMEyzHpCd9uEqkZIlMv5wPNpd3wSpThNOtQ1RJUWenAwqs+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529492; c=relaxed/simple;
	bh=Sxy/gcZwE0shEfdof4tpVTMT+0mLMtUkiNwr1Sz+FnQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=feC70bzXC3wp3UcXNWiqL3JWKDRzeYM9VEUvMidjQ9x7iomHRLYlk4qPKAioMcObhg8kIyMlpUg8JguStcFoiJBTj78d9qOvY2PREn49V0PgDn8W2Iwoif7Z9yN4mhGwSiiE5imovcPvKRJVhPX07NZeXv1zlAHt7soZwx4t/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2AEW2yS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2AEW2yS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31C91F00A3A;
	Wed,  8 Jul 2026 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783529481;
	bh=wy0zRs0iHOEqGoZqY8flVlrypFtpLWv9a+F5MdRc8/U=;
	h=From:Subject:Date:To:Cc;
	b=G2AEW2ySEn90UzrvQCpkM6Q+j1L/83GPtqvTZsBNXrlV0bxDG/M/GjBWWf9qrZFrP
	 pMuMHBvTDnSqtgdwL+H2PtTVX/OWfBxMdQcbiqajGcxEGMDhw3xhzqIOYQKQsjcEJW
	 YLLhawnCF4LGVm6YtWOLaY7PZgndnGXLAA9KQNcmgRnF3CqdseOBh5HJvBY2s/LAFc
	 VUEFoqF+rGumBfxnFp9qtZS5RJD/K1sjpG6qf5vv/cKdsewC05af2uKaRxgn5YVwaK
	 fihX6XCVGmuLZX0saPX8V40UMDMYZjDgw0THH0k+Rb34lSI4a4j4bxeWQhT7gmHASx
	 ABM27GSdvrTgw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] binfmt_misc: use RCU for the handler lookup
Date: Wed, 08 Jul 2026 18:51:15 +0200
Message-Id: <20260708-work-binfmt_misc-locking-v1-0-a009dd5b56db@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAOATmoC/yWM2w6CMBAFf4X02SW0XiD+ijGmXRZYkdbsIpoQ/
 l3Qxzk5M7NREiY152w2QhMrp7iC3WUGOx9bAq5XNq5wp6IsKngn6SFwbIbxNrAiPBL2HFuwx/2
 hrBvrCCuz6k+hhj+/9OX6Z32FO+G49bZH8EoQxEfstmnwOpLkU5k7ELRmWb7dD75kngAAAA==
X-Change-ID: 20260708-work-binfmt_misc-locking-15347df12ec8
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3147; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Sxy/gcZwE0shEfdof4tpVTMT+0mLMtUkiNwr1Sz+FnQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5NbD3sEYcjZMWk3w6ryT6KNN+DUHzaQlRn1oCS61CN
 Vb4XHfoKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMiVFQz/4/8tn7pOxS0g7On0
 hoxnmgub+Hwy9vicjddwW/419PC+xQz/bI5MZ9tnyRenc/jM4fOp079PP/f0euDeM198ZvUrbjv
 3lxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Once binfmt_misc is loaded load_misc_binary() runs for every execve()
on the system since binfmt_misc registers at the head of the formats
list. Every exec therefore performs read_lock() and read_unlock() on
the entries_lock of the relevant binfmt_misc instance, i.e., two
atomic read-modify-writes on a shared cacheline, in the common case
just to conclude that the binary matches no handler. User namespaces
without their own binfmt_misc mount fall back to an ancestor's
instance so on container-heavy systems every exec on the machine
typically ends up hammering the cacheline of init_binfmt_misc. On
PREEMPT_RT the rwlock additionally turns the handler lookup into a
sleeping lock on the exec fast path.

The lock protects very little. Entries are immutable after publication
except for the Enabled bit which is already toggled locklessly via
set_bit()/clear_bit() and entry lifetime is already handled by the
users refcount. The read lock's only remaining job is to make "the
entry is still linked" and "take a reference" atomic with respect to
the unlink sites.

So make the lookup an RCU walk that acquires a reference via
refcount_inc_not_zero() and free entries via kfree_rcu(). The removal
paths need to detect whether an entry has already been unlinked and
rely on list_del_init() reinitialization for that today, but
reinitializing the forward pointer of a removed entry would make a
concurrent lockless walker standing on it loop indefinitely. hlists
support exactly this pattern: hlist_del_init_rcu() keeps the forward
pointer of a removed entry intact for concurrent walkers and only
zeroes ->pprev with hlist_unhashed() serving as the linked test. Hence
the first patch converts the entry list to an hlist so the RCU
conversion in the second is a pure locking change.

Writers remain serialized by the inode lock of the root dentry with
one exception: bm_evict_inode() unlinks entries during umount without
holding it. A spinlock stays around the unlink sites to make that
exclusion explicit instead of relying on superblock lifetime rules to
provide it implicitly.

Handler removal semantics are unchanged. An exec that acquired a
reference just before its handler was unregistered already completes
with the removed handler today. The read lock never protected against
that, it only made the window smaller.

With this an exec that matches no binfmt_misc entry no longer writes
to any shared cacheline at all. The last patch annotates the
long-standing lockless ->enabled accesses for KCSAN while at it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (3):
      binfmt_misc: convert entry list to an hlist
      binfmt_misc: use RCU for the handler lookup
      binfmt_misc: annotate racy accesses to ->enabled

 fs/binfmt_misc.c        | 86 ++++++++++++++++++++++++++++---------------------
 include/linux/binfmts.h |  4 +--
 kernel/user.c           |  4 +--
 3 files changed, 53 insertions(+), 41 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260708-work-binfmt_misc-locking-15347df12ec8

