Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158000;
	b=4YjKsEPl6vJDJQGN5ZgCsx7XJkGkuWmv+Z1LJoIruoXAmJOYnwXLF2Su61mHoNz5M9pa
	 BAyGRmEhbFY9VzlwRYJ2bt0Bux3cP0JHYgFZ1Y09DrPqIPXojdiPIxikU5c9mYq+Jh5Ec
	 lz89RaeTa5U+AaC71XZlFOBmxgwBN5Sb06FhNoc3kT8ohFsQ/+hpj0iyXUgdTZreeq1ev
	 3IjjM1QbSJoqMbQWaS3+XZ77lvgqMysyaPjD2xQuhoZ9Ii/8y2eILoW+3tqJvvWR4QtMt
	 8Wbe+vrD8/weWUfv1GroxJjgK69d84g5vyL5iHr6sLz6M57l9+YUgfMikCB14JQUjRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158000;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=iPoTbsPUcaAQM8kPYpsKksGB/wxM72SDm8WasouMY9c=;
	b=ZeEci9iulG15fYaAMbYX81O+gOLoG2kTlx0d0poY6PUIPDaN8kbE7EsEoX6X3m+jAf7/
	 8qtCbbUPtqmG7krp+Fg5lU+kgvuvsdkg6SeORJz6SlkIDPKtdqb26sNInFTSHUE5LL3RQ
	 wRvKTsTHwV7nX/iep21EXt+llJis1Sgp4ir8WlYnU4gGSnt7+pdFWbKbrwfLNwPeKxCFm
	 Ef6A1XD8/+Kp2aX2W9FOogmexocg9uX5mcpd5Zg4tJHQRIOhzvJw7kN5fhXnY7zSGgdZy
	 PGPYZMD9oamQIUMwj+AnXkHmUE3hJnuYBsciqms0RARoMkou63rrOGW418FbJncqfiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VpIad7wD;
	arc=none smtp.remote-ip=91.218.175.50
Received: from mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26BA606A31C
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 17:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B26BA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VpIad7wD
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=amKArKTv82RVKkSYoJyK4ALaBbAyN8c1ugX/yaRdhmY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794157997; v=1; x=1794762797;
 b=VpIad7wDzyi+WfpCMwKx+0fjfyQFA24/hrUxTtg6N45SewVcLETXoYftLqEpwZA1jsaP9u3f
 YuL7nRH9xvpSaQuUhyua6wcAJ8JPJF/8+vVuJvUJE8/pmiboSPWaw61irk+FCn7GnOE4lH0k4Gw
 Qn++M/iOazBZzh5kdyqxq2U8=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id f91c847ed652e982;
	Sun, 08 Nov 2026 17:13:17 +0000
X-Mizu-Trace-ID: f91c847ed652e982
X-Migadu-Flow: FLOW_OUT
Message-ID: <6bc16c54-a9f1-4c51-ab68-b227eeecaf66@linux.dev>
Date: Sun, 8 Nov 2026 17:13:16 +0000
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: fail a short atomic bounce in
 bio_iov_iter_bounce_write()
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
 <20261107-blkdev-atomic-bounce-v1-1-f66344262096@columbia.edu>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20261107-blkdev-atomic-bounce-v1-1-f66344262096@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/26 04:24, Tal Zussman wrote:
> bio_iov_iter_get_pages() fails a REQ_ATOMIC bio that doesn't cover the
> whole iterator, since an atomic write is submitted as a single bio, and
> submitting only part of it would tear the write. In contrast,
> bio_iov_iter_bounce_write() doesn't. If a folio allocation fails partway
> through, it returns a short bio, which for an atomic write triggers a
> WARN_ON_ONCE() in iomap_dio_bio_iter_one().
> 
> Make bio_iov_iter_bounce_write() also check that a REQ_ATOMIC bio covers
> the whole iterator, and clean up and return -EINVAL if it doesn't.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

This looks reasonable, as atomic stable writes are implied to be 
supported from 3373503df025a ("xfs: use bounce buffering direct I/O when 
the device requires stable pages"). I am wondering how to test and prove 
this (change is good and maintained)?

> ---
>   block/bio.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index b0fcc69de653..61a3812520a2 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1523,6 +1523,16 @@ int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
>   		}
>   	}
>   
> +	/*
> +	 * An atomic write is submitted as a single bio, so it has to cover
> +	 * the whole iterator or it would be torn.
> +	 */
> +	if ((bio->bi_opf & REQ_ATOMIC) && iov_iter_count(iter)) {
> +		iov_iter_revert(iter, total_copied);
> +		bio_free_folios(bio);
> +		return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(bio_iov_iter_bounce_write);
> 

