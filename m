Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039A3C8700
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868555; cv=none; b=cg7kXWWwyT64DVXyclIYnI/LvEUdW9WBTGp08lGnnl28f02KcdXxs9huNxWDpCY6hTChL1v1AgGlDZg/r+uq76C0l6pEoXB6IepCnOdwvW34FCldij2VTvhU6Cw9iJN53RgFyl1TzNoCgaCRw9RHcLToim4MkPlyiAM7Ic8rW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868555; c=relaxed/simple;
	bh=w4WfosLyVbJdqYfqEzDgTa0lYsp7c/L3NCVd/6nd49Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BY3gFOUmZCgoEb8zHC7KcG3ZiUIgGvK9as2IDs3jisO636qQOaDV/pkMgc47TO7QEeO3lBnQj+CfeHrUxMdu+jj5vQeMaFOevQsWnAJnpRDHM+lPEowek7AnSgpc6YMOO0iEFGT+ymdIWb1cLGBC9HDJHTgRIxf39Z1LSnOl+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=doTeVJ+D; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="doTeVJ+D"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779868550; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gTBBni9aV/QOuahpKAd5uzf42qMdGzGn9rFk2bav5M4=;
	b=doTeVJ+Dt7kha3ryOiVgUQUvIH+CPGiqmffU819/YDGq7XB9bWVkjmj4Narao7fm0iI1YQFKbMBzU/69ENoMUmLQUVKxs5rRh4hbYSl+bWeBgCYyjXf5f741nR3YdKhNiyqOzo10sNPlMl1UyemT7aSZ1wDFB86apnAjZT3QAYU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3ipDKP_1779868549;
Received: from 30.221.145.39(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X3ipDKP_1779868549 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 15:55:50 +0800
Message-ID: <961fd3dc-ebd3-454e-85e7-6dff5f45a064@linux.alibaba.com>
Date: Wed, 27 May 2026 15:55:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/34] ocfs2: Convert ocfs2_write_super_or_backup to
 bh_submit()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 ocfs2-devel@lists.linux.dev
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-22-willy@infradead.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20260525171931.4144395-22-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/26/26 1:19 AM, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call by using bh_submit() instead of
> submit_bh().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: ocfs2-devel@lists.linux.dev

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/buffer_head_io.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index 4d3f03f99a8a..5894ab511b58 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -443,10 +443,9 @@ int ocfs2_write_super_or_backup(struct ocfs2_super *osb,
>  	/* remove from dirty list before I/O. */
>  	clear_buffer_dirty(bh);
>  
> -	get_bh(bh); /* for end_buffer_write_sync() */
> -	bh->b_end_io = end_buffer_write_sync;
> +	get_bh(bh); /* for bh_end_write() */
>  	ocfs2_compute_meta_ecc(osb->sb, bh->b_data, &di->i_check);
> -	submit_bh(REQ_OP_WRITE, bh);
> +	bh_submit(bh, REQ_OP_WRITE, bh_end_write);
>  
>  	wait_on_buffer(bh);
>  

