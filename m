Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF03381AE5
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774849175; cv=none; b=d59/sbOL7rQ/zn6oCohGpfaycRWqDxtTHrXLE0AeyO1JKMA7Ps2nHyZn1qz9Ubl6BKkUNshocElFWjbxODFF6oHTItjdA/JN7Y8mc7jaXUIEgTCfRUqYgphPY4Go+lLjWPIYTu/mN7uf9IbsleEkNsgxXnn0DSB3+wOFLffGoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774849175; c=relaxed/simple;
	bh=bMvndX1iyWMEKILVmOBlP2R8h1g5Nshc1RneWssyiLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUHlPG7/ZkfhrnvuQ+ontt35dqaCGUh2CsRpWGL7Jnwvm2myebIXSjgb+CBRCndABCY9/cNEx0dX1vd1PsVEajz1fioIFuY/3wcTxerQw6khhpb0IcGZ06lxRZoZJjQLBVU8qtA51J8R1nugDPbsfCLpig4xn+eKoUuif9wos+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEWSBfJh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEWSBfJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774849172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g8MpXSBjxcDbsCgL0NjDYzsay2G5UIPAPIPiGXT17zc=;
	b=JEWSBfJhcdnCtuQnOy6IFDuxcTo4GQWnzCm5V+wWDYNfM9GJmNwMprCDaT+jxgo21W1Ukc
	79ngnnNeiycliWxXHxMdLmfwXPS/AzRBlLx2RCi0BJMf/B7WaN4/Ukb/UqiQWwXdqqSUgG
	jMNAjYFKq7kNG5cyhXis6iIqYqtKn+E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-JrK4ZgNOO2yHfjrVqeG6yw-1; Mon,
 30 Mar 2026 01:39:28 -0400
X-MC-Unique: JrK4ZgNOO2yHfjrVqeG6yw-1
X-Mimecast-MFC-AGG-ID: JrK4ZgNOO2yHfjrVqeG6yw_1774849166
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FAF71956094;
	Mon, 30 Mar 2026 05:39:26 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58F9B18001FE;
	Mon, 30 Mar 2026 05:39:19 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org
Cc: aubaker@redhat.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] selftests/mm: skip hugetlb_dio tests when DIO alignment is incompatible
Date: Mon, 30 Mar 2026 13:39:15 +0800
Message-ID: <20260330053915.75442-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

hugetlb_dio test uses sub-page offsets (pagesize / 2) to verify that
hugepages used as DIO user buffers are correctly unpinned at completion.

However, on filesystems with a logical block size larger than half the
page size (e.g., 4K-sector block devices), these unaligned DIO writes
are rejected with -EINVAL, causing the test to fail unexpectedly.

Add get_dio_alignment() to query the filesystem's required DIO alignment
via statx(STATX_DIOALIGN) and pass it to run_dio_using_hugetlb(). Skip
individual test cases whose writesize/buf-offset is not a multiple of the
alignment, so that aligned cases are still tested.

=== Reproduce Steps ===

  # dd if=/dev/zero of=/tmp/test.img bs=1M count=512
  # losetup --sector-size 4096 /dev/loop0 /tmp/test.img
  # mkfs.xfs /dev/loop0
  # mkdir -p /mnt/dio_test
  # mount /dev/loop0 /mnt/dio_test

  // Modify test to open /mnt/dio_test and rebuild it:
  -       fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
  +       fd = open("/mnt/dio_test", O_TMPFILE | O_RDWR | O_DIRECT, 0664);

  # getconf PAGESIZE
  4096

  # echo 100 >/proc/sys/vm/nr_hugepages

  # ./hugetlb_dio
  TAP version 13
  1..4
  # No. Free pages before allocation : 100
  # No. Free pages after munmap : 100
  ok 1 free huge pages from 0-12288
  Bail out! Error writing to file
  : Invalid argument (22)
  # Planned tests != run tests (4 != 1)
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    v3:
    	- Adopt statx raw syscall to build on older glibc.
    	- add buf offset alignment check as well
    v2:
    	- Pass dio_align as a parameter to run_dio_using_hugetlb()
    	  instead of generally page_size/2 alignment check.
    	- Add O_DIRECT flag back to the first open().
    	- Add stx_dio_offset_align zero check.

 tools/testing/selftests/mm/hugetlb_dio.c | 62 +++++++++++++++++-------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
index 9ac62eb4c97d..b125092fc6c1 100644
--- a/tools/testing/selftests/mm/hugetlb_dio.c
+++ b/tools/testing/selftests/mm/hugetlb_dio.c
@@ -17,10 +17,41 @@
 #include <unistd.h>
 #include <string.h>
 #include <sys/mman.h>
+#include <sys/syscall.h>
 #include "vm_util.h"
 #include "kselftest.h"
 
-void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
+#define HP_DIO_TMPDIR "/tmp"
+
+#ifndef STATX_DIOALIGN
+#define STATX_DIOALIGN		0x00002000U
+#endif
+
+unsigned int get_dio_alignment(void)
+{
+	int fd, ret;
+	struct statx stx;
+	unsigned int dio_align = 1;
+
+	fd = open(HP_DIO_TMPDIR, O_TMPFILE | O_RDWR | O_DIRECT, 0664);
+	if (fd < 0)
+		ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
+
+	ret = syscall(__NR_statx, fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx);
+	if (ret < 0) {
+		ksft_perror("statx() failed");
+	} else if ((stx.stx_mask & STATX_DIOALIGN) &&
+			stx.stx_dio_offset_align) {
+		dio_align = stx.stx_dio_offset_align;
+	}
+
+	close(fd);
+
+	return dio_align;
+}
+
+void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off,
+			unsigned int dio_align)
 {
 	int fd;
 	char *buffer =  NULL;
@@ -33,6 +64,12 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 	const int mmap_prot  = PROT_READ | PROT_WRITE;
 
 	writesize = end_off - start_off;
+	if (start_off % dio_align != 0 || writesize % dio_align != 0) {
+		ksft_test_result_skip("DIO alignment (%u) incompatible with "
+				"buf offset %u and writesize %zu\n",
+				dio_align, start_off, writesize);
+		return;
+	}
 
 	/* Get the default huge page size */
 	h_pagesize = default_huge_page_size();
@@ -40,7 +77,7 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 		ksft_exit_fail_msg("Unable to determine huge page size\n");
 
 	/* Open the file to DIO */
-	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
+	fd = open(HP_DIO_TMPDIR, O_TMPFILE | O_RDWR | O_DIRECT, 0664);
 	if (fd < 0)
 		ksft_exit_fail_perror("Error opening file\n");
 
@@ -89,37 +126,28 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 
 int main(void)
 {
-	size_t pagesize = 0;
-	int fd;
+	size_t pagesize = psize();
+	unsigned int dio_align = get_dio_alignment();
 
 	ksft_print_header();
 
-	/* Open the file to DIO */
-	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
-	if (fd < 0)
-		ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
-	close(fd);
-
 	/* Check if huge pages are free */
 	if (!get_free_hugepages())
 		ksft_exit_skip("No free hugepage, exiting\n");
 
 	ksft_set_plan(4);
 
-	/* Get base page size */
-	pagesize  = psize();
-
 	/* start and end is aligned to pagesize */
-	run_dio_using_hugetlb(0, (pagesize * 3));
+	run_dio_using_hugetlb(0, (pagesize * 3), dio_align);
 
 	/* start is aligned but end is not aligned */
-	run_dio_using_hugetlb(0, (pagesize * 3) - (pagesize / 2));
+	run_dio_using_hugetlb(0, (pagesize * 3) - (pagesize / 2), dio_align);
 
 	/* start is unaligned and end is aligned */
-	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3));
+	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3), dio_align);
 
 	/* both start and end are unaligned */
-	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3) + (pagesize / 2));
+	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3) + (pagesize / 2), dio_align);
 
 	ksft_finished();
 }
-- 
2.53.0

