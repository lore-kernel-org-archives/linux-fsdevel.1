Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663473932C0;
	Thu, 16 Apr 2026 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329840; cv=none; b=FlSA4pfhlyFBtW1VGuOjLfHhT+IBpjHJcmFgQPpz7MDUnrXFOwu/0oyjG7XVNjzMRTaXBID6F1TjwnLaz+LDVtzVt4TImRMzOhDWkrMsWbABiE2mtgcY6rL4RvuifrIYu2fFtJuQ1+5oYCH9uvKpWi/7ny5CoBcBTobots8KIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329840; c=relaxed/simple;
	bh=KPlintH39o5zXOXkHnT1JmNsubNzdY1a+n1+17/DxAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMvXzsDvehJdiXhKzDUjSN/IxP1/4OKgW17+GYzaTOOHCJaH2+5rdbAKGaCXJ6bV99FfXHs/u9aOcjhoDfXANYMVNDr6E36zi8S5XxC80+I6nZeohC7us3UAm4WMcBQN3Q2i0yVdcq9XOeB2hh5OZBmEw1O6Ge/Z8vYaRUWmzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=arBigrlo; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="arBigrlo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776329828; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=u6ftKaP0vvumVy/DmiEK/Hx7+US3gXqnpPP0+2ugMW8=;
	b=arBigrlo9kbYNPOKpL6y8LGv5npsYoFItVXxjw8gfgFDoZGIGltBVQshN4h1VUZz3CEAAZuQmvI7tAPdOUeA3uudiT66yAGxBNGhL4lm7o7A7jzelGKDHXfJgCJ68BLRr+cDMB08pLYSwwMWXKh2mx33To5xLEBbJQivj36kBcg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X17veO4_1776329827;
Received: from 30.221.148.0(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X17veO4_1776329827 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Apr 2026 16:57:08 +0800
Message-ID: <bb880e0c-82f0-49f0-828b-00678a012568@linux.alibaba.com>
Date: Thu, 16 Apr 2026 16:57:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: invalidate page cache after sync and async
 direct writes
To: cding@ddn.com, Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260309-xfstests-generic-451-v3-1-bb6ad2f59512@ddn.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260309-xfstests-generic-451-v3-1-bb6ad2f59512@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos,

I guess this fix gets missed?

Thanks,
Jingbo


On 3/9/26 4:35 PM, Cheng Ding via B4 Relay wrote:
> From: Cheng Ding <cding@ddn.com>
> 
> Fixes xfstests generic/451, similar to how commit b359af8275a9 ("fuse:
> Invalidate the page cache after FOPEN_DIRECT_IO write") fixes xfstests
> generic/209.
> 
> Signed-off-by: Cheng Ding <cding@ddn.com>
> ---
> Changes in v3:
> - Address review comments: fix typo
> - Address review comments: move sb_init_dio_done_wq() to fuse_direct_IO()
>   Note: We could skip sb_init_dio_done_wq() when io->blocking is true, but
>   I opted to keep the change simpler.
> - Link to v2: https://lore.kernel.org/r/20260306-xfstests-generic-451-v2-1-93b2d540304b@ddn.com
> 
> Changes in v2:
> - Address review comments: move invalidation from fuse_direct_io() to
>   fuse_direct_write_iter()
> - Link to v1: https://lore.kernel.org/r/20260303-async-dio-aio-cache-invalidation-v1-1-fba0fd0426c3@ddn.com
> ---
>  fs/fuse/file.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++-----------
>  fs/fuse/fuse_i.h |  1 +
>  2 files changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index b1bb7153cb78..c43fe74cdd46 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -23,6 +23,8 @@
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/iomap.h>
>  
> +int sb_init_dio_done_wq(struct super_block *sb);
> +
>  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
>  			  unsigned int open_flags, int opcode,
>  			  struct fuse_open_out *outargp)
> @@ -629,6 +631,19 @@ static ssize_t fuse_get_res_by_io(struct fuse_io_priv *io)
>  	return io->bytes < 0 ? io->size : io->bytes;
>  }
>  
> +static void fuse_aio_invalidate_worker(struct work_struct *work)
> +{
> +	struct fuse_io_priv *io = container_of(work, struct fuse_io_priv, work);
> +	struct address_space *mapping = io->iocb->ki_filp->f_mapping;
> +	ssize_t res = fuse_get_res_by_io(io);
> +	pgoff_t start = io->offset >> PAGE_SHIFT;
> +	pgoff_t end = (io->offset + res - 1) >> PAGE_SHIFT;
> +
> +	invalidate_inode_pages2_range(mapping, start, end);
> +	io->iocb->ki_complete(io->iocb, res);
> +	kref_put(&io->refcnt, fuse_io_release);
> +}
> +
>  /*
>   * In case of short read, the caller sets 'pos' to the position of
>   * actual end of fuse request in IO request. Otherwise, if bytes_requested
> @@ -661,10 +676,11 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
>  	spin_unlock(&io->lock);
>  
>  	if (!left && !io->blocking) {
> +		struct inode *inode = file_inode(io->iocb->ki_filp);
> +		struct address_space *mapping = io->iocb->ki_filp->f_mapping;
>  		ssize_t res = fuse_get_res_by_io(io);
>  
>  		if (res >= 0) {
> -			struct inode *inode = file_inode(io->iocb->ki_filp);
>  			struct fuse_conn *fc = get_fuse_conn(inode);
>  			struct fuse_inode *fi = get_fuse_inode(inode);
>  
> @@ -673,6 +689,17 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
>  			spin_unlock(&fi->lock);
>  		}
>  
> +		if (io->write && res > 0 && mapping->nrpages) {
> +			/*
> +			 * As in generic_file_direct_write(), invalidate after the
> +			 * write, to invalidate read-ahead cache that may have competed
> +			 * with the write.
> +			 */
> +			INIT_WORK(&io->work, fuse_aio_invalidate_worker);
> +			queue_work(inode->i_sb->s_dio_done_wq, &io->work);
> +			return;
> +		}
> +
>  		io->iocb->ki_complete(io->iocb, res);
>  	}
>  
> @@ -1738,15 +1765,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>  	if (res > 0)
>  		*ppos = pos;
>  
> -	if (res > 0 && write && fopen_direct_io) {
> -		/*
> -		 * As in generic_file_direct_write(), invalidate after the
> -		 * write, to invalidate read-ahead cache that may have competed
> -		 * with the write.
> -		 */
> -		invalidate_inode_pages2_range(mapping, idx_from, idx_to);
> -	}
> -
>  	return res > 0 ? res : err;
>  }
>  EXPORT_SYMBOL_GPL(fuse_direct_io);
> @@ -1785,6 +1803,8 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct address_space *mapping = inode->i_mapping;
> +	loff_t pos = iocb->ki_pos;
>  	ssize_t res;
>  	bool exclusive;
>  
> @@ -1801,6 +1821,16 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  					     FUSE_DIO_WRITE);
>  			fuse_write_update_attr(inode, iocb->ki_pos, res);
>  		}
> +		if (res > 0 && mapping->nrpages) {
> +			/*
> +			 * As in generic_file_direct_write(), invalidate after
> +			 * write, to invalidate read-ahead cache that may have
> +			 * with the write.
> +			 */
> +			invalidate_inode_pages2_range(mapping,
> +				pos >> PAGE_SHIFT,
> +				(pos + res - 1) >> PAGE_SHIFT);
> +		}
>  	}
>  	fuse_dio_unlock(iocb, exclusive);
>  
> @@ -2826,6 +2856,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	size_t count = iov_iter_count(iter), shortened = 0;
>  	loff_t offset = iocb->ki_pos;
>  	struct fuse_io_priv *io;
> +	bool async = ff->fm->fc->async_dio;
>  
>  	pos = offset;
>  	inode = file->f_mapping->host;
> @@ -2834,6 +2865,12 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	if ((iov_iter_rw(iter) == READ) && (offset >= i_size))
>  		return 0;
>  
> +	if ((iov_iter_rw(iter) == WRITE) && async && !inode->i_sb->s_dio_done_wq) {
> +		ret = sb_init_dio_done_wq(inode->i_sb);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	io = kmalloc_obj(struct fuse_io_priv);
>  	if (!io)
>  		return -ENOMEM;
> @@ -2849,7 +2886,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	 * By default, we want to optimize all I/Os with async request
>  	 * submission to the client filesystem if supported.
>  	 */
> -	io->async = ff->fm->fc->async_dio;
> +	io->async = async;
>  	io->iocb = iocb;
>  	io->blocking = is_sync_kiocb(iocb);
>  
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d1..6e8c8cf6b2c8 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -377,6 +377,7 @@ union fuse_file_args {
>  /** The request IO state (for asynchronous processing) */
>  struct fuse_io_priv {
>  	struct kref refcnt;
> +	struct work_struct work;
>  	int async;
>  	spinlock_t lock;
>  	unsigned reqs;
> 
> ---
> base-commit: 3c9332f821aa11552f19c331c5aa5299c78c7c94
> change-id: 20260306-xfstests-generic-451-fed0f9d5a095
> 
> Best regards,

-- 
Thanks,
Jingbo

