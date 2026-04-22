Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0943D171E
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862338; cv=none; b=hWgY4lBYQ28p4bUQz/ZGidGqa0xpv+jPREBjNOufW5ZXWQ14lSoP78uDFeugZB3KX1+6JI1RR+X+WQRUwAQVzgqRlPymBmuC06kQQdWQYtd/XbChIQoNN66IJhLEm/yfLC7MAUCBJZpLEXr5+ZOdkmczrJmtyV0MBG+HqA4DMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862338; c=relaxed/simple;
	bh=MmNGmkzrujdKlAtu9wBjOQ7e13kpiuNzTUVwF6huc20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMSyTHzYi1P8R2GwubfRIUK/h55TA4EVMB7KQBESqGUgjyi590EXoujorT6QynmBKDhyOpqEYRWTgiN7t69mcq/XTecgWjNhQtEbruf+9sCHbRhgJTkde2+lCkvLPpSLuwq0ITVcsLd1IGAVge+kg715GgaVsy5wdi2p87ZkqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJSJKAeo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJSJKAeo"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso4812843a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776862335; x=1777467135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGEuglpx7Y5DLz6r1LhDNoaDFhM/FZuoOo/K/qS3t/w=;
        b=tJSJKAeoFbHd/VFlw1czoVWgf8V2YQu8Gre9Cro4nreIiYG1X6l+/IuxOSHra9wDeS
         h1p7+d6m6Q0tK+ycK/5hhgXy64ljcBq8CkFH87sB68QDr6mTx+NhRfIIn0XtrlsWvr9x
         UWms4jFAYpqFgcvU2UOjKWM/3jdF7Yn1ybM036cQob2KmxDlXumFeEXF849MfpcvhGDt
         2GHjvZEhLk/rXX+mlHJ88ItJwNibNdCZsjVzKdrpBlV+eBuSugiwRY0rMeSQhHPAMtym
         BOJBelCM71x0DLkR+tE0uvzCoFc/hHzVsEL8OdAhw0HKaVFo64hu9b2J2g/00F3l0h4r
         WtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862335; x=1777467135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGEuglpx7Y5DLz6r1LhDNoaDFhM/FZuoOo/K/qS3t/w=;
        b=si9CNWOaKM3cZUEE/OuiZdj0XWHv5Nt66XiL9UE4FS9go0pDiynYxH5AlNXRxtcG+9
         uURZRG3yCtcV3J+5+cFUjR4VE7CylLZn179z9pcjh1kAuSxdnEd7iNjlJqx8wqmpFc0R
         5j0yEu0r93sf5M7agwf27bA+vBEwMCas+ffVsYw/3qmpVC1hDROi/OYahfMzCkTvmieL
         CYlu4cb+VPINm5WsUIeCF2BIRtehhsa54lkGoIAjTQAZ6hXWLnwkYxyfaEowIv0TiQnF
         GGrxwW0v1Khepk45TlvJPxOrMnai4yxTwcMdc3u8StN7q2/GA9D2GhLewlHAHy16TTyc
         SHkg==
X-Forwarded-Encrypted: i=1; AFNElJ8yEeKaJik9cJTJkzoqR3MqNoKstJgCoqOwOi9PkiEAhlFzjI4kJgkCZ3ElCQv+t5ZAKOal7ALnyzFXf6I9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw7WT0kpQ5L9DruqIu0FsuS0H66LrUoz8QRfW2VQpKsXfPoHOA
	6g3WmFnt9OxMmrsWSPmNcgGAVeEHN2UmOwlCkcSFKShJWQm+XrfruojR
X-Gm-Gg: AeBDievKiKdQPlYJH4aoK/dTL+KjOp8Me9G56Yrb774DgBBbL9Dtgv8HoYgWPV+6KpT
	mPRm7KegqaMtruDpmNruUCQKWoHMwLpaKxEgoPrSxjaZYii+shBEFu63eKvjnuq8Oglw/SkEI0O
	EpjWCMaN+x4gKT223mCd+TSKBImpJeVSxAjuw94PMFUZPrH8ijSbb9jTXfgB6UvDGTpTQf27KHS
	BJ8zOuxzrLuwaVLhIEPzbs8xlhmFupd0Y/7snbtzYpY3Ww9q7rdHEaA8XbjKMap4HWItpOF14p7
	ZfqB+W86v/0IIP1MpOdLfpthz0y85fYwlhqYdMzQfqLRfH8M0IVcp+fiDIGgymDsZdCWTGHTjqN
	9ndjjqGrQMQ0DBDVKU4GaBFQs58C92uWDzaoKxNJU9GFbfGyfzTZL647+QFpOFwBEjpNw9mSD7V
	TRrAPWuRVYEqp7z7yvlZLG0yrK1f+R3Ec6m+ycaEZUjmwRLzQzXo76jK23RLlghTJdhckbOYPSK
	DTmDg0tbb2+fA5yOyxnFu2I4SQqD9tHD/perZI=
X-Received: by 2002:a17:907:80c:b0:bab:81e9:d3f5 with SMTP id a640c23a62f3a-bab81e9d570mr74027366b.16.1776862334018;
        Wed, 22 Apr 2026 05:52:14 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-5c94-170a-2d80-867a.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:5c94:170a:2d80:867a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4519ee4adsm548998366b.19.2026.04.22.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:13 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3] docs: add guidelines for submitting new filesystems
Date: Wed, 22 Apr 2026 14:52:12 +0200
Message-ID: <20260422125212.1743006-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This document is motivated by the ongoing maintenance burden that
abandoned and untestable filesystems impose on VFS developers, blocking
infrastructure changes such as folio conversions and iomap migration.

This week alone, two new filesystems were proposed on linux-fsdevel
(VMUFAT and FTRFS), highlighting the need for documented guidelines
that new filesystem authors can refer to before submission.

Multiple recent discussions on linux-fsdevel have touched on the
criteria for merging new filesystems and for deprecating old ones,
covering topics such as modern VFS interface adoption, testability,
userspace utilities, maintainer commitment, and user base viability.

Add Documentation/filesystems/adding-new-filesystems.rst describing
the technical requirements and community expectations for merging a
new filesystem into the kernel.  The guidelines cover:
- Alternatives to consider before proposing a new in-kernel filesystem
- Technical requirements: modern VFS interfaces (iomap, folios,
  fs_context mount API), testability, and userspace utilities
- Community expectations: identified maintainers, demonstrated
  commitment, sustained backing, and a clear user base
- Ongoing obligations after merging, including the risk of deprecation
  for unmaintained filesystems

Link: https://lore.kernel.org/linux-fsdevel/20260411151155.321214-1-adrianmcmenamin@gmail.com/
Link: https://lore.kernel.org/linux-fsdevel/20260413142357.515792-1-aurelien@hackers.camp/
Link: https://lore.kernel.org/linux-fsdevel/yndtg2jbj55fzd2kkhsmel4pp5ll5xfvfiaqh24tdct3jiqosd@jzbfzf3rrxrd/
Link: https://lore.kernel.org/linux-fsdevel/20260124091742.GA43313@macsyma.local/
Link: https://lore.kernel.org/lkml/20260111140345.3866-1-linkinjeon@kernel.org/
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: Theodore Tso <tytso@mit.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Assisted-by: Cursor:claude-4-opus
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

I think that the trickle of comments has slowed down to a halt
and this version should be good to go.

Thanks,
Amir.

Changes since v2:
- Refine fuzzing clause (jack,djwong)
- Refine ioctls clause (jaegeuk)
- Remove new mount API (safinaskar)
- Use stronger MUST language for technical requirements (brauner)

Changes since v1: (willy)
- Prefer plural maintainers
- Structure of patch series
- Community engagement
- Mention ioctls
- Mention fuzzing
- Mention netfs

 .../filesystems/adding-new-filesystems.rst    | 195 ++++++++++++++++++
 Documentation/filesystems/index.rst           |   1 +
 2 files changed, 196 insertions(+)
 create mode 100644 Documentation/filesystems/adding-new-filesystems.rst

diff --git a/Documentation/filesystems/adding-new-filesystems.rst b/Documentation/filesystems/adding-new-filesystems.rst
new file mode 100644
index 0000000000000..a3d0bf16f73a0
--- /dev/null
+++ b/Documentation/filesystems/adding-new-filesystems.rst
@@ -0,0 +1,195 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _adding_new_filesystems:
+
+Adding New Filesystems
+======================
+
+This document describes what is involved in adding a new filesystem to the
+Linux kernel.
+
+Every filesystem merged into the kernel becomes the collective responsibility
+of the VFS maintainers and the wider filesystem development community.
+Experience has shown that filesystems which become unmaintained impose a
+significant and ongoing burden: they are hard or impossible to test, they
+block infrastructure changes because someone must update or preserve old APIs
+for code that nobody is actively looking after, and they accumulate unfixed
+bugs.  The requirements and expectations described here are informed by this
+experience and are intended to ensure that new filesystems enter the kernel
+on a sustainable footing.
+
+
+Do You Need a New In-Kernel Filesystem?
+---------------------------------------
+
+Before proposing a new in-kernel filesystem, consider whether one of the
+alternatives might be more appropriate.
+
+ - If an existing in-kernel filesystem covers the same use case, improving it
+   is generally preferred over adding a new implementation.  The kernel
+   community favors incremental improvement over parallel implementations.
+
+ - If the filesystem serves a niche audience or has a small user base, a FUSE
+   (Filesystem in Userspace) implementation may be a better fit.  FUSE
+   filesystems avoid the long-term kernel maintenance commitment and can be
+   developed and released on their own schedule.
+
+ - If kernel-level performance, reliability, or integration is genuinely
+   required, make the case explicitly.  Explain who the users are, what the
+   use case is, and why a FUSE implementation would not be sufficient.
+
+
+Technical Requirements
+----------------------
+
+New filesystems must use current kernel interfaces and practices.
+Submitting a filesystem built on outdated APIs creates an unacceptable
+maintenance debt and is likely to face pushback during review.
+
+Use modern VFS interfaces
+  Do not use interfaces listed in
+  :ref:`Documentation/process/deprecated.rst <deprecated>`.
+
+  Use folios rather than raw page operations for page cache management and
+  iomap rather than buffer heads for block mapping and I/O.  See
+  ``Documentation/filesystems/iomap/index.rst`` for iomap documentation.
+
+  Block-based filesystems that need functionality not currently provided by
+  iomap should be prepared to explain why adding that functionality to iomap
+  is infeasible, rather than reimplementing their own block mapping layer.
+
+  Network filesystems should consider using the netfs library
+  (``Documentation/filesystems/netfs_library.rst``), or be prepared to explain
+  why it is not a good fit.
+
+Provide userspace utilities
+  A ``mkfs`` tool is expected so that the filesystem can be created and used
+  by testers and users.  A ``fsck`` tool is strongly recommended; while not
+  strictly required for every filesystem type, the ability to verify
+  consistency and repair corruption is an important part of a mature
+  filesystem.
+
+Be testable
+  The filesystem must be testable in a meaningful way.  The
+  `fstests <https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git>`_
+  framework (also known as xfstests) is the standard testing infrastructure
+  for Linux filesystems and its use is highly recommended.  At a minimum,
+  there must be a credible and documented way to test the filesystem and
+  detect regressions.  When submitting, include a summary of test results
+  indicating which tests pass, fail, or are not applicable.
+
+Provide documentation
+  A documentation file under ``Documentation/filesystems/`` describing the
+  filesystem, its on-disk format, mount options, and any notable design
+  decisions is recommended.
+
+
+Community and Maintainership Expectations
+-----------------------------------------
+
+Merging a filesystem is a long-term commitment.  The kernel community
+needs confidence that the filesystem will be actively maintained after it
+is merged.
+
+Identified maintainers
+  The submission must include a ``MAINTAINERS`` entry with at least one
+  maintainer (``M:``), a mailing list (``L:``), and a git tree (``T:``).
+  Having two or more maintainers is strongly preferred so that coverage
+  does not depend on a single person.  The maintainers are expected to be
+  the primary points of contact for the filesystem going forward.
+
+Demonstrated commitment
+  A track record of maintaining kernel code -- for example, in other
+  subsystems -- significantly strengthens the case for a new filesystem.
+  Maintainers who are already known and trusted within the community face
+  less friction during review.
+
+Sustained backing
+  Major filesystems in Linux have organizational or corporate support behind
+  their development.  Filesystems that depend entirely on volunteer effort
+  face higher scrutiny about their long-term viability.
+
+Responsiveness
+  The maintainer is expected to respond to bug reports, address review
+  feedback, and adapt the filesystem to VFS infrastructure changes such as
+  folio conversions, iomap migration, and mount API updates.  Unresponsive
+  maintainership is one of the primary reasons filesystems end up on the
+  path to deprecation.
+
+User base
+  Clearly describe who the users of this filesystem are and the scale of the
+  user base.  Filesystems with a very small or unclear user base face a
+  harder path to acceptance and a higher risk of future deprecation.
+
+Building your track record
+  A practical way to demonstrate many of the qualities above is to maintain
+  the filesystem out-of-tree for a period before requesting a merge.  This
+  shows sustained commitment, builds a visible user base, and gives reviewers
+  confidence that the code and its maintainer will persist after merging.
+  That said, it is recognized that for some filesystems the user base grows
+  significantly only after upstreaming, so a compelling case for expected
+  adoption can substitute for a large existing user base.
+
+
+Submission Process
+------------------
+
+This section covers what is specific to filesystem submissions, over and
+above the normal submission advice in
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>` and
+:ref:`Documentation/process/submit-checklist.rst <submitchecklist>`.
+
+ - Send patches to the linux-fsdevel mailing list
+   (``linux-fsdevel@vger.kernel.org``).  CC the relevant VFS maintainers as
+   listed in the ``MAINTAINERS`` file under
+   ``FILESYSTEMS (VFS and infrastructure)``.
+
+ - Structure the submission logically.  It is neither acceptable to send one
+   large patch containing the entire filesystem, nor is a replay of the full
+   development history helpful to reviewers.  Instead, split the series by
+   topic -- for example: superblock and mount handling, inode operations,
+   directory operations, address space operations, and so on -- so that each
+   patch is reviewable in isolation.
+
+ - Separate any filesystem-specific ioctls into their own patches with
+   dedicated justification.  Interfaces beyond those already common across
+   other filesystems will receive additional scrutiny because they are hard
+   to maintain and may conflict with future generic interfaces.
+
+ - Expect thorough review.  Filesystem code interacts deeply with the VFS,
+   memory management, and block layers, so reviewers will examine the code
+   carefully.  Address all review feedback and be prepared for multiple
+   revision cycles.
+
+ - It may be appropriate to mark the filesystem as experimental in its Kconfig
+   help text for the first few releases to set expectations while the code
+   stabilizes in-tree.
+
+
+Ongoing Obligations
+-------------------
+
+Merging is not the finish line.  Maintaining a filesystem in the kernel is an
+ongoing commitment.
+
+ - Adapt to VFS infrastructure changes.  The VFS layer evolves continuously;
+   maintainers are expected to keep up with conversions such as folio
+   migration, iomap adoption, and mount API updates.
+
+ - Maintain test coverage.  As test suites evolve, the filesystem's test
+   results should be kept current.
+
+ - Handle security issues and regression promptly.  Both those reported
+   by ordinary users and those reported by test bots and fuzzing tools.
+   The filesystem must handle corrupted input gracefully without corrupting
+   memory, hanging, or crashing the kernel.
+
+ - Engage with the wider filesystem community.  Participate on linux-fsdevel,
+   share approaches to common problems, and look for opportunities to reuse
+   shared infrastructure.  It is inappropriate to develop in isolation on a
+   private list and surface patches only at merge time.
+
+ - Filesystems that become unmaintained -- where the maintainer stops
+   responding, infrastructure changes go unadapted, and testing becomes
+   impossible -- are candidates for deprecation and eventual removal from
+   the kernel.
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f4873197587df..10e40cc9cbc9d 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -42,6 +42,7 @@ algorithms work.
    caching/index
 
    porting
+   adding-new-filesystems
 
 Filesystem support layers
 =========================
-- 
2.53.0

