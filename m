Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97634435538
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619394; cv=none; b=IrmY4i4LK29KzRhaxUNNL31tNnMPsHy6AJOKNa04VhXobnD1Q3cTHWxDFlYJBCVSo9WdIxKaWV9H7LKXjuSe3ZxHSC/oMG9e14X3Sv7CNj0pY2/LG+VZpChhTfsB6g6xDfrWG+AJvBge6Fg0Qm/mdqcF/+lc4s79Vj7uhixYla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619394; c=relaxed/simple;
	bh=F+zIuYMLZHPKpAkyM+TxujFov3y0nB+zLLs3dxYlli8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCy02GbvkwOv1wwVP3do5Geydlvv76KlzOkXyWMcy81iY6aXp7UhAzk2n50Y77E7cmi77p8jEBrKnxU6HoykNKsmQB3RhzlaZek5NKX2U4vqZDzIWMAUDZwfuXrMckGBnNfCFTwpjJFUSQmVsFKjNQz4OGOsAXJ6jmU3d7+f34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fa3uiP/Y; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fa3uiP/Y"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784619388; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XDf6InHoRj8TLJnw9Ijddc+FH8m20sSC2mTiocxxWy8=;
	b=Fa3uiP/YJuwL2mQ5DhutghGzNjoxR2WA6nPrsqXb1nol0Nn7FQtmqG9IhgZU872XAfc7BW4RNnV9SyYnzlDaxo4ecbxjnKwvAcZD+zx/45WpCs/O+9mzXa1rrt2vR+/VwaX5iGictjscmoD0u1OnKixlsQACVoco5fHXnLJKjls=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0X7Z7ZTu_1784619385;
Received: from 30.221.131.234(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X7Z7ZTu_1784619385 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Jul 2026 15:36:26 +0800
Message-ID: <8c57e813-f23d-4947-a1d4-9b29d5ccd3a7@linux.alibaba.com>
Date: Tue, 21 Jul 2026 15:36:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/20] ext4: convert iomap ops to ->iomap_next()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de,
 "Darrick J . Wong" <djwong@kernel.org>,
 Christian Brauner <brauner@kernel.org>, changfengnan@bytedance.com,
 kbusch@kernel.org, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
 David Sterba <dsterba@suse.com>, Dan Williams <djbw@kernel.org>,
 Gao Xiang <xiang@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Andreas Gruenbacher
 <agruenba@redhat.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 Hyunchul Lee <hyc.lee@gmail.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
 <20260720210202.1163861-9-joannelkoong@gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260720210202.1163861-9-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/7/21 05:01, Joanne Koong wrote:
> Convert ext4 iomap_ops to the new ->iomap_next() callback. Each callback is
> generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
> iomap_iter_next() helper to finish the previous mapping if needed and
> produce the next one. No functional changes are intended.
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks good to me.

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>

> ---
>  fs/ext4/extents.c | 4 +++-
>  fs/ext4/inode.c   | 8 ++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 91c97af64b31..15972410d460 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5171,8 +5171,10 @@ static int ext4_iomap_xattr_begin(struct inode *inode, loff_t offset,
>  	return error;
>  }
>  
> +static DEFINE_IOMAP_ITER_NEXT(ext4_iomap_xattr_next, ext4_iomap_xattr_begin);
> +
>  static const struct iomap_ops ext4_iomap_xattr_ops = {
> -	.iomap_begin		= ext4_iomap_xattr_begin,
> +	.iomap_next		= ext4_iomap_xattr_next,
>  };
>  
>  static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ce99807c5f5b..278a032b300c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3850,8 +3850,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	return 0;
>  }
>  
> +static DEFINE_IOMAP_ITER_NEXT(ext4_iomap_next, ext4_iomap_begin);
> +
>  const struct iomap_ops ext4_iomap_ops = {
> -	.iomap_begin		= ext4_iomap_begin,
> +	.iomap_next		= ext4_iomap_next,
>  };
>  
>  static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> @@ -3905,8 +3907,10 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>  	return 0;
>  }
>  
> +static DEFINE_IOMAP_ITER_NEXT(ext4_iomap_next_report, ext4_iomap_begin_report);
> +
>  const struct iomap_ops ext4_iomap_report_ops = {
> -	.iomap_begin = ext4_iomap_begin_report,
> +	.iomap_next = ext4_iomap_next_report,
>  };
>  
>  /*


