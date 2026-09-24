Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433084A5EA8
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265232; cv=none; b=Cr6/WwzeL4qOlhOu1jqSNW05WCK6w3h5ypZcjrqt4smQ0jfJtWd57mr3oIuOSj9/BiMG9XU33cpXGdpoqWKnNkVtJwnaI6S4znJ9Y0aoRQGwZmePagTWZ0iUQLwAnuDSJvKgtVLdKPnUsD9ELyFAjxv0KhJ2S+LFuMs2nxaEMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265232; c=relaxed/simple;
	bh=wMUbxl5vt/9aakHALUb0wzH/L2TqRFPYLffnV8Cgl4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwndrKopoTJjAXi1a8yXiAbzzKBM1iH/S/ocoq9wplhCwRbiSawPXXzOMVF5ARvK8rtrWfBNa/tDrOsxjhi+9zla0urQAIDMjmJ89443mqlgbLns5lGSNcTKf+sj9SHzrfpR5nhficPvfe5f2EpWX3tS+CE5RoNMoR+nS2kO9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCGQz2eS; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCGQz2eS"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6aa13a28848so1600432a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265228; x=1790870028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNmm9vpoKogbEkGqMdf9XAhWMEnJbsDsb3NN6zmWdWA=;
        b=bCGQz2eSkcQYMSbQNfLYFZiq45HlXMpEwZjtjh5ha94/5vOF0qLHpu9X/lZmf/vZXK
         DeUHu394OYCJ6Lj32I9RPjdNdKveIfOpfEWorZhCfIEYywR+cRALMykbVEFtub5oDS2O
         MpV7RU+rbkuShz+jA3asVlrDJ23iFlQ4iSPCrgC2ETXrn5yuRl21vE7rVYDSB5jygVhZ
         dyoViXu0rSJrHzN+ecwAoQ1pkTwqCTYP8kzclXNL+9EdUyS7bNOcgcXqSJPkcGLBQzc8
         HLItADMdjRIEMYD5rCPdt6ykQwa731k1tcla8CM/ahBbW8iD8Wx9Jtw/dlD8gEdJRYNb
         Lqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265228; x=1790870028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNmm9vpoKogbEkGqMdf9XAhWMEnJbsDsb3NN6zmWdWA=;
        b=DV+fpRFEu/RR1fgKUwwNyVtJ6a0d1WHG724D/a/zQoc97Y5KZh0ROP9zmFeNgTyawW
         oASIYcio3sEvp9CawE6HUlr7/FTCrbxBho/W+KtcooVlVrraVhfyUKaDpgkewZkW2aZm
         Wq0uUwFeTR7c++G8/EdPKpdbxCV+/7X9/LRktvvGrhCeOjeFEksQNcAVuAsWX/uAIvNj
         0YfF3tkwMbCIK+yqljrGsI/9DVMjxXPZdrWzLPtNB3j5ItHTjseBp3cYjEuBMk54SzjK
         gpiUV/ifrFjvBc3liIUJD70YTXdlhqWYev3hP27971GCVrzozTRp6mMCWkM7GYVqVCwU
         jcCw==
X-Forwarded-Encrypted: i=1; AKwUvByCdjpRTHMw1I2Qnh4ZXtGL42WNfzdXx29jRBKnaJFP3eMuj42PvDv60N43oeaXkLSa/omrO/orbZdRTh+7@vger.kernel.org
X-Gm-Message-State: AFuF++nUam+KnP4908DPdRRjTW84DY56CUHgElQZhT8DgPcRzi/yCE9b
	D5uBkH+MGFW5GVahEWz7Rw+Pxu5Y1MRadc/biD20otOl+LHdKQoiZDdk
X-Gm-Gg: AYBFou1r0ohV2d8QaZ1EvYRPGJIc3fSyhgQ6QONjL0QKvsXqUM45DJH5LDb3zIMZNTw
	vnyY+h9INqlfvroldg4N8lHuzRsCtvRK38IpbnvGELc2D+XlLlfakIZANI5R7eGKSSiuKF3fost
	EBfALykfcJb1pGpz+Ubv14nhdeh4muDf5iw4s5xoX1+uY3xgxQ1iYS+AREENFSXDaFA9Hpl8tcb
	4k5Wvijs+4KLZ1FZYC3XhMj6ERYpKwZj1qnT2ub4v/p/beIGNzypcfiATr+doFVBpWofvjy88dM
	BwLFf6hUSwf2nODWUgWSzas+b4jco1oRIDaYnz/uYFmYrYWMYkcsd48t0YGcRVHnKcLSb7gJi3+
	QG5LTVDJR4fyt6dEhkQh03b0FJ0kqP8S9kqtRWC9UEEWPwhZ0FLPoomfEGLyXN4I/OAptU7slrH
	Lq8/NSFhBC01S8rEOhMjf6DZ5eyF2HxvpAvBjsoWVXQIOjgIairrjWfiXXcd0Y7hnoaZ9M8LlaP
	wkmF0o7pSrkkNDE9Jc5O9v0AHsqp7JechUxyyP9sdSSzsvzd8SL6tHL+8v8Nvq3COF+5djX8HLo
	Tk+0xHGOMpTfp8cJnMZFeUvkhAUlq0PYbfDRaP4tP8nMV/Wr6A==
X-Received: by 2002:aa7:d94b:0:b0:6a9:c9d8:b3b6 with SMTP id 4fb4d7f45d1cf-6aac8f0ae7emr1949690a12.6.1790265228473;
        Thu, 24 Sep 2026 08:53:48 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab38b2fc5sm3815784a12.27.2026.09.24.08.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 08:53:45 -0700 (PDT)
Message-ID: <6d538f3d-dd83-4dfb-b091-9b84acf47c62@gmail.com>
Date: Thu, 24 Sep 2026 16:53:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/13] nvme-pci: implement dma-buf backed requests
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com>
 <20260922132016.GA30684@lst.de>
 <d39a6dd7-cb5a-43d6-8dcb-16eb9fc95b4d@gmail.com>
 <20260923045505.GB26231@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260923045505.GB26231@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/26 05:55, Christoph Hellwig wrote:
> On Tue, Sep 22, 2026 at 02:37:08PM +0100, Pavel Begunkov wrote:
>>> Sashiko had a few comments, which I think are correct - if we use
>>> dma_map_sg to map the data, we need to use the sync_sg APIs to
>>> transfer ownership.  That only matters on non-coherent architectures
>>> with MMU, but we need to get it right.
>>
>> I've seen that and fixed everything locally that should be fixed,
>> apart from the sync. I wonder what we can do about that? I can
>> somehow replace it with the sg variant for now, but sync'ing the
>> entire possibly multi-GB mapping for, let's say, a 512B I/O, sounds
>> not wise.
> 
> If we'd want to fix this for real we'd need to add an offset to the
> sync by sg methods.  Or move away from scatterlists in dma-buf, given
> that they are a horrible API.  All of these are bigger projects,
> though.  So for now I think you'd want to do the sync all, and have
> the people who run high-performance io_uring code on non-coherent
> platforms suffer.
> 
>> And I can think of another place that does mix sync_single
>> with sgs.
> 
> Which one?

All the recent networking zero-copy / dma-buf apis.

-- 
Pavel Begunkov

