Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C941D38B7B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261164; cv=none; b=ikVj/Ni6SMcr+Q6458r5HAtQfgo0TYe1MtK9pgoGLWqGRCT4c5ft4QZrHWGhjxsag5TjJ9ptQxh6UFOQW1faTKhQJ46ZtBsZLmzIFFtipmxBbamvc6uHhJ6seGMRLDFufO5D2TfNaF2hvPFNX8aspq2LIBiRgyRn5WG+7ReuBh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261164; c=relaxed/simple;
	bh=Z9LPnAWIc8m+8iJ8yMW8YzqtyQ7JoCygIKaTxQuYBy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHhXmB0eRfEbrgw81PbLfqAOdbTsYiSqNgSdML4WbFXT76YyJZPBE6C3OSuDundPOEYVnbNMxwFQrd9BiJ5k8DIptinSObLfKpzC6Wj++xELrzia3SjxZdaePJH5Ywesa0YEm7/kTwtXhcXVlcw/ym8NKBeB1LMl3VC66V++8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YYVGtUhN; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YYVGtUhN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774261159; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F6I96FIoWcKeB03WUOV8XaSbWA3qzQG8xcYQtZA2Mtk=;
	b=YYVGtUhNbveOw/7AmWhUC0K7MfRM4OR7qVft7zTZKTbNgswzVoOrjDeudSpgaqnbNYSV4WjZmTFG/nAP3ijzheUZlHdziBZMmciDi+fQSkD8ZaLzEu6GXwzrufsfYmb6LWxIRWev37DX6xBBiT8x9MlnBGc1/zz05Z6kce/GZWE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.WICFl_1774261157;
Received: from 30.221.131.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.WICFl_1774261157 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 18:19:17 +0800
Message-ID: <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
Date: Mon, 23 Mar 2026 18:19:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Jan Kara <jack@suse.cz>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
 Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>,
 Horst Birthelmer <horst@birthelmer.de>, Gao Xiang <xiang@kernel.org>,
 lsf-pc@lists.linux-foundation.org
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
 <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
 <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

On 2026/3/23 17:54, Jan Kara wrote:
> On Sun 22-03-26 12:51:57, Gao Xiang wrote:
>> On 2026/3/22 11:25, Demi Marie Obenour wrote:
>>>> Technically speaking fuse4fs could just invoke e2fsck -fn before it
>>>> starts up the rest of the libfuse initialization but who knows if that's
>>>> an acceptable risk.  Also unclear if you actually want -fy for that.
>>>
>>
>> Let me try to reply the remaining part:
>>
>>> To me, the attacks mentioned above are all either user error,
>>> or vulnerabilities in software accessing the filesystem.  If one
>>
>> There are many consequences if users try to use potential inconsistent
>> writable filesystems directly (without full fsck), what I can think
>> out including but not limited to:
>>
>>   - data loss (considering data block double free issue);
>>   - data theft (for example, users keep sensitive information in the
>>        workload in a high permission inode but it can be read with
>>        low permission malicious inode later);
>>   - data tamper (the same principle).
>>
>> All vulnerabilities above happen after users try to write the
>> inconsistent filesystem, which is hard to prevent by on-disk
>> design.
>>
>> But if users write with copy-on-write to another local consistent
>> filesystem, all the vulnerabilities above won't exist.
> 
> OK, so if I understand correctly you are advocating that untrusted initial data
> should be provided on immutable filesystem and any needed modification
> would be handled by overlayfs (or some similar layer) and stored on
> (initially empty) writeable filesystem.
> 
> That's a sensible design for usecase like containers but what started this
> thread about FUSE drivers for filesystems were usecases like access to
> filesystems on drives attached at USB port of your laptop. There it isn't
> really practical to use your design. You need a standard writeable
> filesystem for that but at the same time you cannot quite trust the content
> of everything that gets attached to your USB port...

Yes, that is my proposal and my overall interest now.  I know
your interest but I'm here I just would like to say:

Without full scan fsck, even with FUSE, the system is still
vulnerable if the FUSE approch is used.

I could give a detailed example, for example:

There are passwd files `/etc/passwd` and `/etc/shadow` with
proper permissions (for example, you could audit the file
permission with e2fsprogs/xfsprogs without a full fsck scan) in
the inconsistent remote filesystems, but there are some other
malicious files called "foo" and "bar" somewhere with low
permissions but sharing the same blocks which is disallowed
by filesystem on-disk formats illegally (because they violate
copy-on-write semantics by design), also see my previous
reply:
https://lore.kernel.org/r/7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com

The initial data of `/etc/passwd` and `/etc/shadow` in the
filesystem image doesn't matter, but users could then keep
very sensitive information later just out of the
inconsistent filesystems, which could cause "data theft"
above.

So I think inconsistent filesystem harms to users no matter
the implementations use FUSE or not.

You could claim it's not the case we care, but I think most
users should care, and they should full fsck in advance, but
if it's fscked and consistent, I'm afraid the images can then
be handled in kernel directly.

Thanks,
Gao Xiang


> 
> 								Honza

