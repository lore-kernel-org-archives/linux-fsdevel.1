Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457101;
	b=YQvRpmzt9v56NTZBGUkJPtrCYT9TNCJ6bEhRzEu//Af1G+cQp+RZMd++17WFeIPTljyP
	 PcjnI82rhU/R+zgKPFcyBLev+zlYLCZAEcnjfyrzbLs8hpmccoD3ft0mskgdA77lADDbi
	 K8ACtXdROSNMctJQgmVBMaFV9W+CtZEpYG/xtKftJpQQgHHdVXTTIaxaDW37Myvcc1c2t
	 6ayuY/Ehs07I2/W9i59Jf/WJsvKTPXOyw2izKZuQ3IYnA3DdNNvbnpg5ACSCRn5xbupiV
	 uvAwVNMRmavit6KtnkoGqlKK/xgmt3yeBKSLWNSyXZK2mHFiO1xPRyQXyWmdj+UZtXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457101;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=yCfTtI14G/Vzuyv7Ege9XSl7pbk+Nk+u+9gtE9F07qk=;
	b=MUM+twq3p7evp3yZqq/KEDDhA2QBKMzuMHRjUBUL92hzc7e2jLoi23QPI2QHLI0TCElw
	 H8Hneq9s3RY1CPH/XyhYYI8eNir6PbyTVE4eD6piyv1JlQU1jTIQ+36hyXbzjBceelNCy
	 7nC2AcBvvyw9mSOP8e5loNZFm0kXR/a12O6FLTyzjAKHrbr1pL4SWslWFtqxHAYWH7DM6
	 qU9S0KuUnBGqsVviahjdCA6lsUNlzQPvhFXwWqS4zG2VfyWghPSok+iqLiLSbh6x6cWzH
	 S6yVz636B9y6gcBYLUXEjO8Mg19dBTG0uXPmZyDHdLGFIZ+NS1pjtGUrLbTQo0klFeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=YBdfyQUQ;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0F606A32A;
	Thu, 12 Nov 2026 04:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EA0F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=YBdfyQUQ
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id D7E9B12110C;
	Thu, 12 Nov 2026 01:18:17 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794457097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yCfTtI14G/Vzuyv7Ege9XSl7pbk+Nk+u+9gtE9F07qk=;
	b=YBdfyQUQvxyoPWF4HGondRpa05gA85Tx2D/y80SsJEBGy9Rwfj+n0rNWV6yT2EeS8mkyrt
	4hSVa03QHTrMZF5e2hZtu7W8tHkJJAhltjiriMKwpPEd1dqWlQlhKQAey1VrNeNJgMbf3z
	WxHbRxktIy46r50hk1Xm1DotEKx75AhW/8ElXr3hJxGFINKb0JVbQiyC+BPZ6piWpndsW3
	K4qk/SgtsLKc4cSyAdQK/7MFWF08nLNiBhkz53dVLSg9wQb8pN/xo1tSuUJgtoXZw/9vRJ
	hfJXD8ZU5NazY7zO+Mc56oCTLbFs8OwAD3Amjwq5Cz9ajF6Gwp46s43fyzjxMg==
Date: Thu, 12 Nov 2026 01:18:14 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/8] fat: add iomap direct I/O support
Message-ID: <avU8K4W5iEwss9iQ@DESKTOP-PJTTJ93.localdomain>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
 <20261031164326.278125-4-matheus.aalmeida@inf.ufrgs.br>
 <87mrrjtlro.fsf@mail.parknet.co.jp>
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
In-Reply-To: <87mrrjtlro.fsf@mail.parknet.co.jp>

On Sun, Nov 08, 2026 at 11:56:11PM +0900, OGAWA Hirofumi wrote:
>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>
>> Replace the deprecated ->direct_IO() path with ->{read,write}_iter() and
>> iomap_dio_rw(). Add fat_file_open() to advertise direct I/O support.
>>
>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>> ---
>>  fs/fat/Kconfig |   1 -
>>  fs/fat/fat.h   |   1 +
>>  fs/fat/file.c  | 119 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>  fs/fat/inode.c |  36 ---------------
>>  fs/fat/iomap.c |  24 ++++++++++
>>  5 files changed, 142 insertions(+), 39 deletions(-)
>>
>
>[...]
>
>> diff --git a/fs/fat/file.c b/fs/fat/file.c
>> index c27d4e7f698c..177a26186ddc 100644
>> --- a/fs/fat/file.c
>> +++ b/fs/fat/file.c
>> @@ -201,11 +201,126 @@ int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
>>  	return blkdev_issue_flush(inode->i_sb->s_bdev);
>>  }
>>  
>
>[...]
>
>> +static ssize_t fat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>> +{
>> +	ssize_t ret;
>> +
>> +	if ((iocb->ki_flags & IOCB_DIRECT) == 0)
>> +		return generic_file_write_iter(iocb, iter);
>> +
>> +	ret = fat_file_dio_write_iter(iocb, iter);
>> +	if (ret == -ENOTBLK)
>> +		ret = 0;
>> +	else if (ret < 0)
>> +		return ret;
>> +
>> +	/* Fall back to buffered I/O if we could not do DIO */
>> +	if (iov_iter_count(iter)) {
>> +		ssize_t done;
>> +
>> +		done = fat_file_write_iter_buffered_fallback(iocb, iter);
>> +		if (done < 0)
>> +			return done;
>
>If fat_file_dio_write_iter() wrote some, this should return ret (how
>many written), instead of the error? Or it never happen?
>

While I don't think it can currently happen, I will fix it in v2 for
future correctness. Good catch.

>> +		ret += done;
>> +	}
>> +
>> +	return ret;
>> +}

Thanks,
Matheus
