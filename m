Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715643B8950;
	Mon, 21 Sep 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988142; cv=none; b=gNmuxRAjC+O39wAqBM+Y58I/Vpea4hnriF8wp44VYE0tQ4fTsZtwa3Rry4x2o7QIglwIGxJ4E8bWEgrl+EwlTTxfsFcU8McPbqqjF9GMP0Q0srXR5kQw5wBmixPy9DhCHU3HblYEJzjgDXW+b39RuHDWQcCE32vH/kTvUBXp53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988142; c=relaxed/simple;
	bh=0lV9mzOvMXOJsCm50AL0k4mE1WiMkBEe5vE/lWq7H1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLJCASvktMT5FuJcBITLOLC1KuNn57X4gOYfwr/DYT/To9uFIm5LT9jkiopDSm3ACNX+rHEMCW+lvR0KI5opTDTXNuwLlbPInFpxRx+C0/jh987RRMslDcNKnej5EJ8a9O52hZWOrepnzkCQNzuZaKAVHMMAh94HejCrUHmF26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSSOTLFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSSOTLFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155F41F000FF;
	Mon, 21 Sep 2026 10:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789988141;
	bh=XrZuJjYH4FBtiknCE3rWWFSJ54YNsVCSIBI9DrJnVGQ=;
	h=From:To:Cc:Subject:Date;
	b=PSSOTLFof3UyB0LHBgWJnnFTbJef1b5Bqa4d9p2gHSb/ePoDzypv3b0qzJwl9CQd4
	 2BirKxJ7iZZxcQMFZgfsNVN07BG7fbmAfBxC+rdRcPeb+pXjG5jyIGbUrQ8wVvLXBa
	 RdrpMxhWg2M0oTLQFX1Il99gBYrD+MwMoRYtf9MEdE1TdJSxf5fd/LXFKvV/+2H3SH
	 Ol5xcvea7gIxFO3tFJNquH4GVzHEaap2VaaQ7+Mh4+xRevU2QcrJkZKRnX+Oj28xf4
	 fbuKIF7L1EJep+MtW91+gZDN6402QbenEUU7IkbSxFgX3T8c7m2dHyaCeloPlyzGWi
	 UBPckg5RBdRFg==
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Serge Hallyn <serge@hallyn.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/6] sysctl: add typed field descriptors
Date: Mon, 21 Sep 2026 12:54:47 +0200
Message-ID: <cover.1789987960.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Some sysctl users allocate a private copy of an otherwise static ctl_table
for every namespace or device, then rewrite data and limit pointers before
registration.  Besides the per-instance allocation, these fixups are often
addressed by table index, so changing the table can silently associate an
entry with the wrong data or limits.

This series adds struct sysctl_field as an alternative descriptor for such
tables.  A field records the value type and an offset into an object
selected at registration time.  The type-specific offset helpers are small
wrappers around offsetof() and only add a compile-time check of the
referenced member type.  The sysctl core derives the handler, size, data
and limits, and builds a temporary ctl_table when invoking existing
handler, permission and BPF interfaces.

A struct sysctl_context identifies the object shared by the whole
registration and is copied into the table header.  Subsystems which need
more than a namespace can embed it as the first member of a larger context
and select the object to which field offsets apply.

Existing ctl_table users are unchanged, and subsystems can migrate one
table at a time.  Converted tables remain static and read-only instead of
being copied and patched for every instance.

Compared with the previous RFC [1], this drops the per-field accessor
functions and the macros which generated them.  The first two patches
prepare the sysctl core without changing its external behaviour.  The third
patch adds the new descriptor, followed by conversions of the IPC, mqueue
and ucount tables as small users of the interface.

This is only the first part of the conversion.  Network sysctls and the
other subsystem-specific users will be submitted as separate follow-up
series so they can be reviewed by their respective maintainers without
making this initial series excessively large.

[1] https://lore.kernel.org/all/cover.1787770053.git.legion@kernel.org/

Alexey Gladkov (6):
  proc: sysctl: address table entries by index
  sysctl: add unsigned int limit constants
  sysctl: add typed field descriptors
  sysctl: ipc: use typed fields for IPC namespace sysctls
  sysctl: mq: use typed fields for IPC namespace sysctls
  sysctl: use typed fields for ucount limits

 fs/proc/inode.c        |   2 +-
 fs/proc/internal.h     |   2 +-
 fs/proc/proc_sysctl.c  | 601 ++++++++++++++++++++++++++++++-----------
 include/linux/sysctl.h | 150 +++++++++-
 ipc/ipc_sysctl.c       | 188 ++++++-------
 ipc/mq_sysctl.c        | 104 +++----
 kernel/sysctl.c        |   3 +
 kernel/ucount.c        |  64 ++---
 8 files changed, 750 insertions(+), 364 deletions(-)


base-commit: 587858367581b9c55c3690f4e63382ad622719d4
-- 
2.55.0

