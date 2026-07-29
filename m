Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A344C651
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322194; cv=none; b=ZXLJNhA4txTKVY8Oi0jKgbO6+nUbiRcaxa4IU3UMnJSxAE41c4JA59h9Oje6hagf8mjOw/3Lg6pHeorT0i/zVnW8H/0m9jz1cUh6U9iXDQE1RCZ39/qo80KzMlISiezKW7H38RS5pp01D06f4tyvC5xH0eMdhrZsYHWC1Kv9OxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322194; c=relaxed/simple;
	bh=iNi2nFSA8g81W+/HnLXlWmnLlyUILEZvQTRGox6oYII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6SKdm/HWhATrdJZax/lFdBKCwa1NRKGKV6/kTef0RcOSK2TZuMS/rCOFhu+qUIPIx99zI0EvaxLnVIksSk18gi25FypFzXIb3NzPmzUejM7RAbg6sTiTY06TMhNbe3xI1Rqq956gxNMjo6Dp6Hofv4FNxl78LymU70oZ23lxnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6f7Plz8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6f7Plz8"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so1165277a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785322187; x=1785926987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xVEH4RvIZup14rRYV4Zvxl83sd+HTGGj/jXhd9ySH0=;
        b=s6f7Plz8hCZXfh5yIrDR0xQ3OAAJW6lfJ2nNCx9b0/4iAG0GjMrmw0T2rVHZYMI3hC
         ogOq+pzXWmy0m4piruY/4MCQ6T5/GjyfZFStJ+gYah5OmM+m1d++9jRz/weyos5l098f
         FKfMfTpcSM/RQ4KFk7bZuZtsZrdsse0K1beCRAdbe3KejCBQse+RNHSN7A/poayBldUY
         qHhGuPV6sNvmWF3VcHF0EaKge4A0A3Ypobo1f3LEr7c7xqOluLhscdDkMdcrVLONA7yh
         GeN3q6i/ptpHpfZ3AghdpxRH9Iqg/z4mdXe7W5VY1LoT6bi8nFV5VNT3iV8ElLNkLJbG
         UoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785322187; x=1785926987;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3xVEH4RvIZup14rRYV4Zvxl83sd+HTGGj/jXhd9ySH0=;
        b=MgY7NKJt5xUyPNj4bCFVHwupiCE9r2wv0H3RU7BnrYGZAX5tYgYIbdIS1krWiD1Czq
         u1jDPdAeSDmh2w7V0WOZ8sFiZCa+ZK5JuGV8Hja7W2ycE0YZ5cJg2K4YkBrZv+9kwpiL
         4GmtDwkIpiK35VWCX6nKY6ixJmZOAu2G3LEG02Zr+7vDFnN6ye2EXv9oCi5uHlUXDnUj
         oyWMoP2xW7u9JV3AbxmcNtprX9vfsnGM9h/P6Atn5WMBHMDQwK/9L+I1FCZu1XXf391D
         IJS7I6VOmS8iLWCLfgh/1hR/UKyv1K1RbamfqkSY2aNT3fhH8aty2BqzVaN8HsE797vA
         GoWA==
X-Forwarded-Encrypted: i=1; AHgh+RofgYVaN8gZsA4PdLJjnFsVJzIT4X/ZwSvSWrPtQOcG6ObRj4uECva1ANiWXwJ9rM7ufAZSZtnOlWGj5rCa@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/ae1rQFJMCmSB965f+luqv0nVbCoHwCrK9ewQ0uI8SUeukKS
	DtnypV950mimLE1tMmOEGit11PAWUEeBWzYkCH+QGuX8cXTwf/ZMrhDZ4g7YyP1Emhg=
X-Gm-Gg: AR+sD10UiH508KLKmmoh4hk+ZrrHGxYF7KU5bcwBfaZcjmWf2ck0YWRQui+VGBjQA2a
	NgyFtX6ZZsl6IeosSY/5hx4UbYfkUJQfYHS3tCLWdM7rblrQtCJ2LPPbUmhCA+UKoItoJUjcwMc
	dyRdOkTsp2rT+kq1RZI33BedvRXTTB4a5cTyO+2HCOfynvwlqb1ZXmebvgdfEs95dN+++kYuqjX
	/1/TRDH0m3uLCo0/bL/4CFEOfeDTwAVCBqAmRZrc2FH8+EYZ6iy5dSkVJ6IAzrJT1WqphuTVAnf
	NQqlSveO1EsXhK+j7oLihNuH4QC9OaA4Uj6I8ygWXtwPSP0X457oNXdxVduYrKf3FJ9VAg+yGY4
	9vLObD5cPaD8FereN5JnPXjdxFUnYieb9gdEZtuRvDyheaM88MI5QxOew8iTCmacd+9a9sJXeMA
	/Ou0iifYmWAUSqAeY2KI0iqfg4unm6Je7d8eniMhW5VY3rHxWn+Wz8yYtTSu/5LBpFIEOX4UpJk
	WoGzmtTbA201xc71z9zsxj+eK44Gm73bR7K38Vvg1R4GBZQjYwSCZ/DPzHQW58Mz8cnnu1/hMJM
	7QAZYQv8wMnCHS1J9J78e2/er1U2sA==
X-Received: by 2002:a17:906:fe47:b0:c15:bea2:d209 with SMTP id a640c23a62f3a-c1f7215dee1mr299738366b.4.1785322187169;
        Wed, 29 Jul 2026 03:49:47 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83d27f47sm97965566b.26.2026.07.29.03.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:49:46 -0700 (PDT)
Message-ID: <c81be43c-2fe3-4403-b8a9-dd19855eeb58@gmail.com>
Date: Wed, 29 Jul 2026 11:49:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
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
 <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
 <20260729071048.GH9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729071048.GH9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 08:10, Christoph Hellwig wrote:
>> +static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
>> +				    struct dma_buf_io_ctx *ctx)
> 
> Please stick to two-tab indents for function declaration continuation
> for the nvme code to keep the code easy to maintain.
> 
>> +#if defined(CONFIG_DMA_SHARED_BUFFER)
> 
> This should be good old #ifdef.  Same in a few other places over
> the series.

Going to apply both for v5, thanks.

> Modulo these minor nits the patch looks good.

-- 
Pavel Begunkov

