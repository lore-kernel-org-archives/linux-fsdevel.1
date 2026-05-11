Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38B23EA89;
	Mon, 11 May 2026 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510580; cv=none; b=QkWxBBjfe6qQhm7qRYtWwEEIlHdqrqePjv7d6IRHzhRUsQrfpEQto1EdGv/C3Cq5ebrXrUZYWh4fRr5TuTQr61fiXoauS/n0I5iXG4aZokW09Q26B3GR4yQsmJrqzM+X1M7IqE1nKIin0POAdzk8Y7ZPwAAHl+ZKiPAKZ1FphEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510580; c=relaxed/simple;
	bh=67Te4w3aXuPF7dP95A0hbYAvVlxeMvhbp3DjO2HZ0Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTQsk0mxj8hmW479o3x861rCnwU5hNv92h8yM/XM9Ex8se0RLajdwYfSqrx4hIi6Ttzghb6IHqWghAjc6tJ3Kv4MVBCijcFPwSOd9puKyoCDDALEeEFbM875737csyTwNoN9z5wsbxcUpEeI+TYYxhU7C/PxpgsLNGZGG+2hBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Yc5yVf8e; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Yc5yVf8e"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778510565; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FMVWlhVg9AeJ1ZnmPiBpEL8Z//kUv99hwHffwNmxotg=;
	b=Yc5yVf8e+uMp18+2IkASILI4X+j3EtOMqx4hgiB9aZlfjkleBu1575Bp7EEIl05arSCesdeXnY0+AqJuvCK6acPvaaMj+7w49ugFPJpzLeb2+GCWrexO4n8yZXJPTLTmUAPHDy2T3j8p2mHJKt5vVAjx1+pn01IZ0zok/HlM85M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X2klsdY_1778510551;
Received: from 30.69.177.140(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2klsdY_1778510551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 22:42:44 +0800
Message-ID: <98133825-30a0-4519-a0b0-8054ed02490c@linux.alibaba.com>
Date: Mon, 11 May 2026 22:42:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: use the opener's credential when verifing metadata
 accesses
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-erofs@lists.ozlabs.org,
 Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 oliver.yang@linux.alibaba.com, Carlos Llamas <cmllamas@google.com>,
 Sandeep Dhavale <dhavale@google.com>, linux-fsdevel@vger.kernel.org,
 Tatsuyuki Ishi <ishitatsuyuki@google.com>
References: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com>
 <af2c4X1YCB7NEb8p@infradead.org>
 <CABqzrSOaCMPD_QrSq_y_6bXLC3ecm3FZsE_ACrdNbTHG8baMCw@mail.gmail.com>
 <188c33e2-331f-4362-8475-b8cea7a8fe7d@linux.alibaba.com>
 <20260511-ozonbelastung-verzweifeln-a03cd0309ad9@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260511-ozonbelastung-verzweifeln-a03cd0309ad9@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

On 2026/5/11 21:51, Christian Brauner wrote:
> On Fri, May 08, 2026 at 04:39:15PM +0800, Gao Xiang wrote:
>> Hi Christiph,
>>
>> On 2026/5/8 16:24, Tatsuyuki Ishi wrote:
>>> On Fri, May 8, 2026 at 5:20 PM Christoph Hellwig <hch@infradead.org> wrote:
>>>
>>>> On Tue, May 05, 2026 at 11:56:15PM +0800, Gao Xiang wrote:
>>>>> Similar to commit 905eeb2b7c33 ("erofs: impersonate the opener's
>>>>> credentials when accessing backing file"), rw_verify_area() needs
>>>>> the same too.
>>>>
>>>> Two things here:
>>
>> Let me use Tatsuyuki's reply to address your two comments.
>>
>>>>
>>>>    - rw_verify_area is a helper for use inside the VFS and file system
>>>>      read/write method implementation.  Erofs as a user of the VFS should
>>>>      not use it at all.
>>
>> Currently EROFS file-backed mount metadata is directly using underlay
>> fs page cache, which is mainly used for composefs, etc. to avoid
>> different EROFS instances have their own EROFS page cache for the
>> same underlay backing file and avoid unnecessary copies into them.
>> --- That is also what composefs once did in their codebase.
>>
>> Since EROFS just read the underlayfs page cache and does _not_
>> touch anything inside the underlay page cache itself, so I guess
>> it's fine?
>>
>> On the other hand, we talked a bit commit f2fed441c69b ("loop:
>> stop using vfs_iter_{read,write} for buffered I/O") in another
>> private thread related to fanotify, which lacks proper
>> rw_verify_area() as well, since it called into raw read/write
>> iter methods instead of using the previous vfs_iter_{read,write}.
>>
>>>>    - using the opener credentials when accessing the backing file seems
>>>>      wrong.  The entity accessing it is the file system, so it should
>>>>      have system or mounter credentials, not that of someone causing
>>>>      metadata / fs data access.  And this applies to all access by
>>>>      a file system backed by a backing file.
>>>>
>>>
>>> I think there's probably some confusion of terminology here. buf->file is
>>> opened with the mounter's credentials, so we are impersonating the mounter
>>> here. Perhaps the commit message could describe that more clearly. Same for
>>> the previous patches mentioned.
>>
>> Here "opener" means the mounter as Tatsuyuki mentioned, I just
>> follows Tatsuyuki's term, but it just means mounter credentials
>> indeed.
> 
> We're slowly reinventing overlayfs I see. ;) I think it's probably fine
> but it's also rather sketchy to mess around with permissions like that.
> Mainly because I don't think we have any actual page cache permission
> model. It's inherently shared beetween everyone and this kinda tries to
> bolt permissions on top to not make it so. Probably fine here but also a
> bit wonky.

Loop devices just purely use kernel cred instead, I think using
the mounter cred is more reasonable and safer than the kernel
cred.

Anyway, I think this cred part is less controversy.. The main
issue out of Christoph is still the metadata path: I tend to use
the underlay inode page cache for temporary RO access since it's
efficient and cache-friendly; and for immutable models we
shouldn't care too much about the invalidation, etc. since there
is no need to rely on the locking to keep the underlay data in
a strict way.


Thanks,
Gao Xiang

