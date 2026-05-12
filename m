Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F849550B
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578241; cv=none; b=g9xZlx/c7bfAc5eFiojnTeNlpjSInUGbomLy5uLv4KSRTxT+p1GTnXdKW8FTZF0YfsKwafuPkbk9CmAl70m2MrGh+yTlNoiBl4KZCeqDmBspqV1QEpH0ge8ibCWDXxQ/jtyuRd/NSzVa142rOinq5ckL6szZ1NtPcMyFudBM1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578241; c=relaxed/simple;
	bh=AmxHQti+Cn5C3pCrdSnBlqV6BaHV+iBm0oydG8MleKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+oBMdgL953teDw9ggAoir6fPDh9We10M9+y3N+spHlOv8PxpwPmdc/nxdzxplcYsWf9sYYWlY8QGzQ/uGEXjF9bARf2GLkZNp6IWToe+BkipGNofSYH+VSFiqX0jF8ShZkppAqILLj757yNxB4lVdB8bx8mR/5S5a03lUnX8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHcEIjXa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHcEIjXa"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bcceb394417so329461466b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578238; x=1779183038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1i6gK0r7rGWa5W/9WTpQ/H0vww/+AQmB17cNctDGbjU=;
        b=WHcEIjXadNkPFUtxZjibbIycxST9iPZAoiAmYMM+LukrN41+AEMZMMUijkA9iID3PE
         xg4pwXQf1Jf28htElNpnJC22niTXyfKF2ymcgg/R2KWT8wuJf7+q2BzapkmyoHtiZ9yp
         ZeXZ3dQBvv9XhLemLk6KoEUkaMeUy6581GgCbmz5Bl7y6+kbR3Wnh6/jD6M/cDn9kMfZ
         8AT9zIXP9OC7N3eldFmoe4xsIW/dvKGuw497uGm9lfr9q33CRajDdp+P2QckaO8WZZWu
         SK3l7wPIIMsdE2Ht4/8hyulcplC4t6peIu+13WnT+be/vVykhbBCd5Kgo5tQ7Kxl6IsG
         JtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578238; x=1779183038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1i6gK0r7rGWa5W/9WTpQ/H0vww/+AQmB17cNctDGbjU=;
        b=NNu4u7C7KIFZ0Rz5pkPsGtM4QhSBSph23AYOBZI+pFz5ELnJ8tIGgLG2sBPh+y3gtG
         RsFacJeE5KgQ6GONSsAdBPcVHnI3NacpaUjOeovaKMHiPnM/gzc3hX2l/FHBqIwtcdOs
         PWNAPEfZMaXMyTwiLGdK5s6Eb8BI5BooyoBOnZiLbMk06l5q/fHSiUoFsG/awWvA4NXv
         nsuW3lnCZ/fnscuADdd64JiNfvDWHXPE2ITbm/uWCdN7SUZn1egd7lAtm9anlEJyy8N0
         zYMpn+tCE8iGhVKVUAgOSZKDpl7yuFLjiYSqL4fGncp+B7XQcOaNZEraecjlQkFz8OH8
         TMnw==
X-Forwarded-Encrypted: i=1; AFNElJ+HK6G/vScMgLfCzXcQvt2ixz9WjmUsEQrRdJfW7WifjPw2SXOogdFtzMrB/EglDvlXBxFbMZwGaiZgBWRh@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxJTi9SmPx6od1GcKBTO3TLn9JYKQA8jA45/GXtJpZPP3ZreV
	seAxhgw5JtQRRd/KXe8iqVcSu49OUiZF/tO6ECMv+/IjYZQ8IyWncvLl
X-Gm-Gg: Acq92OHwODGwErJq2f2NLK9/yZlJ5Ghu5L3VNsM2mJB4Ne3qvk+dH2K3fdb52xJ7fgT
	TtbQKO+k2iKgH89/TbfR/1GenXjOMhcBQl77dExgyZztiCmn2qbjIcteXMnC3DB4038QQXBJJZ2
	4SViZDbxEPAbifWAakWAIYn6b0mACveLAw8LCZTeeFxFScm+LC3jMVjseCXU0qCXE1KLFtYmvI1
	+XBU5LCUu7zm5mQQ3MRwvd2g4Zdm3qO/WqMle1xJ49RCn53I/gxbud33RrT/Q5RKl3aPJELHYTJ
	IBZKgmtSemOV4K5IfDRhQ06q9uSvSos0fY44nQuW5l0khYK/UBPNacQKE9UnehO6cnb/tzCF1lE
	5Y5AgHyLH0q2EsakvLXbNm1IXMpP3EskvTS57+odODB3mcqE1LPvx/sSFwbUcs0iqD9kY8rgqRm
	vCUxzjisQXmmw6pvKXR/Stenqs1R/+3i5b/9fnvVn8jEOoQ9nk+yyafNmEKl2/UJ9XiQmOMAFob
	/vso2lZTo/mljlQvTXnn0mcHKN175F6jITZ7wC2bk5OQ3MY5g==
X-Received: by 2002:a17:907:97d0:b0:bc2:1dab:3ea0 with SMTP id a640c23a62f3a-bd28de036d4mr114881866b.8.1778578237873;
        Tue, 12 May 2026 02:30:37 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::372? ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfb7b17d1fsm303492866b.41.2026.05.12.02.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:30:37 -0700 (PDT)
Message-ID: <24cc68b2-c432-4623-92eb-b56b76850c35@gmail.com>
Date: Tue, 12 May 2026 10:30:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
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
 <afi7c-VUJWOLlC1m@fedora> <6873d617-c904-45f3-bad9-e1ae39cfecd2@gmail.com>
 <afxgc4hizusnAA26@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <afxgc4hizusnAA26@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/26 10:50, Ming Lei wrote:
...
>>> BTW, inspired by this approach, I adds similar feature to ublk via UBLK_IO_F_SHMEM_ZC
>>> which can maintain long-term vfio dma mapping over registered user-place aligned buffer.
>>
>> Interesting, just too a glance, and it looks like what David Wei
>> was thinking to add to fuse, but IIUC he gave up exactly because the
>> client will need to cooperate and that could be troublesome.
> 
> Here the cooperation is minimized, maybe one shmem/hugetlb path, or memfd,
> and it is one optimization and opt-in, and fallback to normal path
> if application doesn't cooperate.

My point is that with widely enough adopted interface the user will be
able to opportunistically use it without knowledge about the file, i.e.
not knowing whether it's ublk or something else. But as you mentioned
below, it'd be cooperative interface in either case.
>> Should we try to push everything under the same interface instead of
>> keeping a ublk specific one? Again to the point that it requires
> 
> If generic interface can be figured out, it shouldn't be a big deal for
> ublk to switch to it, and the usage is simple actually.

Sure, you'd just need to maintain both as there is a mismatch between
interfaces.

> So far, ublk supports both FS and nvme block device.
> 
> And cooperation can't be avoided for this usage no matter if generic or
> driver specific implementation is taken, for both fuse & ublk.
-- 
Pavel Begunkov

