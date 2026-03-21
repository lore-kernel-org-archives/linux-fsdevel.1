Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896B328B63
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774072838; cv=none; b=HTdAh3JCxn+2fh3hfAZ6QzcL1X68ph1rLrpGBGyfqlIFLrnepsoFAWIxGmiYLYIYHVJcDmWOzgGGhJCGxV5YVbJNoeXMcTr8nG1zhCPCDEB+bklP/G2ktol7K/Xr8UPyGcCZDTchDlJumY0e7zVEUSG7uiwD7abRUtgZjePw7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774072838; c=relaxed/simple;
	bh=5jBbwcwzqqzR8CDjveHtqlmkLyUyfGE0xw9WpE2D5gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tQ4XNkXGc8dvUz8EfNMRRckIptAX8BGe64UlUGNJkCZilkQFkWAdxYsDCq5vcw5v9whQ3c3GJjy/LTbpCGAMGQl9X+sAA+pKIQmzSRIuVh6qzUIwN5E5HW6BEIeGXTXEx/nsLQK/voTYQoBmAGPwXMzdzMrRiOpyeldyn+RfYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tqBpJdk8; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tqBpJdk8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774072826; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=T/L2W7TvjGD3I6OMwBI9RN/KQewEtqHFHrg99ih59U8=;
	b=tqBpJdk8uJrYqZf75YozVTOLcCsvgrzQ9mHPewKVkknbThBOCrrp8gbEJuuyL+h2qMcgyMAMvoKQ5vsZNPf3HIgkmhfts3Z80RznZzVaP/1G0D8TcR2RN9CHMaO7Mq0S8fqtx88YjkRDdjYHIRViWozYocvumG+BdjhRLG1fZ/8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X.O8Caf_1774072825;
Received: from 30.171.190.207(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X.O8Caf_1774072825 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 14:00:25 +0800
Message-ID: <b79abd77-9cf0-44da-8436-b6e4de0e8712@linux.alibaba.com>
Date: Sat, 21 Mar 2026 14:00:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] FUSE: support for file_flags and birthtime (FreeBSD use
 case)
To: Raghav <raghav.original@gmail.com>, linux-fsdevel@vger.kernel.org
References: <CABR4S-vSW7qpvBfUrARtfgc91iF=PZPQNHvd0Xc=iiK=mx79vQ@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CABR4S-vSW7qpvBfUrARtfgc91iF=PZPQNHvd0Xc=iiK=mx79vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/20/26 5:06 PM, Raghav wrote:
> Hi all,
> 
> I’m a new contributor working on improving fusefs in FreeBSD, and I'm
> bringing up an issue in FUSEFS.
> 
> FreeBSD supports file flags modification with chflags(2) and file
> creation time (st_birthtime) at the VFS level. But, these are not
> currently supported by the FUSE protocol.
> As a result, fusefs on FreeBSD cannot expose or preserve these attributes.
> 
> I think we need to append struct fuse_attr with:
> uint32_t file_flags;
> uint64_t birthtime;
> uint32_t birthtimensec;
> Handling them in a backward compatible way.
> 
> Is extending fuse_attr in this way acceptable? If so, I’d be happy to
> make the changes and follow up with a patch.
> 

FUSE supports statx(2) with FUSE_STATX, which exposes btime.

-- 
Thanks,
Jingbo

