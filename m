Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E7314A60;
	Tue, 11 Aug 2026 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786427122; cv=none; b=HIc7cRh1HA6AdOcWNMRj6cHEqJ734EhCoLlM1V7BZcS4mv0qhEUe8CiUVXBuh/tsGWaHyTEaKa1eyYo2HcfulyHOH0DhLvcoJmoqPmQ+XIAwVcb/uqPGKgqIE7Qw/42kmTYHQLMBu2J4agWU/uMDNa0c9QssjZ0wSQHexld40C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786427122; c=relaxed/simple;
	bh=gApwxcEJT+ua3+7u87vUY+QX1afexE4Q54wtbLcegLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjYj7/+09v5eH7Co62x62QbKLqt43tMExdTwMqTMAii9xtwTjdnApyvfpfoO1NCWKz5lbyPHOPvB2Oe9zlCra6Lr33iJ2ApQsKHi5uLQMugpBJVkkBErtigzJ0kqmwm63D5Vc7vl5/3eMgK43zgEA7y4vJMsessGVoF2kbKLwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nWKDWAVF; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nWKDWAVF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786427115; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NCjoWImG5pj0UY2MpYpHUiapYC5/l4wYpXTGyxwreVI=;
	b=nWKDWAVF8rRUnuF5HPjVCGJTVwN1uMReTJI0bmnwIvF9QO0W4S36l4iCY0aAOrD8l/jGtVhCKEnUlos4/Jszjtamt/Zr+7kwpt/pB01lyIyokh4oy0YqbxdBZaa6eEOL3MaFhbJhta2vi6fRBAzRHABO7fzmLBJ8b0D6D+Nfiyg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X8nGF.e_1786426791;
Received: from 30.221.148.211(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X8nGF.e_1786426791 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 13:39:52 +0800
Message-ID: <2eddc058-c808-4c30-8a9c-bc29b443d7bb@linux.alibaba.com>
Date: Tue, 11 Aug 2026 13:39:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: reject a duplicate fd= mount option
To: Baokun Li <libaokun@linux.alibaba.com>, fuse-devel@lists.linux.dev
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260811045350.164272-1-libaokun@linux.alibaba.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260811045350.164272-1-libaokun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/11/26 12:53 PM, Baokun Li wrote:
> fuse_opt_fd() stored the fuse device in ctx->fud and bumped its refcount
> unconditionally:
> 
>         ctx->fud = fuse_dev_grab(file);
> 
> If fd= is given twice (two fsconfig FSCONFIG_SET_FD calls), the second
> call overwrites ctx->fud and grabs the new device, while the reference
> taken on the first device is never released - a permanent refcount leak
> that pins the first fuse_dev until reboot.
> 
> Reject a second fd= outright.  ctx is zeroed on allocation, so a non-NULL
> ctx->fud reliably means the option was already processed.
> 
> Fixes: d42eb23b2ef9 ("fuse: don't require /dev/fuse fd to be kept open during mount")
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/fuse/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 455c7feba057..2372e6ed333f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -791,6 +791,9 @@ static int fuse_opt_fd(struct fs_context *fsc, struct file *file)
>  {
>  	struct fuse_fs_context *ctx = fsc->fs_private;
>  
> +	if (ctx->fud)
> +		return invalfc(fsc, "Multiple fd specified");
> +
>  	if (file->f_op != &fuse_dev_operations)
>  		return invalfc(fsc, "fd is not a fuse device");
>  	/*

-- 
Thanks,
Jingbo

