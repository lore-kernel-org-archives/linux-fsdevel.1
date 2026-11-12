Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458135;
	b=1B/J/PFmmHhGmzAkeafQ03uu9z2PesiVtIdUvoTo7CAxgPo+OgFJO67L81QmWUcqM/8l
	 j+016LeAEnerLHauZCo8v3T8rYCdg6lr7YNaun/UotvrNN7dQwxIL1B+mQypoXl4uQJFV
	 i8Apb6ufFCyiexyDcCZit17F2XQLhKh6zIjMGdWjchK/JDWlOX6PuZpqvB2B8WCXU2Owb
	 U/+lRBQANiZFGOxwyLwWWcOcfE4X9BVTzTpXs8SapD7Kp92CuEr2ch9ED96Bn7Ymf0Q2G
	 QAmYinUl72YVAHW256LBvvCafqozmE+THvr2aTnxFo6EWnrd6STjzQcY66kvFNQ50SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458135;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=r6Gwuj5inUmGI+dhN4AAgJSunjApAZXT7RSEf7dbncI=;
	b=tvARO+jwWauCXoXEWjnPQX0oLlxpPMftsIZtDdUjiinQeapqA/afmfZiVLKQlHh8VXvG
	 lXMgSYlIJgb1lC23It+0Qq67S1+12GVvRllzOTMkNv9lfQLNCpzN92b6vvljq5yGkyO2e
	 wkqyhdXVQky3ew3m+St9+eAZjOihQwPUc1FNXctFBvT2YYsBBybVWTU8ePQHSyiqW6xVI
	 a3/MX2/D3CVk+ImQamNMjVse4wLtiOGaoG1u3JMdQmEpytHmU+B2H8EU6Li6ndlyHdIW9
	 /K0OHpE/V6hLcMpX7fagNr1sDv5f/QseLZkj5BAXrEN0YL3kDObVeDPloQVDZUGFJJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=ZgHojQyC;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A908B606A333;
	Thu, 12 Nov 2026 04:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A908B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=ZgHojQyC
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id AF521121113;
	Thu, 12 Nov 2026 01:35:32 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794458132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6Gwuj5inUmGI+dhN4AAgJSunjApAZXT7RSEf7dbncI=;
	b=ZgHojQyCWhPABPBOcnPttf8gMG+LfH+qCJwVmbJsVKi/h2Xxqpa1DlcCLxNccOMYg0RuvL
	KeaOHnhckpxvW9AS/6eK3DpUCKlYkH/rRRPKwsv171CVOpuqSEq8eOr3qemTfQvwoU75C6
	cAaKiSdtH37SOs/ECSbKFWVToS94kgDO3JGF+o4bD3hxTHs5n7qB9l/T7W4xCdQ240x17G
	81GKc8rSA6KyAyC9/kQxsZl7xD5aK0X/PQikTq9npMz0O+A4n6R1fnlv9c4JCvD0t7x8Pr
	PpPxCix37u6YbrG4YjJ/YziqXgmr2i/+dcxi2ywDWxxccHY7bK7Sxw7l6WgmeQ==
Date: Thu, 12 Nov 2026 01:35:30 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/8] fat: add iomap buffered I/O support
Message-ID: <avVAmq-ntuzsJzXA@DESKTOP-PJTTJ93.localdomain>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
 <20261031164326.278125-7-matheus.aalmeida@inf.ufrgs.br>
 <87a4njtlgb.fsf@mail.parknet.co.jp>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a4njtlgb.fsf@mail.parknet.co.jp>

On Mon, Nov 09, 2026 at 12:03:00AM +0900, OGAWA Hirofumi wrote:
>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>
>> Use iomap for buffered I/O, replacing buffer_heads. Remove
>> fat_get_block(), fat_write_begin(), fat_write_failed() as the iomap path
>> makes them unnecessary.
>>
>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>> ---
>>  fs/fat/fat.h   |   4 +-
>>  fs/fat/file.c  |  72 +++++++++++++++++++----
>>  fs/fat/inode.c | 157 +++++--------------------------------------------
>>  fs/fat/iomap.c |  84 ++++++++++++++++++++++++++
>>  4 files changed, 164 insertions(+), 153 deletions(-)
>>
>
>[...]
>
>> diff --git a/fs/fat/file.c b/fs/fat/file.c
>> index 8689cbbdad13..723b671d5b4b 100644
>> --- a/fs/fat/file.c
>> +++ b/fs/fat/file.c
>
>[...]
>
>> +static int fat_cont_expand(struct inode *inode, loff_t new_size);
>> +
>> +static ssize_t fat_file_write_iter_buffered(struct kiocb *iocb,
>> +					    struct iov_iter *iter)
>> +{
>> +	struct inode *inode = file_inode(iocb->ki_filp);
>> +	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
>> +	loff_t offset, old_size, old_alloc, keep_alloc;
>> +	ssize_t ret;
>> +
>> +	inode_lock(inode);
>> +	ret = generic_write_checks(iocb, iter);
>> +	if (ret <= 0)
>> +		goto out;
>> +
>> +	ret = file_modified(iocb->ki_filp);
>> +	if (ret)
>> +		goto out;
>> +
>> +	offset = iocb->ki_pos;
>> +	old_size = i_size_read(inode);
>> +	if (offset > old_size) {
>> +		/* We need to fill this hole */
>> +		ret = fat_cont_expand(inode, offset);
>> +		if (ret)
>> +			goto out;
>> +	}
>> +
>> +	inode_dio_wait(inode);
>> +	old_alloc = inode_get_bytes(inode);
>> +	ret = iomap_file_buffered_write(iocb, iter, &fat_iomap_write_ops,
>> +					NULL, NULL);
>> +	keep_alloc = max(old_alloc, round_up(i_size_read(inode),
>> +					     sbi->cluster_size));
>> +	if (inode_get_bytes(inode) > keep_alloc)
>> +		fat_truncate_blocks(inode, keep_alloc);
>
>What is doing by this fat_truncate_blocks?
>

It's trimming the clusters past EOF and keeping the fallocate KEEP_SIZE
preallocation. I can add a comment stating this.

>> +	if (ret > 0)
>> +		ret = generic_write_sync(iocb, ret);
>
>Maybe we want to do this outside inode_unlock()?
>

True, good catch.

>> +out:
>> +	inode_unlock(inode);
>> +	return ret;
>> +}
>> +

Thanks,
Matheus
