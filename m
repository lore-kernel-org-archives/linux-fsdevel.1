Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6D4C6F04
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859324; cv=none; b=WYC55+3FP8SbqUGVZMTO0e8IeJ2oOtpx6KAzkn2RXJzqTi3FqNtg8ONExuMxKYsW57nb69up/qI9aFnjCHElgj903yQ5KYZ7wx4kaW5qLZSxC2ZWP178fz5bRF59c5f61W82IaCeQ8Bbsyd7i7QXSoU8PvREN+i82R888ttmkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859324; c=relaxed/simple;
	bh=J82yT8zZ+C6IzncjehAYniSkg1/krOuNDMKGVqwZnfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQxrnxBlyDyfUt90NASehMAdCQV9SN3hNa/7KXSIRIb8wDx/UzafQjNUQ8D9gqGJrksFPyQyjVOdNiKdzKUJArBJrVYhnxUlrkFOi3kNatfTYK2gICytjlb8WF/q0XjzgFx9DE1fYurFb59FENGfy0BDjDzfwo5Y/VrGGIcPmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRgVCWyk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRgVCWyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01637C2BCB7;
	Fri, 15 May 2026 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859323;
	bh=J82yT8zZ+C6IzncjehAYniSkg1/krOuNDMKGVqwZnfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRgVCWykfAAZNoaGftg+yiGvt5/1YtkMwzhYWEayDjCWMLYTt34d7CKG71r26UWl7
	 1MmkC4nwI1yPjZldZxbtWlu1/vcbKbhzKQD8YN3RpsXAlX0FKFGmtc7U7BtuRXWt9w
	 13KYrH4aLcfj//8rVOQP18tEd+2ts2508OLuMB+XS3/Ys/6PyrQJJohQvaRmrwb5H3
	 hk7oiNZjAWOzOW7GSiiEjRepPEPt+mydx6oa11KyeohbEAHVZTih8LQNH2T/e8hal7
	 18IB8QraXR2LG6mLZaFMJhSKzADyBgHpwSYkjIxEzzRWVSU89fpVO+P4udA/qo0sVI
	 /RPDtxb5Xu70g==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 1/7] tools headers UAPI: Sync case-sensitivity flags from linux/fs.h
Date: Fri, 15 May 2026 11:35:09 -0400
Message-ID: <20260515153515.362266-2-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515153515.362266-1-cel@kernel.org>
References: <20260515153515.362266-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The case-sensitivity series adds FS_XFLAG_CASEFOLD and
FS_XFLAG_CASENONPRESERVING to include/uapi/linux/fs.h, and
tools/perf/check-headers.sh would warn about the resulting drift
in the perf beauty copy.  Pick up only those two flags (and the
surrounding comment block) so the series does not introduce new
drift of its own.

This is not a full sync.  The perf copy is also missing the
FS_IOC_SHUTDOWN block added by commit 1f662195dbc0 ("fs: add
generic FS_IOC_SHUTDOWN definitions").  Because
tools/perf/check-headers.sh emits a single warning per file, that
warning will remain active until the older drift is picked up
too; closing it is left to a separate sync outside this series.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com?part=2
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/perf/trace/beauty/include/uapi/linux/fs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
index 70b2b661f42c..2fa003575e8b 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
@@ -254,6 +254,13 @@ struct file_attr {
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
 #define FS_XFLAG_VERITY		0x00020000	/* fs-verity enabled */
+/*
+ * Case handling flags (read-only, cannot be set via ioctl).
+ * Default (neither set) indicates POSIX semantics: case-sensitive
+ * lookups and case-preserving storage.
+ */
+#define FS_XFLAG_CASEFOLD	0x00040000	/* case-insensitive lookups */
+#define FS_XFLAG_CASENONPRESERVING 0x00080000	/* case not preserved */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.54.0

