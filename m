Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C11937C912;
	Fri,  8 May 2026 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229571; cv=none; b=C+WxHcUN2y+Dg2s2znsd47O5ltT9VZKbYnJ/sAq0yXLyhjyV5plfAgkQZMP9kqhzy7E7U6n/uLvA7uTopftjtdqW+q/PztTWhXk72YM6qwQ6THAjYVM0SIuLUzYiXnXqXEVxJIXZRGAlZZxxeXjVLsH9cA6Iz9RnGli+Eyr0Ymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229571; c=relaxed/simple;
	bh=CyZr3DsJEpxKQIukqoXwoDBZ3b4KCgGzQlaz+qCtCBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aj5CY8iqjJUpMUG2yz52iViu5HNDXXKgFXCRK52itjb2VJMZ7KmJqLwVCJTgWUrKcaeuPKvgoS/cKUnG9B6IpohJnZpROmEP3Afyl+Xe5L25ZPxvFv74oKrXY8/in9mYXYQwvLU78YAij0t50HMmC+avpr9iKaCaQcsGeKCRyoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LSmQpsUq; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LSmQpsUq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778229565; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9AJ8IZgkstBlyKEy++hhq2nD3+vl1iyXZTtJuFPuPFo=;
	b=LSmQpsUqZynaOOJaNoXupWFHQRw2ZiRMO4rEIiw5a67MbmvzmHf2s4eWBSEWGsQAdHnLfQ9fZNYv13JLrvcW+QGrxxS3K7gU2DueC4f+mdjdsFOhoANTnH+55x46jB+ydfMrGjJXQz89LQ93YlETpaUEqgBym4ERH1ZxrMnncj4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X2Wy2S2_1778229556;
Received: from 30.69.177.140(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2Wy2S2_1778229556 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 16:39:24 +0800
Message-ID: <188c33e2-331f-4362-8475-b8cea7a8fe7d@linux.alibaba.com>
Date: Fri, 8 May 2026 16:39:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: use the opener's credential when verifing metadata
 accesses
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, oliver.yang@linux.alibaba.com,
 Carlos Llamas <cmllamas@google.com>, Sandeep Dhavale <dhavale@google.com>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Tatsuyuki Ishi <ishitatsuyuki@google.com>
References: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com>
 <af2c4X1YCB7NEb8p@infradead.org>
 <CABqzrSOaCMPD_QrSq_y_6bXLC3ecm3FZsE_ACrdNbTHG8baMCw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CABqzrSOaCMPD_QrSq_y_6bXLC3ecm3FZsE_ACrdNbTHG8baMCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christiph,

On 2026/5/8 16:24, Tatsuyuki Ishi wrote:
> On Fri, May 8, 2026 at 5:20 PM Christoph Hellwig <hch@infradead.org> wrote:
> 
>> On Tue, May 05, 2026 at 11:56:15PM +0800, Gao Xiang wrote:
>>> Similar to commit 905eeb2b7c33 ("erofs: impersonate the opener's
>>> credentials when accessing backing file"), rw_verify_area() needs
>>> the same too.
>>
>> Two things here:

Let me use Tatsuyuki's reply to address your two comments.

>>
>>   - rw_verify_area is a helper for use inside the VFS and file system
>>     read/write method implementation.  Erofs as a user of the VFS should
>>     not use it at all.

Currently EROFS file-backed mount metadata is directly using underlay
fs page cache, which is mainly used for composefs, etc. to avoid
different EROFS instances have their own EROFS page cache for the
same underlay backing file and avoid unnecessary copies into them.
--- That is also what composefs once did in their codebase.

Since EROFS just read the underlayfs page cache and does _not_
touch anything inside the underlay page cache itself, so I guess
it's fine?

On the other hand, we talked a bit commit f2fed441c69b ("loop:
stop using vfs_iter_{read,write} for buffered I/O") in another
private thread related to fanotify, which lacks proper
rw_verify_area() as well, since it called into raw read/write
iter methods instead of using the previous vfs_iter_{read,write}.

>>   - using the opener credentials when accessing the backing file seems
>>     wrong.  The entity accessing it is the file system, so it should
>>     have system or mounter credentials, not that of someone causing
>>     metadata / fs data access.  And this applies to all access by
>>     a file system backed by a backing file.
>>
> 
> I think there's probably some confusion of terminology here. buf->file is
> opened with the mounter's credentials, so we are impersonating the mounter
> here. Perhaps the commit message could describe that more clearly. Same for
> the previous patches mentioned.

Here "opener" means the mounter as Tatsuyuki mentioned, I just
follows Tatsuyuki's term, but it just means mounter credentials
indeed.

Thanks,
Gao Xiang

> 

