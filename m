Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382854CF5F
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084239; cv=none; b=VenokEVr27IRzxzTFXkUYjUL6R1h9M/2wTC09WAR3bhlO6XOuOwVxvYVvc57M+4pWa4eRSCTOI2w/PUNKKFfGXGg0T+M0v3fq60+lXag+2j61kJxtayqwm/zQwdl/tPRs8nRAz8K2iH+n3Xr+qt63WTQ+6Ls+4lp7TvWfhl2eEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084239; c=relaxed/simple;
	bh=HQWVBZQ3a3dF/DEyKoutDX9guSe4Idp8wVDepJLrORk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jb6ASFiTbAa3WVRx5pCU9L55ggaupsl1nInOq2upA5XZo4N4FQHlmv+kLMmjxd7pcNUcP4L7VwgAm4/Ev+8oSJjH8Qj+r4pI+QBXSpgT38YPj1cJT1lAOL3ZCNhKIzXAlL1/rQKqMDQfpdeq23fnQILamu2Mv4pseX+J3OE5eqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9bkKHtw; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9bkKHtw"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f5603a0so558473066b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790084236; x=1790689036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SSB6/4UTXtVP9h0KYT7VpnYQgkILrKgn1VnZQd7YA4=;
        b=Y9bkKHtw4enwyqHTeubDc/hx54OJBxkeUi0FqlJAnpEf91s27PXl+tasxyNLFbyoYC
         jXUWVQ9sCr+9/vROmsNXwRmAPdfxZ4OVE0PwaoEwT/ZD28DT1Ajfppy+TwEwPDpTJ5Wd
         8cHthTZQGvZl6HjcGPRhluw6PreSdfWmx90Epw+BhOD08wxmnBhFSvLNDefwhuD/a9LO
         RPe57iVuZNtHqtFh8yPsPEO/Y6CvsN96wnniPDAlT9eaIGd7gSUsPbL/aHTrif98/2Fr
         LL64vsXgF32RaTvf8BVtlGYT6IkRsiRBD4EsCr77NQzcoP8C7xS+XR639uPQ/73UojlP
         hUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084236; x=1790689036;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3SSB6/4UTXtVP9h0KYT7VpnYQgkILrKgn1VnZQd7YA4=;
        b=bhv2vyaLtoVah+3LeGOPnho2AfVd9O9uM9dlFhL+NW6dha2PPXVJGb/3CP5RFFS+3b
         kpOBadzyJnATdMJoPeCkxp/xVtplo5cKMox4fIsZ/MMHdygZxAlxjgfPDFSZ90iDfUCu
         djHcgHO1JzOzk36r//bGEssR2Nbh7DwVUUr5BM6E2w8TiJ7a13SMOCguE2ZlzYJm0T/D
         sT+VxHBzWTjzOcAQ7yEM9JVsIFsSP5WkR/OpiBeiDiMIWLH7NRXzUEl7bSnmfu+nDGqw
         VXIC/k13LM/2bpzNLgspYGmMtsH66E5DZo+0YMCyotU20bvQFjfDqv15eLvfnBn0Hfs1
         Bn7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwNw6TExqEcJ/SdsBV2pvJx4oZP5XuieLrU960m3AueGKBDSQJG4BnYcOHzW6lupgXq+77OOsWEApaD/s75@vger.kernel.org
X-Gm-Message-State: AFuF++nSujTw6UjLB8ZriR+/7vz1N/tQcS8NL2dXACyGEQBxiJ5gy0ob
	I+P5gdqGxODPi3qvGaCqpEWGCib7Z7I8TK0+5rZ+LyGNMFOIklt5GqFgeNrhLg==
X-Gm-Gg: AYBFou3ZNjbI7xOMdnvIxTVkgQRhLy2hDWHIBYukJJtq1OxN2uarcgajBaWOmg4Tko4
	WtG+s63IVddoZPuWPHWdDs3Z4cDh8zpcemKxVWKDIbTRZHFQFRhEOCMl6Brm4WhFBPo0+Rp42zO
	+rDvcp7RR/FEW/n8V2VMYTvVIx8VgaIXi7RTRF4EeXVasHaqMk9B7kQPZzM0sEgAT12YCVzG1DT
	5hsRhst5CasYg7KlWOAcj1rQy6LpByKYktHU3w5DvOCtC2E1k/57SFqVicMgH4+MN/UaRTySt0e
	P7+iZsZgVzSmeasHsxJOFo95tWEzArG64GOOUdhYdqg6vyX023BOQf/WkbCLLki96qTF1+rtErv
	U1j/iaVxeAKt5ZScCZQ4PaWgn2Q3sJHkztF7uGhipDZeHTMMftD0EeCUxHmVAExTk7HH8cBy3lp
	eHgvyFK/AZrt4kBemOcyg/Grge0dp8coGgs2hghmP9WoYx6JjB//NZhQGZr1X5tgSycs5AwWAoz
	XoPv6pOCBomPEEpXChUKb54XCcw4DBto9Fam99wvsCQ4rKDn24oSUEGMDbRlORMkLMiRwl9etbZ
	lZlE8RIjkDWFe4eucaamq3F1JT2J
X-Received: by 2002:a17:907:6d18:b0:c29:448b:f5d0 with SMTP id a640c23a62f3a-c2a15b86ed4mr1180156066b.33.1790084235477;
        Tue, 22 Sep 2026 06:37:15 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-196.dab.02.net. [82.132.213.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aa9b14925sm14081966b.19.2026.09.22.06.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:37:14 -0700 (PDT)
Message-ID: <d39a6dd7-cb5a-43d6-8dcb-16eb9fc95b4d@gmail.com>
Date: Tue, 22 Sep 2026 14:37:08 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260922132016.GA30684@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 9/22/26 14:20, Christoph Hellwig wrote:
> On Mon, Sep 21, 2026 at 02:38:50PM +0100, Pavel Begunkov wrote:
>> Enable BIO_DMABUF_MAP backed requests. On registration we map the
> 
> This is now REQ_DMABUF.

Will change

> Sashiko had a few comments, which I think are correct - if we use
> dma_map_sg to map the data, we need to use the sync_sg APIs to
> transfer ownership.  That only matters on non-coherent architectures
> with MMU, but we need to get it right.

I've seen that and fixed everything locally that should be fixed,
apart from the sync. I wonder what we can do about that? I can
somehow replace it with the sg variant for now, but sync'ing the
entire possibly multi-GB mapping for, let's say, a 512B I/O, sounds
not wise. And I can think of another place that does mix sync_single
with sgs.

> And the reset deadlock also looks plausible.
-- 
Pavel Begunkov

