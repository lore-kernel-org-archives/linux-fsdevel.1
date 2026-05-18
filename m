Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF73E4C79
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095485; cv=none; b=rs0/f4fPcvjoUhldo3XPWZaoX1lZFPnnA3x4YDel177lLe1ARagPJAvP9TDK2R8NEBHe+BgK2CPkVJk69FEFnwbyE/Dj1tDgsrdQD5DzH5iiBPs+Aq6Rrbnq/iZnVYXOyXnBO7FgpMD3bkKTFgbxikqRWiQWw3uxXdVxCd+FrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095485; c=relaxed/simple;
	bh=j5e+A246+gurA03hzDlo2iGh6kM3EeFHUQqmWGHP3pM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LB8i3FgHvgkeuZOMIkfqehZjw10M9J4oSZjFSq5D/wFWdF29xFVWHqCzIjXg/ug0Xyvnp3Mhe8h0VMRI0kQu0fNRvTq/oEHOWc6zWxjlssHMyK2drXKK5G2jMJ5mt/2CCu3qYTGR6+4x6vLhSODB5HTZ3Z0vrgiCx1xpOU8gB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFnLsH8T; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFnLsH8T"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so23978035e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779095482; x=1779700282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUPmegXaiRoLRWLvDg/ljmtDOi29ffNPo2bGfVCm61A=;
        b=BFnLsH8Tg26vGHAXWv6a24uzDk/Tpsulz41kzt+ZbHVOS9jEJvDyKHFb4y/hIrGdYH
         kes4rZjsp0TtpdR+RR7r3VA10Ae36DyUop1QmyudUUJ/fRvSIWPbwnpmM8EisvWxXy6C
         9EoP+nckTPN/CMfo90C8CypEw5VBq6rcoxJpav0NxCVybJpvSqGmeFZtDWKp5l1kSrWU
         CU88bdz6bdSdqOc+Gz8iJR1ImMiAmshF1ag3ov5OTx7Qa4a8cD0z1NILcLL6hE4nIE0H
         dufH0Ef8666pMpPh+N6cMsvAjvj67rlrEpGrftKwlBIY6eOiL6RoJvIoBmpWd9Zbn3A3
         EaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095482; x=1779700282;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUPmegXaiRoLRWLvDg/ljmtDOi29ffNPo2bGfVCm61A=;
        b=d5l/nLowI7X3CGbrlECFwsEqysOtTRxkHJ6nqviAiv3K6dS7MwISjIBqi9kAF2MMRm
         J659/C6d4JU4jYgGP+RHAAueklXRdY14o6T8XzFjGbbg/OO7tEM0Hq/0STR3cjzsybZo
         DnC534fHUEhpXDkTlRZ88UP9rnjUjOKBoDAKYn9SI67E353/nWGHCY3lko1SI/y+xXek
         c7tFj9cH9gy7d1cmY/1R/608V/nJLfS6aiPzZKVJImq/DKoz/JQk2b48ak1xPIrHG1YF
         fPx8wHM+2+L4Iq7iJdFlCmVTiCrBhXp1WZ4cPrTuEWTy6NKYWphZI1aRR2pQ1hnL4fPA
         ICNw==
X-Forwarded-Encrypted: i=1; AFNElJ/AEPtxMdODduUbspj6+aWw5kr63gMWqK/tWH4VkJdFR4JsuCClPoVUQBLZ25VJK4y8evIUXosbdzbAkTFV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9IPDn49HcYGUoyqOvpNlGZdw8hWSeN3Yg4TqFuN3HmFJxtdx
	QOhHInODU6DTZPVr1RWrGaUiARiNx8jvdf4faRq9CZZhq/vo3ZtMWCwF
X-Gm-Gg: Acq92OHiMLYZPJvskP9gU7Kl/qaFL7rx7ZhHEt8uNEuZ9I/Chd4tTaLm7vW4jiOdU7E
	SmV8oG5xj41k0/TNEhSqXkHlZxRtKkqUwjZMp7Hb14l8kwqhM9ZjD13QV+sWPu9dY8aiLx+Fk5/
	4J/y5pESC0v5VlzsOehNyJJeAjn56r50GVnwi153NzIJ9ZjE5aM+YC08hA5vVwkR0XjHCl1xnXw
	/1z0JZJVFd56GQySl+dX5IapFTH8sfg4NQa7AtdvCWs/QlJg4RioCW6cwaKhOAQLzoEFwr1zySU
	sGe56rddazinaNX+1tt+5osmjaQJkHt53XrkHpmcozHJHmOAxTy2Q2Fvwhxajml1KXGXcn5zk9l
	o5GLJU9UQ4EKGPYd1AN+afs3nmpSD4Ffd325SByyikqCd30RLAuPpMzIbyi43uvsNZaSrvpJUbE
	jWTcHAiYoi9BjvkbeZ/8KL4ABCWoM60KdbXdErBT/w+I27wmi0zhpmooHXWb41eO7K3ovC6waT6
	QO80Nt8GJJXqcj5g0xP7tQKfyKoamFS62qNQ2YfWM4VjwG4AAcWKeWPB9Q=
X-Received: by 2002:a05:600d:10:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48fe60e7d79mr178172895e9.8.1779095482306;
        Mon, 18 May 2026 02:11:22 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe79ce3sm80272945e9.31.2026.05.18.02.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:11:21 -0700 (PDT)
Message-ID: <d262dbc0-48c1-4994-917a-1f975c60b2af@gmail.com>
Date: Mon, 18 May 2026 10:11:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
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
 <20260513083937.GD6461@lst.de>
Content-Language: en-US
In-Reply-To: <20260513083937.GD6461@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 09:39, Christoph Hellwig wrote:
>> +	union {
>> +		struct bio_vec		*bi_io_vec;
>> +		/* Driver specific dma map, present only with BIO_DMABUF_MAP */
>> +		struct io_dmabuf_map	*dmabuf_map;
>> +	};
> 
> ... and please add the bi_ prefix we're using for all (well except for
> one oddity) fields in struct bio.

Ok, going to add

-- 
Pavel Begunkov

