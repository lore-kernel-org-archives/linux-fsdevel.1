Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1703A3E96
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875213; cv=none; b=lxpr+Vo1ZYzMgBAnAGMhgKMX1+5vE5tksuP1zuFNfb8ZImVuFirBGGYGcjetFTJEl3XqZWhgvUPgGZ8hoorRjlKxy47SmhSMNGYS5uEJ/fCspva5TfEqN/pdNAj/Xcfn1bsQcat34WVh2TDBgZabHUkO4HLYZ+J56PU/Gupc7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875213; c=relaxed/simple;
	bh=mE7a421+mR6aUe90SYOzNZOzGzVPWHAp6ts1tqQ7+i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dT9LJI8c4CVUyvIeYa6MONHX9j5gc3yTrX/dSMjO2n8CGgfSdBJ4YQO/yM7XLTnISj6iMsPMKTwZMF8me2nEXShPM2BdbszYN476faOm7XTVd1B48oGFrXY+dyNMMkFqE9yWI4fULJ+7n6CcmbTCrhthkcZRO/4fYROdkJHIXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6/48iMG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6/48iMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774875209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wDzMvwa7hHQR0J91vvkERkkKwoQTKWjm2iHbf3ig1ak=;
	b=F6/48iMG4wYVzJAFp2pMdKtP7vIby81aSUqkskvsLGvetqxgrUVimR4g6Ks+BY8PIYeY38
	pfzVgwxbHASks+pywp62UB2qeL+Bo8g2zJDAZbpXM0rkihAF4fVFOjTALM5hgSmyaplvhT
	A4k8pFMSmzKoc8y8fL/CaxmJtaSWr8g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-YP-4SDj_P5mGu4L44vaIfQ-1; Mon,
 30 Mar 2026 08:53:26 -0400
X-MC-Unique: YP-4SDj_P5mGu4L44vaIfQ-1
X-Mimecast-MFC-AGG-ID: YP-4SDj_P5mGu4L44vaIfQ_1774875204
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B69C195396B;
	Mon, 30 Mar 2026 12:53:18 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80E5C1955D96;
	Mon, 30 Mar 2026 12:53:12 +0000 (UTC)
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
Subject: [PATCH v4] selftests/mm: skip hugetlb_dio tests when DIO alignment is incompatible
Date: Mon, 30 Mar 2026 20:53:07 +0800
Message-ID: <20260330125307.98581-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

hugetlb_dio test uses sub-page offsets (pagesize / 2) to verify that
hugepages used as DIO user buffers are correctly unpinned at completion.

However, on filesystems with a logical block size larger than half the
page size (e.g., 4K-sector block devices), these unaligned DIO writes
are rejected with -EINVAL, causing the test to fail unexpectedly.

Add get_dio_alignment() to query the filesystem's required DIO alignment
via statx(STATX_DIOALIGN) and skip individual test cases whose file
offset or write size is not a multiple of that alignment. Aligned cases
continue to run so the core coverage is preserved.

While here, open the temporary file once in main() and share the fd
across all test cases instead of reopening it in each invocation.

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
Suggested-by: Mike Rapoport <rppt@kernel.org>
Suggested-by: David Hildenbrand <david@kernel.org>
---

Notes:
    v4:
    	- Open the file once and pass the fd to functions.
    	- Add check_dio_alignment dedicated to alignment checking.
    v3:
    	- Adopt statx raw syscall to build on older glibc.
    	- add buf offset alignment check as well.
    v2:
    	- Pass dio_align as a parameter to run_dio_using_hugetlb().
    	  instead of generally page_size/2 alignment check.
    	- Add O_DIRECT flag back to the first open().
    	- Add stx_dio_offset_align zero check.

 tools/testing/selftests/mm/hugetlb_dio.c | 97 ++++++++++++++++++------
 1 file changed, 75 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
index 9ac62eb4c97d..1c673c6c685e 100644
--- a/tools/testing/selftests/mm/hugetlb_dio.c
+++ b/tools/testing/selftests/mm/hugetlb_dio.c
@@ -17,12 +17,57 @@
 #include <unistd.h>
 #include <string.h>
 #include <sys/mman.h>
+#include <sys/syscall.h>
 #include "vm_util.h"
 #include "kselftest.h"
 
-void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
+#ifndef STATX_DIOALIGN
+#define STATX_DIOALIGN		0x00002000U
+#endif
+
+static int get_dio_alignment(int fd)
+{
+	struct statx stx;
+	int ret;
+
+	ret = syscall(__NR_statx, fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx);
+	if (ret < 0)
+		return -1;
+
+	/*
+	 * If STATX_DIOALIGN is unsupported, assume no alignment
+	 * constraint and let the test proceed.
+	 */
+	if (!(stx.stx_mask & STATX_DIOALIGN) || !stx.stx_dio_offset_align)
+		return 1;
+
+	return stx.stx_dio_offset_align;
+}
+
+static bool check_dio_alignment(unsigned int start_off,
+			        unsigned int end_off, unsigned int align)
+{
+	unsigned int writesize = end_off - start_off;
+
+	/*
+	 * The kernel's DIO path checks that file offset, length, and
+	 * buffer address are all multiples of dio_offset_align.  When
+	 * this test case's parameters don't satisfy that, the write
+	 * would fail with -EINVAL before exercising the hugetlb unpin
+	 * path, so skip.
+	 */
+	if (start_off % align != 0 || writesize % align != 0) {
+		ksft_test_result_skip("DIO align=%u incompatible with offset %u writesize %u\n",
+				align, start_off, writesize);
+		return false;
+	}
+
+	return true;
+}
+
+static void run_dio_using_hugetlb(int fd, unsigned int start_off,
+				  unsigned int end_off)
 {
-	int fd;
 	char *buffer =  NULL;
 	char *orig_buffer = NULL;
 	size_t h_pagesize = 0;
@@ -39,10 +84,9 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 	if (!h_pagesize)
 		ksft_exit_fail_msg("Unable to determine huge page size\n");
 
-	/* Open the file to DIO */
-	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
-	if (fd < 0)
-		ksft_exit_fail_perror("Error opening file\n");
+	/* Reset file position since fd is shared across tests */
+	if (lseek(fd, 0, SEEK_SET) < 0)
+		ksft_exit_fail_perror("lseek failed\n");
 
 	/* Get the free huge pages before allocation */
 	free_hpage_b = get_free_hugepages();
@@ -71,7 +115,6 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 
 	/* unmap the huge page */
 	munmap(orig_buffer, h_pagesize);
-	close(fd);
 
 	/* Get the free huge pages after unmap*/
 	free_hpage_a = get_free_hugepages();
@@ -87,39 +130,49 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 			 "free huge pages from %u-%u\n", start_off, end_off);
 }
 
+static void run_test(int fd, unsigned int start_off,
+		     unsigned int end_off, unsigned int align)
+{
+	if (!check_dio_alignment(start_off, end_off, align))
+		return;
+
+	run_dio_using_hugetlb(fd, start_off, end_off);
+}
+
 int main(void)
 {
-	size_t pagesize = 0;
-	int fd;
+	int fd, align;
+	const size_t pagesize = psize();
 
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
 
-	ksft_set_plan(4);
+	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
+	if (fd < 0)
+		ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
 
-	/* Get base page size */
-	pagesize  = psize();
+	align = get_dio_alignment(fd);
+	if (align < 0)
+		ksft_exit_skip("Unable to obtain DIO alignment: %s\n",
+				strerror(errno));
+	ksft_set_plan(4);
 
 	/* start and end is aligned to pagesize */
-	run_dio_using_hugetlb(0, (pagesize * 3));
+	run_test(fd, 0, (pagesize * 3), align);
 
 	/* start is aligned but end is not aligned */
-	run_dio_using_hugetlb(0, (pagesize * 3) - (pagesize / 2));
+	run_test(fd, 0, (pagesize * 3) - (pagesize / 2), align);
 
 	/* start is unaligned and end is aligned */
-	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3));
+	run_test(fd, pagesize / 2, (pagesize * 3), align);
 
 	/* both start and end are unaligned */
-	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3) + (pagesize / 2));
+	run_test(fd, pagesize / 2, (pagesize * 3) + (pagesize / 2), align);
+
+	close(fd);
 
 	ksft_finished();
 }
-- 
2.53.0

