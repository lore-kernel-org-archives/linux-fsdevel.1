Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782592D5950
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345999; cv=none; b=t13Z7x0wnZHfdniPj8hnCBLMMBh6Wpx2C2TmLcnMjMTUlwzTp1dLgRhK8GGhZ2NaK6VM+rllUHV4QiOXtizCNWAmRdYR18yK48Lkh04tsdHDmP+S7UMMBuaI16hMAMY66SovNDT5JSU5Od62jyNSx7yA7SqK0tsaZLZvV/6lO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345999; c=relaxed/simple;
	bh=/oc55iWshDJ+dBTqXPIfOuUkFfgloZbR+vPu3C08b64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MurpW0eLTilmJ5yhG3tYAIGAlUkISDuWBUQIWUNftNe+KozQS+b9RolkveQJy6fCdvqV+U3OtxGW57yycKArenTcGbhEGBik0UJjJQ9A6s/q69hZ8akA1mofA6g+F5IqLuFwxCxKLzIuQkRrvSzPmaCFBv+nq6M8O9dGA0uB8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JSTf9XTT; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JSTf9XTT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774345987; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VPd3pe0H3kcYuCIwWxb0RO9co0AHJBjV5Lc59g/D1mw=;
	b=JSTf9XTT95e5Jf7bcnpomPktXmFdMK5i6iea70WJ9RQsudetCDcWcNcj9u1PGgVMwpHJv+EqTeD9WyL3JdLcoK/P+WEYAcpINQ5qNTIV1EuO/YpzIAH/6B7D1HA/b7AXX68e/7cE49C1k+Jj6KsVVTQs8rHuWAOxP9ChNwSeje8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X.eECp6_1774345985;
Received: from 30.221.131.232(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.eECp6_1774345985 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 17:53:05 +0800
Message-ID: <99ffdfa1-b18a-4f05-91e2-81c320e8edb5@linux.alibaba.com>
Date: Tue, 24 Mar 2026 17:53:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Demi Marie Obenour <demiobenour@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi
 <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>,
 Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>,
 Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>,
 Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
References: <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
 <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
 <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
 <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
 <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
 <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com>
 <2gyfmxfnnxrglpzb7kz63xbve5vnosl6gi54c3umgrpwbjr4og@lz4e2ptqanfe>
 <20260324-hilfen-reibung-9783005d5d0f@brauner>
 <ee146a41-2628-4cde-9f82-e718480edd4d@linux.alibaba.com>
 <052d27ff-9239-44fa-8604-336de0dc4711@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <052d27ff-9239-44fa-8604-336de0dc4711@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/24 17:49, Demi Marie Obenour wrote:
> On 3/24/26 05:30, Gao Xiang wrote:
>> Hi Christian,
>>
>> On 2026/3/24 16:48, Christian Brauner wrote:
>>> On Mon, Mar 23, 2026 at 03:47:24PM +0100, Jan Kara wrote:
>>>> On Mon 23-03-26 22:36:46, Gao Xiang wrote:
>>>>> On 2026/3/23 22:13, Jan Kara wrote:
>>>>>>>> think that is the corner cases if you don't claim the
>>>>>>>> limitation of FUSE approaches.
>>>>>>>>
>>>>>>>> If none expects that, that is absolute be fine, as I said,
>>>>>>>> it provides strong isolation and stability, but I really
>>>>>>>> suspect this approach could be abused to mount totally
>>>>>>>> untrusted remote filesystems (Actually as I said, some
>>>>>>>> business of ours already did: fetching EXT4 filesystems
>>>>>>>> with unknown status and mount without fscking, that is
>>>>>>>> really disappointing.)
>>>>>>
>>>>>> Yes, someone downloading untrusted ext4 image, mounting in read-write and
>>>>>> using it for sensitive application, that falls to "insane" category for me
>>>>>> :) We agree on that. And I agree that depending on the application using
>>>>>> FUSE to access such filesystem needn't be safe enough and immutable fs +
>>>>>> overlayfs writeable layer may provide better guarantees about fs behavior.
>>>>>
>>>>> That is my overall goal, I just want to make it clear
>>>>> the difference out of write isolation, but of course,
>>>>> "secure" or not is relative, and according to the
>>>>> system design.
>>>>>
>>>>> If isolation and system stability are enough for
>>>>> a system and can be called "secure", yes, they are
>>>>> both the same in such aspects.
>>>>>
>>>>>> I would still consider such design highly suspicious but without more
>>>>>> detailed knowledge about the application I cannot say it's outright broken
>>>>>> :).
>>>>>
>>>>> What do you mean "such design"?  "Writable untrusted
>>>>> remote EXT4 images mounting on the host"? Really, we have
>>>>> such applications for containers for many years but I don't
>>>>> want to name it here, but I'm totally exhaused by such
>>>>> usage (since I explained many many times, and they even
>>>>> never bother with LWN.net) and the internal team.
>>>>
>>>> By "such design" I meant generally the concept that you fetch filesystem
>>>> images (regardless whether ext4 or some other type) from untrusted source.
>>>> Unless you do cryptographical verification of the data, you never know what
>>>> kind of garbage your application is processing which is always invitation
>>>> for nasty exploits and bugs...
>>>
>>> If this is another 500 mail discussion about FS_USERNS_MOUNT on
>>> block-backed filesystems then my verdict still stands that the only
>>> condition under which I will let the VFS allow this if the underlying
>>> device is signed and dm-verity protected. The kernel will continue to
>>> refuse unprivileged policy in general and specifically based on quality
>>> or implementation of the underlying filesystem driver.
>>
>>
>> First, if block devices are your concern, fine, how about
>> allowing it if EROFS file-backed mounts and S_IMMUTABLE
>> for underlay files is set, and refuse any block device
>> mounts.
>>
>> If the issue is "you don't know how to define the quality
>> or implementation of the underlying filesystem drivers",
>> you could list your detailed concerns (I think at least
>> people have trust to the individual filesystem
>> maintainers' judgements), otherwise there will be endless
>> new sets of new immutable filesystems for this requirement
>> (previously, composefs , puzzlefs, and tarfs are all for
>> this; I admit I didn't get the point of FS_USERNS_MOUNT
>> at that time of 2023; but know I also think FS_USERNS_MOUNT
>> is a strong requirement for DinD for example), because that
>> idea should be sensible according to Darrick and Jan's
>> reply, and I think more people will agree with that.
>>
>> And another idea is that you still could return arbitary
>> metadata with immutable FUSE fses and let users get
>> garbage (meta)data, and FUSE already allows FS_USERNS_MOUNT,
>> and if user and mount namespaces are isolated, why bothering
>> it?
>>
>> I just hope know why? And as you may notice,
>> "Demi Marie Obenour wrote:"
>>
>>> The only exceptions are if the filesystem is incredibly simple
>>> or formal methods are used, and neither is the case for existing
>>> filesystems in the Linux kernel.
>>
>> I still strong disagree with that judgement, a minimal EROFS
>> can build an image with superblock, dirs, and files with
>> xattrs in a 4k-size image; and 4k image should be enough for
>> fuzzing; also the in-core EROFS format even never allocates
>> any extra buffers, which is much simplar than FUSE.
>>
>> In brief, so how to meet your requirement?
>>
>> Thanks,
>> Gao Xiang
> 
> Rewriting the code in Rust would dramatically reduce the attack
> surface when it comes to memory corruption.  That's a lot to ask,
> though, and a lot of work.

I don't think so, FUSE can do FS_USERNS_MOUNT and written in C
, and the attack surface is already huge.

EROFS will switch to Rust some time, but your judgement will
make people to make another complete new toys of Rust kernel
filesystems --- just because EROFS is currently not written
in Rust.

I'm completely exhaused with such game: If I will address
every single fuzzing bug and CVE, why not?

Thanks,
Gao Xiang

