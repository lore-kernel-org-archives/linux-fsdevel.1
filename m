Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4DB3976AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266148; cv=none; b=RTvUpgtYox3mVHWn+O+koQVxeXRujyFMZRiwtKXOT0+7GHMgwCrhhXRCxCinobq5BF15ldtenst7v83BDuDyUF3RaGhbGVDgMO82Kgd9Gom9tGC+1eYQDMR4d7mzevmHAAEpIvLlZz3kEc0EZ0rxPIb+q1F2dmDQ4eeYMonvT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266148; c=relaxed/simple;
	bh=5XrInb3ag2CJEg5hYbANROVYH74SIF1SCmKVD7cMR1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv1kCWUCj5nssADgyBqJOMEqUMdLHSka0QD8umnjFctn9TjgQpf1o8niAwvcdNeaBwGVhPZwoljt27dpUe/WstzKDk43BdO0GEibLoYN8mZ2bxrgNiyE9LaQwMMI13biqfu3q2NcumfbacbCHWdQ/wpV8xBEewkqT+BMIITZgkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Yhy19FJy; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Yhy19FJy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774266143; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KjgESmYQO5gb8jV7qJWuhKUl2awyIP9xdIpyqpLwG4M=;
	b=Yhy19FJyL869DiviM8XB3o2CTolH1gfskHJT37Qne3PYTLQhdOSMeEkdiAY402RtQC8yQ0AyBzIGCDSgqyNEt9IRNf1MGkjdMBExg6vkZFD49TV7jT1PX5zj4OlIbLgMba5hEJC/KrpYO5UL6kCh89HgaQ1xxxvsnKt2YVlR+GE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.X1YnN_1774266140;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.X1YnN_1774266140 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 19:42:22 +0800
Message-ID: <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
Date: Mon, 23 Mar 2026 19:42:18 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan!

On 2026/3/23 19:14, Jan Kara wrote:
> Hi Gao!
> 
> On Mon 23-03-26 18:19:16, Gao Xiang wrote:
>> On 2026/3/23 17:54, Jan Kara wrote:
>>> On Sun 22-03-26 12:51:57, Gao Xiang wrote:
>>>> On 2026/3/22 11:25, Demi Marie Obenour wrote:
>>>>>> Technically speaking fuse4fs could just invoke e2fsck -fn before it
>>>>>> starts up the rest of the libfuse initialization but who knows if that's
>>>>>> an acceptable risk.  Also unclear if you actually want -fy for that.
>>>>>
>>>>
>>>> Let me try to reply the remaining part:
>>>>
>>>>> To me, the attacks mentioned above are all either user error,
>>>>> or vulnerabilities in software accessing the filesystem.  If one
>>>>
>>>> There are many consequences if users try to use potential inconsistent
>>>> writable filesystems directly (without full fsck), what I can think
>>>> out including but not limited to:
>>>>
>>>>    - data loss (considering data block double free issue);
>>>>    - data theft (for example, users keep sensitive information in the
>>>>         workload in a high permission inode but it can be read with
>>>>         low permission malicious inode later);
>>>>    - data tamper (the same principle).
>>>>
>>>> All vulnerabilities above happen after users try to write the
>>>> inconsistent filesystem, which is hard to prevent by on-disk
>>>> design.
>>>>
>>>> But if users write with copy-on-write to another local consistent
>>>> filesystem, all the vulnerabilities above won't exist.
>>>
>>> OK, so if I understand correctly you are advocating that untrusted initial data
>>> should be provided on immutable filesystem and any needed modification
>>> would be handled by overlayfs (or some similar layer) and stored on
>>> (initially empty) writeable filesystem.
>>>
>>> That's a sensible design for usecase like containers but what started this
>>> thread about FUSE drivers for filesystems were usecases like access to
>>> filesystems on drives attached at USB port of your laptop. There it isn't
>>> really practical to use your design. You need a standard writeable
>>> filesystem for that but at the same time you cannot quite trust the content
>>> of everything that gets attached to your USB port...
>>
>> Yes, that is my proposal and my overall interest now.  I know
>> your interest but I'm here I just would like to say:
>>
>> Without full scan fsck, even with FUSE, the system is still
>> vulnerable if the FUSE approch is used.
>>
>> I could give a detailed example, for example:
>>
>> There are passwd files `/etc/passwd` and `/etc/shadow` with
>> proper permissions (for example, you could audit the file
>> permission with e2fsprogs/xfsprogs without a full fsck scan) in
>> the inconsistent remote filesystems, but there are some other
>> malicious files called "foo" and "bar" somewhere with low
>> permissions but sharing the same blocks which is disallowed
>> by filesystem on-disk formats illegally (because they violate
>> copy-on-write semantics by design), also see my previous
>> reply:
>> https://lore.kernel.org/r/7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com
>>
>> The initial data of `/etc/passwd` and `/etc/shadow` in the
>> filesystem image doesn't matter, but users could then keep
>> very sensitive information later just out of the
>> inconsistent filesystems, which could cause "data theft"
>> above.
> 
> Yes, I've seen you mentioning this case earlier in this thread. But let me
> say I consider it rather contrived :). For the container usecase if you are
> fetching say a root fs image and don't trust the content of the image, then
> how do you know it doesn't contain a malicious code that sends all the
> sensitive data to some third party? So I believe the owner of the container
> has to trust the content of the image, otherwise you've already lost.

The fact is that many cloud vendors have malicious content
scanners, much like virus scanners.

They just scan the filesystem tree and all contents, but I
think the severe filesystem metadata consistency is not
what they previously care about.  But of course, you could
ask them to fsck too.

Also see below.

> 
> The container environment *provider* doesn't necessarily trust either the
> container owner or the image so they need to make sure their infrastructure
> isn't compromised by malicious actions from these - and for that either
> your immutable image scheme or FUSE mounting works.
> 
> Similarly with the USB drive content. Either some malicious actor plugs USB
> drive into a laptop, it gets automounted, and that must not crash the
> kernel or give attacker more priviledge - but that's all - no data is
> stored on the drive. Or I myself plug some not-so-trusted USB drive to my
> laptop to read some content from it or possibly put there some data for a
> friend - again that must not compromise my machine but I'd be really dumb
> and already lost the security game if I'd put any sensitive data to such
> drive. And for this USB drive case FUSE mounting solves these problems
> nicely.
> 
> So in my opinion for practical usecases the FUSE solution addresses the
> real security concerns.

Sorry, I shouldn't speak in that way, as you said, the
security concepts depends on the context, limitation
and how do you think.

First, I need to rephrase a bit above in case there
could be some divergent discussion:

> for example, you could audit the file permission with
e2fsprogs/xfsprogs without a full fsck scan.

In order to make the userspace programs best-effort, they
should open for write and fstat the permission bits
before writing sensitive informations, it avoids TOCTOU
attacks as much as possible as userspace programs.


Container users use namespaces of course, namespace can
only provide isolations, that is the only security
guarantees namespace can provide, no question of that.

Let's just strictly speaking, as you mentioned, both ways
ensure the isolation (if namespaces are used) and kernel
stability (let's not nitpick about this).  And let's not
talk about malicious block devices or likewise, because
it's not a typical setup (maybe it could be a typical
setup for some cases, but it should be another system-wide
security design) and should be clarified by system admins
for example.

What I just want to say is that: FUSE mount approach _might_
give more incorrect security guarantees than the real users
expect: I think other than avoiding system crashes etc, many
users should expect that they could use the generic writable
filesystem directly with FUSE without full-scan fsck
in advance and keep their sensitive data directly, I don't
think that is the corner cases if you don't claim the
limitation of FUSE approaches.

If none expects that, that is absolute be fine, as I said,
it provides strong isolation and stability, but I really
suspect this approach could be abused to mount totally
untrusted remote filesystems (Actually as I said, some
business of ours already did: fetching EXT4 filesystems
with unknown status and mount without fscking, that is
really disappointing.)

Thanks,
Gao Xiang


> 
> 								Honza

