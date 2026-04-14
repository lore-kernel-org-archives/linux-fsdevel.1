Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F138B19DFAB;
	Tue, 14 Apr 2026 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776135404; cv=none; b=gmsP40/3yBwBVhd+4Fl2pFkjBImISTDzx5Rdbngs0k3YWtgIZ9dXqMeRsaCFKbrfmLEXoLNx/6ci3LPbGbLJrVwWx9YtUWMPyfjfVICvt9wuDla62w+H33DsFfMWemiLCeAlyiO2hgK56oA+Z0ZbTyhOLLfSFauRuxA2XW/1Xqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776135404; c=relaxed/simple;
	bh=XgKM+CkUSnyIyF46+xCdWGlKShW0HPjduLuNnd/ygAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAwKMmn5cNVPI6tkhtXmm5Cy4cqfwmHlm0guKNwBDAIrXN0br2Hcoe8Hj8jSOVnDO8/HqC1FFvGrvFJs2xQKrRanvDHynjZ8LGgOcJHeuDMxmCU82T0On9v1eEM7hQlepMMuF46NT4xiGRKnRLlBiCWSolA1hBLpnu0yMrkEm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c3+3DNc0; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c3+3DNc0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776135398; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rFJsBCml9uGA7if6kqvhuINKYdwVEfVBPzHF5zso0YY=;
	b=c3+3DNc0vsx6pTo/VOTgjBIEMR/nBmGdeuZFwAacj8uabLG3JoqFcUDGjiVpg7NFQfdYUft73xAxEMfuF5xxDftPbP9BrLFMYE6IT/35rCMRzwCO7Ub0WLIPKqgLqsWZ10QJUsWbG5IGzsecXPqjeyMJHFbKnR3lGZhPlD1cg/g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X10.UXv_1776135396;
Received: from 30.221.131.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X10.UXv_1776135396 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Apr 2026 10:56:37 +0800
Message-ID: <8045f0a1-bda8-4c79-b488-3b48cd3bcb18@linux.alibaba.com>
Date: Tue, 14 Apr 2026 10:56:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/10] ftrfs: Fault-Tolerant Radiation-Robust
 Filesystem
To: Andreas Dilger <adilger@dilger.ca>, Pedro Falcato <pfalcato@suse.de>
Cc: Aurelien DESBRIERES <aurelien@hackers.camp>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org
References: <20260413142357.515792-1-aurelien@hackers.camp>
 <fkf75lk2sm2nfych34jiyoeqfctwkirzo22coqsad72yeau7ht@mh36h7nercwh>
 <B1515863-5EA3-44A7-BEC2-40A49BEDE7DD@dilger.ca>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <B1515863-5EA3-44A7-BEC2-40A49BEDE7DD@dilger.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/4/14 02:03, Andreas Dilger wrote:
> On Apr 13, 2026, at 09:04, Pedro Falcato <pfalcato@suse.de> wrote:
>>
>> On Mon, Apr 13, 2026 at 04:23:46PM +0200, Aurelien DESBRIERES wrote:
>>> From: Aurélien DESBRIERES <aurelien@hackers.camp>
>>>
>>> This RFC introduces FTRFS, a new Linux filesystem designed for dependable
>>> storage in radiation-intensive environments, targeting embedded Linux systems
>>> operating in space or other harsh conditions.
>>>
>>> FTRFS was originally described in:
>>>
>>>   Fuchs, C.M., Langer, M., Trinitis, C. (2015).
>>>   FTRFS: A Fault-Tolerant Radiation-Robust Filesystem for Space Use.
>>>   ARCS 2015, LNCS vol 9017, Springer.
>>>   https://doi.org/10.1007/978-3-319-16086-3_8
>>>
>>> This implementation is an independent open-source realization of the
>>> concepts described in that paper, developed for the Linux kernel.
>>
>> Well, here's the obvious question: do you have a usecase for this?
>>
>>>
>>> == Design ==
>>>
>>> FTRFS provides three layers of data integrity:
>>>
>>>   - CRC32 per block and per inode (hardware-accelerated via crc32_le)
>>>   - Reed-Solomon FEC (encoder implemented, decoder planned)
>>>   - EDAC-compatible error tracking
>>>
>>> On-disk layout:
>>>
>>>   Block 0        : superblock (magic 0x46545246, CRC32-protected)
>>>   Block 1..N     : inode table (128 bytes/inode, CRC32 per inode)
>>>   Block N+1..end : data blocks (CRC32 + RS FEC per block)
>>>
>>> Inodes use direct addressing (12 direct block pointers) plus single
>>> and double indirection. Directory entries are fixed-size (268 bytes)
>>> stored in direct blocks.
>>>
>>>
>>> Compile-tested on x86_64 with Linux 7.0 (this series).
>>> checkpatch.pl: 0 errors on all patches.
>>>
>>> == Feedback Requested ==
>>>
>>> This is an RFC. Feedback is welcome on:
>>>
>>>   1. On-disk format: is the superblock/inode layout reasonable?
>>
>> The layout itself is super unix-filesystem/ext2 reminiscent, so if something
>> like this is really needed, I would strongly recommend you perhaps add this
>> there. One feature (crc32c checksums over several metadata structures) already
>> exists on ext4.
> 
> This was my first question as well.  If this was some existing filesystem
> that was widely used in satellites or something, it might make sense to
> add support for that format (though a FUSE plugin might be better if the
> performance is not critical).  But it doesn't necessarily make sense to
> implement a greenfield filesystem that doesn't extend the boundaries over
> existing filesystems very far.
> 
> Modern ext4 has metadata checksums for many years, and fsverity can be used
> to add Merkle-tree checksums for file data.  Data redundancy can be handled
> by the block layer.
> 
> If code size/complexity is a significant issue for new embedded satellite
> controllers, then implementing "read-only" support for ext4 could be fairly
> straight forward development to put large chunks of the code under a CONFIG
> option.

According to the patchset, they need read-write support, but
I think the ext2 codebase is more suitable for embedded use
(if they don't need journalling) and to isolate unneeded
features.

However, I don't think an RO Kconfig option is useful for
isolating filesystem complexity concerns, unless the ondisk
layout and related runtime codepath can be separated by
design rather than gathering random RO pieces together:
because in that way, the new RO Kconfig option can only
make the testing and new development worse.

> 
> You also have to consider that filesystems are critical components of any
> computer, and having bugs in newly-developed filesystem code could be as
> fatal to the satellite as the radiation.  The general rule of thumb is that
> filesystems take about 10 years to mature.

Just a wild guess, I'm not sure if it's part of the AI work
(because it seems even there is no page cache for mmap()):

with new AI tools like Claude, it's pretty easy for everyone
to "write" and publish something now and in the future.

Thanks,
Gao Xiang

> 
> Cheers, Andreas
> 
> 
> 
> 
> 

