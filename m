Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CC4A262D
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999240; cv=none; b=aF84Majcg6Cahl1kUcVLCZMVQJ8JBzH9sLgJqh07LL9SOKmXj5zChTQzyGnZcEJ9UBtz8/zzF95iQjZts3StPnORUE6Wa9MCZ0+BmLNBzoJpCDP1riQ2jXIqC4JXK50BgZjpQduhBOkMKp8l4T5gHjI5MN9hQ/vfIZKT6xawN3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999240; c=relaxed/simple;
	bh=OeyvfHgi0AM3S4WMT38BkWK6VSxmsJwFB/n9ks+exd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+4mNXwGoJhMVU3LmgiQBlBDXVRJnCtMENKzfliObenM9xWTvQ8mC3V5/5JBUbDfTcpzwDiAlOonOPo3TId88kqIRj/3ebuIbKxsS7rTVRx545yWm/oB37pc1noxoK8EuOu3XBMAWGPno7x2xyRQhu04PEXNxmaAT/JJ8SaIGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy3lm4mW; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy3lm4mW"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9a2b95b72so4859587a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789999236; x=1790604036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YF4hTPZsf1CzF+RjsRJpL1NqJMDoLq3jkvr85glNVqI=;
        b=fy3lm4mWVVfxCbiB/3/idnBoWiGR7Ak2D36Mzxp6PBr2+Q8laVBrWpIRYVMTFrcp/0
         jFF0hAEuenju7k/fW2j0/C1Jli1UP8WnHH/Of94Gvk1sgDsM7fWI2uyyOZHUsjkVJJPb
         0JtH6BP+SVZlH0HMjkU4m57nlQhEUE2RAVPRXvprm0BKQC1hQgaD4/dvBt4EOAFUDnL8
         rpAJY91Fcg/OygM5CEK/CUumLCPykTEC3z5vkEPe3zTfIl3UWEN1JSUp6/FvaR+dRraE
         jovk046obSWMIph957RrWPJMVfeJ6kFVMrFj0Hqvcqs0jI8QC8TubZvfnFnAJXJHjE1h
         Ikjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999236; x=1790604036;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YF4hTPZsf1CzF+RjsRJpL1NqJMDoLq3jkvr85glNVqI=;
        b=CsQAsZF1xT/dQSBE8qtInTBY8zYB2UpJVd+lvtCVIva+nAfKTDGVv61bPqzdxLmT1Y
         mTC+kIyVSj9oErfUwSgomL6hCX9FsIFMTEjQSg4jZ+0+R4FZ4Nktbx3w/X4IabjyEvAd
         jil0OkjunFb7fKlWwr4cNNJACk7X+wXpt6A+R14+q1GWIU1zmrtOMISG7kdT4EyERtIN
         OpFTjpiVvSwwo/ABARu5CyMOD4xRG2mYvgx/iVr+ybuCd6m4e7DG3344ihI35d5HT7jR
         2CiHMNhQXHLR67cuMzemK4mihlUDaHkk3AAt8Dyf9ecOWW/FYDz0powjQJ1o6EosvSdB
         sfhw==
X-Forwarded-Encrypted: i=1; AKwUvBybkO/Va1UzP1bQZ/xEHU7ngDwlhbtz0g8P0C3k3eQ3yYwgWYpGH2TlVYl/kZD/zByCO62CKKbXMpxD9uyF@vger.kernel.org
X-Gm-Message-State: AFuF++lWvHwriyVlLKW+IxaAS79iMaWz4OZ1P3iiEaa+/vhrOkQ4VHRw
	3FmsAP6SOjfJJ5nBgX9w2Xehe/MYAyii5trT/usbYH1eVTRUVnlQsp+F
X-Gm-Gg: AYBFou2lfyiNfGF7hhLO27Feds2+bllR2q6akNuBITcRsBhjqLpdRgHEbBJ2GSv6IZf
	IhKrzZi41FfaqomC8lLvYMw1pCkjlAQoaMpgbbfnG0QLtIAZqKzdtHCrsh2UsZR9x506rdIzEHA
	p3XeYVVeZyuEDiZgPXY98vDrjOvOMCXFMbv2gomv61U0FU2h6jbBzs4KN3XdmmLF3259F3LigZr
	DC9U4fRayvSbooQqJNuD479xErUH51ELZ8xPQQ1hUoeAMo9LjthCd4mF0Ybe36YLIujQZJgDFLq
	dLJnX1oUHdn1iiR2NTFD58TcZD14WXrK3YumhfhKVWPz/Dl8c/GB0d3A4L67aEAblsDVEYBQvbH
	buiW9V7fUNJGmbzUashfvFyH8b4xes2w6q5r11juA2n7POVyRp0B5XJcQxrlTwoFBuzux/gYOdz
	1ttggkoWaVkXDo9krogXLrcv8B5racCOlcmppPVVGhhWDWE5+ejnYPTVBuAUIuuA20YP26sDuGM
	wmm9K2OtjPV7Tqtc7xb03Cl/0Af17LQC77i1WViDOIHGtUoJz6Nr5bmqPg0cI/FM1x8qehKhE6N
	NuvmluBcsk4tVuxMtoS+AD44Pw==
X-Received: by 2002:a05:6402:210f:b0:6a9:aead:4e98 with SMTP id 4fb4d7f45d1cf-6aa577f5cfdmr8223981a12.1.1789999236010;
        Mon, 21 Sep 2026 07:00:36 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67e1a45esm4427483a12.25.2026.09.21.07.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 07:00:35 -0700 (PDT)
Message-ID: <14db93d0-b41b-43c6-8934-82d10cc50168@gmail.com>
Date: Mon, 21 Sep 2026 15:00:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] Re: [PATCH v4 01/14] dma-buf: introduce initial
 file I/O infrastructure
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Nitesh Shetty
 <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
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
 <181b08be-04bc-4ae9-bb88-15321a82440f@amd.com>
 <anPlbjhpPmj2VZxm@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <anPlbjhpPmj2VZxm@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/26 02:37, Matthew Brost wrote:
> On Wed, Aug 05, 2026 at 10:27:49AM +0200, Christian König wrote:
>> On 7/28/26 23:29, Pavel Begunkov wrote:
...>>> +	/*
>>> +	 * There are no more requests using the map, we can signal the fence.
>>> +	 * It should be done before taking the resv lock as someone could be
>>> +	 * waiting for the fence while holding the lock.
>>> +	 */
>>> +	dma_fence_signal(&fence->base);
>>
>> Signaling fences has a whole bunch of very strict rules associated with it. E.g. you can't alocate memory for example.
>>
> 
> Yes, and the rules around signaling fences from worker threads become
> interesting as well. In practice, the entire workqueue (or any work item
> scheduled on that workqueue) effectively becomes part of the fence
> signaling and reclaim path.
> 
>> Are you sure you actually need and want a dma_fence here?
>>
>>> +
>>> +	dma_resv_lock(dmabuf->resv, NULL);
> 
> So this is illegal because code is allowed to hold dma-resv locks while
> waiting on dma-fences. See dma_resv_lockdep / __dma_fence_might_wait /
> dma_fence_begin_signalling.
> 
>>> +	ctx->dev_ops->unmap(ctx, map);
>>> +	dma_resv_unlock(dmabuf->resv);
>>> +
>>> +	dma_fence_put(&fence->base);
>>
>> You should probably set map->fence to NULL after that.
>>
>>> +	percpu_ref_exit(&map->refs);
>>> +	kfree(map);
>>> +
>>> +	if (refcount_dec_and_test(&ctx->refs)) {
>>> +		/*
>>> +		 * Destruction needs to wait for I/O and dma fences. Defer it to
>>> +		 * simplify locking.
>>> +		 */
>>> +		INIT_WORK(&ctx->release_work, dma_buf_io_ctx_destroy_work);
>>> +		queue_work(system_wq, &ctx->release_work);
>>> +	}
>>> +}
>>> +
>>> +static void dma_buf_io_map_refs_release(struct percpu_ref *ref)
>>> +{
>>> +	struct dma_buf_io_map *map = container_of(ref, struct dma_buf_io_map, refs);
>>> +
>>> +	/* might sleep, use a worker */
>>> +	INIT_WORK(&map->release_work, dma_buf_io_map_release_work);
>>> +	queue_work(system_wq, &map->release_work);
> 
> You can't guarantee that a GFP_KERNEL allocation won't be performed from
> a system worker thread, so you can't safely signal a fence from one. The
> pathological case is when all threads in system_wq are running work
> items that perform GFP_KERNEL allocations, enter reclaim, and then wait
> on a fence that is signaled by another work item queued on system_wq.
> Since all worker threads are occupied, the signaling work item cannot be
> scheduled, resulting in a deadlock. We actually hit this exact deadlock
> early in Xe.
> 
> So, as Christian says, think carefully about whether you really need a
> dma-fence here. If you do, then you need to play by the rules.

I started with moving it out of wq, which was a good idea anyway,
but as mentioned in another email, in the end I just got rid of
fences as I believe Christian was suggesting / hinting on. I cc'ed
you on v6 if you'd be curious.

-- 
Pavel Begunkov

