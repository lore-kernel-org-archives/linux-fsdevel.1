Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE44279FD
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321453; cv=none; b=isfgqRuVd16BrwZdfRqFRa+0tYibWBYEKWmmyFuEZMIpab9rncMbkLM+UKZM2LHSBHL9fhWPvWdEJr+TLYOf3rIu4fIQ21imNeiH4i7ztB43kxs62s015joBeJsvDeok1IGdN6+Pa1sbAcD9VeMiOEiPvN/Ki15mqRL2wVVkY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321453; c=relaxed/simple;
	bh=KMDBHWwtyZpTu40an4MnGq08B+PKsj/C5jew5swtPtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPtbFwG5JU6T3GwBqC2GKGuS7by4zZVu7QB5+HnhcRqrpDI2Ss/Hl+N7vaBMousDHpfOXvhXGvJzZ2Dt18nNst4IhkDT77sNjaDsVzVf3sKEt/N1CW8SDEhNkFkvqq6cyBQ9ZUHZ/zHg2hcvv29+kyIi8Df6/G/j9z80rsMDfoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQuApLte; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQuApLte"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c12614b81c9so141396266b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785321450; x=1785926250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8KbmJYcU1SAlCdU+OP1hBT5okmuW3fRl/0GYAxB+Rg=;
        b=UQuApLteJB9kKcT40XOCwRqmqtd9RC2KId41eJaievdgrQkAkYSBBD3tGi/u/fez2H
         wEj2YyP+qYvRZa4Xtb8VcOAWrjOaeRZICTY9aIFaKTVNuRWxM+CziTXGSrcKYbSYG6NZ
         y4dx/mcV4IB2wRg7eosVnKv9HjbGYw6trbjjsQXNwJ7ddaVp0aqZSyyvGyhhhzks7Aag
         9AB/FWkuXdmVgpfxoSsRPTW6Y25+o4N6kZa1DfBxZefcNyFwXULJk8t2as6huleg4iNM
         gL+plUqY3hdAwGxRONuYMqTwo7vM0we09dnFCaHO01nkbW4UsbTgf4dRtgYw1fJ3wLhF
         KgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321450; x=1785926250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8KbmJYcU1SAlCdU+OP1hBT5okmuW3fRl/0GYAxB+Rg=;
        b=O5TG6GeXBU76oFKieA700h6so8eg0u4tt0w75sKcntUqKtxj9Z84QJeJQobqgURtqv
         Ddn9sfDYMISwhQ84yWOIDRCVdMba+nuuwYZcH+3Q159X3IsUaMgxcY43pUpSsTXYrYt6
         mtSfpZ+3QmN47Svvr5kDmKnWd/56eMAsoQkcvdDTqqTQS7n115XZqX5BQZ71F1CEggu8
         0VrXF/wHuaItTCOH6pC06lGE5JBuEQjZc173s9fGZzlGJQugXfz3sgeNcjyfeJ9uTfmI
         mJeoYLuOxFzttneMwFYzGk3l6UZ3DPe3r0guiPpX5Snr7fego9Bj+x6qVNGZLGmak/ut
         hDBA==
X-Forwarded-Encrypted: i=1; AHgh+Rry3Pur8XR1RP0K2/NJ5uJVyXg6y2pYn/mFTuEbjtIDwYK5tjwmZDsqRNi825q9Q50aPj3Sq5cRU2pRrKqg@vger.kernel.org
X-Gm-Message-State: AOJu0YyuL/NgB3qJtS/6VwHQTp3xInTBSmmSNPHtiCXhNPwcocJr4k93
	I9cZh82xkY53AOKasQmAyqTlGzc20r+K8iSrLUH2N9ll2mx8mQ9aG80K
X-Gm-Gg: AR+sD13UcRmuLEgSzC0wCZ3t+JRYPoi67UiCO3uI0mn/7LroaGdCBjx8rNe/Hoj/jbQ
	VaBlfBLVbVVCEWnLMfRoL/5seP1PV6h4IYEOWZBHcc/uTsOPDq16ciYPt2GBaFXutF8BaRoOcz5
	VkZKYoJYF/bzPfQzfjVG5/IqgcGJTHVeHoYJKLXGvN1PpiK4iTZFbXEElKIvigTZ1opdWfruQzO
	MvzMHcolSgaimI8cNz9iRGdGs0ddG2e3dQhhIkN/JE5k5o0XVs00w34aySFD5kQFbL0dwiZthIc
	UjiAA6DOQ7jCsiL6zpJELUTuB7dlNtmfNCOhbE8a+ZuzRxV/2D4nsBzGU3f4V5oEv1PjKYEqyGE
	PV9Wa2+9a5/Rhvo/XuXQqAwi5BTHnKQmL4A4kx5kPEzutQRZkSYgaLwa2XXc5eBgvRPAty2lfDr
	bEbVJjO+cx9xm5hkibeW3XIJdSElB8fx9BK8OotRPDYZeZtRWfdTiK4+4cN9O3kA2IP52owWl+s
	lMDUMmLG142u0N+vKEXWQ6hnaJwz2xw3vs7OXBhi+BKMtoFbHzMmKT9m01Ch1Eg2p4PC8yLhw6z
	JKare7yRBZnvURd9SPU=
X-Received: by 2002:a17:907:9617:b0:c1c:62b4:1ebf with SMTP id a640c23a62f3a-c1f721913ddmr365145166b.60.1785321449861;
        Wed, 29 Jul 2026 03:37:29 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f84026c47sm93918766b.63.2026.07.29.03.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:37:28 -0700 (PDT)
Message-ID: <340dd033-2a45-49e7-afd6-95dbbbf624da@gmail.com>
Date: Wed, 29 Jul 2026 11:37:19 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065927.GA9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 07:59, Christoph Hellwig wrote:
> The method name feels a bit convoluted, but given all the
> previous discussions I don't care too strongly.  I'll leave
> the dma-buf side review to those who understand it.

I assume you mean this:

+	int (*init_dma_buf_io_ctx)(struct file *, struct dma_buf_io_ctx *);

I agree, and all dma_buf_io_[ctx,map] look clunky, but I don't
see what I can drop out of the name. Suggestions? Maybe I at least
should make the fs op sth like "register_dma_buf".

-- 
Pavel Begunkov

