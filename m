Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3832447ECF1
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200749; cv=none; b=aYUhZewP7fERdvMfRAl1DRNX4bL9VDmHYBXuKv1pR+cHuZsUn47fUuXgTIuyhALZGxRnETtr5CJn5W529C8z5C4kMEHq2sWiVqunsTaKFZqRrEbX00skF/AEKJ3ELAlRWCwYJRj6upH1ATAW2Jt8MKIJLlUffPA1ZqdCUtJaYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200749; c=relaxed/simple;
	bh=ZkH2ZoyFF8jXmocTrDGUE79ENJOStFm8UfOKX52vbLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j31jb9Oxik/4FkbT+3nPX0GWcE2id/k5ULyA8uwN3b/tDRB6T0Kd2fAHKoRkO4X6fpzD35jR7bxeFrapEzA3zEH7lrRswpqOkxq8lSjsPSrbxAsUnhVPrqES/iV97r7E0SJWyZzROgQsdhZCXlZ0dKT3StubqEXpsJtS/TYVLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLvkzRQj; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLvkzRQj"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso9593295e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791200744; x=1791805544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CiogbugpChE2nuDY1/c0G9NHgdsv6JGGhiKd4//mw4Q=;
        b=oLvkzRQj6B3wn6g+GBOQbg4QEY801fSpX6Y+iaT5nUVCpccBnw3PpAFJhBhX3LBn/V
         h9Z36ZH3SCRn9BLxEVVMI861hisMPix9IzSAO3CvO0sQaoUsCVEsdQJOQNPFmcxrlV1J
         4CIiZTiUW5Naal1BuFM4b003nBctAm6EQbEH661idHug8xIePQAeyo17ZDj9ypZaKxY3
         XHm8EiUQERz46r5sN4J6JDMBMJhXLjsT7fYQ/d2V+wCh/iEb59dyeVxJVAWCJ56pckQr
         Lhx1qA4iwvMMeKu71T6xgF6dCJPlRDPY5FxH9bShzzu2/C1/FiLRhlMuM4l17N3cDCi+
         7XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791200744; x=1791805544;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CiogbugpChE2nuDY1/c0G9NHgdsv6JGGhiKd4//mw4Q=;
        b=bEcupJD9Dfj6EJi1r8qxTgOB89Ml4eOGDAFMgOqsjDoM2iNqW9XCq873g+yM1JpW9s
         nkTYTDT92Sb/CwVcdv1Gb/2MPpGle97ZWMnVMgcOAU0lgh3GY+6AOUz3oD2H+KfibqvJ
         sHTGsh59+CPlyeTVgg5bMUDL9UXHrBvmQ7PYpJr8wv/QAnRbe3POist52S25bwwvBCT/
         bGvXEiX1OtyVID0p1I6I8fzWNVbbAGjcA9fWga4rrI4DZnPhlg02VBWO2lpNYNchBYp2
         q1IJXzwwtaLgq3bSLopKO3e4imms+SrNpf+Y/0tX4HhncWocGnKk9kEWkx6FaMCehlaF
         DYjA==
X-Forwarded-Encrypted: i=1; AKwUvByYqbCgujvczq1re7hdzR4OxvQgmhoN3eoYT/nL6iQ9UgReusidfNs5k/uEnsoRCBZHtER8KD8KMrApq1ex@vger.kernel.org
X-Gm-Message-State: AFuF++mW6dwzBpjDtGxWn7mqb/7jchU8Iq3Ra3OAEJGzoP0gUS6VCfG+
	E10Egd1MbWudfBxXg8lQOnxAiPBCRoiyrYyY8FAtjD/9wspdbh7zg0BW
X-Gm-Gg: AYBFou3V+/o6os1Nvj0Xg9ZRHpRNnxWYTbUA8OqMXhWi8+JH/lTmJq1/XqCgf3kvQNk
	jXdOa5zD4PUpA5s4WJU9+riaNUknZ5U4jsyBIK4kq+J7ec3tF+u58+EQl52BPXkxeBTvkWvknAR
	7vnpXoN1eIj62UA7uYA3anTU9qr84RMdDlsz0ITk/kFHSAKnITqCccvfOp+99Voa081bmIii6Ym
	4n7rYfazQ2xmWS7/a4rD4FdTbg3jcGzsihhGXObDjF3wESI03luldTnShCyzclzw/OoQEK6rXD5
	eTO19KabDg6TOFKq6Vb7YIrNq5RAhyyG74/uW3tK8FfmWS1IQdrgvrbh0LcH2ptOXWghrEaBbTP
	9dOyU3vxvo1ySCd0bmbE/h2RSDaA1V2S0sliXyK5W4POxKJOo9aiEP9fSEEtppMkdb+cOgdc0pI
	4I6mAbJDmVETysEAJ7gtvBM7UUFTxB8Z/OoXBQp2sWciCDt48c8fP1C1ZDQIswKJaQmHjzFp0y6
	+njQsFDTXsLZEm/j7AWSv9vsFu8NqEi148+3aOyq0NzA0RwDiEvYpft6fqmWHtb4ToJHg+TFDk=
X-Received: by 2002:a05:600c:c165:b0:4a0:108:3b54 with SMTP id 5b1f17b1804b1-4a02758e674mr183842705e9.32.1791200744219;
        Mon, 05 Oct 2026 04:45:44 -0700 (PDT)
Received: from [10.41.30.1] ([161.12.45.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027735be1sm472096485e9.11.2026.10.05.04.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 04:45:43 -0700 (PDT)
Message-ID: <cc7fb229-7e6f-4ccf-bea4-864ddbd36a02@gmail.com>
Date: Mon, 5 Oct 2026 12:45:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
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
References: <cover.1790602223.git.asml.silence@gmail.com>
 <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
 <20261005091554.GD10727@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261005091554.GD10727@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 10:15, Christoph Hellwig wrote:
> On Mon, Sep 28, 2026 at 02:32:22PM +0100, Pavel Begunkov wrote:
>> +static void nvme_dmabuf_map_sync_for_cpu(struct nvme_dev *nvme_dev,
>> +		struct request *req)
>> +{
>> +	struct device *dev = nvme_dev->dev;
>> +	enum dma_data_direction dma_dir;
>> +	struct bio *bio = req->bio;
>> +	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
>> +
>> +	dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
>> +	dma_sync_sgtable_for_cpu(dev, map->sgt, dma_dir);
> 
> This can use rq_dma_dir in the argument.  Same for the other DMA API
> calls.

Will change

> Btw, given how larger the dmabuf code is now, have you considered
> splitting it into a new nvme-pci-dmabuf.c file?

Let me see

-- 
Pavel Begunkov

