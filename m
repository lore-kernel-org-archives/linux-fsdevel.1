Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA693A7829;
	Mon,  1 Jun 2026 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325876; cv=none; b=qwErnCIIKvssV2rA9logOnrF5X5DAKlupu3EtmtZqRsnTi6QHrxHfUquyqlP1UVwxT1iqzXTMVn8BuSCgQKW+6yo7homJK3haRp4i3fZlFRuuYnX/ffm2fgydX0lH6VPAWi4ed/8rMqcHdlHf7mSGwyhbgzOsflBWDAe+j9fP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325876; c=relaxed/simple;
	bh=CKTKu98ONvYrdse+vtQEzE4SyK35ftNz0SRc7T3Ccmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXIu63/BUOLtFU3loXrbdB1+3zEAYAIdJae6KVGB+BM2gbPJsTOANIGj/UWLo3PpXZLzN4czQGYFZii8o/p0W693dEu1P4N48dZqiylgWhBU5Ms3870aiQr05H6vF7KmOFiOjJ4zl0f213+80xJd3GhzMmLAiOMXxRd+2kh0Ylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mUNCUaKs; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mUNCUaKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=V+C0fp6umJRU33kVMhlbvMKXHYQs58njskwsCD37+g8=;
	b=mUNCUaKsEO186WSEPg0WHIjTPeVuRtl56H1eHuwC+4GoLSqg45rzetb6RCzivz
	CcVqym+/qpjZyq+DEDC3jBf1+EBpS+tW8dydtzHKdTS2On6FUndfWUy1VuOzhOWi
	od3JPn2xDYqpcKrosAuBXTd1rOMsa9Xpvo/dgl6Jm5uMs=
Received: from [192.168.5.171] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCnVF69nR1qOU9UAw--.57248S2;
	Mon, 01 Jun 2026 22:57:02 +0800 (CST)
Message-ID: <e009b7d7-9008-4705-9255-c05a8386252e@163.com>
Date: Mon, 1 Jun 2026 22:57:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm/shmem: introduce copy_zero_to_iter() for large
 zeroing
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-4-chizhiling@163.com>
 <ah2HfH3jJZDiNAQc@casper.infradead.org>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <ah2HfH3jJZDiNAQc@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCnVF69nR1qOU9UAw--.57248S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArW8WF18CF4rKF4DGF48Zwb_yoW8Ar1kpF
	WxKFnxCws7Ja9Fgr4xZF4v9r1Fv3Z5KFW8GFy8Wr45ArnIqr90kry7KryakFn3ArWxC3y0
	vF4jv3s8Aa1Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRvJPiUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3B54Fmodnb5EoQAA3d

On 6/1/26 9:22 PM, Matthew Wilcox wrote:
> On Mon, Jun 01, 2026 at 01:57:02PM +0800, Chi Zhiling wrote:
>> Currently, holes larger than PAGE_SIZE cannot be handled because
>> ZERO_PAGE is limited to a single page. Add copy_zero_to_iter() as a
>> wrapper to support copying larger zero ranges to the iterator.
> 
> I think Hugh put this optimisation in the wrong place, and you're
> perpetuating that ;-)
> 
> So perhaps we can start by moving this optimisation to lib/iov_iter.c?
> And then you can redo your optimisation on top of that.

Sure, it's good to see this optimization moved into another place :)

In that case, I'll assume iov_iter_zero() is already well optimized and 
drop copy_page_to_iter() in v3.

By the way, I assume the benefit of this optimization depends on the CPU 
architecture, right? If so, I wonder whether lib/iov_iter.c is the most 
appropriate place for it.

> diff --git a/mm/shmem.c b/mm/shmem.c
> index 3b5dc21b323c..112cae9f9e4f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3427,19 +3427,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   			else
>   				ret = copy_page_to_iter(page, offset, nr, to);
>   			folio_put(folio);
> -		} else if (user_backed_iter(to)) {
> -			/*
> -			 * Copy to user tends to be so well optimized, but
> -			 * clear_user() not so much, that it is noticeably
> -			 * faster to copy the zero page instead of clearing.
> -			 */
> -			ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
>   		} else {
> -			/*
> -			 * But submitting the same page twice in a row to
> -			 * splice() - or others? - can result in confusion:
> -			 * so don't attempt that optimization on pipes etc.
> -			 */
>   			ret = iov_iter_zero(nr, to);
>   		}

I'll include this change to v3.

Thanks,

