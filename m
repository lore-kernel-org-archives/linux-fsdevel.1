Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2733F39D8
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784846313; cv=none; b=JhpA1Yhi1LGEHWUgsqnlY35ZwH9RgmsFUu4qIEhlR0/pxAiOBqaOP+ThCpBHMdWLNWDIRWsCFq8IE/Hyl7/71v5wGbIrFB5CQiStuR7/DG6As42K3YrNtj6iKLQcDU1QW4qLtSfKLxNO79ehGN+ORbG3nTNGkmPVHIhz3mH+f2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784846313; c=relaxed/simple;
	bh=p/INQeiBaLDykzx+h2uxhjY62Uvaen07V/YY8Us5bgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/xZqOC6LGNw0Swk9vceVXsKi58AYdZV641dVlUDHNfs/xOrNsn46nMD8PCz3BJ+ghztHtuF4kBO5G/JUkotU+JSHdOLmVT/h3KyyQq8PMAG4aprI3n7BRCbyyzL9khy0KE0ItDGCfG7PGKz93KUl5mF6TAXVhuYRbYBp7ZdGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wnA7luhY; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wnA7luhY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784846302; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=otvzCkamAQ0pGgoRdnRXgmnjAzNjUJPrJvRvu9sfZx0=;
	b=wnA7luhY4Dj6VT+7HuCVJl4VufU2dTbZq029gjVcv4ipMk2YwtcgZLD8LDc0rfY3BJJNcGt+R069HcGBfPUDZjDFt2MrlC0tBmZ/bxJq8LQUoPgbfrS1ZdaszzW2Gnn1eKXvJKa9XMOssiRN1zhYH6utFImwWaubEjB/TGDO6KE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X7hBXrH_1784846301;
Received: from 30.180.139.68(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X7hBXrH_1784846301 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 06:38:21 +0800
Message-ID: <95a5fc3a-4259-44a7-bb72-8ff35a49a26f@linux.alibaba.com>
Date: Fri, 24 Jul 2026 06:38:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: accept source file descriptor via fsconfig
To: Christian Brauner <brauner@kernel.org>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, linux-erofs@lists.ozlabs.org,
 cyphar@cyphar.com, linux-fsdevel@vger.kernel.org
References: <20260717134147.1602735-1-gscrivan@redhat.com>
 <20260722-notnagel-allemal-kampfsport-8fd4e4d98a15@brauner>
 <6d1ac697-d5f8-4952-ba68-27610f17bf3c@linux.alibaba.com>
 <20260723-wickeln-schindel-rotstift-d987d4e9c036@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260723-wickeln-schindel-rotstift-d987d4e9c036@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2026/7/23 22:46, Christian Brauner wrote:
>> I'm not quite sure if I catched the point, I think Giuseppe's patch here
>> tried to record `file` into `sbi->dif0.file` (which indicates the primary
>> "device" later.)
>>
>> And if `sbi->dif0.file` is set up by erofs_fc_parse_source(),
>> erofs_fc_get_tree() will just use `sbi->dif0.file` instead of
>> `fc->source` according to this patch.
> 
> Oh, so you only do it for file-backed mounts. Do you only allow regular
> files or do you also support block devices with
> CONFIG_EROFS_FS_BACKED_BY_FILE?

Block devices with CONFIG_EROFS_FS_BACKED_BY_FILE are supported,
but with only `fc->source` (not this way.)

That is the limitation I see in Giuseppe's patch. I'd hoped
bdev-backed mounts could work the same way, but that would require
changes to the VFS flow.

Since this is a side improvement, I think it's fine as long as
it's documented somewhere, and I do hope Giuseppe can at least
address the documentation.

I'd also like to make sure the way fc->source is filled
out of fd passing follows common practice, so that if fd-based
bdev-backed mounts land in the VFS later, they can keep
the same fc->source convention, otherwise it will cause
a userspace behavior change.

> 
> Do you document the expected behavior for the file you're consuming?
> Meaning, are concurrent modifications supported and what type of
> behavior does this exhibit?


As I perhaps mentioned, EROFS itself (or many EROFS) won't do any
modification to the underlayfs bdev or files by design so the
standard behavior is the blob devices / files won't get any change.
Beyond that, both the on-disk format and the implementation are
designed to tolerate unexpected external modifications (or storage
media damage). Even in the worst case, where the underlying storage
(block device or backing filesystem) is malicious, corrupted on-disk
(meta)data will not lead to the kind of complex, hard-to-resolve
inconsistencies you see in general-purpose writable filesystems,
whose ondisk/in-memory cached metadata is much harder to reconcile.

I'm not sure whether you'll agree, but I want to emphasize that
again this is one of EROFS core design goals: the on-disk and
implementation design ensure that. If there is any human bug, it
will be addressed and fixed as long as it discloses: it won't be
hard to fixed.

But if you really want to avoid concurrent modifications or keep
the image golden, I think dmverity or fsverify should be enforced
to ensure the filesystem won't be modified unexpectedly or expectedly.

> 
>> The reason why `fc->source` is set was discussed in the
>> thread of the previous version suggested by Aleksa.
>>
>>>
>>> If they close it before this means you can mount something completely
>>> different. The other thing is even if they keep the fd open someone
>>> could just rename the damn thing and fc->source ends up pointing
>>> somwhere completely different. The could switch namespaces as well in
>>> some circumstances and then it points again into wherever.
>>>
>>> I've played with that fd idea before. The only way to make this work
>>> correctly is if you plumb this down into get_tree_nodev()
>>
>> fc->source in this case has no use in erofs_fc_get_tree() (`fc->source`
>> is just used for mountinfo for example), `sbi->dif0.file` works instead
>> I hope I don't misunderstand something.
> 
> No, I misunderstood this.

Thanks,
Gao Xiang

