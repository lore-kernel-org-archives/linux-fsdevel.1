Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A9442FB4;
	Wed, 19 Aug 2026 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134448; cv=none; b=l/yFlqXiHxFViWP/Odoeo10vtwDctmkm7jzjAPvsfPs4EbiwwXpigKnyWkdE7WqcwyDP/wrb6iYzOlxsvcNg2vsjMVBveXKp01Vxj8y1nBIXjj++OYK15tgOCgS0g7+OQbUqCwm5vghkNYiKRsnxLhNYljMEeKbOG0PWDqbnzN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134448; c=relaxed/simple;
	bh=lxBZKA5JGd4oFAL7tKjnQwoewutgtnhWoLDlpwJmTL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vb2qh6IG20H0S50yjofAB7JdHyUjMF7AX+VLkMTXdR5XrrmsHhsCoSgrxp4kFO1gwH07hWwAyiYBgHRPTsKKH4IFXWszb5ghJe4VzgN8FejP4JYxPYs3ERALBtMbwByZ+V4snfJObLGW2izrPtmaNe99dCyJD+09L+vsk7PAS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=ZFlego71; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k8dwY3pM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="ZFlego71";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k8dwY3pM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0420CEC018B;
	Wed, 19 Aug 2026 06:14:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 19 Aug 2026 06:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787134444;
	 x=1787220844; bh=jZ0gUQPj/MnLJ8Zgf8OHj9y36T59sKFKv65jvaNDfSg=; b=
	ZFlego71+gfxYHi8pdafQsXdWPprMUpeyfxGgyj4yDXH5urzrHRpnWXrAhYB9BI/
	f6fd/Mc30tH8atZqomJnpqnPZPdWWb/vXi3fx9ZstdSIn620ley4oo3e4iwav6mR
	l5zCG4qdGulpwfMqnpOG96k9thBzioPY68zcbU34QUHdg9pcku1vPsi9wJqMCJ8a
	B6edvMZjk8aFQ2f2BZ8JmSzQH56I6qtfKjaRy9qaBMmVPZ9V73MRYboq1C5NRMmV
	uCH7XBTBOiHsGoumMA3kML7cMRpva+Re3N4XxY115ZGRWQeSw3thCPUgR/xuna9R
	S/3Y5ffSUxgyShbzccIAww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787134444; x=
	1787220844; bh=jZ0gUQPj/MnLJ8Zgf8OHj9y36T59sKFKv65jvaNDfSg=; b=k
	8dwY3pMH6lQnEqpNlFvJ7KDcPAYINgQBaMQjH7faf3Fu3B3x5qShIwYKqD6jUkKi
	5x844tEiEfBqjbOR1YFGZ6/Ws5QfKV04lEGjcRSgd/WhkKMUIpsNyXW8NQwO9+IG
	0de7ExAUgQdt5Z+fF0wmHA5dKSi3V26FddMfihmhdTN0aVi/Qqq+zIbpdywsWjLJ
	FRQGFuCkQdDsktmIzifl+wJ5pYNgOCDPj7/xB7+TzCMN8nbgdIVzVeqCwVHIxeCf
	XMG9Qvh/3yS4t32gJEgWYijRBUWspVh7cVHSlFI02L+IyBCrxEgTwgSCkyegVEqi
	qAM6U7Uwh4iR+C7uua0RA==
X-ME-Sender: <xms:7IGFapXyX9QjrPPnTXDkENdYQnYnU5kMxN8qtW3kkI4KFSppBQHFXQ>
    <xme:7IGFajlFEe2yuN83ClN_Ej3lH6qXdPDnJKjGkZ1g-FiGQp02yCEI67ArBVxQtBHwq
    l8j7DGwAljw3IBh_7TJBAhE1nKRz5y_InIKCQ4WSmdNMd2VbFs>
X-ME-Received: <xmr:7IGFasA9VtuifXYbQY9t0d7nLme7yNcODGbMf62mxZwgXPhlmm4uCVF2K4cQGDtB1pTUuSiLws5DuG0NWux3SPSaMR-PQ3vJPUe-p1GbOUWVg-Kh2uAgZiF6>
X-ME-Proxy-Cause: dmFkZTEg1y+6XtKdHKf68SbkCRY671WXcPE2SPQH6yiNHk8lEoZ/TtjEW6tMcyn2ldSSTW
    gb+WQG0Rujijp3dkyXTkQPfP33RtJ0OwCa3z4greBE5O5rSb575dNG2JlPDYF9VUyg3He5
    yLfq11RSn4nNdWFItxR5Pb9ir30XFbAYBtTNIBJriK5fI8Kfovf0CrtoLF2ryu4qxovIvA
    wrFJ6YOukwY+6gk3uIwqqtLRWKerVMwGs59qiErjsiRbJiRcTDW8OzZxdaEVW+DmILKvLA
    aQ66aRtdMVVny4ITCnUzAvjJY8LLL8pxLb3e1gDqvi8f/FLXeERdzmIWe6pt8iKae+ujBT
    YBeG7L6r1cIwSv3hMr755VyrW+wgPEpX2+kjk4GsH5bzegLGvR+/QkHhiw23kWYfj/facG
    K3Z1zWgoF8gRhUPTSfOllCiRwDPBV8iF3sAvbV1EsOk3G+XR3tzc21/sXYQ+7SZThMGwQe
    FT6dci5gUTQqPaRz9D4+R0ZqUa0CvDlkM2MrHoQfl6xv9N76EqWZ0PklFYOgGELYqrDX9T
    IqTS01nwO1DACYjhfORMKv04iBUeeE2N5OLFC9qO3VGIJaToyMdnE9uXVIUe2t5zYltJ7R
    YNlCSSf5q+6UBW/OA6e//QjlORgrNOwUzYxUsIxSXVfuCGN+EZrPsP57uAYg
X-ME-Proxy: <xmx:7IGFaqjI6iwAlMI5rGzoxfX7ROPTj_rUEUJUdEJMJkMEkrw8WKmEbQ>
    <xmx:7IGFahyw4T1Yv_MEVdQ7-7rpK1Kqdhe93YV0FxrLkCicMfzGjiuz0g>
    <xmx:7IGFaj0E1fFpL6t5frubC85R6DPWM37eIcCofUzFuYRteAKoFbB0nA>
    <xmx:7IGFau9w267gXNY339LSGs-e81sQ-HU13xvE-UkQ8jxhlJ849KxESw>
    <xmx:7IGFakWWbnnx8n8csMgfwTHu--8DlYkroSCdSVJEiKg-pl1_N2U1Pej1>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 06:14:03 -0400 (EDT)
Message-ID: <a553af27-fb6d-4136-9caf-c438eb8c9cfe@bsbernd.com>
Date: Wed, 19 Aug 2026 12:14:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: invalidate the correct range after O_APPEND direct
 write
To: Baokun Li <libaokun@linux.alibaba.com>, fuse-devel@lists.linux.dev
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, cding@ddn.com, jefflexu@linux.alibaba.com
References: <20260819090728.3331501-1-libaokun@linux.alibaba.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260819090728.3331501-1-libaokun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/26 11:07, Baokun Li wrote:
> fuse_direct_write_iter() captures pos before generic_write_checks(),
> which moves ki_pos to EOF for O_APPEND writes:
> 
>   fuse_direct_write_iter()
>   {
>       pos = iocb->ki_pos;           /* 0 (user-supplied)       */
>       generic_write_checks();       /* ki_pos -> EOF           */
>       fuse_direct_io();             /* writes at EOF, correct  */
>       invalidate(pos, pos + res);   /* [0, res) -- wrong       */
>   }
> 
> The post-write invalidation targets a stale range instead of the
> actual written range at EOF.
> 
> This can cause data inconsistency when the file size is not
> page-aligned.  The tail page straddling EOF has a valid portion
> before EOF that concurrent readers can fault back in during the
> DIO write window:
> 
>   Tail page (file size X not page-aligned):
> 
>     page_start         X (EOF)   page_end
>     |--- valid data ----|-- stale --|
> 
>   CPU0 (O_APPEND DIO writer)    CPU1 (buffered reader)
>   --------------------------    ----------------------
>   invalidate [X, X+len)
>     tail page evicted
>   FUSE_WRITE in flight ...
>                                 read [page_start, X)
>                                   tail page re-faulted
>                                   [X, page_end) = stale
>   FUSE_WRITE completes
>   i_size = X + len
>   invalidate [0, len)  <- WRONG
>     tail page still cached
>                                 read [X, X+len)
>                                   hits stale tail page
>                                   returns old data
> 
> Fix by reading pos back from iocb->ki_pos after generic_write_checks(),
> as generic_file_direct_write() does.
> 
> Also fix a typo in the comment ("may have" -> "may have competed").
> 
> Fixes: 2b0408d0284f ("fuse: invalidate page cache after DIO and async DIO writes")
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
> ---
>  fs/fuse/file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 45ebd1b15874..d12a9fdf770e 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1789,13 +1789,14 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	struct address_space *mapping = inode->i_mapping;
> -	loff_t pos = iocb->ki_pos;
>  	ssize_t res;
>  	bool exclusive;
>  
>  	fuse_dio_lock(iocb, from, &exclusive);
>  	res = generic_write_checks(iocb, from);
>  	if (res > 0) {
> +		loff_t pos = iocb->ki_pos;
> +
>  		task_io_account_write(res);
>  		if (!is_sync_kiocb(iocb)) {
>  			res = fuse_direct_IO(iocb, from);
> @@ -1810,7 +1811,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			/*
>  			 * As in generic_file_direct_write(), invalidate after
>  			 * write, to invalidate read-ahead cache that may have
> -			 * with the write.
> +			 * competed with the write.
>  			 */
>  			invalidate_inode_pages2_range(mapping,
>  				pos >> PAGE_SHIFT,

Good catch! Looks like there is a missing xfstest scenario.

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
