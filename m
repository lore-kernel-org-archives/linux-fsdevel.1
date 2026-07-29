Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D968391E7F
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330693; cv=none; b=u/KAv+Up1rtTgXaK9ef20MAJxoYTZMffuW2B+u/LlqTexLPKpjqyu74eKfcm5q0Uma6BXHZxdSaZlulFKwjwx6JJHWvekOsVsTn5migh0x4J5rzDymGX4rCEdB1+ObIrT8yn7FQTbhEMTuugfNyQ+RIX0kaF+1ewz9uRSTCuWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330693; c=relaxed/simple;
	bh=iCKby9e1qhvE8ns2sICVS+CCbRWmXfOjz3bB7l8ahOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHH13oW/JYlPRPwIp2gZ1ZJK48JRYN45pWc6O1l6c+Brk4zyuil8C2USDWYqrlS6Bl4vER4LXX0k8kR+37CJxqIgbdaQHXw+v88fUkZAiuaQV6cnDugQ8a9EJ3O5HnpvLb/bjYww7CayVRLYDO8rDKPqSt7igK16lH3DTsVHuhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jti4ijP6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jti4ijP6"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495635a85d2so7229735e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785330690; x=1785935490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QlPatibx3g8XfK6S5eprVRseiFbSJCNNQ3hXCye36cc=;
        b=Jti4ijP6nIE18iAiAjCvzk7mtWD9uz6VNgJit+2+WuC97b8pScL9tVa28/B7KhF1e6
         6qBRiH4ncAICQI6XhK5XOV/2qsaxwo/f/oJmnCgNx2vo09a6sQtcBSS7pRXnSqxFDJGY
         INpBceOL/EqOodFVGAxNBVghwit1FrKOGVvhaUoDsKfB2I0x5a5hNYhSotMKW3frkoQI
         Un8BtM07xXis4VfUBUjrapU6CSGh2KhiceUEN6HRqsuTPC4pRlQEN7UnWjKm8NIESBvv
         YUAAYlsGBXioHmaXaAYAQZe4TvPo8pV8I6t24ZujjdUL+tNRxbyyQRntMzULHkrAclbQ
         8QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330690; x=1785935490;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QlPatibx3g8XfK6S5eprVRseiFbSJCNNQ3hXCye36cc=;
        b=EvO+Hx8P6n3dAmCHNhP1ppAHzXDYKO6WiF440plAFYtZw/VHjmrynEA8BiKjdbl6bn
         HHkOn7SPkfrINegFvuxrwVUZ1HUiBi7X+FBe+m3eHRAGlH+SsH3r3DVY58Ub3+Gj0OW3
         h7K1jkDck7POu3kEvKGGH8y57Sd7xsTqZhf3e+q19q48c+uXWUa4BauuPCjPAqpCGMlH
         MA+icNON/t5EctLUix3Lm6N4HrzgyT2fn/BVDgJtYHxAutcgynE4eegVnZl9HzcDw6/Y
         2xsfWVc30q/B2dmWPJbLrp02g3XdeEg1A3HHlsifyEdDAHg/Oh7YcaGZl4NGL12jOhAR
         71Ww==
X-Forwarded-Encrypted: i=1; AHgh+Rq0zbK2QuPEnzXXK+z41bxSdyviVa+2LU3FkKrgScQDUyh37lxyKfINxCp0q7+tL7R27++uTBAS6Y3ukGnp@vger.kernel.org
X-Gm-Message-State: AOJu0YzCbH3YS1zWBoi8r6lqDeZbQ840sq6bSfaoll5jcCGACJ1Bs4Ef
	qj75EGKAn3dcEAfVlowiTcyXoPqmkl7FD6TePr/rXAp3FNjWX9sg9+eO
X-Gm-Gg: AR+sD11pt++hw+S+SphKycnfctuOp/sb+856qOS34+bQyy+mwVHngsoBH7alTiAEPKM
	UNlRJNv90VMMxT2rRC+tW2RS4d3PrV8X9PSM6/sdalpQegofstlGH9mOfoQp3L75KpTtWq4UqoZ
	T5Xs9suze5vhBuoeyeZxIYgJbgHRLaaGCWnDiZX83adXerkjPpY2xK9dDMlHhZ5llp5gJ9nh/MT
	rWcerAgmaIxDAA+KMaDvzsABM3g+uuFp2vbbUpAAB9J2kJQubTidivDsy/ArcDlS1wlVRC9jU0C
	GrWY7OFF/UuMipIvK1s2tvt85NPfqL5tIS57BNe34dULfhZjWgBMpGlYXbz4qq76VuwEV1zO5kH
	4T1jUzzbdiDgPdKYFnjc+qBf1mBU3aGjSYEOzybVDJxcK3vylfTVsN05HK2Aex37K34ay+99/Dd
	h8kF2CfKzHkGZrih6y9zMrbvWOUJWx4FcDnitbPHdVpR0Zj/VXapIxAzDPZEAoz193hSA/fbB5x
	I3LPSztLpjNw28PzxcLVREbxwEIVfZixcJ/cLBSZYThl9uNVkUpkfLtOxWn1STqS8AcYdCEAegv
	ChIpo/+yWAacThzvFY0=
X-Received: by 2002:a05:600c:3485:b0:493:b243:8ffc with SMTP id 5b1f17b1804b1-496c6586bbcmr69846215e9.35.1785330689440;
        Wed, 29 Jul 2026 06:11:29 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45c338fsm157280305e9.8.2026.07.29.06.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 06:11:28 -0700 (PDT)
Message-ID: <60df6af0-3bf0-4954-8181-a0acca7c21c4@gmail.com>
Date: Wed, 29 Jul 2026 14:11:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] dma-buf: introduce initial file I/O
 infrastructure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <bc20381e8daf85ac58811c344325d8192cde9d1e.1785274111.git.asml.silence@gmail.com>
 <20260729065927.GA9534@lst.de>
 <340dd033-2a45-49e7-afd6-95dbbbf624da@gmail.com>
 <20260729112808.GA30851@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729112808.GA30851@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 12:28, Christoph Hellwig wrote:
> On Wed, Jul 29, 2026 at 11:37:19AM +0100, Pavel Begunkov wrote:
>> On 7/29/26 07:59, Christoph Hellwig wrote:
>>> The method name feels a bit convoluted, but given all the
>>> previous discussions I don't care too strongly.  I'll leave
>>> the dma-buf side review to those who understand it.
>>
>> I assume you mean this:
> 
> Yes.
> 
>>
>> +	int (*init_dma_buf_io_ctx)(struct file *, struct dma_buf_io_ctx *);
>>
>> I agree, and all dma_buf_io_[ctx,map] look clunky, but I don't
>> see what I can drop out of the name. Suggestions? Maybe I at least
>> should make the fs op sth like "register_dma_buf".
> 
> I just remember scares from the last discussion :)
> 
> register_dma_buf sounds fine to be, but unless I misremember there
> were objections to that before.
I'm going to respin the set in a couple of days, just going to
leave it as is unless we find better options.

-- 
Pavel Begunkov

