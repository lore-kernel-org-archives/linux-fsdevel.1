Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794150184;
	b=REQc2nCAZSiPPuvJ910xq4u1ZON0bAKuy6Tr+nc5iFtFDbG/TH0zfTfJunj57lqcT7/k
	 eIwkFGehjpyDHMpGVcEvZBYyUuYQsZKOiQht8yNs/zQJhCNf0X39RinKkaVx08K8Erz3s
	 BARGg3TP3Y/b/8y/27tz4Uprgq/M4iIY5Oyv3BD0LeT1eojOc5/FG+yVycjxjGQEmRFmN
	 3UFN+jAM2N78dPgMi7A7U40B94EHACd61/1ufhFrkaapg1pOqalokAghi7H/qC9bPLgpo
	 8/vF8cSh7m1z95l5zkqdfR75iz9dZQp6pxs0JvzL4RRd2tRY9xEzM6eUjUGfi6b/eHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150184;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=bZMDDSEbstrrBxqro/V4y0hp97EWTM7ZBohHqqfsHp4=;
	b=WY+IfhfIvl9JRJkEBCZKh8UoF24HF5LGda9+/ooQ+Gruk3DV2+ou8Rxo88d4fDexB11k
	 iJeGJeMgk4RTZZblpPtcSZuZzfufqCdu0N4bXXvgwHDcvt1wnfN6X5F2N/d1LHGPWTEKV
	 WEP7yBBbcZna1uxd8nxOlr6TkWZ9x07Q4Kiw58uDtXJfxo1Q4L34cPedI5HNUkZPL+duO
	 7cN0awmoQ4gf9nnw7+w7T5RBFVC69nEtQNqEvFHMtzV3ZSq1i19zLeWcXFYI49klWjT9M
	 uHO3LeSHQkscq+NE0PxFHAfCZ1AqZVXXcbf8JK/L7ivR214fboVu0WDP2B7r9kX9zTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b="HL7zu/AH";
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=Qo1vOSPm;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CC606A31C;
	Sun,  8 Nov 2026 15:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 045CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=HL7zu/AH;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=Qo1vOSPm
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 4A03320BD289;
	Mon,  9 Nov 2026 00:03:01 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1794150181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bZMDDSEbstrrBxqro/V4y0hp97EWTM7ZBohHqqfsHp4=;
	b=HL7zu/AHW2aD8+DnmDe1Fdquyt3x44oI+n93C8etOO3SojOm3S6b7xABPNMK5Vgt2Hrerz
	Y56eyo0U44Hd1td/X72LxOyeT8Rmaq7lEHqz6juziNlKhowEpgKYYgWDWzAmklJvno1xW/
	gjHd13/icumay+zlHPqjEWcCmPyYKFu0VzOvpsGkW/b1YCNfKOga2Y/B5hwgd+Cxke1Gq0
	AUVy/JsylG+QzBJk2CbJtqVyPCiE5FCHsu974y9Whm4JLYSMV33BUa7eGWiHi4qoBgtUMy
	x06q25r/E9iOzaRa718Oy9Wrywi773Xr3ePgb/eKO/0+zM5aVxhcFDy9TT1ceA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1794150181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bZMDDSEbstrrBxqro/V4y0hp97EWTM7ZBohHqqfsHp4=;
	b=Qo1vOSPmVSOdSF4SJHPf5ZLb0+Mf+uxHy0TNYX4vv4FOEeLlPYaw8e1XWnqovvOgWrt1AK
	2SAzp68ieCit2sCA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id CB45AE001A6;
	Mon, 09 Nov 2026 00:03:00 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id B8B7622001DF; Mon, 09 Nov 2026 00:03:00 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,  djwong@kernel.org,
  hch@lst.de,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/8] fat: add iomap buffered I/O support
In-Reply-To: <20261031164326.278125-7-matheus.aalmeida@inf.ufrgs.br>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
	<20261031164326.278125-7-matheus.aalmeida@inf.ufrgs.br>
Date: Mon, 09 Nov 2026 00:03:00 +0900
Message-ID: <87a4njtlgb.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> Use iomap for buffered I/O, replacing buffer_heads. Remove
> fat_get_block(), fat_write_begin(), fat_write_failed() as the iomap path
> makes them unnecessary.
>
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>  fs/fat/fat.h   |   4 +-
>  fs/fat/file.c  |  72 +++++++++++++++++++----
>  fs/fat/inode.c | 157 +++++--------------------------------------------
>  fs/fat/iomap.c |  84 ++++++++++++++++++++++++++
>  4 files changed, 164 insertions(+), 153 deletions(-)
>

[...]

> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 8689cbbdad13..723b671d5b4b 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c

[...]

> +static int fat_cont_expand(struct inode *inode, loff_t new_size);
> +
> +static ssize_t fat_file_write_iter_buffered(struct kiocb *iocb,
> +					    struct iov_iter *iter)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
> +	loff_t offset, old_size, old_alloc, keep_alloc;
> +	ssize_t ret;
> +
> +	inode_lock(inode);
> +	ret = generic_write_checks(iocb, iter);
> +	if (ret <= 0)
> +		goto out;
> +
> +	ret = file_modified(iocb->ki_filp);
> +	if (ret)
> +		goto out;
> +
> +	offset = iocb->ki_pos;
> +	old_size = i_size_read(inode);
> +	if (offset > old_size) {
> +		/* We need to fill this hole */
> +		ret = fat_cont_expand(inode, offset);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	inode_dio_wait(inode);
> +	old_alloc = inode_get_bytes(inode);
> +	ret = iomap_file_buffered_write(iocb, iter, &fat_iomap_write_ops,
> +					NULL, NULL);
> +	keep_alloc = max(old_alloc, round_up(i_size_read(inode),
> +					     sbi->cluster_size));
> +	if (inode_get_bytes(inode) > keep_alloc)
> +		fat_truncate_blocks(inode, keep_alloc);

What is doing by this fat_truncate_blocks?

> +	if (ret > 0)
> +		ret = generic_write_sync(iocb, ret);

Maybe we want to do this outside inode_unlock()?

> +out:
> +	inode_unlock(inode);
> +	return ret;
> +}
> +

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
