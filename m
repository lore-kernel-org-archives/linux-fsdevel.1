Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D19A3E3157;
	Tue, 19 May 2026 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183590; cv=none; b=WdNVl52/fPxZXGKijpStqkdnWZopl+5IXzGdQ/Bg/FFTg0eJUhSLNpavusuyYiVFsxejtz/YXdgc/xT0+tkFKB0bYmSqgXg1OeamOD223rL3oTXfCdScRosrOFXh8iYwR/k3iJXntnOcNHzRNS3tQHgSuaa74g+jvFmJObTNAMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183590; c=relaxed/simple;
	bh=ZNDVleXOLPu9tcQiqIDQaOVi8Y4l811lnCFsvmfNUWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pyz61SVrDcC0h142YESQtDx0aBHo6jCNzRfgM/S+klz2oIca2u3io174idAWn16X5h/0TenFA8W6gzIjaU5Or5PsTrxevhooUF3qT937VybV6teIDp1PJLSgbs0RB+OjYzA0u4gAdSafSJYeOqWL50kGhhTjZGTrvS84ySIjgPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pDVBFju+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pDVBFju+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8F281CE0;
	Tue, 19 May 2026 02:39:42 -0700 (PDT)
Received: from entos-yitian-01.Arm.com (unknown [10.168.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B76F3F632;
	Tue, 19 May 2026 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779183587; bh=ZNDVleXOLPu9tcQiqIDQaOVi8Y4l811lnCFsvmfNUWo=;
	h=From:To:Cc:Subject:Date:From;
	b=pDVBFju+PlUhUisiOSHZs5tQXuj33LWd2LA6b2iBT+S04yDZF4RweFO97QcW2X0Qt
	 SFEilUFtkihIeWQ4QjpIrRnyUIEaMl1JqzS2slsKnFQX35LVhQhR+/oYnyG4eOuh63
	 EuNLjeHlfwY2FdGd6W+6tAYvIyWVcTduAlFpa+vQ=
From: Jia He <justin.he@arm.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Disseldorp <ddiss@suse.de>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia He <justin.he@arm.com>
Subject: [PATCH 1/1] init/initramfs_test: wait_for_initramfs() before running
Date: Tue, 19 May 2026 09:39:37 +0000
Message-Id: <20260519093937.1064628-1-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

initramfs_test_extract() and friends call unpack_to_rootfs() from a
kunit kthread while do_populate_rootfs() may still be running
asynchronously from rootfs_initcall. unpack_to_rootfs() keeps its
parser state in module-static variables (victim, byte_count, state,
this_header, header_buf, name_buf, ...), so the two writers corrupt
each other.

On arm64 v7.0-rc5+ this oopses early in boot:

  Unable to handle kernel paging request at virtual address ffff80018f9f0ffc
  pc : do_reset+0x3c/0x98
  Call trace:
   do_reset
   initramfs_test_extract
   kunit_try_run_case
  Initramfs unpacking failed: junk within compressed archive

do_reset() faults because 'victim' was overwritten by the boot-time
unpacker; the boot unpacker meanwhile logs the bogus "junk within
compressed archive" on the real initrd because the test wrecked its
state machine.

Add a .suite_init callback that calls wait_for_initramfs() so the async
unpack is quiescent before the first case runs. suite_init runs once per
suite rather than before every individual test case.

Fixes: 83c0b27266ec ("initramfs_test: kunit tests for initramfs unpacking")
Signed-off-by: Jia He <justin.he@arm.com>
Reviewed-by: David Disseldorp <ddiss@suse.de>
---
v2: Hook up .suite_init for initramfs test suite (sashiko-bot)

 init/initramfs_test.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 2ce38d9a8fd0..a4c06ec34368 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -3,7 +3,9 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/init.h>
 #include <linux/init_syscalls.h>
+#include <linux/initrd.h>
 #include <linux/stringify.h>
 #include <linux/timekeeping.h>
 #include "initramfs_internal.h"
@@ -510,8 +512,21 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
 	{},
 };
 
-static struct kunit_suite initramfs_test_suite = {
+static int __init initramfs_test_init(struct kunit_suite *suite)
+{
+	/*
+	 * unpack_to_rootfs() uses module-static state (victim, byte_count,
+	 * state, ...). The boot-time async do_populate_rootfs() may still be
+	 * running, so wait for it to finish before we call unpack_to_rootfs()
+	 * from the test thread, otherwise the two writers race and crash.
+	 */
+	wait_for_initramfs();
+	return 0;
+}
+
+static struct kunit_suite __refdata initramfs_test_suite = {
 	.name = "initramfs",
+	.suite_init = initramfs_test_init,
 	.test_cases = initramfs_test_cases,
 };
 kunit_test_init_section_suites(&initramfs_test_suite);
-- 
2.34.1

