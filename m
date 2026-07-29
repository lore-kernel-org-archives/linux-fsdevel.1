Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAEF445AE3
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321662; cv=none; b=VgVco9c9fBH56lYBG6bQR1g7L0aiHS7zbCAWQGuoOWUaS0EtYLSR5+6FhUTRXrQNHp62Hi0d3EflbsY+lTHOWu2Ug4chZy33KEzEJG+iYQJXmpFN724zSZhP35HIoPLbUHdiq+EUXI9R27a6z2o1gDTCQppQt+cCTE61TD/3YsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321662; c=relaxed/simple;
	bh=BlIgo2y4Fy5hrKd1QKUkkESSegtx04afaFtVA1ds1gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0uE8pP8aN0/XXu7ZJ1dGrocb69aY+pc4TIMDA5DkhZwotjUYAqLsnfy0dPujszeIm2T5CUI6RITHNX1fYd+kCFyugUmViP2eizyRcZ33qHpY5vyFkXIhImMuNWEaySUiY/NKKZKO3ggpNDk38xWQgeAukXtVhAnVGRUEKSyv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZW7RvJ1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZW7RvJ1"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69ffbd2a277so1212897a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785321658; x=1785926458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vFsiSXVzFdxW/ZniSNP4YKGbRVTSiHE8ZZ1h1zgY8AQ=;
        b=AZW7RvJ1STgaHPD067590JbiwZ7/34KkecunFz4HmT2Fi02qcgoKjEl6XHdy8YZyAF
         a1oi2y/aYLDURgNoJeiHP7TZdqGHCY4lG8IvCKSYD919abCIOKzi8qMnKv2gDZxFpy9L
         hyysoYYhM65ulovurImQpFEzWHzrMy/rj2KlTaNZJWfSjpNko9E/m5q6lDqq6tUMD6bT
         PFzrLoHh5b+EbjmV+E6OdzlQXjvc2ErhKNFIzk703pn1/Ktb5thQAAsb8gNV6ytBYHN6
         8LwS3GdKBv7lngBhfBrKWm3Ny5/coLObNc64Zdc9o5g9BCLQo53BuJU7NJUmSbQoYgz3
         Nb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321658; x=1785926458;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFsiSXVzFdxW/ZniSNP4YKGbRVTSiHE8ZZ1h1zgY8AQ=;
        b=Y3ghJ65x7fMj9ufxwe8DfX6r5naX8/cxh9rpcE0Z1UF1mzcGvtk31PJObvhFRL8U/p
         YBBA2hjOxv7RpWApvIe0tUVpdD1iDduD6ETmMmvMzvQeTLgqqhb+fnEDbeSYvV73DVob
         +iJDR58Rj7qS9XuYBnfLj6KPfYkQQL/gKCMNVsUeJ3SWjyBN5gfVvcEN7ixuBAntEgZk
         v337jquQ+icyzHQEhy4TV/yyvvQjsx64dCbwi642WfUrFfo5RcudaLt0f6oOH2tV2qm1
         qxvLdhf6MUTPRm4lYYZy0ZjDbxDyDuWj8+4YDoSZEMjJq5srTNW9RDHx4bM0KNgWd317
         IiBg==
X-Forwarded-Encrypted: i=1; AHgh+RpG5YrbmIvwHyCA4+SrnsaOe+gJi4/lmsg/Sq9BOKIxL1kv+uveJs793mCTxlRH9H0+UyI1NCWffJF9e1S3@vger.kernel.org
X-Gm-Message-State: AOJu0YxFKCUXjvU+8MnIVZkbkHDYsd8JARCRegJ3cg41AIrpU7g0jvuP
	V9b83/+XtfNake5L/tD2gjH6Vv4rMlQtPx3cnar2Yd3z0hsMVUkiz19w
X-Gm-Gg: AR+sD13dONhtVCtnxk6eks3X/FEKTImrRzuX27eCMbl7qWR+g0KZHXUHmIWLBvO/4ty
	b+baPpWtFWqHdUhiZCdWsGZCzaJIz6ATFy9q7uzbYd9hQ09wkPO39yqZdM3BcpMRa6oenaPuMAL
	6mhET0N7kg0bh2xwGuJieLHH5IDx+47Qmp9Wvl5TSz7RGIH0VIJcasbYo2v3wsKZ8ooA2x7Boxs
	/T8VJTyk6lzB1yvBxFnTQxNDds3eaR+DH7uSzNyLl63T90OoMqS8P74dZ1OYQ3RtyKEgJ+2bn0j
	Htm3hqWL56G1rku4HwHOw/QrYcY8IprNv1PujwM3pkee7f6zPBs2IdEE5wmrHNMj488MLjZWV8x
	sj5i9aKeWxuI+KgKnj/ghVdGOPGANXeh+91VM59JDVulI7eMpLCnYALgCS7AbNS8eUG79HuiISK
	1WMehFEynIcRBdQuiPCD6U7Ls8iLoaRZWzqdfXVljImjT4HVHvSXcGXkG207IRFQBI817F4EPpE
	PU6+m2bFnuZBqtIVex4HUC+noZcg4MsvNqf39vgXJ9CK3e27tSmQ0gQ+0s2rL2JVXtz/qNGDYmT
	sWO0k3btiNN9aQSVRuY=
X-Received: by 2002:a05:6402:548e:b0:69a:596f:ba0d with SMTP id 4fb4d7f45d1cf-6a034a7f6camr3086746a12.33.1785321658080;
        Wed, 29 Jul 2026 03:40:58 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c5cf0bsm661299a12.23.2026.07.29.03.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:40:57 -0700 (PDT)
Message-ID: <7217c204-786f-4fb1-9c09-fc1ac7c8a249@gmail.com>
Date: Wed, 29 Jul 2026 11:40:48 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] iov_iter: add iterator type for dmabuf maps
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
 <132442812a40277a5904cb2a8ca1e02f4f6e82a2.1785274111.git.asml.silence@gmail.com>
 <20260729065953.GB9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065953.GB9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 07:59, Christoph Hellwig wrote:
> On Tue, Jul 28, 2026 at 10:29:14PM +0100, Pavel Begunkov wrote:
>> Introduce a new iterator type for dmabuf maps. The map in an opaque
>> object with internals and format specific to the subsystem / driver, and
>> only it can use that subsystem / driver for issuing IO. The task of the
>> middle layers is to pass the map / iterator further down, maybe doing
>> basic splitting and length checking. The iterator can only be used by
>> operations of the file the associated map was created for.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,

> I'm also pretty sure I reviewed this and vairous other patches
> before..

There was a lot of shuffling, so I dropped the tag after a 10th
amendment to the patch as I didn't know whether you want to keep it.
I'll keep it all for v5 unless anything conceptual changes.

-- 
Pavel Begunkov

