Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9699535FB5
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922833; cv=none; b=O4k535cTq0DXfKDkBjTgLBbxRLMvtno/hoNtVi+2D17jQxZTaQJ7FrxyNxLPAAYlRxsOI3BlNxpPpghhnD8yHreBTx3LQswX1sm++VgcqNzXBRwsI8bkQ3KvJAbVMLPgR+Ha7GXxxcEJX5pxWJg9l8JA0pRyhMKxixGta3bY/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922833; c=relaxed/simple;
	bh=52S8eIGd/kdNc5YUeahu1cnDerc/gG8vGqhjAz+A1V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0q4+2DRslegnG3eyCGxTEUOUacNWawoKZQGXeSYXWhXOjP8CjrTHauBT52zqVcneV6AsXIJ0Hp31nuFYGLBXvE/21ig1sTFpYiqaQgX2ywbZ2HTlM7lWDeVHb22gLigSJ1mlkg9ng4+EaFzYDzpSufsQd2FKx9DKZbjF2kCRWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT5OjOJz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT5OjOJz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so27445425e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922829; x=1792527629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFWmLiUqCazwiWkaP/d2QvvXVbxF3nnToJUN5Fd7XEc=;
        b=UT5OjOJzidLKFj05iK9BuOurmL8Uy7CUWIVuguxc1JgXSg2hNlDZMtKm9doKnw6oO3
         kNbLvL4Qq8q88Gqnb/+spB0G6J6pBDp0TQDv2ePCHeXCo89++B5/nWWFBLB0ROyYsz+n
         SjMCdmZwi6AVTjJGBZr2ovMgkciMxK6/5L8uxL7691rIZ7Ru9pXBx5JDvcA4ZktJKwT1
         0c0wbUI8DbdmOvZfzCL8fQD8zIivnfBNbg9vKCtVljI9d4l2VzIv2SoFefvb99VsUrb/
         5MU+3aW9OrjhgiUZkULiycdJdAsQKRajaCALEXwleSDsZCtNM9+dHOS76uxMzmpad8d/
         725Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922829; x=1792527629;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFWmLiUqCazwiWkaP/d2QvvXVbxF3nnToJUN5Fd7XEc=;
        b=hOsDfRAuaA9axUvyaNBvZgNyp+t7vWXarqJB7EtIuTQjE028hwPYaMuOI4Ihe3PdVK
         BzAjgUK2rFl5Zb61QhQrbmkbQPFTJDiOmYgCIARv7ovVl1UZMExgBU0in5iNp7XNvuh4
         q88fRikaypFGkZ4LNi/KDUn/GkEPXBXkgausNBberlyzlYJcG4hNvOfLvuvdPjljsVIe
         jlcJvMm9WCI1Hy0UKfLZ4lQv/ySYDm+xLsnGKTwlEYhF9pVQqGdJDwbilMl+zqc4mNMU
         g97TLT4gYOr6oAnbGgyczLSW6qWWbODIFloBKc2sH0mCD1y1WMcf+jr1AOaek6EccgQ+
         gJWg==
X-Forwarded-Encrypted: i=1; AKwUvBywWe1RND3UOK2JrRHSB/Pf79AUpmzkmhDQz/k8fDYhB6SGzYWEVjNE4bsikZB1WkLuqnaMeJJEyzcT4H3p@vger.kernel.org
X-Gm-Message-State: AFq9FYI7Gkl7NWRpNORwzeO8kRG38huaLwBW/NxeR2B2aJoM9O75MUKs
	3QzZqzroz5CbIc7qJeOWnt9q2Ar3Tthpv7OXLsor2ikTRdATv7L4u6KL
X-Gm-Gg: AYBFou39OL5F+HFPMIH+G8ggl7t3HsqGinckQbtoOmY6HkV6y3QqnEwT08BY4gBVCi3
	n8lEATOqBKxqIhAQ0bwssGXS66BDWKsVtOWcIycjapL8DYqsXHyLESfkpluN+/3+JUj6AMlledg
	JHtnYbZUkEuSjk2heW3ibqGicF7W+g20+DhBjM1SWOq+GXBDKzCORzne49flPgg3RKZEzkjWj+d
	EnXR7O9WEgkCSjecM/2f7zowFjHUQc2BmFvGxm9r2yB9Wqv52abUi7LPW6ipRrEZPyrOxRNK4xa
	tix7fpseivkgkMyMKmEsSW+qNKa2OGWI9kFmkY1LZ4BR4aUbr3Z9/twCeq48TDGG/MJB5us1viI
	rp6EAyfe7kcca/sUt4gA0HN4MvH8VGOYtAxRxHwfLm1lrgKWLl5RESFHM7yYamkqMBqa/mRPHXM
	/hxMIkE9vUyM5TbstXrua2vlQHvbrvmJhpLoNKBfLDIgtzEiglUnBsyMDDJwkzhMHkktq/pIld9
	l6v9e4GPUJBiEX7QZzOhpp1dR3iosYZ1Ldsk24MY3m9tV1LTkVqHW+SKkhgD+9v597ZLz5H2sa6
	Xv7i0elVDB69cvVpMNBnZubSlBrOElOUxZhHTIGrazcGx2qG
X-Received: by 2002:a05:600c:4594:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a18e4d6ac3mr267044135e9.26.1791922829049;
        Tue, 13 Oct 2026 13:20:29 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2caf4sm426025355e9.10.2026.10.13.13.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:20:28 -0700 (PDT)
Message-ID: <32a70bda-de28-416c-84d8-a56c261063dc@gmail.com>
Date: Tue, 13 Oct 2026 21:20:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
 <20261013141046.GA12680@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261013141046.GA12680@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 15:10, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 02:21:41PM -0600, Jens Axboe wrote:
>> I've queued this series up for some testing, in a separate branch. JFYI.
> 
> More testing it obviously good.  I've been waiting for addressing
> of the Sashiko comments on the nvme patches before doing more ACKs,

The nvme array out-of-bounds one is sashiko getting confused, we
check all sg chunks on alignment, and seems like sashiko ignores
it.

> and while I can't really judge the code those in the dma-buf code
> also look somewhat serious.

Should be false positives as well.

   So it would be useful to get them addressed
> and the series reposted.  Same for folding in the PI vs dmabuf fix

I was going to repost, I guess Jens staged it before. I'll send
v10 anyway, should be less confusing this way.

> from Anuj, although making the combination work would of course be
> even better.

-- 
Pavel Begunkov

