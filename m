Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82906371049;
	Fri,  8 May 2026 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231446; cv=none; b=FzFaU1i2TzUnNNir6g1hV5XqTFZ8n0IlFRQMJaFE0MXdUfpYoGiucmOJSPrAef6SS5eOZyVwiX8QKAq6UV7kRLuzeEL/UonH+siyApbEBAuNRGHBAx0mxN2bjmZI8h2uFeUSQdVGtmEJ2LMYK/ic3HJExQKyhcDo0PhLMX6hEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231446; c=relaxed/simple;
	bh=G1Gg/u98w8atwA14XNv7U2/AU3zvqxe6RLy/1mgkehA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAU0Mymv5jVq0LMRjo1/VRd/oAybqgNbgvSsMRcrvLorAQc3+Zlj7HfdjfwbE54U736rrUb/wAIkkSnODsON0TbhXZV1xYGDKwcgB0ShyzxgpnIFGBswQcVuyV+ENC4EiiMOudOcZMYNfN+nwjpDF5UTcNfPalJmNJduGh5rEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Vdu60LdW; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Vdu60LdW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778231435; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G7gqn9fF68YEGO2rjLNc6y68iZ4WaEVDGDVBH/83ckA=;
	b=Vdu60LdWGc5YTPf/HOIVrnWaUtViRI+OarxIcLxq2sFzS0XdYT+aLr1R40YYPU9quUqcxMk46YBdPJAxvKJ05kUyfhGkDHlXjQ8h/Bo8UOEovXF3malq1UVjuBCm3NcAhjdpu3PZiQ7eBbaOblr2bzlITnNiGt2gF0ibSgGS2eE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X2WwjyI_1778231422;
Received: from 30.69.177.140(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2WwjyI_1778231422 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 17:10:34 +0800
Message-ID: <50668994-b6cf-4288-9ee2-0264bad2b271@linux.alibaba.com>
Date: Fri, 8 May 2026 17:10:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: use the opener's credential when verifing metadata
 accesses
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, oliver.yang@linux.alibaba.com,
 Carlos Llamas <cmllamas@google.com>, Sandeep Dhavale <dhavale@google.com>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Tatsuyuki Ishi <ishitatsuyuki@google.com>,
 Matthew Wilcox <willy@infradead.org>
References: <af2kDfHe0B3LnvVm@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <af2kDfHe0B3LnvVm@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/5/8 16:51, Christoph Hellwig wrote:
> On Fri, May 08, 2026 at 04:39:15PM +0800, Gao Xiang wrote:
>> Currently EROFS file-backed mount metadata is directly using underlay
>> fs page cache, which is mainly used for composefs, etc. to avoid
>> different EROFS instances have their own EROFS page cache for the
>> same underlay backing file and avoid unnecessary copies into them.
>> --- That is also what composefs once did in their codebase.
>>
>> Since EROFS just read the underlayfs page cache and does _not_
>> touch anything inside the underlay page cache itself, so I guess
>> it's fine?
> 
> At the micro-level this does mean erofs needs to do the checks itself.
> OTOH it means this whole scheme is completely broken.  The page cache
> is owned by the file system, so erofs can't simply poke into it.

The page cache is indeed owned by the underlay file system
instead, but erofs doesn't poke into it: it just needs some
temporary metadata read usage without extra allocated buffers.

On the one side, I hope if there could be some interface for
such temporary usage rather than just one vfs_iter_read model.

> 
> Now for reads it mostly works on the most common disk-based file systems,
> but it does create lots of problem for slightly more complex ones like
> network/clustered or synthetic file systems.  It also really breaks

Just out of curiousity, could you point out one specific path
so I can look into that.

> layering, so we need to fix it.  Not sure what would be best, but I'd be
> tempted to have a cross-instance cache maintained by erofs and filled
> using in-kernel direct I/O.  IFF the page policies work great for you

Direct I/O may be improper for many cases, since users will use
buffer I/Os to download the images from remotes just now, and
direct I/O just makes it worse (invalidate the cache, and reread
from disk) and double caching if underlay file is also read.

> that even could be a synthetic inode/mapping.

I expect the similar comments, if we really need to work out such
cross-instance cache, I'm fine to implement for Linux 7.2.  It will
increase the complexity of the codebase and also it won't share the
cache with the underlay fs.

But could we just fix this issue first for previous linux versions?

> 
>> On the other hand, we talked a bit commit f2fed441c69b ("loop:
>> stop using vfs_iter_{read,write} for buffered I/O") in another
>> private thread related to fanotify, which lacks proper
>> rw_verify_area() as well, since it called into raw read/write
>> iter methods instead of using the previous vfs_iter_{read,write}.
> 
> Note that this does not add the bypass, just extends it to both I/O
> types.  But yes, this breaks fanotify.  We actually have quite a few
> raw ->read_iter/->write_iter calls, so this might need more structured
> treatment.

It also bypasses the security hooks I think.

Thanks,
Gao Xiang


