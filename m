Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BE43B9933
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870528; cv=none; b=I/v8oM2Dr4J7Sy/eeMAvvamAsNd9gLkWhSjczd86OJSVcLYnhYVnlitgnuHzEtfrCGh62yMWVGYcR2CAKWyqLCsDBWkxIMVFFxaSflpBz7YPesYnZN2e8LeXs4LeTUb0ibjwWv2g0nEcO/5tGvpalOLmQNNyo6xz4KU25h4zF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870528; c=relaxed/simple;
	bh=biUuqa6zZHkHgYG38Bmz54ce3FPSro8XA/9nNBq52PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpDUezIjRKp8rR7leE8xfl8abk0O2c+wDQ0m8SjFTyUlfd8nA9bRlX+t7ySUaEAaXaUWqRfbfFwCGflAIa+wVvTkEvJlbFMPyKSb8q3i4b6NV56LQdGqGIIriWDSLsriIGrj3XwCJt+B5s+kFZ0eXVnSMT+IcCbjQ+7/yMmPkaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZChWmF38; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZChWmF38"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779870523; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aDTiceTkc6A+YbV9dkL3LhOQFyFRx2IcfSB9xG53D7A=;
	b=ZChWmF38xU8T9JcwKKbWF2GvxEz1pV2IiIKf6x7uudYA44hkMeWkSa84zfep7k7mP1YBF7uIc1Hr7lpPBUcAYHfKf1JJp3MJAk8+L6jNjCQkHLAUDoKijXnym4VAnfhgt3QOw102YgQE5ndqTWycQ313Z9CVcOs1J+BHv2TuI3U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X3j8PPC_1779870521;
Received: from 30.221.147.201(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3j8PPC_1779870521 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 16:28:42 +0800
Message-ID: <276f3e66-967c-4c91-bb0d-94fe8dee3e57@linux.alibaba.com>
Date: Wed, 27 May 2026 16:28:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] fuse: support buffer copying for kernel
 addresses
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-7-joannelkoong@gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260402162840.2989717-7-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/4/3 00:28, Joanne Koong wrote:
> This is a preparatory patch needed to support pinned buffers in
> fuse-over-io-uring. For pinned buffers, we get the vmapped address of
> the buffer, which we can directly use with memcpy.
>
> Currently, buffer copying in fuse only supports extracting underlying
> pages from an iov iter and kmapping them. This commit allows buffer
> copying to work directly on a kaddr.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

Looks good to me.

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>

> ---
>  fs/fuse/dev.c        | 23 +++++++++++++++++++----
>  fs/fuse/fuse_dev_i.h |  7 ++++++-
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 0b0241f47170..a87939eaa103 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -848,6 +848,9 @@ void fuse_copy_init(struct fuse_copy_state *cs, bool write,
>  /* Unmap and put previous page of userspace buffer */
>  void fuse_copy_finish(struct fuse_copy_state *cs)
>  {
> +	if (cs->is_kaddr)
> +		return;
> +
>  	if (cs->currbuf) {
>  		struct pipe_buffer *buf = cs->currbuf;
>  
> @@ -873,6 +876,12 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>  	struct page *page;
>  	int err;
>  
> +	if (cs->is_kaddr) {
> +		if (!cs->len)
> +			return -ENOBUFS;
> +		return 0;
> +	}
> +
>  	err = unlock_request(cs->req);
>  	if (err)
>  		return err;
> @@ -931,15 +940,21 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
>  {
>  	unsigned ncpy = min(*size, cs->len);
>  	if (val) {
> -		void *pgaddr = kmap_local_page(cs->pg);
> -		void *buf = pgaddr + cs->offset;
> +		void *pgaddr, *buf;
> +
> +		if (!cs->is_kaddr) {
> +			pgaddr = kmap_local_page(cs->pg);
> +			buf = pgaddr + cs->offset;
> +		} else {
> +			buf = cs->kaddr + cs->offset;
> +		}
>  
>  		if (cs->write)
>  			memcpy(buf, *val, ncpy);
>  		else
>  			memcpy(*val, buf, ncpy);
> -
> -		kunmap_local(pgaddr);
> +		if (!cs->is_kaddr)
> +			kunmap_local(pgaddr);
>  		*val += ncpy;
>  	}
>  	*size -= ncpy;
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 134bf44aff0d..aa1d25421054 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -28,12 +28,17 @@ struct fuse_copy_state {
>  	struct pipe_buffer *currbuf;
>  	struct pipe_inode_info *pipe;
>  	unsigned long nr_segs;
> -	struct page *pg;
> +	union {
> +		struct page *pg;
> +		void *kaddr;
> +	};
>  	unsigned int len;
>  	unsigned int offset;
>  	bool write:1;
>  	bool move_folios:1;
>  	bool is_uring:1;
> +	/* if set, use kaddr; otherwise use pg */
> +	bool is_kaddr:1;
>  	struct {
>  		unsigned int copied_sz; /* copied size into the user buffer */
>  	} ring;


