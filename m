Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99C3A7853
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907572; cv=none; b=rmhaFOYuD4SDFtHQGQ8uUb89/Lwfpd4pngOhroW3QU/KIoIRlVYRmK5911G/dcZASesuhr7I2b4i1R32M46Q/fzzsuXevXX1N6+bXW+bDFq8ESvU4rw18S90shZXxFULMPXoW904Tp9Tjjrajb5EA6+/5XAOHDFhxTMmO+07h+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907572; c=relaxed/simple;
	bh=tVH4iGuSzroFPi8LxjBaMTk0MLs7ENgUE2MLqkFK1nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCYmp0ZRrvW9pT4St2dfl2NqHd2HwFzDNzEAO6UhNdbCI+odH3Bgi2q7CppCbRMUGh0FIME17F0VfdZi/I6GqxHAd2QkPAmCFQdLp7/qyGoIAnFg/YCdWp07H+ztCsemd0O0K3gEx2p3vwR442yvXk+kj5bYU/fvDMaLDho5jvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hOlteDPX; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hOlteDPX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773907559; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uEhtfqZ8acEuz2M69R397e+6hd+sy+z5+EebQOxYuWM=;
	b=hOlteDPXj50TY+hCOrGo3RqYIe+mvcZYce9d/iHEVcGrAecPIM0J1XphgH+dNeR+B9AFPCewZoNa4ndgdOb8LiAKlHVpkZR5Ocw1c76o7B/cE8Pop/AKtyxSU5OebgvXuGB591laCicKXoK2CLozQeACArwaggQYh8fQZEYFwFs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X.Hj8lI_1773907558;
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.Hj8lI_1773907558 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 16:05:59 +0800
Message-ID: <5c9aa8e6-646e-47a7-8488-2ad193fc5bbe@linux.alibaba.com>
Date: Thu, 19 Mar 2026 16:05:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>,
 Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>,
 Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>,
 Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
 <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260318215140.GL1742010@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Darrick,

On 2026/3/19 05:51, Darrick J. Wong wrote:
> On Tue, Mar 17, 2026 at 12:17:48PM +0800, Gao Xiang wrote:
>> Hi Darrick,
>>
>> On 2026/2/21 08:47, Darrick J. Wong wrote:
>>> On Fri, Feb 06, 2026 at 02:15:12PM +0800, Gao Xiang wrote:
>>
>> ...
>>
>>>
>>>>>
>>>>> Fuse, otoh, is for all the other weird users -- you found an old
>>>>> cupboard full of wide scsi disks; or management decided that letting
>>>>> container customers bring their own prepopulated data partitions(!) is a
>>>>> good idea; or the default when someone plugs in a device that the system
>>>>> knows nothing about.
>>
>> I brainstormed some more thoughts:
>>
>> End users would like to mount a filesystem, but it's unknown that
>> the filesystem is consistent or not, especially for filesystems
>> are intended to be mounted as "rw", it's very hard to know if the
>> filesystem metadata is fully consistent without a full fsck scan
>> in advance.
>>
>> Considering the following metadata inconsistent case (note that
>> block 0x123 is referenced by the inconsistent metadata, rather
>> than normal filesystem reflink with correct metadata):
>>
>>   inode A (with high permission)
>>   extent [0~4k)               maps to block 0x123
>>
>>   random inode B (with low permission)
>>   extent [0~4k)               maps to block 0x123 too
>>
>> So there will exist at least three attack ways:
>>
>>   1) Normal users will record the sensitive information to inode
>>      A (since it's not the normal COW, the block 0x123 will be
>>      updated in place), but normal users don't know there exists
>>      the malicious inode B, so the sensitive information can be
>>      fetched via inode B illegally;
>>
>>   2) Attackers can write inode B with low permission in the proper
>>      timing to change the inode A to compromise the computer
>>      system;
>>
>>   3) Of course, such two inodes can cause double freeing issues.
>>
>> I think the normal copy-on-write (including OverlayFS) mechanism
>> doesn't have the issue (because all changes will just have another
>> copy). Of course, hardlinking won't have the same issue either,
>> because there is only one inode for all hardlinks.
> 
> Yes, though you can screw with the link counts to cause other mayhem ;)


Yes, for generic writable filesystems, incorrect nlink values
can also be another potential attack vector.

However, for strict immutable filesystems, we never actually
leverage nlink for any writable thing except getattr(), which
is used only to display archived stat information in the image
to users.

This is similar to how FUSE getattr simply returns nlink to
userspace, so corrupted nlink values for immutable fses doesn't
result in any serious thing (again like ro FUSE returns arbitary
nlink to userspace).

Since the filesystem is strictly immutable, any write operation
triggers a copy-up (copy-on-write) to another trusted
filesystem via OverlayFS.  I admit that hardlinking is no
longer valid in this context; however, since we are already
in the containerization era, almost all applications work
well with new OverlayFS semantics.


> 
>> I don't think FUSE-implemented userspace drivers will resolve
>> such issues (I think users can only get the following usage reclaim:
> 
> Filesystem implementations /can/ detect these sorts of problems, but
> most of them have no means to do that quickly.  As you and Demi Marie
> have noted, the only reasonable way to guard against these things is
> pre-mount fsck.
> 
> And even then, attackers still have a window to screw with the fs
> metadata after fsck exits but before mount(2) takes the block device.
> I guess you'd have to inject the fsck run after the O_EXCL opening.

Let's not talk about the attack like malicious block devices, the
typical real use case is that the container runtime fetchs
a filesystem image from remote, and then mount it.

Consider such typical scenario, I still think full fsck should be
run before mounting, especially for "rw"; otherwise FUSE won't help
serious inconsistent metadata corruption attacks;

> 
> Technically speaking fuse4fs could just invoke e2fsck -fn before it
> starts up the rest of the libfuse initialization but who knows if that's
> an acceptable risk.  Also unclear if you actually want -fy for that.

But if `e2fsck -fn` is run, and we scan the image then finally
find no metadata inconsistency, why not just mounting in the
kernel then? ;-)

I guess the main propose of FUSE was to avoid the impact of
serious malicious inconsistency?  I agree that this approach
will almost never crash the kernel, but like what I said,
the security risk is still here, and it doesn't need any
malicious block device likewise, just fetching untrusted
remote write fileystems to local, and mount.

Out of the topic: some of our alibaba cloud serverless
businesses are still mounting untrusted rw filesystems from
arbitary publishers in the kernel without any fsck in advance,
I tried to persuade them "don't do that" for many many times,
but who knows? :-)

> 
>> "that is not the case that we will handle with userspace FUSE
>> drivers, because the metadata is serious broken"), the only way to
>> resolve such attack vectors is to run
>>
>> the full-scan fsck consistency check and then mount "rw"
>>
>> or
>>
>> using the immutable filesystem like EROFS (so that there will not
>> be such inconsisteny issues by design) and isolate the entire write
>> traffic with a full copy-on-write mechanism with OverlayFS for
>> example (IOWs, to make all write copy-on-write into another trusted
>> local filesystem).
> 
> (Yeah, that's probably the only way to go for prepopulated images like
> root filesystems and container packages)
> 
>> I hope it's a valid case, and that can indeed happen if the arbitary
>> generic filesystem can be mounted in "rw".  And my immutable image
>> filesystem idea can help mitigate this too (just because the immutable
>> image won't be changed in any way, and all writes are always copy-up)
> 
> That, we agree on :)

:)

Thanks,
Gao Xiang

> 
> --D
> 
>> Thanks,
>> Gao Xiang
>>

