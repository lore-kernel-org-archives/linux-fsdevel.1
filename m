Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534583;
	b=pZz/Ve4ZZEbQr9DNKyOzkKoAm0pzN2mtD9CefnyRq3Pf4oMXFh0CUAaS1mL3f7LoHy7z
	 SmtmVS+lBPfu0xRBKFk3tkpyeRN6D7G98cCks4kkrhpEQan8B3k0d1LyJrXTsF5JpF+5a
	 XlZoFleDcl9kvu7JzWu5C8S0fPWx3dG1B9+a+Qu0R4HTEQkP6gmZbgOF8Z/er1BvaMrKF
	 mwlkdTTv84B4MYqa89OqOwd2HApjfqnxmhulOhfbROUHjzv8iwESfya4NXujWVifrSEeC
	 PLacLtJGmpbt0WEkhA8TpzN461kb3uva2cLi2PvcDNVPp4RNeDCQCTCPN7d+mZKI3/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534583;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=m9EQ9AqcRYXv3YcRpptxp+HixtfQsEg44OaJxaIMFkw=;
	b=QBguprel9gOwaE0LHQ2HMKtTFZcrEsH+Lgr9wDUXZyaoCpVmIe9jL/Jg0J4lLwjFPTWT
	 pwdRz9mHys7Wr+9elzoqkvsvWDHFQLXF5MjfNrwKIy4seROtNBmIaw09Wvi+WJqm83ZJO
	 GRPpB3BDa08RuoutyBXPi8QMl3bD8Ys+zf9ylMcO6L+LW9Q8QSWQhuEv5Bi6oH0j+m4XF
	 2lR77NJiqp+qaqNJQaHmbnhdSvrdh5ccrl4vTSag5tVwUC4y/b822eYGMxm2+2VZQNGIj
	 r/0XCT9Q1b2hxhwj3qDzYm9Z6oGx58o7Yg/48/wGmjcqUfCJzYDxWe+YE2/Jdmo28MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=EU2G10y2;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6747B606A31C;
	Fri, 13 Nov 2026 01:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6747B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=EU2G10y2
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id B1410120351;
	Thu, 12 Nov 2026 22:49:39 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794534579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m9EQ9AqcRYXv3YcRpptxp+HixtfQsEg44OaJxaIMFkw=;
	b=EU2G10y2Ue0rZMQ/jJYVSuglcP2P/o4s73iOCQd3J4TWeWfqg6eIt2nO+x42nl4qDKibIr
	/xZ4gl71ihJqJ6wqOPn/mWOiiGIOdF/3djYgaqt+izNQlyvwocMTvYmiKVmKT4VE9J2S+E
	F2J3W3FEVK2Um0YEwCId0kNdpp9NdZ3Gc0yA9wZPqcm42pzycFhW+h0t5c7ETf59d9sXBW
	QKCPn/R3Ru5t98Zw+dp2zpiLcuPdn35i8+sNCpEK565Ppz5N+iz31swQGYhQLP9vyP5JE2
	3byHWgUAha1L0PP/dI7WYjn0ZzzwesnLycp99P2mt/EPGeqlbgzEjlK+sthycQ==
Date: Thu, 12 Nov 2026 22:49:37 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/8] fat: add iomap buffered I/O support
Message-ID: <avZrAxczb507gDls@DESKTOP-PJTTJ93.localdomain>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
 <20261031164326.278125-7-matheus.aalmeida@inf.ufrgs.br>
 <87a4njtlgb.fsf@mail.parknet.co.jp>
 <avVAmq-ntuzsJzXA@DESKTOP-PJTTJ93.localdomain>
 <878q2yaba4.fsf@mail.parknet.co.jp>
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
In-Reply-To: <878q2yaba4.fsf@mail.parknet.co.jp>

On Thu, Nov 12, 2026 at 02:06:43PM +0900, OGAWA Hirofumi wrote:
>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>
>> On Mon, Nov 09, 2026 at 12:03:00AM +0900, OGAWA Hirofumi wrote:
>>>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>>>
>>>> Use iomap for buffered I/O, replacing buffer_heads. Remove
>>>> fat_get_block(), fat_write_begin(), fat_write_failed() as the iomap path
>>>> makes them unnecessary.
>>>>
>>>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>>>> ---
>>>>  fs/fat/fat.h   |   4 +-
>>>>  fs/fat/file.c  |  72 +++++++++++++++++++----
>>>>  fs/fat/inode.c | 157 +++++--------------------------------------------
>>>>  fs/fat/iomap.c |  84 ++++++++++++++++++++++++++
>>>>  4 files changed, 164 insertions(+), 153 deletions(-)
>>>>
>>>
>>>[...]
>>>
>>>> diff --git a/fs/fat/file.c b/fs/fat/file.c
>>>> index 8689cbbdad13..723b671d5b4b 100644
>>>> --- a/fs/fat/file.c
>>>> +++ b/fs/fat/file.c
>>>
>>>[...]
>>>
>>>> +static int fat_cont_expand(struct inode *inode, loff_t new_size);
>>>> +
>>>> +static ssize_t fat_file_write_iter_buffered(struct kiocb *iocb,
>>>> +					    struct iov_iter *iter)
>>>> +{
>>>> +	struct inode *inode = file_inode(iocb->ki_filp);
>>>> +	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
>>>> +	loff_t offset, old_size, old_alloc, keep_alloc;
>>>> +	ssize_t ret;
>>>> +
>>>> +	inode_lock(inode);
>>>> +	ret = generic_write_checks(iocb, iter);
>>>> +	if (ret <= 0)
>>>> +		goto out;
>>>> +
>>>> +	ret = file_modified(iocb->ki_filp);
>>>> +	if (ret)
>>>> +		goto out;
>>>> +
>>>> +	offset = iocb->ki_pos;
>>>> +	old_size = i_size_read(inode);
>>>> +	if (offset > old_size) {
>>>> +		/* We need to fill this hole */
>>>> +		ret = fat_cont_expand(inode, offset);
>>>> +		if (ret)
>>>> +			goto out;
>>>> +	}
>>>> +
>>>> +	inode_dio_wait(inode);
>>>> +	old_alloc = inode_get_bytes(inode);
>>>> +	ret = iomap_file_buffered_write(iocb, iter, &fat_iomap_write_ops,
>>>> +					NULL, NULL);
>>>> +	keep_alloc = max(old_alloc, round_up(i_size_read(inode),
>>>> +					     sbi->cluster_size));
>>>> +	if (inode_get_bytes(inode) > keep_alloc)
>>>> +		fat_truncate_blocks(inode, keep_alloc);
>>>
>>>What is doing by this fat_truncate_blocks?
>>>
>>
>> It's trimming the clusters past EOF and keeping the fallocate KEEP_SIZE
>> preallocation. I can add a comment stating this.
>
>Hm, I wonder mostly why this truncate without checking "ret"...
>
>Thanks.
>

It is meant as a cleanup for a failed or short write, serving the same
role as fat_write_failed(). I'll add a ret check for readability.

Thanks,
Matheus
