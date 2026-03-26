Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373763E556A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537815; cv=none; b=TcrVs6vXZQdGVsuv7DoMZnHmS7Q9SfwOs0OOfeQ+gq+C7lvOf1m0FGBiN6I1Vti9D5MUNcCSceLlTQR6vRINGlZQkQk3Q+C85rzXTVtzPNlM8DpMyQg5RR3BjKOqQREUzbMeR9pdk0b2WSZLv5EZWnJwMn0IGFKzjERiZjkEYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537815; c=relaxed/simple;
	bh=NjoU0MViJCzIbcuaHD6P7G+B2csgJNmx1NXS9aA/nnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGJGdmY74anunZEuwKVQ972b4noeg11VlzqPcHbvgYTD87PfXZnYH7PGaJcyCC6mI3dCXFvQkRg8QQsv2tJItcbd8u9CPZhosW8y1JkljFA9PWpADRlvJM65CI6TxLG/arXmIsoJkI3nmeWiCTpMsiRb9fqUE5L7Cq+JihdImwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XlP2MO6h; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XlP2MO6h"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774537809; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EMmPmsG9dYVZkJMkoD1Rlfk5BJDX7UPQlVSUngxnfhY=;
	b=XlP2MO6h193GNbfxj6KDqz5GhLn67cpUB1KQ4xjvQtl9mhNEoBwBNjDLVI4OSiLbRUV3WvjntRHOhd4reht/P4M3/+FAdxOXoGl6MneZj3QEcNVomwaVuzdkCTnpMpPZ879WeURvCiad8NM8HcpnqYdO9XSkpZ8m+dAU6k1HeTk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X.lcqcG_1774537806;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.lcqcG_1774537806 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Mar 2026 23:10:07 +0800
Message-ID: <f1cef32a-1c35-41dd-88af-a8c504d41a93@linux.alibaba.com>
Date: Thu, 26 Mar 2026 23:10:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Christian Brauner <brauner@kernel.org>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, Jan Kara <jack@suse.cz>,
 "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
 Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>,
 Horst Birthelmer <horst@birthelmer.de>, Gao Xiang <xiang@kernel.org>,
 lsf-pc@lists.linux-foundation.org
References: <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
 <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
 <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
 <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com>
 <2gyfmxfnnxrglpzb7kz63xbve5vnosl6gi54c3umgrpwbjr4og@lz4e2ptqanfe>
 <20260324-hilfen-reibung-9783005d5d0f@brauner>
 <b8f5bff1-27bf-4934-9297-0aad551a550c@gmail.com>
 <d2d5c218-7063-4ea0-ab03-1433449f4d83@linux.alibaba.com>
 <20260326-gemindert-vertuschen-fd3a507eba94@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260326-gemindert-vertuschen-fd3a507eba94@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2026/3/26 22:39, Christian Brauner wrote:
> On Tue, Mar 24, 2026 at 08:21:00PM +0800, Gao Xiang wrote:
>>
>>
>> On 2026/3/24 19:58, Demi Marie Obenour wrote:
>>> On 3/24/26 04:48, Christian Brauner wrote:
>>
>> ...
>>
>>>>>>
>>>>>>> I would still consider such design highly suspicious but without more
>>>>>>> detailed knowledge about the application I cannot say it's outright broken
>>>>>>> :).
>>>>>>
>>>>>> What do you mean "such design"?  "Writable untrusted
>>>>>> remote EXT4 images mounting on the host"? Really, we have
>>>>>> such applications for containers for many years but I don't
>>>>>> want to name it here, but I'm totally exhaused by such
>>>>>> usage (since I explained many many times, and they even
>>>>>> never bother with LWN.net) and the internal team.
>>>>>
>>>>> By "such design" I meant generally the concept that you fetch filesystem
>>>>> images (regardless whether ext4 or some other type) from untrusted source.
>>>>> Unless you do cryptographical verification of the data, you never know what
>>>>> kind of garbage your application is processing which is always invitation
>>>>> for nasty exploits and bugs...
>>>>
>>>> If this is another 500 mail discussion about FS_USERNS_MOUNT on
>>>> block-backed filesystems then my verdict still stands that the only
>>>> condition under which I will let the VFS allow this if the underlying
>>>> device is signed and dm-verity protected. The kernel will continue to
>>>> refuse unprivileged policy in general and specifically based on quality
>>>> or implementation of the underlying filesystem driver.
>>>
>>> As far as I can tell, the main problems are:
>>>
>>> 1. Most filesystems can only be run in kernel mode, so one needs a
>>>      VM and an expensive RPC protocol if one wants to run them in a
>>>      sandboxed environment.
>>>
>>> 2. Context switch overhead is so high that running filesystems entirely
>>>      in userspace, without some form of in-kernel I/O acceleration,
>>>      is a performance problem.
>>>
>>> 3. Filesystems are written in C and not designed to be secure against
>>>      malicious on-disk images.
>>>
>>> Gao Xiang is working on problem for EROFS.
>>> FUSE iomap support solves 2.  lklfuse solves problem 1.
>>
>> Sigh, I just would like to say, as Darrick and Jan's previous
>> replies, immutable on-disk fses are a special kind of filesystems
>> and the overall on-disk format is to provide vfs/MM basic
>> informattion (like LOOKUP, GETATTR, and READDIR, READ), and the
>> reason is that even some values of metadata could be considered
>> as inconsistent, it's just like FUSE unprivileged daemon returns
>> garbage (meta)data and/or TAR extracts garbage (meta)data --
>> shouldn't matter at all.
>>
>> Why I'm here is I'm totally exhaused by arbitary claim like
>> "all kernel filesystem are insecure". Again, that is absolutely
>> untrue: the feature set, the working model and the implementation
>> complexity of immutable filesystems make it more secure by
>> design.
>>
>> Also the reason of "another 500 mail discussion about
>> FS_USERNS_MOUNT" is just because "FS_USERNS_MOUNT is very very
>> useful to containers", and the special kind of immutable on-disk
>> filesystems can fit this goal technically which is much much
>> unlike to generic writable ondisk fses or NFS and why I working
>> on EROFS is also because I believe immutable ondisk filesystems
>> are absolutely useful, more secure than other generic writable
>> fses by design especially on containers and handling untrusted
>> remote data.
>>
>> I here claim again that all implementation vulnerability of
>> EROFS will claim as 0-day bug, and I've already did in this way
>> for many years.  Let's step back, even not me, if there are
>> some other sane immutable filesystems aiming for containers,
>> they will definitely claim the same, why not?
> 
> If you want unprivileged filesystem drivers mountable by arbitrary users
> and containers then get behind the effort to move this completely out of
> the kernel and into fuse making fuse fast enough so that we don't have
> to think about it anymore.

Let's think it on the contrary.

First, I don't think the end of all kernel filesystems is FUSE,
1) Linux is a monolithic kernel and EROFS is active maintained,
actually I do think it will be useful to more users; 2) and
FUSE is becoming more and more complex, and many use cases
doesn't even bother with all features.

Also many EROFS use cases are not all about containers: e.g.
billions of Android phones are using EROFS for system rootfs
now no matter of containers.

My one question is simply: why an already in-kernel filesystem
with a sensitive security model needs to bother with userspace
implementations just for this?

Also if EROFS enables FS_MOUNT_USERNS, does it really impact
to other popular kernel filesystems EXT4, XFS and BTRFS, and
abc? or even bothering with VFS?

This feature is just EROFS-specific, and will not be impacted
to other fses at all.  All bugs, issues will be still addressed
by ours and in time.

Think it in another way, although I do think LOC is not a
good measurement, but why we should follow the same policy
with complex COW filesystems with more than 200K LOCs, does
that really make sense? And many of them just never have
relationship with containers.

> 
> The whole push over the last years has been that if users want to mount
> arbitrary in-kernel filesystems in userspace then they better built a
> delegation and security model _in userspace_ to make this happen. This
> is why we built mountfsd in userspace which works just fine today.
> 
> I don't understand what exactly people think is going to happen once we
> start promising that mounting untrusted images in the kernel for even
> one filesystem is fine. This will march us down security madness we have
> not experienced before with all of the k8s and container workloads out
> there.
> 
> For me it is currently still completely irrelevant what filesystem
> driver this is and whether it is immutable or not. Look at the size of
> your attack surface in your codebase and your algorithms and the ever
> expanding functionality it exposes. This pipe dream of "rootless"
> containers being able to mount arbitrary images in-kernel without
> userspace policy is not workable.

I can only react it as: Get an agreement in the userspace is much
much much harder than in the kernel: looking at how many Linux
different distros now, every single person, every single cloud
vendor has his/her/their thoughts on the userspace stuff.

The fact of Docker images is just tar extraction, of course, the
integrity can be guaranteed by layer sha256, but that is all;
garbage can still be tar garbarge; but all garbages keep in the
isolated namespaces; so garbage tars in the garbage namespaces;
that is how Docker images work:  Of course, I could persuade them
to make images signed, but that would not be called as the Docker
image model anymore: So finally I still cannot make some people
happy.

Then, how do I persuade them following a single userspace policy?
If you even make a kernel implementation guarantee (like CVE and
0-day bug guarantees) and userspace folks still never get in
agreement.

I know systemd has very large users, but some few people still
don't want to try mountfsd, many of them even never uses
erofs-utils, how can I persuade them.

What I mean -- getting in agreement in Linux kernel may be easier
than dealing with various userspace people for a single filesystem
group; And it doesn't impact other kernel filesystems.

> 
> We debate this over and over because userspace is unwilling to accept
> that there are fundamental policy problems that are not solved in the
> kernel. And that includes when it is safe to mount arbitrary data. This
> is especially true now as we're being flooded with (valid and invalid)
> CVEs due to everyone believing their personal LLM companion.
> 
> You're going to be at LSF/MM/BPF and I'm sure there'll be more
> discussion around this.

Okay, but honestly, I've said too much these months, but I'm
never aggressive on this, I just don't want to be bother with
"all kernel filesystems are insecure" again, and we believe
our on-disk format is secure and we always fix our implmentation
bugs as soon as possible if someone finds any, and syzkaller
works pretty well, that's all.

Thanks,
Gao Xiang


