Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D813CF96B
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868806; cv=none; b=A9cIRC8JBnBSYFvTB6E46iBr0uzrciSY4fmRxTS/LXYtn76n5qWp0fggLjIKdM1OTVHMDE6DP2nT4fvnF/uvg57KXZQ03QyBYZAzmWkxFYXcvmWrFMjZdHo17NzX9yhHbRt+FozXuaGfriW9Wz9S64FMQxHdJhOP8ZVMZI46ILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868806; c=relaxed/simple;
	bh=r2CdmUt9vJ3JA0P9UYyJVR8Tg4yVwtbWnTHJijeji78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8IMeefYZ4uFT4gKcgfwtM4LVoSUB1oQCG95hEqjZw3qt+PSCvezS5PYggYyZLU/Qrd/fHrVU9h5+Jw56RyPsIseXmXLiI58DJLlGrXfhIrYWXPpYXo/dH8qeml2Nl1lcfmTMg9pQmHK1Xcxay/3y2IpY3rBqkw1yeiqw99OhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k+fmdUHD; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k+fmdUHD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779868793; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iTiY0JNHNI2uJ32QpCQH8YLgznwGyDMe0eHrOf1pmO0=;
	b=k+fmdUHDCMsxDSuczFQuLMB0aGmypBj+1JJMU/EePYMZQrHR6479Zt8tjUoftFEDPmdRHKslzOO0pqvYz5V2uD6t+8+/2olCEx68eRD92BJoJSZDjDSvCgtrFLboHpnpTwaS80yFjP+DhclPd42wNEs6eaevWQHyuQZ+k1CQ2Gw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3ioSmd_1779868481;
Received: from 30.221.145.39(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X3ioSmd_1779868481 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 15:54:41 +0800
Message-ID: <3164f091-7777-4144-a18a-023478ff9f8a@linux.alibaba.com>
Date: Wed, 27 May 2026 15:54:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/34] ocfs2: Convert ocfs2_write_block to bh_submit()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 ocfs2-devel@lists.linux.dev
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-19-willy@infradead.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20260525171931.4144395-19-willy@infradead.org>
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
> index 701d27d908d4..3e42ca700db0 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -62,9 +62,8 @@ int ocfs2_write_block(struct ocfs2_super *osb, struct buffer_head *bh,
>  	/* remove from dirty list before I/O. */
>  	clear_buffer_dirty(bh);
>  
> -	get_bh(bh); /* for end_buffer_write_sync() */
> -	bh->b_end_io = end_buffer_write_sync;
> -	submit_bh(REQ_OP_WRITE, bh);
> +	get_bh(bh); /* for bh_end_write() */
> +	bh_submit(bh, REQ_OP_WRITE, bh_end_write);
>  
>  	wait_on_buffer(bh);
>  

