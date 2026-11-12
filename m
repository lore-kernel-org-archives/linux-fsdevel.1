Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460006;
	b=Zx8NCfpfFf/8K0RlphQFufdFnTa+N6zvxF4StPwDU2AqvTMyL+VAyxq71iwehIlk84+m
	 Gms59pFxCdhk90rYYW5I2FoxH8l1gEawpmLlmEbDzfi1CMhkKrbooJJX+rjQQXtLg1XMw
	 nco2pA74KFwl1/bsZAFLS21O68KyvaYgAa51lbT77X3X9PGvSWoyanLiJgLAuQtHbZRwL
	 cmUpJPiy239uCRySHFrW1PlqBkECoj526+5URMy1R99HDJI7YhAYODjUlNgNjT8IewlyY
	 YGApQXFXb4bXA2qGqYSJjz1VH4pWT183RvygYu5ayM/qTKt16stq4TOCxjyP64x5bmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460006;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=JVborQqwXwIUslERK/Ta6eT/yh6s8Zzf2MSzCCpOFA8=;
	b=R0CgG6fX5/CrfeEK/GnRdXbZ66aEQmesSMJAEtbUJbEtg6oYf9L/AbNdBfCyHsPsTKZY
	 kokMDt7bmcZs5KqOEZ7EvwIIK1OBoxBi1dTcWufkir0qEW8USF65bOr2HNrU68e47OiJG
	 QDldtIomY9cv/srOckLTualfUu4KLDSwgCresHT7qRMubqGpopVo8W+2UpDYUQ+05dim3
	 mTU7F5ZFjgP8G+P+8D4mhqtEx+4BaERVWchBvBa6XoHhuwxjCbORrFsbQPDEBVfKc5mkD
	 IVs88Dr1NDjpjvF83fOzmRpQK72ffdZ++JP/NB002zUHqMPlSi2kcIIxyX12F5H2EUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=0hRlVvHU;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=V7DJTkFO;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA617606A321;
	Thu, 12 Nov 2026 05:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA617606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=0hRlVvHU;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=V7DJTkFO
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 4C68A20BD28D;
	Thu, 12 Nov 2026 14:06:44 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1794460004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVborQqwXwIUslERK/Ta6eT/yh6s8Zzf2MSzCCpOFA8=;
	b=0hRlVvHUiZQ4F2/PC3gSN9Vuc9DftjijTqqz0qFI6Wx6C/OH9vYN19CYowha5Ubbwrp92m
	Vk6CHDz4/3mgxzJFlLozDvF+Yw/QWgZcQh/zdlF+/E+/sswCw2otf8uG0SKUeNrubylZRJ
	Q5IoAFRqd8BbNvNycPyBfr8Epf0XKLrHM5I6eRBGE5De5qYEEClnaPabAKoTH/o386tB0p
	epXWbIkMnjkF/qAa77CqdeVMtDuTw1NpNcBdwtQrLJik5WtD/IBIiblaJgCWfmuBT9LoUI
	vuo65KuaiGkgbt3AWI5g0edTyMuEJTqzZg6T+liS3bX3PrBzmN0SSXc5AOHhqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1794460004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVborQqwXwIUslERK/Ta6eT/yh6s8Zzf2MSzCCpOFA8=;
	b=V7DJTkFO+FJ7Om6Uq44SkMGU2b3lypudJVFijWqcLEEwFrp69BUaLSxyg+axpWY9LctqhZ
	d3GjZwvO48xcL1DA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id D2ED9E00129;
	Thu, 12 Nov 2026 14:06:43 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id C115C2200263; Thu, 12 Nov 2026 14:06:43 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,  djwong@kernel.org,
  hch@lst.de,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/8] fat: add iomap buffered I/O support
In-Reply-To: <avVAmq-ntuzsJzXA@DESKTOP-PJTTJ93.localdomain>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
	<20261031164326.278125-7-matheus.aalmeida@inf.ufrgs.br>
	<87a4njtlgb.fsf@mail.parknet.co.jp>
	<avVAmq-ntuzsJzXA@DESKTOP-PJTTJ93.localdomain>
Date: Thu, 12 Nov 2026 14:06:43 +0900
Message-ID: <878q2yaba4.fsf@mail.parknet.co.jp>
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

> On Mon, Nov 09, 2026 at 12:03:00AM +0900, OGAWA Hirofumi wrote:
>>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>>
>>> Use iomap for buffered I/O, replacing buffer_heads. Remove
>>> fat_get_block(), fat_write_begin(), fat_write_failed() as the iomap path
>>> makes them unnecessary.
>>>
>>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>>> ---
>>>  fs/fat/fat.h   |   4 +-
>>>  fs/fat/file.c  |  72 +++++++++++++++++++----
>>>  fs/fat/inode.c | 157 +++++--------------------------------------------
>>>  fs/fat/iomap.c |  84 ++++++++++++++++++++++++++
>>>  4 files changed, 164 insertions(+), 153 deletions(-)
>>>
>>
>>[...]
>>
>>> diff --git a/fs/fat/file.c b/fs/fat/file.c
>>> index 8689cbbdad13..723b671d5b4b 100644
>>> --- a/fs/fat/file.c
>>> +++ b/fs/fat/file.c
>>
>>[...]
>>
>>> +static int fat_cont_expand(struct inode *inode, loff_t new_size);
>>> +
>>> +static ssize_t fat_file_write_iter_buffered(struct kiocb *iocb,
>>> +					    struct iov_iter *iter)
>>> +{
>>> +	struct inode *inode = file_inode(iocb->ki_filp);
>>> +	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
>>> +	loff_t offset, old_size, old_alloc, keep_alloc;
>>> +	ssize_t ret;
>>> +
>>> +	inode_lock(inode);
>>> +	ret = generic_write_checks(iocb, iter);
>>> +	if (ret <= 0)
>>> +		goto out;
>>> +
>>> +	ret = file_modified(iocb->ki_filp);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	offset = iocb->ki_pos;
>>> +	old_size = i_size_read(inode);
>>> +	if (offset > old_size) {
>>> +		/* We need to fill this hole */
>>> +		ret = fat_cont_expand(inode, offset);
>>> +		if (ret)
>>> +			goto out;
>>> +	}
>>> +
>>> +	inode_dio_wait(inode);
>>> +	old_alloc = inode_get_bytes(inode);
>>> +	ret = iomap_file_buffered_write(iocb, iter, &fat_iomap_write_ops,
>>> +					NULL, NULL);
>>> +	keep_alloc = max(old_alloc, round_up(i_size_read(inode),
>>> +					     sbi->cluster_size));
>>> +	if (inode_get_bytes(inode) > keep_alloc)
>>> +		fat_truncate_blocks(inode, keep_alloc);
>>
>>What is doing by this fat_truncate_blocks?
>>
>
> It's trimming the clusters past EOF and keeping the fallocate KEEP_SIZE
> preallocation. I can add a comment stating this.

Hm, I wonder mostly why this truncate without checking "ret"...

Thanks.

>>> +	if (ret > 0)
>>> +		ret = generic_write_sync(iocb, ret);
>>
>>Maybe we want to do this outside inode_unlock()?
>>
>
> True, good catch.
>
>>> +out:
>>> +	inode_unlock(inode);
>>> +	return ret;
>>> +}
>>> +
>
> Thanks,
> Matheus

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
