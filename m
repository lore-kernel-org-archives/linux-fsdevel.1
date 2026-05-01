Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112F3115A5
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777655731; cv=none; b=hJJoulJbZ1FjKZh37WQlY7rtH+8m9Ok5HLWs2t/5srGiRZElQXrxVxYes2rzKg70LyNpaUFU3zIY0SFxc67UjL0bTGDaPqdQBUrmfn79PYup/PQm6IowDOYVSg22FYS/3xD2kGngolXoNlPnXi5bcO40CWeveD6fuEkPw2tocac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777655731; c=relaxed/simple;
	bh=ohwjUtUpXuaVoqzj2fKfGZmRZBe6KaDfrCAwwOuZK/U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=aX/GE/f0dHxC57/9vgcY+DY2XDEyoLizAIjprzqEAd2z5pfjYGGs6L3mWHkZF4faVw26et6Hfa5C+Wall4CWN+HhVN0b0UvH+npNjcbdAMvvM59VSrLR2sdN5p34e4KmZDgkgjOrxWnEeiYvpuyAi0uPDQFhje6pB/4ENLcRP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=aobzvbXX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lqgqySVR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="aobzvbXX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lqgqySVR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A11714000B0;
	Fri,  1 May 2026 13:15:25 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 01 May 2026 13:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1777655725; x=1777742125; bh=wu
	4PpLmKTEhtbPZz9szlYCe6vEyLoCx3Sv0GBHELtDg=; b=aobzvbXXFLI+zDGP0B
	Xs5nudOGNwPQ9Su2tE01f3WiPkNqFqXreN0/NgMJ3Y8CtLKRg/3rRR/i2Zypwio6
	yLtDESDrqOpHna4dTJxmQe5AqN868MV3U1hQoNE8zQGiHBp6KV2A5koDUPIhFffy
	B6894+92bCq1/a9QiQ3ftkZoUUUCpDvlWeW9FRzi0mn3MI53wh80kD5HaUbQj0mF
	dK7ILCYPVI1WFU90zo3GDC6+/YgbJbu+xvuCmZzd9BXMp3gO60g7sZrgp0TIK+0+
	kqMeG4CyVYghDzDLynrSUx/coVj2z4C5WuAgblope2o62yXrIEPSLP5M62sxAQq8
	nQtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1777655725; x=1777742125; bh=wu4PpLmKTEhtbPZz9szlYCe6vEyL
	oCx3Sv0GBHELtDg=; b=lqgqySVRwvNqtF8sZ+8s9nvqveRu0XaBA6us3C1n8P5V
	dyPVj96+0i0mDDLzd33LvjewFnV5koK6yo0ivXHaynzeT31s35L9yNcIbEaqbRAq
	pxNprwbbLnWVaniW/FqtBvmWdzmp7FI/wZPy8lx2yM5pDkQS/NIHWd2h0etpEe9e
	FyYa2uzQWl5sq0Uvvyv+rx+DCsRe6X19do2IJ8aTyMsIIGc5wfI4h4zgk6e8PHGC
	xiwoz/a5LRIbNa3JEVMgfUC0Cf+u4bKFHMF5PWvbRwNEOK9BOIxUZJs2PAuM7dkr
	pfUNzMCb6dhNdy2ZSmaBCnsIR8eLznCHWcdkn5apSg==
X-ME-Sender: <xms:rN_0aQWoHvarV2aCij0JM7IQaU5KTz4MR19Qp2KB_LzAbP-XKXtz9A>
    <xme:rN_0afbbLGwJoODQZZK6OS92Lh7B4skp9S5wStDS6ZiwWUNxMYRH9SNcsjp5X_jIH
    ikADkjOxjxuZV6bANtMMJS3O_H1zAUwe1Vyiwe90hdLeIHj9KZh8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeltdejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdevohhlihhnucgh
    rghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecuggftrfgrth
    htvghrnheptedtfefgledvfeettdelhfdvkeevveefffevkefgteegudefkedtvdevteeu
    ueffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghr
    shesvhgvrhgsuhhmrdhorhhgpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegvsghighhgvghrshesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rN_0aXTOLaNfRNqY2CVokEe6rqlRQ-tcnRZE9OPsoESXTwLoFAK1iQ>
    <xmx:rN_0aQijt3V9yBgIViy6hUpvD9CQzGpal-rBKC9gN-z1p_9xecIdXg>
    <xmx:rN_0af4Va8G3EAXUCo-JKVYZ_1vcXuipKa33pBuveByA1EjOqdBd2w>
    <xmx:rN_0aVASFCWB9fbb9bWhr7nia9lbITiLeLfV9KZ-sguGUbNh2ZO_yw>
    <xmx:rd_0ab3Y5Bx5KtjXxRpvBT-681RxAmrdcl1oSEY9Gd3uK70L9Hx12hgZ>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6B9F3780076; Fri,  1 May 2026 13:15:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMDuz2u8DR1N
Date: Fri, 01 May 2026 13:14:54 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Christoph Hellwig" <hch@infradead.org>,
 "Eric Biggers" <ebiggers@google.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-Id: <bf0ba588-002b-4860-848e-e806b193840a@app.fastmail.com>
Subject: overlayfs: verity validation broken since f77f281b6118
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Christoph & Eric,

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f77f281b6118 broke composefs's usage of overlayfs verity=require, this was reported originally in https://github.com/bootc-dev/bootc/issues/2174

There's some output from an agent run I had in the <details> there, but here's an xfstests patch that passes on without that commit and fails with it.

From 14231122bfd1e41337e4fb847acbbe038457c32a Mon Sep 17 00:00:00 2001
From: Colin Walters <walters@verbum.org>
Date: Fri, 1 May 2026 09:45:58 -0400
Subject: [PATCH] overlay/118: test fsverity lazy load through metacopy overlay

Reproduces the regression reported at:
https://github.com/bootc-dev/bootc/issues/2174

A recent change in how fsverity state was cached in memory
I think caused inodes not in cache to appear to have
missing verity=require for overlayfs.

This test catches that.

Generated-by: OpenCode (Claude Sonnet 4.5)
Signed-off-by: Colin Walters <walters@verbum.org>
---
 tests/overlay/118     | 62 +++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/118.out |  1 +
 2 files changed, 63 insertions(+)
 create mode 100755 tests/overlay/118
 create mode 100644 tests/overlay/118.out

diff --git a/tests/overlay/118 b/tests/overlay/118
new file mode 100755
index 00000000..ca21e076
--- /dev/null
+++ b/tests/overlay/118
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Red Hat, Inc. All Rights Reserved.
+#
+# FS QA Test No. 118
+#
+# Regression test for the overlayfs lazy fsverity load path.
+#
+# See also overlay/080 which builds a metacopy midlayer over a
+# verity-enabled data lower layer (the composefs architecture).
+#
+. ./common/preamble
+_begin_fstest auto quick metacopy redirect verity
+
+# Import common functions.
+. ./common/filter
+. ./common/verity
+
+# We use non-default scratch underlying overlay dirs, we need to check
+# them explicitly after the test.
+_require_scratch_nocheck
+_require_scratch_overlay_features redirect_dir metacopy
+_require_scratch_overlay_verity
+
+# remove all files from previous tests
+_scratch_mkfs
+
+testfile="verityfile"
+lowerdir=$OVL_BASE_SCRATCH_MNT/lower
+midlayer=$OVL_BASE_SCRATCH_MNT/midlayer
+upperdir=$OVL_BASE_SCRATCH_MNT/upper
+workdir=$OVL_BASE_SCRATCH_MNT/workdir
+workdir2=$OVL_BASE_SCRATCH_MNT/workdir2
+
+mkdir -p $lowerdir $midlayer $upperdir $workdir $workdir2
+
+# Create a verity-enabled file on the lower (data) layer.
+echo -n "overlay verity lazy load test" > $lowerdir/$testfile
+chmod 600 $lowerdir/$testfile
+_fsv_enable $lowerdir/$testfile >> $seqres.full 2>&1 \
+	|| _fail "failed to enable fsverity on $lowerdir/$testfile"
+
+# This is the same structure composefs creates at install time.
+_overlay_scratch_mount_dirs $lowerdir $midlayer $workdir2 \
+	-o redirect_dir=on,index=on,metacopy=on,verity=on
+chmod 400 $SCRATCH_MNT/$testfile
+$UMOUNT_PROG $SCRATCH_MNT
+
+# Drop all caches to reproduce the bug.
+echo 3 > /proc/sys/vm/drop_caches
+
+# Remount and verify we can read.
+_overlay_scratch_mount_dirs "$midlayer:$lowerdir" $upperdir $workdir \
+	-o redirect_dir=on,index=on,metacopy=on,verity=require
+cat $SCRATCH_MNT/$testfile > /dev/null 2>>$seqres.full \
+	|| echo "verity file read failed through overlay (regression)"
+
+$UMOUNT_PROG $SCRATCH_MNT
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/118.out b/tests/overlay/118.out
new file mode 100644
index 00000000..881d8dcd
--- /dev/null
+++ b/tests/overlay/118.out
@@ -0,0 +1 @@
+QA output created by 118
-- 
2.52.0


