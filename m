Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517622576E
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 02:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935493; cv=none; b=IHACGZrere0be/tan4eucpey9Fkl9f4WzjUyYgmtKmvtOcPagoJp0K9c4He2N1jHOboKl++vBACaOijerOe9XTJCVEYGv0OrjlXY/r4PRojKKLSLyBxDGxyXAQA+rF7Hs2va0YNZ0crTKT/bWf+1QYE4l7rVxb80AkUtsnfw99A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935493; c=relaxed/simple;
	bh=myUvuy9oJZVt8E0PipSjsSIHPEuQCDDpEvLqc2IYuCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xfw2LLmR51s0juhVaCYZkgSdfyMrx1GS/aOvJrnl0mLUMWLIs73OQBPO0mVbtG9spkNIT53hiXCx9gS6BHfjUGuFNRl/s+57+dVihYjXLtHhgPMmMHaQ0D8V3TTOisLaw+SWVa0wlTS1xpe+QQhm6XJQWoxon08zeRIECwWnMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tx7ZTkcY; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tx7ZTkcY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779935490; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=myUvuy9oJZVt8E0PipSjsSIHPEuQCDDpEvLqc2IYuCI=;
	b=Tx7ZTkcY0eyY++vSQBcV+Yu/oNy+l8DcXgEHayIH/9RNX0EyRFU5wcU+1Mrw/D8RCHq2b5qHRvoXMkwxxzz8IwAEkiq4DawVq6CZpn/o5smqK45xPJaHFQZ/YPFiervy4JTwaAzsJYJMZQDjQpDtenvbOl2TQmZA2EmY3AodnTo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3l1ZXA_1779935488;
Received: from 30.221.145.190(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3l1ZXA_1779935488 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 May 2026 10:31:29 +0800
Message-ID: <826e5016-4dcb-4697-ab0c-a5838e5d0f06@linux.alibaba.com>
Date: Thu, 28 May 2026 10:31:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] fuse: separate next request fetching from
 sending logic
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-2-joannelkoong@gmail.com>
 <ae5355a5-b10d-47e2-88f8-fc3eaa0de54e@linux.alibaba.com>
 <CAJnrk1Ypd=ek1E7qLpdxCoVzwzmzXLktXdpDbjPBZz7qKrWWTQ@mail.gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <CAJnrk1Ypd=ek1E7qLpdxCoVzwzmzXLktXdpDbjPBZz7qKrWWTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/5/28 04:53, Joanne Koong wrote:
> On Tue, May 26, 2026 at 9:02 PM Baokun Li <libaokun@linux.alibaba.com> wrote:
>> On 2026/4/3 00:28, Joanne Koong wrote:
>>> Simplify the logic for fetching + sending off the next request.
>>>
>>> This gets rid of fuse_uring_send_next_to_ring() which contained
>>> duplicated logic from fuse_uring_send(). This decouples request fetching
>>> from the send operation, which makes the control flow clearer and
>>> reduces unnecessary parameter passing.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
>>
>> Nice cleanup.
>>
>> Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
>>
> Thanks for taking the time to review the patches in this series,
> Baokun. There is a newer v3 version of this series in [1] that was
> cc'ed only to the new fuse-devel mailing list (with fs-devel dropped
> since the patches are only fuse-specific). I'll make sure your
> Reviewed-bys get added to the series.
>
> Thanks,
> Joanne
>
> [1] https://lore.kernel.org/fuse-devel/20260522205823.1597313-1-joannelkoong@gmail.com/


Hi Joanne,

Thanks for the heads-up, and apologies — I hadn't noticed that fuse now
has its own dedicated mailing list, so I ended up reviewing the stale
v2. I've subscribed to fuse-devel now and will follow the series there
going forward.


Cheers,
Baokun

