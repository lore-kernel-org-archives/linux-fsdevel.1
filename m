Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530841C2E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108023; cv=none; b=oN2I6b3+uo/qxmXinHjPhrmqNtnbbOfrjB0ZjnzIgl6j3PlznUR3htd7ZIVZx65koRMcArU+ai8rYn01lDS6qWLes9x3C+qb2jFE8+1NkCb4XM9LxcrisxHR9SiMDWnx4C9o3efXwZFm/Baoa1y/Ot5ofH/h3tTTjJeYBRdjO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108023; c=relaxed/simple;
	bh=Mcv0gCsXAUFhkjqy5dwsfsmky6PBnJ9/bZQl4jFqXoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sziL8xylF2NotDyq5MSOwC3oL1QU7qkgoRxds5pCdTFLA7TmYLuffH+O8m/BhGglUYavoXrZ6wihK4qIdUYc4P79d73ske8/2FgI49b6OoQCYAygYmbwX7j0DDlsgC5g/dqPVqUvTOISMh5B76k5UdkBCQkVVWD5vLUwOwqRQOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldE6kcPi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldE6kcPi"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48e56c1bf5dso10443465e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779108021; x=1779712821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXVLM8myHSCmhmEigozDJCG9BugvlW9svyQsziHjoMk=;
        b=ldE6kcPijQ/Hej3uTb2mO+vEIefs2sqY1NKId/V+147wlqd3oqIKkGon8DEsKZa5dk
         T6Ix7dztbeyZ45XcmyYdewf/zIUmYooD3KWj+I7aYQaroDlRCD/Al3Nz/suqK0DJrB9n
         hpmHIKEFi6UPyBYwKC7D4LacIPfYR3QPnxbfoKiQH5ZcA71vDhee1bs+jArrNZY8nOY/
         2fZ/a7g7sOa9ZQtdBWmCI252Pz4WOB+qrC9s4x4nmAJ3LtQlj+uC35X9HztbaGmDWYZu
         MSFcZajGYOABIfHqGsgYm9Tp0nsR2VcLRag533bANJQsH90f3lv2QHY5SpF3ElD9n196
         0Gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108021; x=1779712821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXVLM8myHSCmhmEigozDJCG9BugvlW9svyQsziHjoMk=;
        b=lCoVsohcnOp8gw7pcntoJ/cosGYw/XgX/NItWzyb+kHvfrh+M3CF+bRHghq06e5Kpf
         WdowEXiQwNNRjM+Mh34/5HBW0wGgsFNugTPamqF1Wr3R7qoGs6oET1iQDpxqanxUBj+i
         NMPuivOLd7PVNb1y9ROAsJIYPfeGxlLIHYsSGyrEfGRjQGsDZTkjtZkbdiWpEFrZCAcH
         jaib/IScZoSJy8KM93y2snTaN1sayyjULnmns7tXkTAJttCFVqPa/nDhUmwXgGFpQYlm
         eL0Idw+JWOkt91ddG83gM2pP7h3Gp4FnoUJ+Ekfwb1sWenMtfYI7AvzG+rm4ctIYiYAI
         DrCg==
X-Forwarded-Encrypted: i=1; AFNElJ8pIUbAC14w/g67kwWYIQsGPpoYHO+F+H16QQk3pgpIFj4EpyER1gSNLvW7wlSQmWZW+XpNSYVTkYYojQ+F@vger.kernel.org
X-Gm-Message-State: AOJu0YxvujWFmENAUXPILE8unPVS/X7iwXsBMaTPcdvjaCgDS4LbldNa
	JnMNCahIHf3NFJ/0shqEUUD1dTjAU7PX1s93rBkWZ6HYmD7Keo6J7ke3
X-Gm-Gg: Acq92OHzys0W2BLle9kafoFfrrA657Kh/iLi5ZgJV1Cvg/+k38Zuv5AxckKy4bh+d7o
	pr+ld8jbxXctqMjrzsWwaoz01TNfyyEXihLquuyGRG9rsEh529MsDYDTlqC2xJl2R3rB9e3Re7o
	GWFFZqrI8xZvQ8BuLq+TmvQ+rd+6Qw9/lkUjaJnJuAoJmGkNKSMPJBoGDF7kCIMcSI6KNlLuJqk
	55v399qo/0NWLzL3X0USbIPsNO6Oa7v1IoG6FJ9T1fq4pQ+QZDCDi+o+igqk2s4X3CmlOiWxINk
	4/zmQn6tDoxBDjQdGHqRqUNNEFcV3UaMw/fHaLO7tgO2qKjJn4L8w6o7n/72/UO//6vJlo91C/f
	E3/0rvTs0Tfh/TqDgosBx88GZoGfT8onwXsWBRsdA8uVdDGu9EFNcDvD3KmYyoTopGj/X7s58yQ
	TBX/umr/rvwPbaN0lfqjly/VI7D/Sn4GHey3/eA8snSHVQUBSjIcUBL4Mi6xY0+a9WirrIQGyEU
	zuYV9Tptn0zOQl2J+4ZSJ0BhUO5lUqdpWwFj0ll1WyCydiFFB4JPlDPU+qpvcUjbB1ehORPO3nl
	gD90IoaUBTGh
X-Received: by 2002:a05:600c:6592:b0:48a:557e:6b4f with SMTP id 5b1f17b1804b1-48fe62f8861mr237008575e9.23.1779108020601;
        Mon, 18 May 2026 05:40:20 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8d39esm256597555e9.7.2026.05.18.05.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:40:20 -0700 (PDT)
Message-ID: <4561c621-817c-46be-8ff0-0b557f6c819d@gmail.com>
Date: Mon, 18 May 2026 13:40:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
 <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
 <df697a76-c700-4908-ac08-a47ad07e0796@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <df697a76-c700-4908-ac08-a47ad07e0796@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/18/26 13:22, Christian König wrote:
> On 5/18/26 12:29, Pavel Begunkov wrote:
>> On 5/13/26 09:19, Christoph Hellwig wrote:
>>>> +    if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
>>>> +        bio->bi_io_vec = bio_src->bi_io_vec;
>>>> +    } else {
>>>> +        bio->dmabuf_map = bio_src->dmabuf_map;
>>>> +        bio_set_flag(bio, BIO_DMABUF_MAP);
>>>> +    }
>>>
>>> This is backwards, please avoid pointless negations:
>>
>> I can flip it, but compilers tend to prefer the true branch. E.g. this
>>
>> if (cond) A; else B;
>> C;
>>
>> can get compiled into:
>>
>> jmpcc cond B
>> A: ...
>> C:
>> return;
>> B: ...
>> jmp C;
> 
> When that is really a performance critical path then you can use the likely() and unlikely() macros to give the compiler the hint which one to prefer.

That might be more penalising than placing them in the right order,
and it might be fine as it's new and all that, but it's not a clear
cut as it's definitely not created to be a slow path. TBH, not sure
why we're bike shedding such things, is it somewhere in the code
style?
> What could be useful is to have the true path for the more common and the false path for the less common case for documentation purposes, but in that case I would expected some code comments as well.
What kind of comment are you thinking about? A "this is not a likely
path" type of comment before each mention of the flag is usually not
very useful.

-- 
Pavel Begunkov

