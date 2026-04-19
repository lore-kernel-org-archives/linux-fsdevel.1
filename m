Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3064C3B1BD
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776597519; cv=none; b=H9byMfVqt1l/IC7ssEab0VNGJYtevuAUki4A6aM8FfnHZE/62pNtkZgQaHa8XRicpE2WCWKHELnsIAe2duniXf6wLBzUfGUxEIOTndO19uE+LzR/DAWL5yunwyZ5I99zU5Lc1LOD/lWzFfK2Zah+2qm1e+BFsD44mPo4p566WfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776597519; c=relaxed/simple;
	bh=h26zSae46UiQWX79yaq5gAUVpJ9MvJq9YRPu4mCjYmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFsnI+QQch7xugio+2tLZqPu7IisIzaZBxoez2k65jmy72Eow2TMJnfrXkf6mYnP0wJWtIxQhPo+hjoIUsYk9+ggALIFLJH6DwXhxrQOJ9tW4YCDCwSKKfTdAzp2LegVt6MfUkJAquIH9UxDu71V4pvQ/dAkCZEWtwHT6jbiQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4T2xJK0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4T2xJK0"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba60d78aff3so103522266b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776597515; x=1777202315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LdQsDScwQbJr9r6BUH7G0BxJchzcG5z7uH8QLakWZ/A=;
        b=D4T2xJK0ib3gi5fgqt8r9KojsjDgEjbv8zxqkD1k7bwX6wmmzg/aSDCPdbssuXdtDi
         SKHOmiJlYVCQzljPDgSWhySZOMK6w3B0oano3tzoC/1vWvMtzxO0IL5lCU47iZrVxCfn
         wEOAmOLnS7Pd5vy6fT3jz2bZu9JRB6SS6UR8qHWALCC8/NC3fdJB7raYiPo/HbvIwzas
         Z54Rjr9cPjDe262aEMgGOm0ShLivp3SYsw+qIHjdhJpufgm4PbmOICiSR/DawD3xCU5g
         ih/iA9vsmJSe+LrQntowh37s1gUsMwbRmbzyy2lYMhcINQ36/Jpee67/x78zTP/SSdr9
         +u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776597515; x=1777202315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdQsDScwQbJr9r6BUH7G0BxJchzcG5z7uH8QLakWZ/A=;
        b=B/DFkeskL0koyDT/q4+783jC2w3tnoEEEJEa/D9F+YDDmEKATkekPaDW5xe5NbBhAO
         j4mOtZTk+oC58K/b+SCvcSM349q6khDiBBbTXJeYJfGGMH7yI0oIcuvF0Rti6r7aPi1r
         lI6RvM2F2uC7P1pP0vlE2ykqV6vp1WgbC9565d3wE75Ml+udbmvQqT4wFyQVTNHTHxaH
         w3pcTYKFQl/qQ4xkFlh8BA2O3hJ5kYGdqOFylzm6sF6H5HI1BhT3ePn+a+QlJ4RSAqCA
         jjjCODoXbDi7lOYYxheKR74vxbjz4a7Wk90KsjOS3w4rGwm1DoMATT8bQE8B3YMWvRFK
         ufZA==
X-Forwarded-Encrypted: i=1; AFNElJ8fIsga8WkGtnjJHF9++dRuLVY5yJ/cb1mkwmT9NPe5U8SXM3LzTBNPld3Q/KHbUNCNoSNozSEVkcfwr8Vh@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBAA5Or8ErRv/SLlL5Id/Q33kEBXmcqz2YLGZQJICFJXOrVkq
	c5Jy5ZH55sspsWnQryzg6hZHP/htrWC5WIuITMmVhhJDP5RYPocIQAeU
X-Gm-Gg: AeBDiev8pjPjVVlpelHKiLPsKLKO8jIPrP6Drl8ldnv6jrMcuUjdYNJlbJF/LiZdRC8
	uEUaRvl71G6pmY0+Y1cXqYE2BXh1ML8dEKjDn3WpDqR+BlRc3Vc6ZrjAtexOmRpnDwZoEnLJgAJ
	ii59KNa5/JofjtwIgEFyaKzOB7VRtQx+5hwNaP1Z3XdRIZMd+ymrXCAYZ0s1f9RWr9+GGm1ZD3c
	IoJOe0NX43F/SwLv/cG9un0YF+R9mQ2lrAPiSWVFLe9tREgNmcI06tK07k5x4iFZaS9+L937UkV
	2d8scYjxQst5URrLvFFIp/SPe9K6+jzuXlIDS9qcWLerVTtKyP4jhtj7k9D2VVeUI7ALvTiSeti
	YP92gu7JbVwiKMD1Rymdm3xmujASpF8XMCP6CiF5zUf8xydPvhcGh/ecPQyiPXYCrud+DinltUP
	6Fi4QxzbNNTnCHBXiFZU6F0bRu1i+Wxnin4gd7YoVb/52NW2LfvMG9UvSRHKG0j7bbOJsz9Qfbk
	1QZ0vPHsfZJnGm7Plk46Pob/qeqxG7tztjSVw==
X-Received: by 2002:a17:907:fdc1:b0:b9d:1e6a:9b05 with SMTP id a640c23a62f3a-ba41aa16162mr518346266b.27.1776597514991;
        Sun, 19 Apr 2026 04:18:34 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-ef3e-0116-378f-2ef9.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:ef3e:116:378f:2ef9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45553e502sm245049066b.61.2026.04.19.04.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 04:18:34 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] docs: add guidelines for submitting new filesystems
Date: Sun, 19 Apr 2026 13:18:33 +0200
Message-ID: <20260419111833.1520854-1-amir73il@gmail.com>
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

Hi folks,

A few days have passed and collected enough edits, so
posting v2 with suggestions from Matthew.

Thanks,
Amir.

Changes since v1:
- Prefer plural maintainers
- Structure of patch series
- Community engagement
- Mention ioctls
- Mention fuzzing
- Mention netfs

 .../filesystems/adding-new-filesystems.rst    | 199 ++++++++++++++++++
 Documentation/filesystems/index.rst           |   1 +
 2 files changed, 200 insertions(+)
 create mode 100644 Documentation/filesystems/adding-new-filesystems.rst

diff --git a/Documentation/filesystems/adding-new-filesystems.rst b/Documentation/filesystems/adding-new-filesystems.rst
new file mode 100644
index 0000000000000..ac5e1e88da5f6
--- /dev/null
+++ b/Documentation/filesystems/adding-new-filesystems.rst
@@ -0,0 +1,199 @@
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
+New filesystems are expected to use current kernel interfaces and practices.
+Submitting a filesystem built on outdated APIs creates an immediate
+maintenance debt and is likely to face pushback during review.
+
+Use modern VFS interfaces
+  Do not use interfaces listed in
+  :ref:`Documentation/process/deprecated.rst <deprecated>`.
+
+  Use the filesystem context API (``fs_context``) for the mount path.  See
+  ``Documentation/filesystems/mount_api.rst`` for the mount API.
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
+ - Handle security issues promptly.  Filesystems parse complex on-disk
+   structures from potentially untrusted media and must treat security
+   reports with urgency.  Expect the filesystem to be subjected to fuzzing
+   of both syscalls and filesystem images.  The filesystem must handle
+   corrupted input gracefully without hanging or crashing the kernel.
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

