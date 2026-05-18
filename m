Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC95325483
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099255; cv=none; b=tIi5+J0qgqQnwhPA5t44pdd5OFGnU4P6kjA+kNrGIGlvJ44BBBFLr6eBABR8EO10nvK0mBGZ/ju/XzkKEQ1MFPrjeERyIDzpgNnE8xPznUjsMKYSF1oz5r0ufjCLc4q01DLXvUGXCCVzLLYfUv+LMQXCH7J9xDG9Q8wzlLpy4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099255; c=relaxed/simple;
	bh=3CuHTJb7a1uf/Vt2GUcQwRyWkRY1v//75zEJ72jrsaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAE9mAR8qBQxekIwoyy0Em4H6pQWMTwQdU6IVkRTU1oJVwX9Hq+XUHllPCvDkLpM0ZGJi67Hy+tdzWR5s7YRvPrVsXgSv0lIBUZM3xNTP+iXm2Lfl0UnnnQPH7YqV7En/GXGgvg7PzfAg+P1/cI2HxZT7tmB37UHcJa5fwyAPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1ZDf3kA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1ZDf3kA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so31091725e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 03:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779099252; x=1779704052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqBDj90Kc3B5RL3RITDRmt05U20tIBaa43CY99Xd9RQ=;
        b=R1ZDf3kABY32pxy0h+kPbdKnYZrzH+iwDxvK0ocrMzmv6o/u7R6jnvJNBjuqGhkdpP
         iB1W2mKv4uHNINJ4/JHtzaDwU9PoOKCte0Dt79zh0ecxFFMPRqapHpVfQA+keKfmXxIS
         8DayMB3M23H8ChWcpQzKj5cxBTOrA7GD1qECTci1sCGjehOqYyruEyGzahz/9HNyMIAI
         dRpw5nxgLiUc9hrvd/73CZz3dusoKm1en3BGRDHuSHotzc8LXPnDIGRjijVTeFqz9yi6
         qssw9j+pbQAZjKy7HRStnmeQzG53nx0zF/WhTSRPfs+mJDUbdUBlAoLY7uWrqoLow0SF
         p8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779099252; x=1779704052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqBDj90Kc3B5RL3RITDRmt05U20tIBaa43CY99Xd9RQ=;
        b=OxNBl3SobKvdtGiTBV1H9m5MMSPMY1J88cVfhqReuLUkvHk3RahEiYxoq3i1qOe5dw
         jRTs9YGWG1MAMH87O9b57Ty5Q8xYxLicCWJM8Cx3axlirW/ZKgEvp4udt3T0JpkgkcS0
         xh4Ep47yRBz2pLI5me47+C9dvxbqcIoQFCOnPDAUOka1jKuZJgZzMNwUXRFCUXDqw3Og
         +06Pxst0IT/Hnt7rotPolQNOleUNMXjHe0IVVs3BOT2bX5f/DH/AUuFXyH/pikWh3cQk
         Uqg2ciGdWIXf4hAAnZF8bvZAQX25Nbz5Vb2dyl2a4226xyHKSYx9oEydoU3XEDeh7cl5
         OuBA==
X-Forwarded-Encrypted: i=1; AFNElJ8T5q2N1Iy5gtDPSPwWEmWmFkjAhOeRBfoTe54zQZdgYqvngoLyBkOqUAnV7VS6dIBP2Tf4LSS26HiBKMpC@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+mELSgyqUXGvMy3Lw166TOS6IBJSvw1/nPVVsJmVnpTU4RaQ
	faU7OFVN+ZWx+3YcOY9M1lyGNJXU3jGC8x8zQtn+c0e14p7HCeDD7cvn
X-Gm-Gg: Acq92OFCBE7sNswe4EgdZ9H95D3u3H23GEgAWJJi6hNj7wOZMvj2FgXVvcOObTRZhlL
	ViFiliWTX9w2sW2wikYdoKZahArLJY3J2tR4iAwuIotp48NPGRGn4cziH5b2ciC2CHYFRMkMBdS
	rLRH3ack80ykhvCtofFUiF29gp3VyXem4dm1S/+m9jsppZXU5+q7ZpfMMfmqpdXdHWgyxKZSWUO
	zU5T3SUYNSMKi0jLAaP4MUrtZyIIrIbfEQfXD5BXC8qUjXh+jRYVog0f/9+ZvKbUraRaQG7POvC
	Rt9SYGlitQGhdF1lcuDs46sFBAvG3inn/3M3ZrTwpysEEQfmhIG12RAL1/xgVFXJfBH+nDNMSlr
	CxrCcN6Sm5wCZNWH0p2yl+33Wb68tWGMRld2p1WtmfaHfnEMwoU8mJvJ8CIvTUiemnHdxH9fYgR
	j0gR0P69V0qxmAvz/+XHc2Fj0WY3ElwW4+27LeAIGc9+ahPh/fOzca1Sj/wdYvzNxuXw3CvYa1Z
	qxyXkaK4LVkygCam4A+dTo3qJQXFqRUC/hapMthsUC6QkKd7AKP99GpVdk=
X-Received: by 2002:a05:600c:3b12:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-48fe59ab80emr218398395e9.0.1779099252361;
        Mon, 18 May 2026 03:14:12 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm38877974f8f.25.2026.05.18.03.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 03:14:11 -0700 (PDT)
Message-ID: <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
Date: Mon, 18 May 2026 11:14:09 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260513082431.GA6461@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 09:24, Christoph Hellwig wrote:
> Naming and placement:
> 
> This is about dma-buf based I/O.  So I'd expect it to be named dma-buf-io
> and no io-dmabuf, and live in drivers/dma-buf and not the unrelated lib/.
> But I'd like to hear from the dma-buf maintainers about that.

Looking at what Ming is saying, it'd make more sense to keep some of the
parts like iterator and the file op more flexible and not automatically
imply dma-buf even if it's the main and for now the only medium. I.e.
ublk/fuse can use a similar interface for mapping buffers to the server
even without dma mappings.

I don't know how the API should look like, maybe passing memfd, and dma-buf
supports mmap, but I think it's better to call the op something like
"register_buffer" instead and keep all it in lib/ for the same reasons.

> Config option:  as this unconditionally when DMA_SHARED_BUFFER is enabled,
> why does it need a separate config option?

More clearly marking relevant code, easier to make optional if needed,
and gives some introspection via /proc/config.

> Interface:  io_dmabuf_token_create / ->create_dmabuf_token filling
> in a structure allocated by the caller feels odd.

It's minimising pointer chasing. "token" is mainly used by io_uring in
the hot path, and io_uring just keeps it as a part of a larger struct.
For the same reasons "map" is allocated by the driver.

I can add an extra parameter to io_dmabuf_token_create() for how
many extra bytes to allocate for the caller's use, if that makes
things any better for you, but it was easier to just pass an
already allocated struct.

   My gut feeling
> would be to move most of io_dmabuf_token_create into a helper called
> by ->create_dmabuf_token so that the token is allocated in the
> driver data structure and returned from create_dmabuf_token.

-- 
Pavel Begunkov

