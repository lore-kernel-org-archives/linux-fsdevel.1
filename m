Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF448C8A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114242; cv=none; b=QE1O+MvzDWeh9DCcbAj1e/+eBjiln3khmWraBdPe8LUCnRu06khLtZqo3xIoptwxIikEXwppXZi0m0YNso6cLHQVfXIbVGQFTCSPu8LtIKkuh06fHnKeUz1DBxYkHH1RibTSbwz3MIPITV9IWtYMi2vRjbfl+1AM6RIoQFnazYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114242; c=relaxed/simple;
	bh=Ja0DTfaEYIoGmin0aywYwaWpB4UWlA4iW9ZxB9BMNMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxhM5PB8qnIc73isvIzuK4p1VLiMLbx9N73GWWWltNQhI8a02Lx8gmqG9f52OA6iIu6kJ9FUOKOxAt+emPXW+mQkt44vEI7khe0qV7LuQyCWV36g7ZY4TblKkhBRtvFpDizrtL98xvKQ9PP736ae6ekl/sjoGx6JA5UyWHW+Tbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFK1UxCj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFK1UxCj"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd11a3729e8so383703266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114237; x=1779719037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m58bYDJ543WmyZ11IWytLuY71YuFJ2Bw6ePCWpryz/I=;
        b=jFK1UxCj/9hu/WpBG5drcZwxOWtR6cGYB4ErAsxcCoLRnUmHgxSqEAMVAolDJJrH9Z
         1hdwdgmStI3zkbuwkOFKLgAduKUp4s7IUV0QrqjtVZyxKN2R7lpp0/keTjJeNXORBfRY
         iKxXU0l5N5r8xvhB9XCY4w6jrNvDuJXLhYZ9wYbjP+gKbOrmICrOApzAhigvnRrrinaL
         Gb3NRTZM32EVOdDbYX5+S47nP2KhGAiP8F7wO2/WZgTZ0Wdf97sbuXSYfnv1T9IEtqU5
         Nv1u3gHY/kqeewKzSvB0u83tg+4FS0uxqPRyB/9oZfAlZtbMwcY0Wlc9g1oZrrMLTZS/
         v+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114237; x=1779719037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m58bYDJ543WmyZ11IWytLuY71YuFJ2Bw6ePCWpryz/I=;
        b=BNaROxJmeXRM947Z0//sVlAUcJxjXGfxR1zO/thte+PEw5PD9lWL6AqOxBDz3NQkEY
         IAv/1bUoiB7HRnpxCrd771K5zrqSdL8u4Ote8rF+I04wBWousxuvX4eeq5uCTm3q6OaA
         yruwuwMN1iltcUHOUVeu0LRIJmK8kfIOtXAWxTwlKJfi6km63ZQXje2oJi0deUquhBdW
         Q6UH8/H2zK+qYIN3vok1uM1Z1q0uQrKHiZ00bPoniQM/0ZRa7+Qr7pRgY+Ojp20UIOO3
         sx2eVDg7U4EkLXaInKXFokDWjf8f3GMrekloEdIpw80ib1Fd6G/DuPrSoYyNtX5jKGHg
         J7pA==
X-Forwarded-Encrypted: i=1; AFNElJ9AM5zJ2uwf8FXfnYmXJU3Kg1bCJu9iEMu7Huco5z/Oo+aBXAienDrZHV2KpDM2FOxTpHxo49I04yYZpeoU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkk02VF93tFLHloeblvQfUalcmU/i0p8UzaH9a7271b1vBG+kZ
	DW8oCe24CAPX2iakQISsryltlmrC7PwhVygMdcSnCeFh5Ip5ELxLLSOt
X-Gm-Gg: Acq92OHFB5468fpDXWz02+2wYu6tdS7xeEstARoA/US3sB60TKo+nnDOh0O7u7YValA
	E6veGe41mteM9nobAcOPKC9YOXkgWR6hWTCN+F1BAeyshEsRGXx0lkQmyjFpb2OYyROsd5JUqOU
	nPPClHfcm0qRvscK8Uzat0M0Ja/plUTgiREzVf02kKmb6iDB4++2tUj3uiKC7g/GAh9duJ1uJMk
	mTvQGIYkO9PE5ofmfqnzs09sbHQLGRsYTFUJn6rL+goHr/RA43E1F3Kusg3GI8Uf5W7+VDA5Y+g
	go8QJPL/9skN78+9XpKmgJ8Co+iRNcVvSpOY4BlPrEg5XadViqqv+ct3Chl/BL3hEcUv7MJj0Qe
	1UJ8iABiZ6BPO295I3hTF6iZsEIYoU4EoRJiOzgI6s/Fddv/o2m+vuoCMBG+Fghv5iRf+FnBpch
	46aIB+nUEYiX/LJZbMqPaoNlTtOqc3q+fo6ebxBG+32t5v+jjZGuIHiLxDxQ3wiMer9tHzG74ES
	lujDZwTG6RoEd0mCKOg2Xq5wQ5KyvdkaTnFOoKdy1jhZifFmqZuhHmxj+je0JzsIhu8l7y1KxZb
	9w==
X-Received: by 2002:a17:907:c291:b0:bd5:7a3:a58b with SMTP id a640c23a62f3a-bd517994249mr821357066b.46.1779114237152;
        Mon, 18 May 2026 07:23:57 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d58c79sm5325464a12.12.2026.05.18.07.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 07:23:56 -0700 (PDT)
Message-ID: <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com>
Date: Mon, 18 May 2026 15:23:53 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260518125326.GA5754@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/26 13:53, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 11:14:09AM +0100, Pavel Begunkov wrote:
>>> This is about dma-buf based I/O.  So I'd expect it to be named dma-buf-io
>>> and no io-dmabuf, and live in drivers/dma-buf and not the unrelated lib/.
>>> But I'd like to hear from the dma-buf maintainers about that.
>>
>> Looking at what Ming is saying, it'd make more sense to keep some of the
>> parts like iterator and the file op more flexible and not automatically
>> imply dma-buf even if it's the main and for now the only medium. I.e.
>> ublk/fuse can use a similar interface for mapping buffers to the server
>> even without dma mappings.
>>
>> I don't know how the API should look like, maybe passing memfd, and dma-buf
>> supports mmap, but I think it's better to call the op something like
>> "register_buffer" instead and keep all it in lib/ for the same reasons.
> 
> Let's get the current version landed.  If we come up with some kind of
> non-dma dmabuf in the future we can refactor it and move it around.
> I'm a little skeptic we'll be able to share code as long as dmabuf
> is allergic to physical addresses, though.

To be fair, it's not that dma-buf specific. This lib/ code only
does some resv locking, fence waiting and queuing fences, otherwise
all the attaching is done by the driver behind callbacks. Switching
it to some memfd could be pretty simple. But The main thing it'd
need to share is iterator handling like forwarding in the block
layer, and it should be fine as it's already passed as a completely
opaque object with no knowledge about pages / dma / etc. for the
middle layers.

> lib/ is most certainly the wrong place for something that absolutely
> is not library functionality but directly interacts with a few
> subsystems.

It only interacts with dma-buf, and even for dma-buf attachments
are created by the driver. Block, nvme, io_uring are users, either
using the helpers or implementing callbacks.

Ok. Let's assume for the argument's sake it's not dma-buf
specific, if not lib/, where would you put it? I was also
assuming that dma-buf being under drivers/ is rather a relic
of the past rather than the desired location, hmm?


-- 
Pavel Begunkov

