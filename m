Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F83E0235;
	Mon, 30 Mar 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880679; cv=none; b=Iyny1av8K6oICiVH81LyJEb3IG/Ce0Kak6nJrUzDEC723sALeVt+mZNuK9BP970t4lXGySXWm6spTc5QbgqYhyK/X4E70r8NcXRdAt4oy9287DNALyRmHM572CQsk3bKf+Ag4fEBfGeGppQox0t9wO4eq8PmtkDl2c2icOJErTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880679; c=relaxed/simple;
	bh=3rj+sXJaZ9wh2XdFPjuo89ucmKl3UhlADlwbFbe84e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VChTlYuIqw1MSaTlHolMV0JUy4irQTMoQR1IXuPyAUR10VbL5DUgpP98g010nBVgKWvCu03v5PC+ta49rQQYxTWN8pvb8M6q8RVH7ic8Gb/OXvuvsJ9CVAKPQDsqXek/yFi/iKqbknqsmWcVQpK7L+R0cBAxEb/hAhJTWBKWWoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzLsfE7a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzLsfE7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234E3C2BCB4;
	Mon, 30 Mar 2026 14:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880678;
	bh=3rj+sXJaZ9wh2XdFPjuo89ucmKl3UhlADlwbFbe84e0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KzLsfE7aN0NHA9dqLon8kGWP6B+Jr6CjqLLn3sB/uAb4ltieAjQaJ5+MKjtFbohHG
	 7XbbIzlj0PEYR5lqPqjD6LpzCRCiB736dSKPlQFUpUIRM4Czre77YdW+LkTATUC/uY
	 /iymHSY1xrykYRESNAL9rsiAj7O/gUs8JtE3Mcgd9oi5mYBtIVag++nrfnd6jDWnaL
	 C7vMDZxsvzdu6vo+buwLfqczcNGfV8bdW9wTfXyAwT5c6IQHWfI1valyDj98tYeBqE
	 SOdsmJYvkemiJ/il3FB6x/IpdQZz1ClYseUuWD+G5ahHV5Ca7378tYivD/iij73FtZ
	 SgXzQXckkT8Lg==
Message-ID: <96d14f27-ca0f-413d-8b61-768933ee70ba@kernel.org>
Date: Mon, 30 Mar 2026 16:24:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] selftests/mm: skip hugetlb_dio tests when DIO
 alignment is incompatible
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org, rppt@kernel.org,
 ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
 surenb@google.com, mhocko@suse.com, shuah@kernel.org
Cc: aubaker@redhat.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260330125307.98581-1-liwang@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260330125307.98581-1-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/30/26 14:53, Li Wang wrote:
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
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Suggested-by: David Hildenbrand <david@kernel.org>
> ---


[...]

> +static void run_dio_using_hugetlb(int fd, unsigned int start_off,
> +				  unsigned int end_off)
>  {
> -	int fd;
>  	char *buffer =  NULL;
>  	char *orig_buffer = NULL;
>  	size_t h_pagesize = 0;
> @@ -39,10 +84,9 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>  	if (!h_pagesize)
>  		ksft_exit_fail_msg("Unable to determine huge page size\n");
>  
> -	/* Open the file to DIO */
> -	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
> -	if (fd < 0)
> -		ksft_exit_fail_perror("Error opening file\n");
> +	/* Reset file position since fd is shared across tests */
> +	if (lseek(fd, 0, SEEK_SET) < 0)
> +		ksft_exit_fail_perror("lseek failed\n");
>  
>  	/* Get the free huge pages before allocation */
>  	free_hpage_b = get_free_hugepages();
> @@ -71,7 +115,6 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>  
>  	/* unmap the huge page */
>  	munmap(orig_buffer, h_pagesize);
> -	close(fd);
>  
>  	/* Get the free huge pages after unmap*/
>  	free_hpage_a = get_free_hugepages();
> @@ -87,39 +130,49 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>  			 "free huge pages from %u-%u\n", start_off, end_off);
>  }
>  
> +static void run_test(int fd, unsigned int start_off,
> +		     unsigned int end_off, unsigned int align)

Nit: prefer to-tab alignment in MM land.

> +{
> +	if (!check_dio_alignment(start_off, end_off, align))
> +		return;

Is there a reason we just perform that at the beginning of
run_dio_using_hugetlb(), avoiding run_test() entirely?


In general, LGTM, thanks!

Feel free to add my

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
