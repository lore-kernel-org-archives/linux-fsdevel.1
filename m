Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C603BF67A
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242043; cv=none; b=IRvpjhzXT/mJb92r65gAMOXl/PSmuG93Y6riKX5KasfZZGLSR+IM++XyuX10MydtDEg11uANag31RCGlk94vuhai+cmXl8U6dIcLBeVHdwoAx+Sykv7halarIIM/sZkY07V8haTY/hTSjoLuhXYtjy3t/O1MIMjjyOwE3LFmsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242043; c=relaxed/simple;
	bh=gIttXfvKXqg7unNmPCtv9nQuKbP8blH4bd3fKutVu64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlOEsSKnyns5pAPorjoOYFtSiKb+dE+LneKOeQ1OK5ZoLGCtjCAPm4clnzIuCOD4zO+1UEX8IohRkl8A1gENPnc9S7GjYWJEScWmpy3ZihjddVONjMp28JkYsFVNW10EtRpzeEIIkca1elZCpSHObvIG05X3vz0pKJi6Lh4ZoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X6olnusd; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X6olnusd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785242033; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HZYbAcie+5Exfmk84qOueCdd8pPr5SW+ez9Sxtfghyc=;
	b=X6olnusdJT1n6HtKvhbPfFdWZE4z4a9dHVi6lmB+Vu5UiydcRO6HrgZMSkv6vkAroFlTO4TfAN8drMB9D2Af4oDmJWzLlfuaugjQo0tVaL6hfa2Im+Oe/bGBo+5aX7k17zh4BAAU8xfUIZ7QmQK9iHIkB9sNIMuxb6L3SY4FMns=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X8-vD6H_1785242032;
Received: from 30.180.139.68(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X8-vD6H_1785242032 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Jul 2026 20:33:53 +0800
Message-ID: <ba39c0d9-1b7a-43d6-9a91-e729cb3a2731@linux.alibaba.com>
Date: Tue, 28 Jul 2026 20:33:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: accept source file descriptor via fsconfig
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-erofs@lists.ozlabs.org,
 cyphar@cyphar.com, linux-fsdevel@vger.kernel.org
References: <20260717134147.1602735-1-gscrivan@redhat.com>
 <20260722-notnagel-allemal-kampfsport-8fd4e4d98a15@brauner>
 <6d1ac697-d5f8-4952-ba68-27610f17bf3c@linux.alibaba.com>
 <20260723-wickeln-schindel-rotstift-d987d4e9c036@brauner>
 <95a5fc3a-4259-44a7-bb72-8ff35a49a26f@linux.alibaba.com>
 <87mrvckgip.fsf@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <87mrvckgip.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Giuseppe,

On 2026/7/27 16:01, Giuseppe Scrivano wrote:
> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
> 
>> Hi Christian,
>>
>> On 2026/7/23 22:46, Christian Brauner wrote:
>>>> I'm not quite sure if I catched the point, I think Giuseppe's patch here
>>>> tried to record `file` into `sbi->dif0.file` (which indicates the primary
>>>> "device" later.)
>>>>
>>>> And if `sbi->dif0.file` is set up by erofs_fc_parse_source(),
>>>> erofs_fc_get_tree() will just use `sbi->dif0.file` instead of
>>>> `fc->source` according to this patch.
>>> Oh, so you only do it for file-backed mounts. Do you only allow
>>> regular
>>> files or do you also support block devices with
>>> CONFIG_EROFS_FS_BACKED_BY_FILE?
>>
>> Block devices with CONFIG_EROFS_FS_BACKED_BY_FILE are supported,
>> but with only `fc->source` (not this way.)
>>
>> That is the limitation I see in Giuseppe's patch. I'd hoped
>> bdev-backed mounts could work the same way, but that would require
>> changes to the VFS flow.
>>
>> Since this is a side improvement, I think it's fine as long as
>> it's documented somewhere, and I do hope Giuseppe can at least
>> address the documentation.
> 
> would something like the following be enough?
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 4230884fb359..768e1d43dfcc 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -139,6 +139,29 @@ inode_share            Enable inode page sharing for this filesystem.  Inodes wi
>                          page cache.
>   ===================    =========================================================
>   
> +File-backed mounts
> +==================
> +
> +When ``CONFIG_EROFS_FS_BACKED_BY_FILE`` is enabled, EROFS can mount filesystem
> +images stored as regular files directly, without requiring a loopback block
> +device.  The source can be specified either by path or by passing an
> +already-opened file descriptor via ``fsconfig(fd, FSCONFIG_SET_FD, "source",
> +NULL, source_fd)``.  Only regular files are accepted; block devices must use


File-backed mounts
==================

When ``CONFIG_EROFS_FS_BACKED_BY_FILE`` is enabled, EROFS file-backed images
can be mounted directly without a loopback block device.  The backing file
can be given either as a path, or as an already-opened file descriptor via
``fsconfig(fd, FSCONFIG_SET_FD, "source", NULL, source_fd)``.

Only regular files are accepted as backing files; to mount an image that
resides on a block device, use the traditional block device mount path
instead.


It's just my own sketch of this; you could just fold this into this patch
with modification (I'm not quite good at English.)

Also it lacks how `fc->source is filled` when source_fd is specified, we
may need to document here as well (and hopefully vfs maintainers can ack
on this so it can be stable.)

> +the standard block device mount path.

> +
> +The backing file content must remain stable for the lifetime of the mount.
> +EROFS never writes to it, but concurrent modifications by other processes lead
> +to undefined behavior.

Yes, I explained to Christian but I don't think it should be included
in this patch, maybe we need to document this as a new section
in a seperate patch later (possibly as a formal security model.)

> +
> +Ioctls
> +======
> +
> +``EROFS_IOC_GET_SOURCE_FD``
> +  Return a read-only file descriptor (``O_CLOEXEC``) for the backing file of a
> +  file-backed mount.  Returns ``-ENOENT`` on block-device-backed mounts.
> +  Requires ``CAP_SYS_ADMIN`` in the initial user namespace (returns ``-EPERM``
> +  otherwise).

I hope document this part in the corresponding patch but I guess we have
to get a consensus between filesystems first.

Thanks,
Gao Xiang
