Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06273F23B9
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354877; cv=none; b=tW1gDZn/s+TAwrnHL+fDw2aGNhJ9DRtDMGu1X0Pn+W2Nkeps2Gph8SbZ19FoOX3B0rBkK9ZwnG5+EXCQLs4qQfn86DhfKDSOE11+M2XKtNLxgwBv5MSARZmZUPBIHHnVkfOHqxHz4yGPKRv47I19nVBT7pTOVirM+e5MyTGhRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354877; c=relaxed/simple;
	bh=WYZqZ+6RJ/fVzN1+QuC5YH0+w9S4AaueQ/4141lCI/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpBoCdTC3oMyIObFkaB8hsb1DaKK/bVDMNBnicd6RvzGt4WTodDb9IDEBnlOA8yLJDg9DqQN+P0rttyvYWYtC//b7w0M/nfNjJxDQ++mg32Wl4qxmi6ka7QyKit6fvsCazEc3lCcgSnuoYCbq5cIqIQdFPFGogGQdMbU5r1DEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e7/g+jhS; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e7/g+jhS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774354865; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aOV9naY/SMihiWNIDhTe+GdiXcA75JHl5EbbebYyOzs=;
	b=e7/g+jhSBV5isYYScMdIjYtVXRkjTynQ/buDSinStAQYLz+vgDCSlgkydJNo7jQEGMc5G6qvusba7+if6gUsIqJlktMWpHl9PNt042RIjpWNgh0IxorzyqiZBIEpfhHSdu0Rpi9B6eR7D3OO3W9d4QfWFDi35Fhp5vn7j7CyHn0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X.eVul2_1774354862;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.eVul2_1774354862 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 20:21:03 +0800
Message-ID: <d2d5c218-7063-4ea0-ab03-1433449f4d83@linux.alibaba.com>
Date: Tue, 24 Mar 2026 20:21:00 +0800
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
 <b8f5bff1-27bf-4934-9297-0aad551a550c@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b8f5bff1-27bf-4934-9297-0aad551a550c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/24 19:58, Demi Marie Obenour wrote:
> On 3/24/26 04:48, Christian Brauner wrote:

...

>>>>
>>>>> I would still consider such design highly suspicious but without more
>>>>> detailed knowledge about the application I cannot say it's outright broken
>>>>> :).
>>>>
>>>> What do you mean "such design"?  "Writable untrusted
>>>> remote EXT4 images mounting on the host"? Really, we have
>>>> such applications for containers for many years but I don't
>>>> want to name it here, but I'm totally exhaused by such
>>>> usage (since I explained many many times, and they even
>>>> never bother with LWN.net) and the internal team.
>>>
>>> By "such design" I meant generally the concept that you fetch filesystem
>>> images (regardless whether ext4 or some other type) from untrusted source.
>>> Unless you do cryptographical verification of the data, you never know what
>>> kind of garbage your application is processing which is always invitation
>>> for nasty exploits and bugs...
>>
>> If this is another 500 mail discussion about FS_USERNS_MOUNT on
>> block-backed filesystems then my verdict still stands that the only
>> condition under which I will let the VFS allow this if the underlying
>> device is signed and dm-verity protected. The kernel will continue to
>> refuse unprivileged policy in general and specifically based on quality
>> or implementation of the underlying filesystem driver.
> 
> As far as I can tell, the main problems are:
> 
> 1. Most filesystems can only be run in kernel mode, so one needs a
>     VM and an expensive RPC protocol if one wants to run them in a
>     sandboxed environment.
> 
> 2. Context switch overhead is so high that running filesystems entirely
>     in userspace, without some form of in-kernel I/O acceleration,
>     is a performance problem.
> 
> 3. Filesystems are written in C and not designed to be secure against
>     malicious on-disk images.
> 
> Gao Xiang is working on problem for EROFS.
> FUSE iomap support solves 2.  lklfuse solves problem 1.

Sigh, I just would like to say, as Darrick and Jan's previous
replies, immutable on-disk fses are a special kind of filesystems
and the overall on-disk format is to provide vfs/MM basic
informattion (like LOOKUP, GETATTR, and READDIR, READ), and the
reason is that even some values of metadata could be considered
as inconsistent, it's just like FUSE unprivileged daemon returns
garbage (meta)data and/or TAR extracts garbage (meta)data --
shouldn't matter at all.

Why I'm here is I'm totally exhaused by arbitary claim like
"all kernel filesystem are insecure". Again, that is absolutely
untrue: the feature set, the working model and the implementation
complexity of immutable filesystems make it more secure by
design.

Also the reason of "another 500 mail discussion about
FS_USERNS_MOUNT" is just because "FS_USERNS_MOUNT is very very
useful to containers", and the special kind of immutable on-disk
filesystems can fit this goal technically which is much much
unlike to generic writable ondisk fses or NFS and why I working
on EROFS is also because I believe immutable ondisk filesystems
are absolutely useful, more secure than other generic writable
fses by design especially on containers and handling untrusted
remote data.

I here claim again that all implementation vulnerability of
EROFS will claim as 0-day bug, and I've already did in this way
for many years.  Let's step back, even not me, if there are
some other sane immutable filesystems aiming for containers,
they will definitely claim the same, why not?

Thanks,
Gao Xiang




