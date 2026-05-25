Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0C3D1CD0
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694155; cv=none; b=kVhNtTHE2gTaJd0hTRmUg8qUqb9fFrX4L2H1RVb0Aje/uD2vVwm7hkx4hOkbOlgyB/gSZjZqhUxyv2OdBB1rwCR1X1NjYDL+eus72PES7lXlRgraZEIOJaRk8oKeApiSp4wOxh7XXxDetbiykkNPCw+Ap3R2XHTh1FyYcCFHjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694155; c=relaxed/simple;
	bh=Dg6xOhAfC8nAS8w2UlP1hkcGBI6/eEQ9ST3cagLZT4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctC3O7jwkQc8idlSuR+KXtMTrUZ6J8H+F05p/LLJIY+pwzuypjHvYU7BWakoPO90GaNtL51oamVmAVRJ5jNKuoZ1H/tQLAE5dt1WM3/rmEuA/SogcakOVSYVAAkzEUAywODFz7sgmUQupGbD0YTmFC5Xt0YPcenz9evroVp+aAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlHC2Qlk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlHC2Qlk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4904127c32cso18242445e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779694152; x=1780298952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+/CremarURMLXbq9HZsozt2//0CtuRcgdYp3OMzrIs=;
        b=UlHC2QlkIb4XLnXGJy7wJ9WEAIolGMLkGZ4XYlME8S5AEhdyWcsYCae0wgtAz5uZ6+
         wDxbJJc9Qcy9N4zpjKC7zI5pmqbWBoSZDbWXiLTEehoIUXCaj34l+WX6RaOvip1EfiRN
         BWYI+Lt8tA7PBSZL/Rc7fB0gydpI+H2O6cCgLPmW57JUpG8J7z0/QgZ2aUm1B9SPftOE
         Rp+dcu5/00PDGT9i0OHnPZ0cYSSdG0yV5Eq+2sDJGN61sVIoGEdfy28aIcecT3IQko+W
         ZWSGztFHDohN0gSU1UiEHLFPN28TmZTWsrNkupph4hd+MoKIvQjrfq5Tc9IWiVAk6hog
         kHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779694152; x=1780298952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+/CremarURMLXbq9HZsozt2//0CtuRcgdYp3OMzrIs=;
        b=c5D1c8+rJyxPjgNIATwsd/Lccqy66x3RC9G65oAZaChyGCAkRlQ3co3vrWl7nWG25F
         Z/kIaVYNmwohCz793Ac0jt2SkDbh83xWqmUvcJ/u9FL8PmRYQhA5mvDAqdFju0gakjED
         zGxlEPr5yYweAXxpgMDpa6tJ6+WviQtkgEmjnm4amgQOtU2gEw1tl+k+GJYjo7Qfw0gI
         nkafqdzLSBUSkgZf5SlSoGb8mBFBmNYgBgjPKPeM6ZeSUqNUjXNaEznqdWuYM/HaPnRt
         LyQT1qa0vYxsbbafojbkmwC4xsvrgCcdGLBxv8GmdWwG6RlQg3Iy5WDgQ0K13ycXW2/w
         Vu7A==
X-Forwarded-Encrypted: i=1; AFNElJ9RZjprq4o98lzymXc1kanQJDlWjq9ufW2KE5yXfp8rv0SDkSHle4f3Y4ASeaW4qdEjXZ1YwTZtOVp2b0Ws@vger.kernel.org
X-Gm-Message-State: AOJu0YzEK/acNrEG+YtmZDM/3bax8lpzFzZDSMFB97HQBu6kD3BW/L0Y
	Ne85KBhnqiQG01s4xNBlfP77dPIyH8MiWzqIyBAulgFBqithJyo7r1Pq
X-Gm-Gg: Acq92OGuFN5E1sCYpuluD5hiZMKh6uXyFrkJSRcuCF5Ub4bphVtBY3mKp3f0R92IFcL
	3CQeAWejMKKg76CwcqJBtjIU4nkYYL6UhuIKBuJYirL5BuCztgFQ1Ee86gksyyZGGwQz8FynFAZ
	fifzfI00esm5hCqGxAc7kjfFGQH4c5E8FIKPA/K6hz+Bfh5FYr/c1S5eLvpq40aqhXZyiB9YvEA
	ma0kn1KAYzKt57v7ur5D9HyXEy9kvOzTtoY/8LF3wCTejK8jeLkNDto43RDswtDBLueMtPvulBD
	Y72akAemxewr+NGshEEFI7V18k4314AftlAQKRjsg6jw/pNrD2rH6r5lLWmNIyt1Zl++ttbtuJM
	wf6u4fEpTYx0s74p2ECOTBC4tCZykH9xG3Tpq6KARKJ4lgQHc+v1eAcaeO6Wv/i83G5PkmHf95c
	Ut0nt842hkJhE1L54DOJDJxt6qRXEqRKKE5/wzvssY/GWO7QdhZq74juI4mg4hb1ofX3JDY5no7
	CAvDvBrNVwVq5l03YrF/Wt+OQgTe8w2JrwxqwxU1EauKp7zNlQNgthUoMwn0srBXXeeKe2BUrqo
	FBhPJPO2KS2ZSztfjBlLR2w=
X-Received: by 2002:a05:600c:c4a1:b0:490:1640:8269 with SMTP id 5b1f17b1804b1-490426d1a16mr227253215e9.18.1779694151663;
        Mon, 25 May 2026 00:29:11 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d4cefsm81771025e9.14.2026.05.25.00.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 00:29:10 -0700 (PDT)
Message-ID: <57ae2e2f-8523-4cba-ad77-920535edd236@gmail.com>
Date: Mon, 25 May 2026 08:29:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
 <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
 <20260520083043.GA18893@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260520083043.GA18893@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/26 09:30, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 11:29:54AM +0100, Pavel Begunkov wrote:
>>>>    	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
>>>>    	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
>>>> +	BIO_DMABUF_MAP, /* Using premmaped dma buffers */
>>>
>>> Shouldn't this be a REQ_ flag as we should never mix and match bios with
>>> and without this flag in a single request?
>>
>> Do you mean adding both and propagating it from bio to req? submit_bio()
>> takes a bio, so we still need to set it there before it reaches blk-mq.
>> And there might be bio-based drivers using it in the future.
> 
> I think I forgot to reply to this, so let's do this now.
> 
> REQ_ is actually used by both bios and requests, so if you set it in
> bio->bi_opf it will automatically get propagated to the request, but
> it can also always be tested on the bio, including by bio-based
> drivers.

Ah yes, good point, thanks

-- 
Pavel Begunkov

