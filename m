Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4349553C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332370; cv=none; b=ncvZ3C4mmidQMpqhJfb5fVRUtdi31tGTX0x06eD6+zR6vQBiqg+NPCF7PsWliqJz0A/Sp2jXS60JFALtrMEFJH7t3UEph1O3B8OwUJsKOQ7LolEDA1vdKXUwfBJGR6d7lmg2E1wrBdKmJbADj2LwR3IjsxA8b1Td8fsx0rbwT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332370; c=relaxed/simple;
	bh=uY3sUepmqssMOr1jNQvyXWE6qqQrkaRqI5lsNd3E8OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5oUa1LL2HHn71RGYozOG1yQyHwCfuBYM7Gdz7TA0TO/ADgqPmu5r54debid6RAQC0OF89Y4mm82R+xoEr6MbUZXjFf/zdJoIKGSCn3jIBeQfLn9ezk+yE3Y4z+uQjfN9lpS7KMstQRatosHecvzwZjoRiz7bLInS2T+hWPp8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGVPcDzP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGVPcDzP"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1f5208b38dso182342566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785332352; x=1785937152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aN3udKBcENjBD5UHxw3XhgPgHCGso1JhkYTFHwhTGI=;
        b=KGVPcDzP8wQ2SyiaYgiEB/4+DEBMYVALsc3jCB2ht0eAjAMxzC7NXELzSBNNQc9MON
         d+5UWFqymcPii4NKyLLs61jvxSrgM4urA7UkU2HBYDgPFjDRMUOonbQMxjRRz2fM1A1G
         0KQEeIhH9kn1nef3qZipqo46Ff4aokfZS8yASW93kTavs5E/4t210s8/nqPmRCI2xWmQ
         cfiUS6RP81gBjK/rG275PimVCBEjZw1hM2fIi52JuSxl+y5ssYS80UyMSVQF+j+qwWAN
         5FmGmrGXBoIq6mhUzjQD+AoBX6TSFQp9EuI2mNAYYE4/W/exMXsXk9Ptt68mGWbQptup
         dcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332352; x=1785937152;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aN3udKBcENjBD5UHxw3XhgPgHCGso1JhkYTFHwhTGI=;
        b=PWVv6pKSwYlaBHNYVXpfzjLQY4nxFY6ieV2dQ2Jw8J0nrZJiUh5NymyspbD38/WlVD
         MUo6cF+PJ4jqi+wHiASXwGxp4zpuJjY93+xPiCZV5F8bGlMo2kXVM+HSWV2P+6ZedX+u
         Vo9E53EBFZu+kUvDYoO7g4qcsJHBY5sow7s0IXJZE38+bqtA1BxFJ3z/pbpIHpnHYjnE
         b2CrUZXP5Zc9KbX4clCM7qwWutLuEm7bwwdu8OpQI+u86DNXcaVxCVzjn9Dn2iWRwiRR
         0fwha7cmlDOcFwIz1hvu6GqQCJ6iqIeNBGFPVQpaGVPxzSUnUbJ6k1npSW7L6ZZ39qRi
         AEOg==
X-Forwarded-Encrypted: i=1; AHgh+RpBDu2IW618fBlIwWG71gbZzZE3IzaNVMREpUpZV+12cNiaN6Js1wODtlAWKsvx47SrzZTCLbpk8sqMjRth@vger.kernel.org
X-Gm-Message-State: AOJu0YykK0LSpGNjEBN1KB1Tox95ri36ITZDc8GzIBRHvfcjTCLEmAD9
	YzDYCMw3gxV1wSKnu+CCfjOuOMl+pMs1I0sbzeDRxJdNolYNaK5Uk0cm
X-Gm-Gg: AR+sD12dGAG2qVmi75Tjyf5NKXo8ruX7TiRuGhR0Kw2LRu7Q0ptdHNpR9/J3zNIU4EU
	/St0/gHwp5IAT9800g1w1IFkWfGaUApn9XeiO3iU2vdQUsdgDrTPyqmhHG1/37ui0+l0ByDq4hN
	a7bysiWTri6nFL/bx2HvX4vGIoyZ+QUQFmR9P4aX4i2wZy0NN6TYPmJ59mQeNEfmGc1Fe+eZYX3
	3IIkSzXOEeRKc83GsmmPSN2mst4coTsEEcqyYeoqafF/0qYwsiQbpP/n47VYGqdicCaGZjrkPMT
	/hUCeoy/O2I6jf9Sixi/2v2rFyaHwL8eYjofIHLmS03AFBTy5EHSSMru1MPn8svO43klIodwEt3
	Zjpu2lV5QulGR9tWqptfGQpbaxSg6X8ICWzao3XlLGNI4qaOHd8jiVBtrBfAtz/dna0AxnkO9Tz
	PHx7y8pox6c1sCyIvPSc+fzoRAvvh74/uJFeUYh/RRNbP8DT38jI/vVdKEw+e9OwO9ipb+vz0We
	Zb8Fjczo4+Fz/cGZV5MobkLFwYAoqy0XDA1uJsJ89sZNZdS9qir9L14Rl0lc7ni80RURmHElDWs
	vkLPYt52Qbq5VRFuATk=
X-Received: by 2002:a17:906:f598:b0:c16:7b66:4932 with SMTP id a640c23a62f3a-c1f721bf58emr374209166b.64.1785332351629;
        Wed, 29 Jul 2026 06:39:11 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f4de5bsm118685466b.29.2026.07.29.06.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 06:39:10 -0700 (PDT)
Message-ID: <dc72d46b-7b45-4beb-8e36-d810d2a94c28@gmail.com>
Date: Wed, 29 Jul 2026 14:39:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] io_uring/rsrc: extend buffer update
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <CGME20260728213008epcas5p418dfc10b7ef786e162ade86d14430475@epcas5p4.samsung.com>
 <633d33d8e278999f55126794fce948343403494a.1785274111.git.asml.silence@gmail.com>
 <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 14:31, Anuj Gupta/Anuj Gupta wrote:
> On 7/29/2026 2:59 AM, Pavel Begunkov wrote:
>> @@ -882,8 +894,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
>>    	struct io_imu_folio_data data;
>>    	bool coalesced = false;
>>    
>> -	if (!uaddr) {
>> -		if (size)
>> +	if (desc->type >= __IO_REGBUF_TYPE_MAX)
>> +		return ERR_PTR(-EINVAL);
>> +	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)))
>> +		return ERR_PTR(-EINVAL);
> 
> desc->flags  isn't validated here, unlike __resv. nonzero flags should
> be rejected too?

good catch

-- 
Pavel Begunkov

