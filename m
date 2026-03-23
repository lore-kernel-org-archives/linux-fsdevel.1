Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7423876CC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260325; cv=none; b=s3/PCmqR1iJpvtvUpUmtCE55WrqGAb3sxxP22e4OZt3b2CkvDp02kWU/cizQSLQAy0cZE0obQlW/LOHG2Cf70caZ8N4m2nYb7NWQ92KdVGAP4PGrH3rT4YtAGSjiVU8uqdGe8/g3/tSSQbS/xHV5BrleYMK/BCtoo+gmpiDo6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260325; c=relaxed/simple;
	bh=mwI+ckfrg6/Hl/G3DZS45cITEASkEJ3T0mFb6J7ZDJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXeoOgCrz5/0os9G5EJ+b8UTwbhQRVY31myyJDUwX+/L5XZIf9gDGRsL0HLyRZcRLkrHylva6ocXjLTIyTpPP/Q6a6WPgc+j5HuOpUWiwU2yxVky/XUuxa9G2REy77J475fhCv+1CDfJ7v+MjdD/6wMVHr9Fy1VdlRudofbYfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FHsvfkIB; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FHsvfkIB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774260320; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/7bQUMGnmEDf5rtN7xB98DmDBro178eKlnjTudFri4w=;
	b=FHsvfkIBIDQO7yAxjC+aWlaQ0Xrw8JJ2kHfOeqsTwuq41cNYNCInxh1bMHRvK6VLxPVLi1HIlNAzi/PvHQHOOlECtS3cpCUScsYpWWEuaacBZ3H1HnmWk4uBF6IwvAxNg0QCeDKwgQzVUS+6pwNf/NNQh+Lf+p2mxJMVZTpVeYA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.WI8RH_1774260318;
Received: from 30.221.131.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.WI8RH_1774260318 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 18:05:19 +0800
Message-ID: <6ab85914-6328-4762-910a-2ad17d45a358@linux.alibaba.com>
Date: Mon, 23 Mar 2026 18:05:17 +0800
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
 <4a1fd8dd-6c8a-43bd-877d-c37720ac1e21@linux.alibaba.com>
 <dkixubohp7hp4scizz46s3aruu327vf6gcwelpwlnto3iab7fz@4z7lpju4acqd>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <dkixubohp7hp4scizz46s3aruu327vf6gcwelpwlnto3iab7fz@4z7lpju4acqd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

On 2026/3/23 17:43, Jan Kara wrote:
> On Sun 22-03-26 13:14:55, Gao Xiang wrote:
>>
>>
>> On 2026/3/22 11:25, Demi Marie Obenour wrote:
>>
>>> The only exceptions are if the filesystem is incredibly simple
>>> or formal methods are used, and neither is the case for existing
>>> filesystems in the Linux kernel.
>>
>> Again, first, I don't think "simple" is a helpful and descriptive
>> word out of this kind of area:
>>
>> "simple" formats are all formats just archive the filesystem
>> data and metadata, but without any more use cases. No simpler
>> than that, because you need to tell vfs the file (meta)data
>> (even the file data is the garbage data), otherwise they won't
>> be called as filesystems.
>>
>> So why we always fall into comparing which archive filesystem
>> is simpler than others unless some bad buggy designs in those
>> "simple" filesystems.
>>
>> Here, I can definitely say _EROFS uncompressed format_ fits
>> this kind of area, and I will write down formally later if each
>> on-disk field has unexpected values like garbage numbers, what
>> the outcome.  And the final goal is to allow EROFS uncompressed
>> format can be mounted as the "root" into totally isolated
>> user/mount namespaces since it's really useful and no practical
>> risk.
>>
>> If any other kernel filesystem maintainers say that they can do
>> the same , why not also allow them do the same thing? I don't
>> think it's a reasonable policy that "due to EXT4, XFS, BtrFS
>> communities say that they cannot tolerate the inconsistent
>> consequence, any other kernel filesystem should follow the
>> same policy even they don't have such issue by design."
>>
>> In other words, does TCP/IP protocol simple? and is there no
>> simplier protocol for network data? I don't think so, but why
>> untrusted network data can be parsed in the kernel?  Does
>> TCP/IP kernel implementation already bugless?
> 
> So the amount of state TCP/IP needs to keep around is very small (I'd say
> kilobytes) compared to the amount of state a filesystem needs to maintain
> (gigabytes). This leads to very fundamental differences in the complexity
> of data structures, their verification, etc. So yes, it is much easier to
> harden TCP/IP against untrusted input than a filesystem implementation.

Thanks for the reply.

I just want to say I think the core EROFS format is not
complex too, but I don't want to make the deadly-simple
comparsion among potential simple filesystems, since
TCP/IP is not the deadly-simple one.

In brief, mounting as "root" in the isolated user/mount
namespace is absolutely our interest and useful to
container users, and as one of the author and maintainer
of EROFS, I can ensure EROFS can bear with untrusted
(meta)data.

> 
> And yes, when you have immutable filesystem, things are much simpler
> because the data structures and algorithms can be much simpler and as you
> wrote a lot of these inconsistencies don't matter (at least for the
> kernel). But once you add ability to modify the filesystem - here I don't
> think it matters whether through CoW or other means - things get
> complicated quickly and it gets much more complex to make your code
> resilient to all kinds of inconsistencies...

I only consider the COW approach using OverlayFS for example,
it just copies up (meta)data into another filesystem (the
semantics is just like copy the file in the userspace) and
the immutable filesystem image won't change in any case.

Overlayfs write goes through normal user write and the
writable filesystem is consistent, so I don't think it does
matter.  Or am I missing something? (e.g could you point
out some case which OverlayFS cannot handle properly?)

Thanks,
Gao Xiang

> 
> 								Honza

