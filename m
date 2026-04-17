Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DFE29B20A
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435909; cv=none; b=M3zk+5KHRx7vRXGrOSx32lcHknLlAGVRpPoMpCpoPh911Jq+H4E95CsVhnGsyMGusJbxiO6K05LS2UmcH23FeDI0CiOrLwa7afzO8rKfmn8P3JXee418tAoTMhtUNeyo1dOCn+3+euQtyF5I8Iy1/4CxvAhKzyRb1DQQIJii848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435909; c=relaxed/simple;
	bh=Es3tkDnuB+2bPX0Y21qZtqfihnBDUkocN4i6Ikk/71U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cmLUhRS4MB+pSwdZoq+vtCPjvW6ripTBoNx4YO0zbgoqx1dW7a/+EqECsiMmQfqCLTESNl5ebKD8L7Fw9nEJuFsP1qlmPMwvxlWV1XlhCc91paMDV7MsJqlHpCDI+vh45AYImQqCW+mTJdT97TJwZ2/Q70gwAqfFpfucVYDWzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dco8c5fR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dco8c5fR"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b886fc047d5so130352466b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776435906; x=1777040706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBmZWGOD/sJVwym7pO+5jLllkAblMaVOnMbyA5A1f0I=;
        b=Dco8c5fRLepq3lqZ3Ud7NYRcoCN6iWUMTHomv8dc0cnLPnDD1Slq9Gmpk5b/RjJfbU
         upTSMnZDgF6JQpjnnWUqEBgRswq6Bi/eGXXXsryZZQM6PAJbYnD8ZUZABppPBWPqSicO
         9C9n6XvFJLaBzzL3liSD5E5bWzy7iF3G1WL7ZI6/cZRv3DXFc42zOIryO6fPYuLhRY9+
         pKIqbRI5nfCg/Ij9ZiybseQA/bHdGTmWKc+0aZVTDSK4uKuwg/tStt2Rlyv31Qt4vCxb
         bxKFAEVFK1Ivi2Ptx2UJNk2F1BGXwNRe9g/eD47VrR+n+QTtI90BDf9Box0x4hvpZktV
         kN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776435906; x=1777040706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBmZWGOD/sJVwym7pO+5jLllkAblMaVOnMbyA5A1f0I=;
        b=JgF286fu+WlLxuoiRumXqg2b+WCh0cfKaqhcj31kCSybfgTMZ5lbfXsf30QpLWYjFm
         xjcO26sTH4YhDaRwlc6VFpqeoXlUrXDQyghTe9YoCYDWeMcGP8Up6zkiKQKvCtvX7Aye
         rBR4EpvhzPWlfmtllBpaGGdUx3zOGE78Gi/84XiKlHtT/4KUBZeOvTPBlFzxjfF7bA/L
         7dSIn1s+zaAvm1UqZ5IF1uXX9qecX87XoApdIq3+KFURQpFLAuOj5eq5uJPwGzikHW1N
         yTuGPcKk2S3j+GffIEffcJ2cB2IREu2waHjrAdJKNDTqxatxh0XRgilPeXKyqHUUpq1l
         DDHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PGHCPMiFKlEML2y0LuGcizfEF+q3Qum47H25fZjo9A8kAl+8g2nyuyf2bwXKnztsb2RCe9sO6mFdxrNVN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6iVQR/yRIf2KLGqTcD+2RIYDDODPEDPYcWBFBIMez9beyUHE3
	8Os4xu/GgMZew+mec8oovo984muk7BAN6aKtpjKLZEtDXecfbR8U95J1
X-Gm-Gg: AeBDietcwf6V3hmjEYcRbhca7BgZQ8g0Tou1px9oQv7v2XtpKHtfnG9z/6Os1FucTMK
	bA/BCvLYyZjiRlTWLfOotRMbmyYRhOvkxq2jA8N6zxjct1B/4nxTVg2kgcV0gCsXp/3spvoimRG
	32YOHfzmsKUoFEb8Lep98qJs57qdB5DO8cD0KfGYu70YoveceV7DsU/6LLf6xoCBaKEJvTbJowu
	r23d5/4CgWEf94TV46qF17+uAKb6rrT1xYJ0/oFg0kLXVb3xJNpa7CbLDxNAM5LE8yrb6KuPGX4
	QAnSOc3RTFxeuJzKf67PWi2KRlMIbBjvp6ihUfIuuZ6DE2GMqzyzMYluybvRke8LKQads/GdoO1
	o9SCLGpl6AT/cQY+W8Yr7pHRFT9ymtzYaQUtgM1jECJBU2TboxXD/M2Ymq3kMZ2IOwk/jWbYZow
	zAkVNSiSRRzVdhIsxuyblbFaqeX7j9MRKiqKLqZ0z2cn8u25R/ev6giJvKLHhNO+SX/lZVq5NLD
	a3qNeu25AzJ3MN8yAtHAo8OyjP+JrKiwd0NY4U=
X-Received: by 2002:a17:907:1c96:b0:b87:173f:61b with SMTP id a640c23a62f3a-ba41bacff3fmr150465066b.9.1776435905012;
        Fri, 17 Apr 2026 07:25:05 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-1973-6fc5-941a-7905.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:1973:6fc5:941a:7905])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45121109csm59251766b.6.2026.04.17.07.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 07:25:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] docs: add guidelines for submitting new filesystems
Date: Fri, 17 Apr 2026 16:25:03 +0200
Message-ID: <20260417142503.1436446-1-amir73il@gmail.com>
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

I am posting this patch as a placeholder for a TOPIC discussion at LSFMM.
This is a reoccurring topic on fsdevel and in LSFMM, but I think it is
worth having, because I do not think we have made a significant progress
in solving the vfs maintenance burden problem.

As much as I hate manifests and even more so discussions about
manifests, I think that having a document like this will at least save
us some time in writing the bounce emails.

Please try not to make this a discussion about a legal document!

Note that LLM has helped me collect the relevant discussions and
articulate our collective feedbacks into a summary.

Note that same LLM makes it much easier for random people to
submit new filesystems, so we may need to work harder in the near
future on push backs...

Thanks,
Amir.


 .../filesystems/adding-new-filesystems.rst    | 167 ++++++++++++++++++
 Documentation/filesystems/index.rst           |   1 +
 2 files changed, 168 insertions(+)
 create mode 100644 Documentation/filesystems/adding-new-filesystems.rst

diff --git a/Documentation/filesystems/adding-new-filesystems.rst b/Documentation/filesystems/adding-new-filesystems.rst
new file mode 100644
index 0000000000000..2e59b7127c05f
--- /dev/null
+++ b/Documentation/filesystems/adding-new-filesystems.rst
@@ -0,0 +1,167 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _adding_new_filesystems:
+
+Adding New Filesystems
+======================
+
+This document describes what is involved in adding a new filesystem to the
+Linux kernel, over and above the normal submission advice in
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>` and
+:ref:`Documentation/process/submit-checklist.rst <submitchecklist>`.
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
+  New filesystems should use iomap rather than buffer heads for block mapping
+  and I/O, folios rather than raw page operations for page cache management,
+  and the filesystem context API (``fs_context``) for the mount path.  See
+  ``Documentation/filesystems/iomap/index.rst`` for iomap documentation and
+  ``Documentation/filesystems/mount_api.rst`` for the mount API.
+
+Avoid deprecated interfaces
+  Do not use interfaces listed in
+  :ref:`Documentation/process/deprecated.rst <deprecated>`.  If the
+  filesystem depends on an interface that is being phased out, plan for
+  conversion before submission.
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
+Identified maintainer
+  The submission must include a ``MAINTAINERS`` entry with at least one
+  maintainer (``M:``), a mailing list (``L:``), and a git tree (``T:``).
+  The maintainer is expected to be the primary point of contact for the
+  filesystem going forward.
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
+A practical way to demonstrate many of the qualities above is to maintain the
+filesystem out-of-tree for a period before requesting a merge.  This shows
+sustained commitment, builds a visible user base, and gives reviewers
+confidence that the code and its maintainer will persist after merging.
+That said, it is recognized that for some filesystems the user base grows
+significantly only after upstreaming, so a compelling case for expected
+adoption can substitute for a large existing user base.
+
+
+Submission Process
+------------------
+
+Send patches to the linux-fsdevel mailing list
+(``linux-fsdevel@vger.kernel.org``).  CC the relevant VFS maintainers as
+listed in the ``MAINTAINERS`` file under ``FILESYSTEMS (VFS and infrastructure)``.
+
+Expect thorough review.  Filesystem code interacts deeply with the VFS, memory
+management, and block layers, so reviewers will examine the code carefully.
+Address all review feedback and be prepared for multiple revision cycles.
+
+It may be appropriate to mark the filesystem as experimental in its Kconfig
+help text for the first few releases to set expectations while the code
+stabilizes in-tree.
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
+   reports with urgency.
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

