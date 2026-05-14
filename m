Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630430DEB0;
	Thu, 14 May 2026 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722792; cv=none; b=AdhTmQ8jDJuKfZ4p8HyeNO2DHyAgydqmdA2FJMptwyZ+HB14So7dL375rrxtUtJiopvq5BZUEY7gDTCtpED6/iEQu4hUtSymXjZZoOGaHv1dScyohLOWw5WlPPnBhXgCWByBV2RmqUEp9VcC2+GnBs/tNInGeM6saw/1jojya4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722792; c=relaxed/simple;
	bh=n/SuGtXDAksDz1i+mRBzi4UfB58RtfAyuAHLLeVePPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNALe8ZrJkqXiW31EYidIccF3VC/JvEFeX4jsxKT9Lt/Bzt805m00EpD7xnmcaRYJzijJnQBjKMWvqbolgxOvei5cF5D+d13QfLZv0gn/GvHFjVRAdsvXTTKquknVgw7lpfxNGPon+aCxIJPpwx+oGzj27p7VnN1mMd+4aNK4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mope1RZU; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mope1RZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=g82PADP2zDcuVVEGOU18YPkJsm7ZjDaI7v6K0FO8kHQ=;
	b=Mope1RZUaDIU19pHxe8B+eUTENItBeLA3pThfxKHB9zhBq+GOqz0v+2IDGrGDk
	ZFmYaMoGKpMdTmsgQFu1GvEkfl7sVWIQlT7ELgK80PFwRWL7BtxriFZXlsRAU/pJ
	dwtOtxbUVloAjS/3PZmlsd4AApKM6sEQUb+g5+xnfBjW4=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3X4W5JwVqeOzKBA--.25494S2;
	Thu, 14 May 2026 09:39:06 +0800 (CST)
Message-ID: <67ea38e7-ec7f-4ade-8962-074c60a45321@163.com>
Date: Thu, 14 May 2026 09:39:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] exfat: add iomap buffered I/O support
To: Namjae Jeon <linkinjeon@kernel.org>, sj1557.seo@samsung.com,
 yuezhang.mo@sony.com, brauner@kernel.org, djwong@kernel.org, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me,
 chizhiling@kylinos.cn, linux-kernel@vger.kernel.org
References: <20260513112156.9122-1-linkinjeon@kernel.org>
 <20260513112156.9122-9-linkinjeon@kernel.org>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <20260513112156.9122-9-linkinjeon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3X4W5JwVqeOzKBA--.25494S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1DKw17Zw4xWFW7XryxKrg_yoW5Gw1Dpr
	4qg3W3GFW3Jr1UXr48Jr98ZFySkw1DKF12qw1kWry5GF97tw18K3WDCa4Y9wnrWwnrZr4a
	qwn5Kw47u3s7Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRec_fUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BvTcWoFJ7uXDwAA3q

On 5/13/26 19:21, Namjae Jeon wrote:
> +static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +		unsigned int flags, struct iomap *iomap, bool may_alloc)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct exfat_inode_info *ei = EXFAT_I(inode);
> +	unsigned int cluster, num_clusters;
> +	loff_t cluster_offset, cluster_length;
> +	int err;
> +	bool balloc = false;
> +
> +	if (!may_alloc) {
> +		/* Completely beyond EOF. Treat as hole */
> +		if (i_size_read(inode) <= offset) {
> +			iomap->type = IOMAP_HOLE;
> +			iomap->addr = IOMAP_NULL_ADDR;
> +			iomap->offset = offset;
> +			iomap->length = length;
> +			return 0;
> +		}
> +
> +		/* Clamp length if the requested range goes beyond i_size */
> +		if (offset + length > i_size_read(inode))
> +			length = round_up(i_size_read(inode),
> +					  i_blocksize(inode)) - offset;
> +	}
> +
> +	num_clusters = exfat_bytes_to_cluster_round_up(sbi,
> +			offset + length) - exfat_bytes_to_cluster(sbi, offset);
> +
> +	mutex_lock(&sbi->s_lock);
> +	iomap->bdev = inode->i_sb->s_bdev;
> +	iomap->offset = offset;
> +
> +	err = exfat_map_cluster(inode, exfat_bytes_to_cluster(sbi, offset),
> +			&cluster, &num_clusters, may_alloc, &balloc);
> +	if (err)
> +		goto out;
> +
> +	cluster_offset = exfat_cluster_offset(sbi, offset);
> +	cluster_length = exfat_cluster_to_bytes(sbi, num_clusters);
> +
> +	iomap->length = min_t(loff_t, length, cluster_length - cluster_offset);
> +	iomap->addr = exfat_cluster_to_phys(sbi, cluster) + cluster_offset;
> +	iomap->type = IOMAP_MAPPED;
> +	if (may_alloc) {
> +		if (balloc)
> +			iomap->flags = IOMAP_F_NEW;
> +		else if (iomap->offset + iomap->length >= ei->valid_size) {
> +			/*
> +			 * This is a write that starts at or extends beyond
> +			 * the current valid_size. The region between the old
> +			 * valid_size and the end of this write needs to be
> +			 * zeroed in the page cache to prevent stale data
> +			 * exposure (see IOMAP_F_ZERO_TAIL handling in
> +			 * __iomap_write_begin()).
> +			 */
> +			iomap->flags = IOMAP_F_ZERO_TAIL;
> +		}
> +	} else {
> +		if (offset >= ei->valid_size)
> +			iomap->type = IOMAP_UNWRITTEN;
> +
> +		if (iomap->type == IOMAP_MAPPED &&
> +		    iomap->offset < ei->valid_size &&
> +		    iomap->offset + iomap->length > ei->valid_size) {
> +			iomap->length = round_up(ei->valid_size,
> +						 i_blocksize(inode)) -
> +							iomap->offset;
> +		}

Hi, you can write it like this:

if (offset >= ei->valid_size) {
	iomap->type = IOMAP_UNWRITTEN;
} else if (offset + iomap->length > ei->valid_size) {
	iomap->length = round_up(ei->valid_size,
				 i_blocksize(inode)) -
					iomap->offset;
}

Thanks,


