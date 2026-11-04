Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754465;
	b=e2UHh8xtBgXBggWbQR0MFVTCje/34lbx0JA1xYytkIcT2UbVH78LBLlfmk4bWTbV4Ph5
	 DnlcsSzH4OCB9L9FNLhBA53/49zMMR4cmd/eDA0ORbZQKN7ZKa7t0CzGo1ygTsyrhpBi+
	 JapcBGxTUPPHJ/a3xtMKIYExLpPgf26DuOKlaC2JLKBxCf+V9d4I6lvaDPywlQzNc/ESk
	 wenrQzaZIC0T9WD1Cna+9KcTlCBFNxUK0Sf+ssRbWu1hxUUwhM7vwR+q/gmHX3Hdlaa5d
	 r+O/dViR/W/Uf3i8aw/tbxURnSDEP00J9GRAtZKneBpoOBzhmIuVWKDzOy2qHr1RncQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IkoTUr12d3aBSwhfLu9j73ajMyz1vUUn+p4JbB9hc1c=;
	b=s5GDCJhGpXlGYLs6kv1ydNFB0JDNLzv6BaRKAUhH0nf0awb17Kbd2KX587m84dDaj57f
	 epT0ashnOEixL2JSHVo91PucupOrBDyizR0wlMU7DJ8yjPE1s14gYc+icyBDziTwA+Z53
	 HJz4WD8Fgd0CHGiLAyJcX0k85aEPzB/jKMog4eqwxk2jV8MjF/5NpzqH9k0cGovGueb6t
	 Ju8LYEF5Dj2dvGrdaxM/VZvPOMIHVs5WlX/ph6Bk8WdNyX8xqUDHliyJ2YHgVlKXBjCOD
	 ybBivk3B8Bzstfmr4qrqLPx22ArpdvMD919VxEHBxe6OPge9KeFxwhpl9bhI8osRNhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x74JWfN5;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0F606A32D
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 01:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA0F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x74JWfN5
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so1053065e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 17:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793754463; x=1794359263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkoTUr12d3aBSwhfLu9j73ajMyz1vUUn+p4JbB9hc1c=;
        b=x74JWfN5h8ikXShPfz4EZ8TGJByCm/kix2rdXXQg+GWssuw/Jmx8f+11kO1OJKvkQx
         P6ptJKKG3pnuMuTPYPcUvf1vPG25sSvkhfc4LHjL9sVd1CfzGwxcVL5dcm/LvNH2jPOL
         /AmWRtRIk6qpwVompzpiz+IrXvZnsuZmuCwNb0pk6Qy8S5ozLPrPqFYDC967eEUffyHu
         TMGNHaORHxAaDKrpKfY1cTVaY3znb8Q4iEu/WK/SdK0X2Q87qsT6/fNNLkq0dyJVJDO2
         HW1tUYmxA9m/cy3GF94xTfSR2hUQYr+M/OuLs19JAv21wQZ/wtY2qI6cL5BGRn5xqyAZ
         tVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754463; x=1794359263;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkoTUr12d3aBSwhfLu9j73ajMyz1vUUn+p4JbB9hc1c=;
        b=P4kAcT+cQfnCqhJTpiGtvrPWA1AI0Ymi4oWRUSj3s8ghI9jYdAR6CJsGokA178J07/
         daLEzWnZ6D83lQoZtjAOs+Lg21cE8gaq8sgC3qdFSyMj8grKr3Un/OiaElTIFZHjD1zu
         L0yMk9Aj/aHYdGKFXoPxmKmLzDld5Dg/G3stqAizjy2l08of1Hoive5w2Su2pkt+RAWX
         b6qlYisNEe93TBV90nmXdyGjpQPe4lObhyPSZ0YM2hWlRGO9Wx4GTkhSR1Yyntnk8v6l
         ecAC4CGithvTovFCV3X2D4GBUI23KyX38OLTX6qB35lsWQuQcUIfDJ4RwzyBR7VbYNxU
         n+qg==
X-Forwarded-Encrypted: i=1; AKwUvBzoN9HdKk344FKTVXVhowUGGisbda/ATkLVla0HRMFKILxzaoDAU8Qn2VH6LQq7JZng+REGmETpI1Uxauk2@vger.kernel.org
X-Gm-Message-State: APuU4Z//HHFV2RphsH30IU1xm755hC3Sx3fzzlrAWbMtG5PBLGJ0+nVo
	ZNb4KzY2OkHIT9yUsx9uFdNqYnY59+W4r3mWaELd/R/Mz01sv+CR+QNN
X-Gm-Gg: AYBFou3Wj6Mc6sBzpAgLGAjGKZWd3XCGScDln2/S30n+5yJgPqf28hnq88lyYOjIZqd
	czrCX7eemdAPg8IBXIXpLOtTcc/tLBUeYBJPl4KPO6uboeEujsnwT1v2gsILQAX9pW135dqaO/B
	BJ8HWvdOp9IQnJvLM7G7hOQvuwNAiV4MIY+ATGfOkkf44ZyBCxBqgUaEXQ3kasUgkOwIZkqFb6i
	qJlETqVFPY0sqaSlWQJKHyh1QCn5C+jmRjW524AcBBAXTugzjW0+6s1uXq9/4lSHl74d7Bf890U
	9oUPrsBhF22OuwIkejtmHWwwGvPROgiqGDDMXjau40RHS3r8VOPfMxPXTMVZuGGzyRHjrIertv7
	5nPC69cZd4kaBNXbuRdfn9TrYPRQPluZ+GqFxOZD4YMpBiIiU8n5zOp7gXgs1fJSrcE6VQ3t/IL
	OPj4Zckl+cmUYSJytoIz3sbJziwqob3QBmDNvvCPcTFEHXEyn5JPQUpeBG5tPv9Io+MD/Q5bW7B
	CXMaPXy4jAjX+eL2QZrsPSUlVMF47ulk+4OTb9ITa13+Qlb8QwDZG6r3w74Trn8WpmS/8cZMmSu
	ijAnGFeHL1huFN+N49C47FWlp6bwHrUHuHOT8roF9PLh3czduSd/N7ssk08iT0LSHM0GD67G7Zq
	fujXs05pviDBAHkUs+1CsIhR4kN66A4MHLJ8OQUjmAuEtmfQozyyw9RCXGmPsom5ybRkpFRM3xR
	iHbA==
X-Received: by 2002:a05:600c:4f0f:b0:4b3:ad9d:e21 with SMTP id 5b1f17b1804b1-4b3ad9d0e48mr50657685e9.12.1793754463523;
        Tue, 03 Nov 2026 17:07:43 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm181749615e9.14.2026.11.03.17.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 17:07:37 -0800 (PST)
Message-ID: <50be53a4-0136-4c8e-97bc-2cdc1caf76fd@gmail.com>
Date: Wed, 4 Nov 2026 01:07:35 +0000
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
Subject: Re: [PATCH 0/5] allow dma-buf-io ctx reuse across files
To: linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1793751001.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 00:18, Pavel Begunkov wrote:
> Currently, dma-buf maps can only be used by the file they were
> registered with. This means that we can't open a new file, even if it
> comes from the same subsystem and point to the same block device and
> use it with an old dma-buf registration. That would be too restrictive
> for upcoming filsystem support, so lift it now and allow reusing
> contexts between files pointing to the same NVMe, even if they refer
> to different partitions.
> 
> To do that, we add a tag representing for each file, save it from
> the file passed during registration and use it to reject files
> which tags don't match it. Tags are set by subsystems creating
> files, should be unique and represent the instance of the
> subsystem.

Fwiw, sashiko raised good points, I'll need to address
them in v2.

-- 
Pavel Begunkov

