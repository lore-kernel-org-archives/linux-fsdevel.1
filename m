Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2584A33F9;
	Mon, 20 Apr 2026 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691970; cv=none; b=jmYdw67dEhrE/EeLVf1VOtYe7EzvaLGTSHDQfLEctSu41ATf8BmnxMJuvtr3GUGGXknWtjvvRn6t0VaPWnmDAByQfURV0idhurJd5HPYCiveWHIdY5R2mEzu9dCuGSjkD8fz7v///E9MqkNcI0XdRITgB2Pt0msIRcELBWbioDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691970; c=relaxed/simple;
	bh=jx1CWyv2pvN98Qc7dFxzNUrg/J3h2PF8TmCc2/2xxUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0vyLK5ij4x3jjM+1s/8AYwEeNlHufuZsOHkaUYs7WFQv0O7Fdx/aMv5Rpv8uiI1v4qZdNiDO0vw7Qs5jtfJoQao1N4wCl7U0F1/X6PIeqb46lHEsybUVHaD2VVF/VaBq5mNHH6bKs/Cm74XmE+QudxHGJSYSe5n1Cs41mtgyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqQ1Y5qq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqQ1Y5qq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5FAC19425;
	Mon, 20 Apr 2026 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691970;
	bh=jx1CWyv2pvN98Qc7dFxzNUrg/J3h2PF8TmCc2/2xxUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LqQ1Y5qqnQLEekKg3u8R1anJCQCwiKzvzCJ/Tj9Us3jAWwsXffRp7APkTM2nnz9a1
	 CSewq9BbT5pfQsgqZU7VrmATSGi0ssGtzx/zRQ8gDj9v4uhUMb8YgGpfdR+eELOiYc
	 4NynxB2xkbGFjQPY0qh2cuEYGuLHiIbYp+zVZbW4MWkkdLVkPz98JZMUym0AMRmMO4
	 AI3N3uSRW1ZSsSI/UYyqD7RMd0DMpV0flo4P7PWVPU8aD4BtaftHoagENpKQay7ON2
	 ynN5NFuIHKS+nvbe6ZO83tcP4anxSPDMXn08MsFunz9r0Ll8zEAAnVF0qk7RRWZBAv
	 v0Lf4t3QPZ7RA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Apr 2026 15:32:37 +0200
Subject: [PATCH 3/3] pidfs: don't report pidfd_info fields that won't fit
 in the user buffer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-work-pidfs-v1-3-4bd614e1cb33@kernel.org>
References: <20260420-work-pidfs-v1-0-4bd614e1cb33@kernel.org>
In-Reply-To: <20260420-work-pidfs-v1-0-4bd614e1cb33@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jx1CWyv2pvN98Qc7dFxzNUrg/J3h2PF8TmCc2/2xxUo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ+0/o9w/SxveJRlituiQt1Aif0K0+RaSzSmv0ivytQW
 a78frdXRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETWRzIydL+pn6tS/nfyZ/cs
 o27PPfNt2U6uOBTpXnTbhWu2obvCeYZ/xr0tpw9aXWW77R0TPGP1oimv5gpomXlFfRbdtlHhqGQ
 GNwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The UAPI documentation for struct pidfd_info promises that if the
structure provided by userspace is too small to contain a field, the
kernel will not set the corresponding bit in the returned mask.

The kernel violates this contract: it sets PIDFD_INFO_COREDUMP and
PIDFD_INFO_COREDUMP_SIGNAL in the returned mask without checking that
usize >= PIDFD_INFO_SIZE_VER1 (the coredump fields start at offset 64,
beyond a VER0 buffer). Similarly, PIDFD_INFO_SUPPORTED_MASK is set
without checking usize >= PIDFD_INFO_SIZE_VER2.

While copy_struct_to_user() correctly only copies min(usize, ksize)
bytes (so no kernel memory leaks), userspace that trusts the mask bits
as documented may read its own uninitialized buffer and interpret it as
valid data.

Gate each set of mask bits on the user-provided struct being large
enough to actually deliver the corresponding fields.

Fixes: 9e77e4882bae ("pidfs: support retrieving supported pidfd_info flags")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 2ab8fd2646f0..4c24d2eb7e41 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -375,7 +375,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 	}
 
-	if (mask & PIDFD_INFO_COREDUMP) {
+	if ((mask & PIDFD_INFO_COREDUMP) && usize >= PIDFD_INFO_SIZE_VER1) {
 		if (test_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask)) {
 			smp_rmb();
 			kinfo.mask |= PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL;
@@ -400,7 +400,8 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	if (!c)
 		return -ESRCH;
 
-	if ((mask & PIDFD_INFO_COREDUMP) && !kinfo.coredump_mask) {
+	if ((mask & PIDFD_INFO_COREDUMP) && usize >= PIDFD_INFO_SIZE_VER1 &&
+	    !kinfo.coredump_mask) {
 		guard(task_lock)(task);
 		if (task->mm) {
 			unsigned long flags = __mm_flags_get_dumpable(task->mm);
@@ -455,7 +456,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		return -ESRCH;
 
 copy_out:
-	if (mask & PIDFD_INFO_SUPPORTED_MASK) {
+	if ((mask & PIDFD_INFO_SUPPORTED_MASK) && usize >= PIDFD_INFO_SIZE_VER2) {
 		kinfo.mask |= PIDFD_INFO_SUPPORTED_MASK;
 		kinfo.supported_mask = PIDFD_INFO_SUPPORTED;
 	}

-- 
2.47.3

