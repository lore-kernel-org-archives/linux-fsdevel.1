Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A53B8930;
	Wed,  1 Apr 2026 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077282; cv=none; b=IEt3f59VFQltflVxOUgTDNoRm1F/y6VZHeKAimhWiEM4xQvgSNPi5E9Tpk8SWxYo/M22k+FwcMD/IuQr/hiYRD12A6+V15fla6N9SAfzq7Ka+StexrUS0ZAzBBRhpMQE8huQYgDo1wZiGxDJWxu6gvXNwqs9sFmDI1hQj06QDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077282; c=relaxed/simple;
	bh=O8Vo4jZDWqqW0uxQ2thCeW0mz8X2oEjk8T/VgT+wO6E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hMweiv+kPP15u0CO5MSnC4REvE1UvE8IaqJ2B1OjW2Ud6vrnsm6x/6e9Vg7cHlOZJnx1msvd7gxVnyY3fJEZ0GHrNe+8oc/mWluIT62fMf/nbR4LaO43nJpWim7F+0c/gMzijmvxaeWczfqr+kSR/n4s3O2/hEdkX6o3jlCti3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hUYT0NQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hUYT0NQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32BFC116C6;
	Wed,  1 Apr 2026 21:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775077282;
	bh=O8Vo4jZDWqqW0uxQ2thCeW0mz8X2oEjk8T/VgT+wO6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hUYT0NQwE1/aqyZL6tnYr8vsofwQSlwRlkfoXcyTUN7oAj4RVLQMrS7DjPVj93Yih
	 pk1v5NE3GBqu4oRB//kra+8WheLUs+YSTYiuz5GCf2burXypwSe6dfdDANy/nq5Nyh
	 ne0uu0GVYVP+ORus40ex+AQ5AP0IHcZUErLCWTN4=
Date: Wed, 1 Apr 2026 14:01:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Li Wang <liwang@redhat.com>
Cc: rppt@kernel.org, david@kernel.org, ljs@kernel.org,
 Liam.Howlett@oracle.com, vbabka@kernel.org, surenb@google.com,
 mhocko@suse.com, shuah@kernel.org, aubaker@redhat.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] selftests/mm: skip hugetlb_dio tests when DIO
 alignment is incompatible
Message-Id: <20260401140121.23643cf9784ae8dafd9f0ab6@linux-foundation.org>
In-Reply-To: <20260401090520.24018-1-liwang@redhat.com>
References: <20260401090520.24018-1-liwang@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Apr 2026 17:05:20 +0800 Li Wang <liwang@redhat.com> wrote:

> hugetlb_dio test uses sub-page offsets (pagesize / 2) to verify that
> hugepages used as DIO user buffers are correctly unpinned at completion.
> 
> However, on filesystems with a logical block size larger than half the
> page size (e.g., 4K-sector block devices), these unaligned DIO writes
> are rejected with -EINVAL, causing the test to fail unexpectedly.
> 
> Add get_dio_alignment() to query the filesystem's required DIO alignment
> via statx(STATX_DIOALIGN) and skip individual test cases whose file
> offset or write size is not a multiple of that alignment. Aligned cases
> continue to run so the core coverage is preserved.
> 
> While here, open the temporary file once in main() and share the fd
> across all test cases instead of reopening it in each invocation.
> 
> === Reproduce Steps ===
> 
>   # dd if=/dev/zero of=/tmp/test.img bs=1M count=512
>   # losetup --sector-size 4096 /dev/loop0 /tmp/test.img
>   # mkfs.xfs /dev/loop0
>   # mkdir -p /mnt/dio_test
>   # mount /dev/loop0 /mnt/dio_test
> 
>   // Modify test to open /mnt/dio_test and rebuild it:
>   -       fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
>   +       fd = open("/mnt/dio_test", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
> 
>   # getconf PAGESIZE
>   4096
> 
>   # echo 100 >/proc/sys/vm/nr_hugepages
> 
>   # ./hugetlb_dio
>   TAP version 13
>   1..4
>   # No. Free pages before allocation : 100
>   # No. Free pages after munmap : 100
>   ok 1 free huge pages from 0-12288
>   Bail out! Error writing to file
>   : Invalid argument (22)
>   # Planned tests != run tests (4 != 1)
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Thanks, I update mm.git to this version,

> Notes:
>     v5:
>     	- Perform that align checks at the beginning of run_dio_using_hugetlb()
>     	  but not addinital run_test().

Here's how v5 altered mm.git:

--- a/tools/testing/selftests/mm/hugetlb_dio.c~selftests-mm-skip-hugetlb_dio-tests-when-dio-alignment-is-incompatible-v5
+++ a/tools/testing/selftests/mm/hugetlb_dio.c
@@ -66,7 +66,7 @@ static bool check_dio_alignment(unsigned
 }
 
 static void run_dio_using_hugetlb(int fd, unsigned int start_off,
-				  unsigned int end_off)
+				unsigned int end_off, unsigned int align)
 {
 	char *buffer =  NULL;
 	char *orig_buffer = NULL;
@@ -77,6 +77,9 @@ static void run_dio_using_hugetlb(int fd
 	const int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB;
 	const int mmap_prot  = PROT_READ | PROT_WRITE;
 
+	if (!check_dio_alignment(start_off, end_off, align))
+		return;
+
 	writesize = end_off - start_off;
 
 	/* Get the default huge page size */
@@ -130,15 +133,6 @@ static void run_dio_using_hugetlb(int fd
 			 "free huge pages from %u-%u\n", start_off, end_off);
 }
 
-static void run_test(int fd, unsigned int start_off,
-		     unsigned int end_off, unsigned int align)
-{
-	if (!check_dio_alignment(start_off, end_off, align))
-		return;
-
-	run_dio_using_hugetlb(fd, start_off, end_off);
-}
-
 int main(void)
 {
 	int fd, align;
@@ -161,16 +155,16 @@ int main(void)
 	ksft_set_plan(4);
 
 	/* start and end is aligned to pagesize */
-	run_test(fd, 0, (pagesize * 3), align);
+	run_dio_using_hugetlb(fd, 0, (pagesize * 3), align);
 
 	/* start is aligned but end is not aligned */
-	run_test(fd, 0, (pagesize * 3) - (pagesize / 2), align);
+	run_dio_using_hugetlb(fd, 0, (pagesize * 3) - (pagesize / 2), align);
 
 	/* start is unaligned and end is aligned */
-	run_test(fd, pagesize / 2, (pagesize * 3), align);
+	run_dio_using_hugetlb(fd, pagesize / 2, (pagesize * 3), align);
 
 	/* both start and end are unaligned */
-	run_test(fd, pagesize / 2, (pagesize * 3) + (pagesize / 2), align);
+	run_dio_using_hugetlb(fd, pagesize / 2, (pagesize * 3) + (pagesize / 2), align);
 
 	close(fd);
 
_

