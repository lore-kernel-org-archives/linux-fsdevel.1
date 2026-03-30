Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A302BEC2B;
	Mon, 30 Mar 2026 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774850526; cv=none; b=gu63W8jbovig8WPMyfaEdnLyHEC/AAmDWeu9em4044rdLoKDbX2QcezAHrRIZ7Agw/5gn2FENzqbbeBkcnwJXT6EBw7w1onOgIgBKIzsVBedvuTty6cm2qWOaRNfzQaLnEcKc7Rq0/V0S44b2lDqtYFy/6j/tcelzxI1QHdR7Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774850526; c=relaxed/simple;
	bh=CGuekXdyNMAp/fxcByK34kMMDVgow9ju2U4NlT6Am4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gq+Jr8Ioke9CWFhtev+Dh3pWmuAgVmFWFB/XBHMeAEZcMaA8v8qvECI98C8Rbl5+28JzILH8oGZ2dsr1bFDtYh2s3MfXxc7JUrITdCRiauSZUovczh1RO2wvBQuQR+0kXcKCtdN7etuzI+4QlOa9c6iPDNvU515VhnVxj89MRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hybSj+et; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hybSj+et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B4DC4CEF7;
	Mon, 30 Mar 2026 06:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774850526;
	bh=CGuekXdyNMAp/fxcByK34kMMDVgow9ju2U4NlT6Am4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hybSj+etFTy1+LIAuCzZvsp25MVzR795OuJzHMQNu4IsJoubutQLiPHYFfZ9ujqrd
	 Sd5018EiDDavI+or7SivXwvU8YK/rtLpP4P3z9Wo9YndtRGYXNDOoZvGpjl6dLayWO
	 YRydMIXlNCoObElT4BCKBzKqZ9aJNRArGPHM0I1RgOHIBdOS8TPOedcza/zLxWlGH+
	 Kmx1S88nn8skMIdod6KI+DyLkVUx1kGMxDiodVzCWrJYQSYSXGota10fVu2e5XF1nq
	 wrff+Ia1MSPj6p64ZoGJei2r5hHJ7phQt0cGqYmz46c1XVk5pMFalfIs3WpCYFK64E
	 VMIdD8U94skfQ==
Message-ID: <a5b7add7-0507-40c0-a324-81f243ffa261@kernel.org>
Date: Mon, 30 Mar 2026 08:02:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/mm: skip hugetlb_dio tests when DIO
 alignment is incompatible
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org, rppt@kernel.org,
 ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
 surenb@google.com, mhocko@suse.com, shuah@kernel.org
Cc: aubaker@redhat.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260330053915.75442-1-liwang@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260330053915.75442-1-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/30/26 07:39, Li Wang wrote:
> hugetlb_dio test uses sub-page offsets (pagesize / 2) to verify that
> hugepages used as DIO user buffers are correctly unpinned at completion.
> 
> However, on filesystems with a logical block size larger than half the
> page size (e.g., 4K-sector block devices), these unaligned DIO writes
> are rejected with -EINVAL, causing the test to fail unexpectedly.
> 
> Add get_dio_alignment() to query the filesystem's required DIO alignment
> via statx(STATX_DIOALIGN) and pass it to run_dio_using_hugetlb(). Skip
> individual test cases whose writesize/buf-offset is not a multiple of the
> alignment, so that aligned cases are still tested.
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
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
> 
> Notes:
>     v3:
>     	- Adopt statx raw syscall to build on older glibc.
>     	- add buf offset alignment check as well
>     v2:
>     	- Pass dio_align as a parameter to run_dio_using_hugetlb()
>     	  instead of generally page_size/2 alignment check.
>     	- Add O_DIRECT flag back to the first open().
>     	- Add stx_dio_offset_align zero check.
> 
>  tools/testing/selftests/mm/hugetlb_dio.c | 62 +++++++++++++++++-------
>  1 file changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
> index 9ac62eb4c97d..b125092fc6c1 100644
> --- a/tools/testing/selftests/mm/hugetlb_dio.c
> +++ b/tools/testing/selftests/mm/hugetlb_dio.c
> @@ -17,10 +17,41 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <sys/mman.h>
> +#include <sys/syscall.h>
>  #include "vm_util.h"
>  #include "kselftest.h"
>  
> -void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
> +#define HP_DIO_TMPDIR "/tmp"
> +
> +#ifndef STATX_DIOALIGN
> +#define STATX_DIOALIGN		0x00002000U
> +#endif
> +
> +unsigned int get_dio_alignment(void)
> +{
> +	int fd, ret;
> +	struct statx stx;
> +	unsigned int dio_align = 1;
> +
> +	fd = open(HP_DIO_TMPDIR, O_TMPFILE | O_RDWR | O_DIRECT, 0664);
> +	if (fd < 0)
> +		ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
> +
> +	ret = syscall(__NR_statx, fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx);
> +	if (ret < 0) {
> +		ksft_perror("statx() failed");
> +	} else if ((stx.stx_mask & STATX_DIOALIGN) &&
> +			stx.stx_dio_offset_align) {
> +		dio_align = stx.stx_dio_offset_align;
> +	}
> +
> +	close(fd);
> +
> +	return dio_align;
> +}
> +
> +void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off,
> +			unsigned int dio_align)
>  {
>  	int fd;
>  	char *buffer =  NULL;
> @@ -33,6 +64,12 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>  	const int mmap_prot  = PROT_READ | PROT_WRITE;
>  
>  	writesize = end_off - start_off;
> +	if (start_off % dio_align != 0 || writesize % dio_align != 0) {
> +		ksft_test_result_skip("DIO alignment (%u) incompatible with "
> +				"buf offset %u and writesize %zu\n",
> +				dio_align, start_off, writesize);
> +		return;
> +	}
>  
>  	/* Get the default huge page size */
>  	h_pagesize = default_huge_page_size();
> @@ -40,7 +77,7 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>  		ksft_exit_fail_msg("Unable to determine huge page size\n");
>  
>  	/* Open the file to DIO */

This comment is misleading as we are not opening "the" file, but we create a new one.
See below, maybe we should clean that up.

> -	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
> +	fd = open(HP_DIO_TMPDIR, O_TMPFILE | O_RDWR | O_DIRECT, 0664);
>  	if (fd < 0)
>  		ksft_exit_fail_perror("Error opening file\n");
>  
> @@ -89,37 +126,28 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>  
>  int main(void)
>  {
> -	size_t pagesize = 0;
> -	int fd;
> +	size_t pagesize = psize();
> +	unsigned int dio_align = get_dio_alignment();

Both could be const.

>  
>  	ksft_print_header();
>  
> -	/* Open the file to DIO */
> -	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
> -	if (fd < 0)
> -		ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
> -	close(fd);


Why can't we simply open the file once and pass the fd to run_dio_using_hugetlb()?

fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
if (fd < 0)
	ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
dio_align = get_dio_alignment(fd);
if (dio_align <= 0)
	ksft_exit_skip("Unable to obtain DIO alignment: %s\n", strerror(errno));

...

run_dio_using_hugetlb(fd, 0, (pagesize * 3), dio_align);

> -
>  	/* Check if huge pages are free */
>  	if (!get_free_hugepages())
>  		ksft_exit_skip("No free hugepage, exiting\n");
>  
>  	ksft_set_plan(4);
>  
> -	/* Get base page size */
> -	pagesize  = psize();
> -
>  	/* start and end is aligned to pagesize */
> -	run_dio_using_hugetlb(0, (pagesize * 3));
> +	run_dio_using_hugetlb(0, (pagesize * 3), dio_align);
>  
>  	/* start is aligned but end is not aligned */
> -	run_dio_using_hugetlb(0, (pagesize * 3) - (pagesize / 2));
> +	run_dio_using_hugetlb(0, (pagesize * 3) - (pagesize / 2), dio_align);
>  
>  	/* start is unaligned and end is aligned */
> -	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3));
> +	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3), dio_align);
>  
>  	/* both start and end are unaligned */
> -	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3) + (pagesize / 2));
> +	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3) + (pagesize / 2), dio_align);
>  
>  	ksft_finished();
>  }


-- 
Cheers,

David
