Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB003DA7D2
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177340; cv=none; b=DQtZ+WXZs9uFm8hNHiL3pHeOMeCsMAx7yXJtWoghx8HJL4tF8tDiZ9HMkSQnJWfxYo9IoPRFbXr5JCogqgPTuGKriVgSiYCXE0lGelMCA9abGDPnNbyE7gbtBs+683aV2SwYrpVMww130J4m6Cq2wNi4JCZqN6erWPT9kcrSpY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177340; c=relaxed/simple;
	bh=MXBiZ/wthBntpSi+XVh/5KZUGWD1ymfLzKpiLi2B+50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLg30YnlUDs7dqC1ap1cTf3oYLaXSJemme9wD1Hzs65tAp3xNi3/azvXJpKPFujZKIzA6XIoOI+EOWKAyWk1SAK21ZJEnSOwqkpmnTMIvl6PC23jL5lLN1h3tWeD+IKC2uwSZTlpASw3XfVuaYFZoDD6UeE5B/cJmlPA9N1pNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks1aaa+s; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks1aaa+s"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso22874675e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177335; x=1779782135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/lqih5w8kOsHKdyaSXO9SGORGhwE1abTlQDwvsKNOc=;
        b=ks1aaa+sOp1IU4Gt4nMoXDYLCXD3Mx+MGbDkxgF8grRjAcwSob1Qq/k4toYk6mwLeV
         qoEL9iT9F7oFpcFmcO+ka12sKKyWyymSGfBm47llOR7KuUZ4EyRJBO0cGW9IQunqoYtw
         D2U5DyBoASaN5/xXTiSQMwJjMBgh+drWKglYcIJ7eHQ0mBqVANk+svcqRzgmxR87zZs+
         VgzkEyi7wlvf+Pe7YnQnM6SMSw6nPlH6O1esy7/oTVXftAKeiccmv49bvoyPTYfW8u89
         c6rT6f2ScKw48a6OOo73lL9scxd4NYF8QO8lTGKzXhKvvHF1KGy1qtd8ESF65fOoDbuI
         KGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177335; x=1779782135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/lqih5w8kOsHKdyaSXO9SGORGhwE1abTlQDwvsKNOc=;
        b=DkQK8zUphQYxv+cSkr5qKNt+XRRgTYG1AACzyxC2yHij0kLM0l2jtKDqiDj0awYF5H
         cuk7Gp1yfxKJjnVHbp+q+2/JyO9Y4+Ubs6/mePXNyeQ3so+siIaDpxpjnqqivKrADs3j
         4rx/GdO33sRJ4FMwylvgL1i38QYdc9s9Hf2LBO0VB82n2LbEqw+FVG+j8ar12DMQo8dn
         uEHg1H34gjAPYz+fVt7nU01VsErVBr1KZIdv1CloxTHTbiPMpvP/B35rdzuZCFHrfV/x
         b07lCDkqEYaOWtrc71s+bU4E7MeBOeLUG9v15rkgvwUNMGjjCu+bNr4jY1poWR1MXkjR
         8cng==
X-Forwarded-Encrypted: i=1; AFNElJ+DOnJWM8vnWAXhjPmp2Q3mWIOjz5murVj9FVLWloYE3tvmhb/j2OGPxDJoZg+4qiSmeqChZrG7rQ7+TMDd@vger.kernel.org
X-Gm-Message-State: AOJu0YzyVflYK2JAbGep68KkaQucMdsrvADH2j98ykT2uIJqcDjXRU90
	aKG97Fpvi9GK/9b9yHdW8E0+GeAqhvTKtF9VvYaa4Yhf60pG4UrPrQuC
X-Gm-Gg: Acq92OEXAF4FBqzSIDP8vvkMmYje2LsCQKSzvRTD+WXuBI0qVmjaTjaMRN8zZ3C5DSe
	KBrSx/Zh1ctnuPRur8Hvr8ELaGuxpuoQSCJXTGsvXb273xeWAJo8eQaSfeoFwKZ2AYcsB4DOu66
	JYSRalThQGN5Y0jT3RWNyQgZ4QGrPu+bdmgLny/idi0105YmlzipsLtwR3j/HbVfY8NoodUQHBv
	KpBzJ5qCIUpMHTPKUdi3wZbq3l2Kt2cT1T+yb11h2DF+uQL51a5Lh+KEn0m6R/2jWknCTkDT52R
	sj41I8W9LDbD4m/S8QPMmD+d2No41tzEeoNiLr7sc3ytMiX7FRFQJAZClKUbkBrhkHY7AYDOm5h
	kqr1dgMqNfhHfDh0voEG3IkwxWiu0WAGuaYyTWEWn9ZNwb0EnvzewwLPRonwEwC1jFFHhqHkr5E
	/c/DXLWAygqTv+5M8FqE/1bX24J4ubUhfplOc7eCgkgTq8S09B+C5/TP21nbRvSDoUnDDtrtLD/
	eKaI1e7pqwjdEllkUUGP5MIaZhEMDthbuBQaHI8E1le5fw/F+tlNck/QcLtBx0+wd1fCY534mzO
	BQ==
X-Received: by 2002:a05:600c:470e:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-48fe60ea590mr265981195e9.12.1779177335066;
        Tue, 19 May 2026 00:55:35 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88e5asm329088665e9.6.2026.05.19.00.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 00:55:34 -0700 (PDT)
Message-ID: <9933142a-4ce2-4219-9574-73da30edd74e@gmail.com>
Date: Tue, 19 May 2026 08:55:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] lib: add dmabuf token infrastructure
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
 <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
 <20260513082431.GA6461@lst.de>
 <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
 <20260518125326.GA5754@lst.de>
 <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com>
 <20260519065653.GB8173@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260519065653.GB8173@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/26 07:56, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 03:23:53PM +0100, Pavel Begunkov wrote:
>> To be fair, it's not that dma-buf specific. This lib/ code only
>> does some resv locking, fence waiting and queuing fences,
> 
> But all the dma resv/fence stuff is pretty tied into the dma-buf
> ecosystem.  I don't think it would really apply to something not
> doing DMA at all.

The point is that those can be separated to reuse the rest.
  >> otherwise
>> all the attaching is done by the driver behind callbacks. Switching
>> it to some memfd could be pretty simple. But The main thing it'd
>> need to share is iterator handling like forwarding in the block
>> layer, and it should be fine as it's already passed as a completely
>> opaque object with no knowledge about pages / dma / etc. for the
>> middle layers.
> 
> But none of that really sits in the current lib/ code anyway?

It's about naming. E.g. passing a DMABUF_ITER that doesn't have a
dma-buf would be confusing, and then it'll need renaming at all
layers to support the use case.

>>> lib/ is most certainly the wrong place for something that absolutely
>>> is not library functionality but directly interacts with a few
>>> subsystems.
>>
>> It only interacts with dma-buf, and even for dma-buf attachments
>> are created by the driver. Block, nvme, io_uring are users, either
>> using the helpers or implementing callbacks.
>>
>> Ok. Let's assume for the argument's sake it's not dma-buf
>> specific, if not lib/, where would you put it? I was also
>> assuming that dma-buf being under drivers/ is rather a relic
>> of the past rather than the desired location, hmm?
> 
> drivers/dma-buf is a pretty natural place for it, I could not thing

_If_ there is no dma mappings, drivers/dma-buf would definitely
be an awkward spot. Just trying to understand your criteria for
placement, let's say of a generic buffer registration code assuming
there is no dma-buf involved at all. Again, just a hypothetical.

> where else you'd place dma-buffers.  I'm not sure how hmm has anything
> to do with it.

Looks there is some confusion. It's was meant as an interjection
with an open question, I didn't mention the HMM subsystem.

-- 
Pavel Begunkov

