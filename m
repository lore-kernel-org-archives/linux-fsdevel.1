Received: from mta1.migadu.com (out-151.mta1.migadu.com [95.215.58.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061042C4F7
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234734; cv=none; b=InGjgT4lbJgoVm9h+tgVgoNvrHCUNxnh3lilRC00Fk6OhkLyR2Fs8REV5Yw0rFdIUR11PNsDs8hEfYSp9boPeXtLWk4joOe+FqvMd2LOa6fSuEcVEs3nFB0sHrvStZQsrAWkJFKII56Z34Cx7gwIzPi9F9dv3lM3pFnsQ3VQG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234734; c=relaxed/simple;
	bh=kpxnQ+T5dm8y5ACvCTrDn+fdvTMPwnbCt6gITaWVTuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BX2eHc8XMvNroEFFCpkXZTJgVRwWXBAkNo6Q/CiYxn+fve5Y25lQT4bjpM0qgZkymSEIYqemOznqvaG6ZZQZDH4/ft8rkF7olzTSYRyywfboe1j00jaTuILUv6geBcxWldGr4vBzBWd6qwJpy17+uBHJCOsi8Sz3jm+9RFYbOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pr0XdeH+; arc=none smtp.client-ip=95.215.58.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pr0XdeH+"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kpxnQ+T5dm8y5ACvCTrDn+fdvTMPwnbCt6gITaWVTuo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790234730; v=1; x=1790839530;
 b=Pr0XdeH+QlgtgqCXW39pDZmXk6NA7+1UQDARuwTzK/a0n27363NEt8+Zw/bIzzAmc1xeDXYq
 Mjo+J/JxAfT+Ejk+gz0dWfvyWnTmBXc1PiZbSqxwPku88M8RXgh8KzBr5f3E2QyWcY8I9B4aNMl
 0FQmlpFMbB9lRB1FrBw3WhXI=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 61f703b09c6c258b;
	Thu, 24 Sep 2026 07:25:07 +0000
X-Mizu-Trace-ID: 61f703b09c6c258b
X-Migadu-Flow: FLOW_OUT
Message-ID: <5ded31ca-fabf-4492-ab5f-75cf43118714@linux.dev>
Date: Thu, 24 Sep 2026 08:25:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] iomap: reject atomic writes in
 iomap_file_buffered_write()
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
 <20260923-blkdev-fixes-v5-7-89e60d66eb38@columbia.edu>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260923-blkdev-fixes-v5-7-89e60d66eb38@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 00:56, Tal Zussman wrote:
> Buffered atomic writes are not currently supported. The page cache
> writes folios back independently, so it cannot guarantee that a range is
> written atomically. iomap_file_buffered_write() does not check for
> IOCB_ATOMIC, so a direct write that falls back to it would complete an
> atomic write without atomicity. While no such case currently exists,
> fail IOCB_ATOMIC writes with -EOPNOTSUPP, so that a future fallback
> cannot complete an atomic write non-atomically.
> 
> Suggested-by: John Garry <john.garry@linux.dev>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: John Garry <john.garry@linux.dev>

> ---
>   fs/iomap/buffered-io.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0a5ebfda90f1..e6654cfe1cbf 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1304,6 +1304,10 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>   	};
>   	ssize_t ret;
>   
> +	/* Buffered atomic writes are not supported */
> +	if (iocb->ki_flags & IOCB_ATOMIC)
> +		return -EOPNOTSUPP;
> +
>   	if (iocb->ki_flags & IOCB_NOWAIT)
>   		iter.flags |= IOMAP_NOWAIT;
>   	if (iocb->ki_flags & IOCB_DONTCACHE)
> 

