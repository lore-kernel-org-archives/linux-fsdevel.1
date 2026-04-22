Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046FF34887E;
	Wed, 22 Apr 2026 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856728; cv=none; b=bz+zFcpoRUF8ntal4DC/ocwcPb8Mi5giMXswXiUzzIUDvTEym5TjAqmN6d/mIa3yOk+1nfqF1juNiizIaJC2axorBGc3yILzkZIjT0X3AJw3yHy3M9qYOhLn6umn3pRWIqwvJLSFqqKmC7gcshm73/Kxh4SxOMt1IxvRGf629mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856728; c=relaxed/simple;
	bh=UZAwPE3zV70ZDG2zvyR97sh6801/zUaUNxodPAdKzEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEKa/K96r8qNaLLy/W7/kzhEWiIr1qYUZ96WoMbj5c+2ELkQ0VsqyAh9oSQbdFgHDJkAYE4Hm28yz7uV51wRHEkZtOa4PxLycwJ7wOBXDqpVqWJ0RyBm+trQwbpqiCuiY1ew3Ggd97roIiuzuPMsGemKJcyB8e7aYVgbiebHKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DG20fmD8; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DG20fmD8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776856717; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yR/lqPrRrmvF6Jm37H3vRerN4mdbQMQte1lfFjBcSzE=;
	b=DG20fmD8vqQVU3Uvi8BReClEx0Wmz5T01yBKowPRUjeE7oMAfh8ZQaCpYz5FRlPmtouwdh7/+QMLhYog3nLxqpKaEcipenvGtv5MzxBy4j4nJqqzfRtKvTw6uVPtbgyCGSnJ2tbbDxxDwaR5X7a2yVTjJERy2YJaPnVTyEpWJQY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X1W.KTk_1776856716;
Received: from 30.221.145.53(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X1W.KTk_1776856716 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Apr 2026 19:18:36 +0800
Message-ID: <e6077b7c-160c-4444-8ab8-ccab8b14ac27@linux.alibaba.com>
Date: Wed, 22 Apr 2026 19:18:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix kernel NULL pointer dereference in
 fuse_uring_add_to_pq()
To: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert
 <bernd@bsbernd.com>, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260422103603.4554-1-liwang@kylinos.cn>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260422103603.4554-1-liwang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/26 6:36 PM, Li Wang wrote:
> A kernel NULL pointer dereference was triggered when testing the
> 'fuse over io_uring' feature with passthrough_ll. The call trace
> is as follows:
>   BUG: kernel NULL pointer dereference, address: 0000000000000878
>   RIP: 0010:fuse_uring_add_req_to_ring_ent+0x89/0xd0 [fuse]
>   Call Trace:
>   <TASK>
>   fuse_uring_queue_fuse_req+0x82/0x100 [fuse]
>   fuse_chan_send+0xe6/0x180 [fuse]

I don't see fuse_chan_send() in upstream kernel.  I think you are
testing kernel with this patchset[1] applied?

[1] https://lore.kernel.org/all/20260416091658.462783-1-mszeredi@redhat.com/

-- 
Thanks,
Jingbo

