Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C637E319
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268028; cv=none; b=OiRBHGqjhz6+jsNi1BuKPYV2EuOoK3rktutvCP0mL6ma+YZ6RVzs7C6LU2MZaEB2UBDZddA28q528gtZs8ScsvB7qAKOW4imTeXhxJYjc5NvElYOld5/Ou0bNg/35uY+0TJ3Ens1cd6sg/aNxV7ozBZW7Q6WlxP+GZyEJcY/6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268028; c=relaxed/simple;
	bh=1ukSqvZfYOuBFdTaYeIydW29JgfZOzk3IxP05HpCPTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXUyToQYbzgx87MMD1Rt0IX+kFjn21pgaR8z+mQQ+K1omvtKW1zX68A0ychabqyuwroVzPo53MJx4fIqG06Ks8irgq3w2CHy9EqBBlOHAh4sbQgvq21MujKT6nmo4xwooI1x+cKJsXsKisz93ctc4+b2DqJECiXn9MN+3JHJ3S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yHtckOd0; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yHtckOd0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774268023; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=s19T3UxuW2hdSn3zhYaMlukTpf2FOKAKdbAjZ8Y08JM=;
	b=yHtckOd003WAlBY1SaQpdWxuz6UH7FNGzg1vTYwf4r15Hltgd1nZjCxlTL8Lb0HIbgkF6Bw34NXFz586ACk34xPFnZ+UVtn2u8moAD+GwH4LLJaP23621h6CEz5Y/RhBSKD1mHq7AY+tBq/KQL0qzUfgFu4wLYMfTjIrlshYrKI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.XnRoI_1774268020;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.XnRoI_1774268020 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 20:13:41 +0800
Message-ID: <caad0716-1ddc-481b-b6d3-39b0c2a062d2@linux.alibaba.com>
Date: Mon, 23 Mar 2026 20:13:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Demi Marie Obenour <demiobenour@gmail.com>, Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi
 <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>,
 Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>,
 Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>,
 Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
References: <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
 <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
 <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
 <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <0b6d72a6-24d3-4558-81dc-d193828f6bc4@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0b6d72a6-24d3-4558-81dc-d193828f6bc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/23 20:08, Demi Marie Obenour wrote:
> On 3/23/26 07:14, Jan Kara wrote:
>> Hi Gao!
>>
>> On Mon 23-03-26 18:19:16, Gao Xiang wrote:
>>> On 2026/3/23 17:54, Jan Kara wrote:
>>>> On Sun 22-03-26 12:51:57, Gao Xiang wrote:
>>>>> On 2026/3/22 11:25, Demi Marie Obenour wrote:
>>>>>>> Technically speaking fuse4fs could just invoke e2fsck -fn before it
>>>>>>> starts up the rest of the libfuse initialization but who knows if that's
>>>>>>> an acceptable risk.  Also unclear if you actually want -fy for that.
>>>>>>
>>>>>
>>>>> Let me try to reply the remaining part:
>>>>>
>>>>>> To me, the attacks mentioned above are all either user error,
>>>>>> or vulnerabilities in software accessing the filesystem.  If one
>>>>>
>>>>> There are many consequences if users try to use potential inconsistent
>>>>> writable filesystems directly (without full fsck), what I can think
>>>>> out including but not limited to:
>>>>>
>>>>>    - data loss (considering data block double free issue);
>>>>>    - data theft (for example, users keep sensitive information in the
>>>>>         workload in a high permission inode but it can be read with
>>>>>         low permission malicious inode later);
>>>>>    - data tamper (the same principle).
>>>>>
>>>>> All vulnerabilities above happen after users try to write the
>>>>> inconsistent filesystem, which is hard to prevent by on-disk
>>>>> design.
>>>>>
>>>>> But if users write with copy-on-write to another local consistent
>>>>> filesystem, all the vulnerabilities above won't exist.
>>>>
>>>> OK, so if I understand correctly you are advocating that untrusted initial data
>>>> should be provided on immutable filesystem and any needed modification
>>>> would be handled by overlayfs (or some similar layer) and stored on
>>>> (initially empty) writeable filesystem.
>>>>
>>>> That's a sensible design for usecase like containers but what started this
>>>> thread about FUSE drivers for filesystems were usecases like access to
>>>> filesystems on drives attached at USB port of your laptop. There it isn't
>>>> really practical to use your design. You need a standard writeable
>>>> filesystem for that but at the same time you cannot quite trust the content
>>>> of everything that gets attached to your USB port...
>>>
>>> Yes, that is my proposal and my overall interest now.  I know
>>> your interest but I'm here I just would like to say:
>>>
>>> Without full scan fsck, even with FUSE, the system is still
>>> vulnerable if the FUSE approch is used.
>>>
>>> I could give a detailed example, for example:
>>>
>>> There are passwd files `/etc/passwd` and `/etc/shadow` with
>>> proper permissions (for example, you could audit the file
>>> permission with e2fsprogs/xfsprogs without a full fsck scan) in
>>> the inconsistent remote filesystems, but there are some other
>>> malicious files called "foo" and "bar" somewhere with low
>>> permissions but sharing the same blocks which is disallowed
>>> by filesystem on-disk formats illegally (because they violate
>>> copy-on-write semantics by design), also see my previous
>>> reply:
>>> https://lore.kernel.org/r/7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com
>>>
>>> The initial data of `/etc/passwd` and `/etc/shadow` in the
>>> filesystem image doesn't matter, but users could then keep
>>> very sensitive information later just out of the
>>> inconsistent filesystems, which could cause "data theft"
>>> above.
>>
>> Yes, I've seen you mentioning this case earlier in this thread. But let me
>> say I consider it rather contrived :). For the container usecase if you are
>> fetching say a root fs image and don't trust the content of the image, then
>> how do you know it doesn't contain a malicious code that sends all the
>> sensitive data to some third party? So I believe the owner of the container
>> has to trust the content of the image, otherwise you've already lost.
>>
>> The container environment *provider* doesn't necessarily trust either the
>> container owner or the image so they need to make sure their infrastructure
>> isn't compromised by malicious actions from these - and for that either
>> your immutable image scheme or FUSE mounting works.
>>
>> Similarly with the USB drive content. Either some malicious actor plugs USB
>> drive into a laptop, it gets automounted, and that must not crash the
>> kernel or give attacker more priviledge - but that's all - no data is
>> stored on the drive. Or I myself plug some not-so-trusted USB drive to my
>> laptop to read some content from it or possibly put there some data for a
>> friend - again that must not compromise my machine but I'd be really dumb
>> and already lost the security game if I'd put any sensitive data to such
>> drive. And for this USB drive case FUSE mounting solves these problems
>> nicely.
>>
>> So in my opinion for practical usecases the FUSE solution addresses the
>> real security concerns.
>>
>> 								Honza
> 
> I agree, *if* the FUSE filesystem is strongly sandboxed so it cannot
> mess with things like my home directory.  Personally, I would run
> the FUSE filesystem in a VM but that's a separate concern.
> 
> There are also (very severe) concerns about USB devices *specifically*.
> These are off-topic for this discussion, though.
> 
> Of course, the FUSE filesystem must be mounted with nosuid, nodev,
> and nosymfollow.  Otherwise there are lots of attacks possible.
> 
> Finally, it is very much possible to use storage that one does not have
> complete trust in, provided that one uses cryptography to ensure that
> the damage it can do is limited.  Many backup systems work this way.

In brief, as I said, that is _not_ always a security concern:

  - If you don't fsck, and FUSE mount it, your write data to that
    filesystem could be lost if the writable filesystem is
    inconsistent;

  - But if you fsck in advance and the filesystem, the kernel
    implementation should make sure they should fix all bugs of
    consistent filesystems.

So what's the meaning of "no fsck" here if you cannot write
anything in it with FUSE approaches.

Thanks,
Gao Xiang


