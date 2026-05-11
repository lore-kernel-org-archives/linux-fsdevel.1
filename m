Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453212EC0A1;
	Mon, 11 May 2026 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482392; cv=none; b=Mq5/DmVqnPwS/vubURLyd8uAPd86Me6VDK1VPPOdxfq1QGU9yvpehIkZAGh72vdBPP+E/29uF6tWyr97L0BK5+a1KCeNm/Q4Z8iVmRnmF9keXwdkP6/U6oZR67VFQKZjnOPROa8ISSWi1DmlyIE/cPcuaw0lCUE2Gz54v+GaQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482392; c=relaxed/simple;
	bh=Nu62acDWGcxmGfXD7MOMdYP0sJJjYuQgbyW8mu2top0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+UnHzk/ydKBhOvsH1MUJDuQxLp5mPMv1ZvPWs1kj4/1MVvQvzd4ZFI3fN34YdDxXs5JOnNyjd/Hs9AT2ip5mRTy96HToAhO1xsyUQa76ke7kXtAXQk6dEQNZOEZC4Dd9GShvrtO0C7HVI2PwvE3/IxoVmQSLpDjrgMLTjXuHts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r7CpiL5b; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r7CpiL5b"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778482386; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w8ztuvuiqII8JK6Sx0lF53pCfMpk/9qYJ0qOvBoYU1Y=;
	b=r7CpiL5bxccVKUflGpQdWtdvY85amzCQYMOw6ECbLYjb9Dvaz9N0T6M3VGGcZv7HessQNGNiYT9b3nQ+SptRjYIVDjMjttz4nwpqwgoneSYTdo3Wzt6AYaURAHOCJsYRtPG0NSImcVrY794nc5JBEz+7PQKiSgkuN9Rs8YwtrWU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X2fyt74_1778482374;
Received: from 30.69.177.140(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2fyt74_1778482374 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 14:53:05 +0800
Message-ID: <507ddec5-3a13-4df6-a6b5-732cc6b62d22@linux.alibaba.com>
Date: Mon, 11 May 2026 14:52:51 +0800
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
 <50668994-b6cf-4288-9ee2-0264bad2b271@linux.alibaba.com>
 <agF0wJSFRAEcRP8M@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <agF0wJSFRAEcRP8M@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/5/11 14:18, Christoph Hellwig wrote:
> On Fri, May 08, 2026 at 05:10:21PM +0800, Gao Xiang wrote:
>> On the one side, I hope if there could be some interface for
>> such temporary usage rather than just one vfs_iter_read model.
> 
> As in a in-kernel mmap?  While not entirely impossible, the locking
> model for that sounds horrible.

I don't think it needs a full in-kernel mmap, it just works on
some uptodate folios.

Which locking model? For page cache, it's expected that all folios
shouldn't clear uptodate randomly at any time.

At least for erofs use cases, we only care uptodate folios, no
matter if it's being invalidated/truncated or not (mapping == NULL).
Maybe it's not suitable for other stricter cases, but for immutable
fs models, that is enough and efficient.

> 
>>> Now for reads it mostly works on the most common disk-based file systems,
>>> but it does create lots of problem for slightly more complex ones like
>>> network/clustered or synthetic file systems.  It also really breaks
>>
>> Just out of curiousity, could you point out one specific path
>> so I can look into that.
> 
> file system might require their own locking, e.g. cluster locks for
> cluster file systems, and at least in the path direct page cache access
> also caused problems with NFS data invalidation semantics.  Last but not
> least ->read_folio has a file paramater that isn't really a file but a
> file system specific cookie.  So calling this with something not managed
> by the file system can cause problems as has caused crashes in the past,
> although the offender at that time (the old smbfs) is now gone.

file is indeed a cookie, but I did some research on the codebase,
and I've seen no odd cases other than a real "struct file *" anymore.

I agree such usage is kind of gray area, but I've seen no risk in
practice as long as the underlay fs supports proper ->read_folio
callback (and erofs restricts that.)

> 
>> But could we just fix this issue first for previous linux versions?
> 
> I just pointed out another issue.  You'll have to fix the credentials
> either way.

I really hope Matthew could give some opinion on this too, because
this way, the underlay cache can be directly used for temporary use,
and it should be a RO access and won't impact any fs-owned state.

Anyway, I could work out an alternative, but that makes the metadata
access less efficient.

Thanks,
Gao Xiang
