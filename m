Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C974A3415
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578234; cv=none; b=ga4YeQqhKMB37DPh0cGqFKSf52HhA0y3s7c7DFqrC4oaLuB0lPpHIcODN/6HnKTT2l9s6b/YARRTSBMiR/ZBgZBHpwpNOtvjZmLSCXUG4yIL9y7SAb33dA44dkY+HAfb32MoqFrVIyLDEw/QeyjIo2sUIQ900nmM6HY+Lce2lm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578234; c=relaxed/simple;
	bh=9ZVEYWiJ8mfJhHSDmdYoWsnzgviWs338ieiJcp1NW8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHefMnEFNAYg8ybmBXPl/tsNTeea9/SUrz8HXZuvDyEDm54c19XMXFEBLwYLuPCFIdb3QeqpK1uR3N5FXs7B4j5G2DSPFbGQmv79osvyQ6XWfFVJIhz8WECTue0JxljiCzP3w2aLwviczTuryPwJMwa3q4pDwiKsdhdZFpExuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2CAUCIc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2CAUCIc"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd1caeba6beso46384466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578231; x=1779183031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGZAkcM+ym8AsbVGOAJ6+xeqYSrWcyKvdgdcKQ4eIYE=;
        b=h2CAUCIcRb1DusSV3M0DsVMKaSnFMzQWB6BN488Z0jBqWbmUCtiTejmJ++7kPmu9az
         GBKb0ygNhV2hiSnqxDsOYc4Z4bZoFQNS0sIGhGkJOhwnEXt056MHvrdx/cJoM0ub2HUN
         NOvpioQrJODvqUNhlzDTfCE7DGx/rnVg27HjOsNWBMVHOWkKkLp3exAhuEciaqbO6r9F
         qRqgLy8MESUqxlcORPoWtDDbcIV9/tbZe41qBYHOUhIsPqYoAtcBornYvNJbQBmrrmQa
         gyfnctFEo/U/XYK9lRLVL/m9QMQM7poAmGO/UeuMf4Zlfs09jO9HRptcF0fqlDrExe9g
         iAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578231; x=1779183031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGZAkcM+ym8AsbVGOAJ6+xeqYSrWcyKvdgdcKQ4eIYE=;
        b=s7bCBMQIHJW0OKSRXFVIVCh0uxXhPttSBwiY1Q20JovzVQC80hDS6YQcKK7/bPE9LT
         AQg/aSRoODqAZUsnaNemgxGtP5Z4+hZe3P+G0/0OqdT+aEObnW+RxfCC6GEx9KinrrsA
         ZmEErFmODjcHObxUQs6wWmKwfyCTC4oWRf19O7S3evbnME1J2Frs30+jfGwNKsLRPQbF
         xzfxY+70uItHj0UnQxdI3tJ+Wf3pqD4VbWYdh+yzjF6IO/q6pRlAj9EuHkR2rUnL91Nj
         uKdKuUmRW3oIZ/lmx41BAV6ERjX3obMqJrFov2aY4K95TceCpLQuj7oMBOkM2PWiqhv3
         BvrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8scEyRbYntY6w5eZRP4lnRwMSUsJCzZ4OzRTvPcda9ykXnDFUC4gn49Bp4cxRRVmTAvX5V4IW2lmFXH0s@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkY6Exi39jx4RfBZj3JYHgo6sw1RqbFAzz9dmtOqewz20vuai
	eoEqrvFST94ynkUJJVbsHKz3iO6Qyv6nnxEIdgqvVFoWaxUr6q/qwoQF
X-Gm-Gg: Acq92OGELZtUMmTLsjce6MahJJr8cZc8azP4HQ7dHkto7K3TUbT9detF+88BwLBp7Wv
	prC6Y/CkWc5MMgVcJ5Ej+wPMqwYwwKuEUwVgLDqsW6GjkVaaA0j9yOXLhTzmlGBIWG3hWu7SbRA
	KFHSp4W7S9uyYodZJJzSX0P3UwEyD7bW52QAYg010opl+g7ceTrsfWqM4fzcUhtaEA7c5WhdKHr
	jrASpRIeKuYQ+hapMEOilQKDrxzcf+O96Nv3fnSOdczFIwdsgWY9voB7OTLUrQbFVCo7HSFdiGK
	3GQReDfd/Dor3CA7ROJ2NrCKS0xyO97rvnr/Wz7xiBA4lqeL71zw5gWZaxPUtPoUZT42WfzXTuP
	pPtvWzOeR1Fo3wi1S2rwsvi8T/srVH6u/i//Gzfzfe7StN6hmoyG/fn8TA/D5VGEYjAA/wR0CBB
	19s6D0ilURvcaz7RuB/zEuKsFDh/uDoxY1u2XfxXitz4CqRQ5pBXYpm1IlAHm2JqXnwJn676XxS
	Og8n+Pkh79Z60JTSPfq7vaoPdBoTZtiVaEnN+GWWBeP9loHOA==
X-Received: by 2002:a17:906:99c3:b0:bc4:f3ef:e43c with SMTP id a640c23a62f3a-bcaad52246cmr973369766b.45.1778578230560;
        Tue, 12 May 2026 02:30:30 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::372? ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfb7b17d1fsm303492866b.41.2026.05.12.02.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:30:30 -0700 (PDT)
Message-ID: <a4748a29-8aa1-44c1-a1e4-b82f4f191d4a@gmail.com>
Date: Tue, 12 May 2026 10:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
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
 <20260512070045.GA32030@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260512070045.GA32030@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/26 08:00, Christoph Hellwig wrote:
> What tree is this against?  I can't apply it against the usual
> candidates, even accounting for the time lag in getting to it.

It should've been a Jens' for-next

> Can you provide a git tree?

git: https://github.com/isilence/linux.git rw-dmabuf-v4
url: https://github.com/isilence/linux/tree/rw-dmabuf-v4

It's a wip branch, for now it's just v3 + 2 fixes.

-- 
Pavel Begunkov

