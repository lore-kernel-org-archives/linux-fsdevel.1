Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2333244694;
	Sat,  9 May 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778320843; cv=none; b=sRRnPmME7EwDl3Am3vMhRbNOhi2nhIt4TgCvpiBhsvUMolAacW5kB2iVVB1FlKbQLHlQ1UD8KlsS4f7alWCiF6vbh2VJ9nvxgLz5QWstF2ExspWPBCcImzSEJZgSs191DzkXc38HvqpPTJRxY3PaVtA/R06ZoTAcY0wy7nBBEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778320843; c=relaxed/simple;
	bh=Zg7PyT51QvZx/MMJMbQbjwvdE9GKx2lZd51lEZfhYfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZI+YdhWP9UYQuXLczEs8ox0/X5G18wznKALrt7Sn9ck16IBNHqltzv3KsbZjv9UhwKwnt5gsj53TJd3zott8B1+KTmnE1JrqwSRjTBJLG+wjGwC0cYRX9RGQkrG+0WruPa33rSjRi6O77uFNWMMMHcN/0xzA4H3sE87bK10I3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oAy/f/pm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oAy/f/pm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ZRh4oAt5neiGKdjVZ0x1hG0VKiAh3w9/Tzarfa+c2Gk=;
	b=oAy/f/pmKGorNmlPi5uoF7BLBCcFvMNQT/ka4T4PMap/VmuFaeILvcINxzjMks
	GXNMxSoY9OR8u0LYzLwvx6FUJ1pS5aHooZJIVhb6cKiFBfTpe41G7o5J40c55S7s
	Rjn9hwFpOpAZrH655X5+f8+QXNBxOCVlBvfqs7cJ8b9Bc=
Received: from [10.42.20.201] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAnYiWZBf9pvLMODw--.15082S2;
	Sat, 09 May 2026 17:59:54 +0800 (CST)
Message-ID: <9452723a-0c46-48ae-bbe4-9620923b179e@163.com>
Date: Sat, 9 May 2026 17:59:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] iomap: introduce IOMAP_F_ZERO_TAIL flag
To: Namjae Jeon <linkinjeon@kernel.org>, sj1557.seo@samsung.com,
 yuezhang.mo@sony.com, brauner@kernel.org, djwong@kernel.org, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me,
 chizhiling@kylinos.cn, linux-kernel@vger.kernel.org
References: <20260507124238.7313-1-linkinjeon@kernel.org>
 <20260507124238.7313-6-linkinjeon@kernel.org>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <20260507124238.7313-6-linkinjeon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgAnYiWZBf9pvLMODw--.15082S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1kAw47WF17Wr4kKw45Wrg_yoW5Xw4DpF
	Z3KFWkKFs7tw17uFn7CFy5ZrySywn0gry7Cr1agry5u3WYyr12gr4vgayYvr1rurZ3Cr4a
	vr4vvF95CFy3AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRec_fUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2xrBX2n-BZoijwAA37

On 5/7/26 20:42, Namjae Jeon wrote:
> In filesystems that maintain a separate Valid Data Length, such as exFAT
> and NTFS, a partial write may start at or beyond the current valid_size and
> extend it. In this case, the region after the previous valid_size but
> within the same filesystem block is considered unwritten.
> 
> This patch introduces IOMAP_F_ZERO_TAIL. When this flag is set in iomap,
> __iomap_write_begin() will zero only the tail portion while preserving any
> valid data before it in the same block.
> 
> Without this tail zeroing, stale data in the unwritten portion of the block
> can remain in the page cache. Subsequent reads can then return incorrect
> contents from that region.
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>   fs/iomap/buffered-io.c | 4 ++++
>   include/linux/iomap.h  | 4 ++++
>   2 files changed, 8 insertions(+)


Hi, Namjae

While testing this patch series, I found that generic/299 can cause my 
virtual machine to become unresponsive for a long time. Calling 
balance_dirty_pages_ratelimited in the loop of iomap_zero_iter can 
resolve this issue, so perhaps we need to add this change.

I am continuing to test this patch series, but I'm not sure I will be 
able to find all possible issues :)


thanks,

> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d7b648421a70..9ae136a9fcd4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -837,6 +837,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
>   			folio_zero_segments(folio, poff, from, to, poff + plen);
>   		} else {
>   			int status;
> +			const struct iomap *iomap = iomap_iter_srcmap(iter);
>   
>   			if (iter->flags & IOMAP_NOWAIT)
>   				return -EAGAIN;
> @@ -853,6 +854,9 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
>   						  len, status, GFP_NOFS);
>   			if (status)
>   				return status;
> +
> +			if (iomap->flags & IOMAP_F_ZERO_TAIL)
> +				folio_zero_segment(folio, to, poff + plen);
>   		}
>   		iomap_set_range_uptodate(folio, poff, plen);
>   	} while ((block_start += plen) < block_end);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 2c5685adf3a9..e3e7ad72b29e 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -67,6 +67,9 @@ struct vm_fault;
>    * bio, i.e. set REQ_ATOMIC.
>    *
>    * IOMAP_F_INTEGRITY indicates that the filesystems handles integrity metadata.
> + *
> + * IOMAP_F_ZERO_TAIL indicates only the unwritten tail of the block should be
> + * zeroed.
>    */
>   #define IOMAP_F_NEW		(1U << 0)
>   #define IOMAP_F_DIRTY		(1U << 1)
> @@ -86,6 +89,7 @@ struct vm_fault;
>   #else
>   #define IOMAP_F_INTEGRITY	0
>   #endif /* CONFIG_BLK_DEV_INTEGRITY */
> +#define IOMAP_F_ZERO_TAIL	(1U << 10)
>   
>   /*
>    * Flag reserved for file system specific usage

