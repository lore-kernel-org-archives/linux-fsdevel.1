Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEC24749E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324523; cv=none; b=RGZNdjPcibZjKuif3wEQhYgjga7D16kktJlQX/X4C1V3he3E39LLsDcxp8ADo3hEPRzjSR8TrKqzbwaHx+TSiOBgDzrnisGFPMQjjqIm5bSrx2kvYjFWpXiNWRNTl5uarmrm/XbzgnR6w8OdrVS8RraoKXImoqzDQcUmGq6Ejvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324523; c=relaxed/simple;
	bh=c8bXkSao9MJ4kDOqs6oXQ3HhNP8HUICfRxyNML/BlEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxsGn5QCDF5vib0KojsaTnC3e0KT5FtkbkZN+kTxepIZ59MQZAW2rhiQ9pBodpb5lUMBoUOMP5FUjnmDHxbW1VrCzNw0uUBTQqft9O8KOuEbtqUA1alT3lhI/SuA5j55aNvrcWF73HuOwkhjI55ZUuDorKIFezG50QkffmWgfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vkg4Roxn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkg4Roxn"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1c4db7ca93so109781066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785324520; x=1785929320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDeRfN9blSLpZUyGDvy3JYR8gWm0jeyVXT2Ay7oVK6c=;
        b=Vkg4RoxnL7SMMdhAff6n/vIOD+Pc3C/D2bzK4+xOfQr5JJzbu2Nzj2OteytHhygSU2
         2qcOxRr0/unoHvtpi8ruamO7pvP0unzfVF4THkhrNVNBt6nFOzGNIYDPJ4CTyn30aDTx
         ArH3rJa2/Si5ZeDm3EDHg/8cbytqnImUoP6J5guGPJXGEvkKppTDiJaSYm72tJN4N6y8
         niAVdf9dPY5QCiHcVDYsVReWc0cxc5kw5zlKF2EcyZBHMw7FBIdLDuScoqXWL2thfpGq
         bP1JNt9kscBaNxWdYTTaQNDzBwA6z6f4BIecLNChO0Nth/vp8MRI8U88JbxmPS936owP
         giMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785324520; x=1785929320;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDeRfN9blSLpZUyGDvy3JYR8gWm0jeyVXT2Ay7oVK6c=;
        b=VgBZF2Q/OQSUbZs6GAunRu4Dlrp8eH1pqBZGOTr9j2vSzjds0xvncaa1TTeGu47+sa
         FCcQlaSTlVkgYeCwkjOREaAxrC9z6HtJBGcXYYUJftXYgLfUKd5unLQebwvLwZ9kMvW6
         3bh1/WScKqwHN2G9hE47Ii2nEkT5QKbQeQmmJcKEZZyL5CEhBd/HsMOmSkfLzcmiR5Ro
         7jbEaeNFSTxZ4BPYN/z4GJu4h2D5R7AygQlNW3DY5ZCY6oyBifSXB8a4M9AwNwq04Niy
         r+ErD/5p4kjx0m4EN5Wpxs2zvHCZfr5lBSa+adynh02zZSF5cOSiaBcZzCDmlgYM8+3q
         WC4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpcnqXtlmtnyEoR3+OBCxzYF5Rs3ab7j7wph915NaTJWsOHgotYOsT0czZqdAYkS/QcQOB0sOEecoAm6vqx@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrpmzFxT8iuhx+o38YpwoNS6/GxkSmHKIktz4otpCfEUbwQAB
	DQiOE46WUCObhOBlsW0MYpzLNef41ScwpNBQONHE9r1GWv4theXvqsJC
X-Gm-Gg: AR+sD12sxPkbCy5s11IbfZXZ27Lb6MgKnNpMheRFZNFBNgVI6g+T7tkofgpOaTCK8s/
	A4dG1pk9ehb2eH5UyBG2i+jRkF0RpZCsmKNViQ52Vmwco/kY9Xxzf9Wc2ClljxBGBM3fXTh0LtT
	/s4fkR3aQUCSOMp4Yx4sL9M+8sKCd971kQolvsz+MeUBAlICvA9BxmghnfANU7n8pDU8eMiGvOY
	DPWe5kt9/VQInA/A9hbcZpSJKV3hQTYHmeP7d97BkDGz7ZAK1MrDkXGwzeLh9pjwjxkZbDBRK/4
	oNokTW7FLShBB3g45yxand6y2s9sDAS3sYe/jutqmh+XQwjmxXD+g8aB1qi+7WR+pPzBhk1K3N9
	NHUqVngeSj9978tT//t+OgBIgm0ojBOP7QsJpH7P4QxAci0TcBgVq7N5kWivLKfNgtksFYjfNBO
	E/ebTI6d6WtiTOej21mbLTMoHVJ7e4HzFjlajGvIFpVhjCHG/8yaJImSp0hVvE+2s7amQkKhVqe
	66tDN9OUmWbrAEhjzc/JIC5ChK0scssQrSEGpruWqke089LkIrqZZ6fLQHTF8tvqtQUHPwZcfb4
	bd9J
X-Received: by 2002:a17:907:842:b0:c16:5b3f:52e0 with SMTP id a640c23a62f3a-c1f72147104mr346195966b.38.1785324520387;
        Wed, 29 Jul 2026 04:28:40 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83cea5f8sm100629666b.24.2026.07.29.04.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 04:28:39 -0700 (PDT)
Message-ID: <872e7a5e-011e-4415-98dc-96c9066b0614@gmail.com>
Date: Wed, 29 Jul 2026 12:28:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Add dmabuf read/write via io_uring
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
 <20260729065421.GA9468@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065421.GA9468@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 07:54, Christoph Hellwig wrote:
> Might help to say this applies to Jens' for-next branch for those trying
> to apply the patches..

Ah yes, and there is a branch as well:
git: https://github.com/isilence/linux.git rw-dmabuf-v4
url: https://github.com/isilence/linux/tree/rw-dmabuf-v4

-- 
Pavel Begunkov

