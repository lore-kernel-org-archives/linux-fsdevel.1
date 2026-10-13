Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC930EF97
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919010; cv=none; b=GLXHv7V4q1zFPy4tj86qILpBhkMzgDHNWVpbot8TxMa6ywI4GakyYRHYq9W9ETck5548BZkqbrwmUJ93ZHqRWIftkYTKBI8pitwtyPjQLu6LRpvO1Ixz7i9z95bFnFu9uSUAI4u2TjArs+uOcIy+lPrdecpWH4aYlLjdNv0rMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919010; c=relaxed/simple;
	bh=NZKCsIl+eMG9fGsQjejtk9lf0m8MqeFHKmqySR38f9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AR88rFnKXOxnfr6bH+5rFKj3FE+azpViiHkHbSIJSkhuM2hCkE6uxXf4/MnltRzJeRymQHshehtoM6Y8og04MRGPI3VmQ1bFihOd5GlhW/h9RXe5GP6ofFXPD1qoLs0bWb5kbG4laXLjDwpAhXMXw1zXLfu1XF3dPsaSL6h82AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=tLLiJs/f; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="tLLiJs/f"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6deb848ddd7so195796eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791919007; x=1792523807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9LMVzPqyuXj5ApWA2StVi76ci1CLBOXVU23pBi3Y7Tc=;
        b=tLLiJs/fgjv16ZNdmzoHeA22l8fBTqjwKXQSZAxFHG0QrydUpQBIParCFiBt38o5bi
         avBRxV7jzLlj1drEnH/C3aXXSrHbUvPukcZ0And3v0BpdgM2GhAoN/0UrJ0pxULVV/4R
         0XJQckApncG0TFCW/WEefYFgNlswkWIv3OcnZxOph1q6iMbTiH1LettNuCThs+CovbvD
         VDZs5MkJF2NF1h3FCJCmQ5ZqLfHKpHq71NftsCusCH5YgvB9EHiwuTPFaJ42dGJJjVwe
         ALp1pTu1Zln74/r2cr1RCK4vy3EAGIG43BlFHNUY3zZYK32SrDiZAqpgCXr3kjiglDRT
         jh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919007; x=1792523807;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9LMVzPqyuXj5ApWA2StVi76ci1CLBOXVU23pBi3Y7Tc=;
        b=XS9GjbDs++QjcrGEEpiQEfZJlhW37QW5N80apxDDy5Cl6H8enOuH3XiXD1IeGkRSzQ
         0BKW4U3AMHd3ukRjffTY6pL7MJLonsM+Q+tNStepancp8QW2gQDh00n9d7I4mzl5fEG8
         zGe7YJFu/XViNzsEgcEVkf32OtZ0z1oHQ9zL0J73QEeQzzMcfaRRbr32Ff1/tlgCf2At
         YxA9i9rHwWJ38CDaWt1/DhWnYLZLV9FB6BMcRzaiIKNBo75nDoVdarwcm/+dOw5mp6Ye
         0zl+oFVLDGQZnKX5CY+xS0H5m9c3mOoblXOH9T+QOehOVLTV6rbOixj32S1kef6ZFF+W
         jsFw==
X-Forwarded-Encrypted: i=1; AKwUvByB3Io4+ogYBJvDKTURJppUY3WLTe1Q7ucCZ/FGHzIITPJ+Kc4SUdicmGhm9vK6feYeHWeRv3YUBpuKGX8Q@vger.kernel.org
X-Gm-Message-State: AFq9FYJN7KyHvd9IQDKq6SfdQmXeAg8ubC4ZxaTWWX/9zZuCXxZeSsHR
	fbvEcTlL7ePHISJP9PhC/dMGbNEASMOoN0soM03BOgk21zSZeyBbvj0jt+H1VUGmP6w=
X-Gm-Gg: AYBFou2OXYkUZfQ/bRcGp/uWylxu25SwvbXkhe+a0mE0VBbCR9tfdjYfJwfay0B0jd4
	eimxuFYuZ1/eGLyIDoLXhEl0PP20pO18QC3ACyPqAGA0g3pbBj4WYe+prslByGg9kR45Yf1Ob2M
	VoT4UAdmO+X/Z/SLRESSZ4w7ytPgywzI6UiICHgJl0DE5DlXM7Uav+MpW9g4ER526AiK6v61iAn
	nG0ehW6s/u8LnsSdDaUkELt7pruvtXDUhetS3jkafkAjx5sYFwzXOvFB6c2ZERBjRU+3pH31xlO
	HHlGKPhaKNJmRlodrfp/y+snaZBm9IC6oOgU3k/NMynNNRFjgY3/2IwYwdcsaAlFRVCvE+99Rns
	miCYsDehR5jv0JxxpoLn44xbbeIWlFjQyiXbFpB2zUIBqn2sq9vqJ+Qxg6ua4120jpfyClZ1XYO
	FkvgW9S06xJUpMDRUnR795eDKhpCyv+XD0mU0H2gLFNoDT39R36ZNcC323RYshzkBUNvaxWW8z8
	DvrjenZJv4jszuSkn5PeHpXpVZ26yf/0+7zD6qO0X8pHBeJR5xsXJ/Jjg==
X-Received: by 2002:a05:6820:c8f:b0:6e2:2dcf:2cd4 with SMTP id 006d021491bc7-6ef0eec73fdmr9825677eaf.16.1791919007140;
        Tue, 13 Oct 2026 12:16:47 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef023a1c1dsm12597782eaf.10.2026.10.13.12.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 12:16:46 -0700 (PDT)
Message-ID: <baae166a-4464-4065-a642-348034cda28a@kernel.dk>
Date: Tue, 13 Oct 2026 13:16:43 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>
Cc: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261013141046.GA12680@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 8:10 AM, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 02:21:41PM -0600, Jens Axboe wrote:
>> I've queued this series up for some testing, in a separate branch. JFYI.
> 
> More testing it obviously good.  I've been waiting for addressing
> of the Sashiko comments on the nvme patches before doing more ACKs,
> and while I can't really judge the code those in the dma-buf code
> also look somewhat serious.  So it would be useful to get them addressed
> and the series reposted.  Same for folding in the PI vs dmabuf fix
> from Anuj, although making the combination work would of course be
> even better.

Agree on both of those (sashiko and folding the PI fix), but it's been
forever and let's at least get some testing done. As mentioned, it's in
a separate branch, easy to update. But if we were to have any hope of
making 7.4 and also not missing yet another release, then it would
basically have to happen asap.

-- 
Jens Axboe
