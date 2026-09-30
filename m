Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B03BB110
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762994; cv=none; b=i/mluR6DkNVmFuO8L6uyzBRCBlacnit/FQkKlPv1Asr+YsqIKwt96u1hNlvSo8VOEEs6m4F0PM+z1TsUVc92l/1cRk+djPCNPJb76f+RjrK6DqSs87Zqit9RQqCE1+bCovRXIZTfmUJYnGDr1UMGZGkNmSSBKlPRI4MlQ5CrNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762994; c=relaxed/simple;
	bh=hrw1dd3W52X2PRIBJ61p/Ixy3mLjm6opZZ+GWT4oBp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AG63S+WuWGHDKTRnWRnoS+J3MYP57ffquvHyz2Ui8INMy6B4CiSOQG1pKCJd3CUKowZnyzYy4/o2nnOLzPb+Y3gHV4CHFK1liXDuXzUoOfyYepz7YFhtG6Fty03pldv52kmHbKX5qz9UQA8UKEzq0/fKjyTjFmVQudUFAjaFz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkzMs851; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkzMs851"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae19959791so385891a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790762987; x=1791367787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ruocdeJmKgpaQFus+PucSGDLt7ZSCHmy/3XR1sTVzPs=;
        b=bkzMs851c9zZ8pLRd7lGGP1HQkdNCJPEQ9CuXY49B0eFdR7dpGB2Nur49+z/HeFkDt
         /SUCrNcWrt6mHvkiKtv5YoTO978/x0FED9JnCX0Almu9bcN+rWc6Vw9/YKgCZNEsUjMY
         eEPNYB/IE7flOrrYfumMz/Yx/kGJAuanFQkOz1UHN2Vd5QMBdgYAjUmprorWC5SOGetH
         DH3fbXlvIB1K4BuylVIKa8z6j3JzdSpqtjjxxZ/nhXwLOhcKvaNjXwDfodTHtvNH3Z2P
         mx/KKz9VOP4glr4+nStpRUBmLTXc6hFwIx1ennedbu8C9DVP9nCgNzuTcNnitLYDpsnu
         fOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762987; x=1791367787;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ruocdeJmKgpaQFus+PucSGDLt7ZSCHmy/3XR1sTVzPs=;
        b=1vvHU2Qv8WDBDWhU+WV4W6GqCdA15kmKpIHijpKo12YDLAcOU56yOxP5Jorl+chqxn
         G5C01m+Ha8kcUxtxjhdH+C6nfcisIsRDNsEuNSJWrVkRaookXP/1BXZi/ewVUSFJn9I8
         PXo6jD/61Y1zjMHUmDinhXXEsJtUaS+MqDuTanghPPiwQpO25Hs4YGvqG+98Y3ZRELmk
         N4XWRS36eP3EKowHwOLNUZfVaMLnY6u6xHbrXcTnp9aYZFQbImbvRKeZBsTxg0jzSkZT
         DjGSCrkat6quEDMaqKDR6uWZ2NNMpeluyGT5MCHXtIgeXuOvubjOynDuGtmwg2n6YvnN
         pLFA==
X-Forwarded-Encrypted: i=1; AKwUvBxbnmlLiB1mZJH3lnQrqLX+/CxqmNh31rr8ST/sBVj+5S6Z8IJOFAvQoXutv97gJvucbA6uqH2qBbd5wqY+@vger.kernel.org
X-Gm-Message-State: AFq9FYLRPkyEozesNpEGkVy/fXd5x4ssryupo6z17XK/i9AYBcZ35idj
	NlF/hEQ0Ygpg8T1byHDIXOaETp5hnoerG7uVGBqUazAkiWWjW+DizSC9
X-Gm-Gg: AYBFou3qAzfapH0U/vV1eTZf9TpKzc4RUwbyLdksfw8q39jGk/1OXFUS80rPHJSuW5H
	GF12SOZhLMxU0WnU/FpQEbR+D6UtiyPbamuFPNHFLyLJW66nqnVuaJyxqcXtydWo/LbiAiyXEYZ
	CdNmLV5bUmN+3uC9xhrbyyKCtFLVXlvHHbMhGz/vGEtCUpN+ZALiH7RKx/jcgWvNjiLBr1hWcrK
	EUlGoNIKUQgUrsjFCqyZYIvj39jXYRoeiMMpAH5cENTOIBxC8V00MJUrGMxIpeRXv9D+aZ8lr4C
	DeI3gpet5RDFwKvmj11XhAWw1PbyO2FVYKq6VE1BmXypwmypPhAsAAFxcchB6Yawttq6+4RiZKt
	MVOmbIW4xWdgsWTNoMOcD4F8DaSSqdUTB/lXhF7jJBtve8KZmDaD14GXIXRppGFJkRE6remrQeK
	3K/vRupgPUssqr15YukPj4m2GUZBh92XGlKwovLT+iMs843Hut9BvgVYlo38I27SV76dlvHPwqQ
	HToZAb0pYWDw6l5UbGCo1l0UgACSzEEQlu9fBKCDO9hfw6Ys7bFQFHi9Jthj/WvtRZjQKiCO+Qr
	O4/0WAVGv66K+2h8Wlafw1CZY345jEZaLc+AmUSCM0x8C59z
X-Received: by 2002:a05:6402:27d0:b0:6aa:ec02:7de1 with SMTP id 4fb4d7f45d1cf-6ae199152a4mr634773a12.24.1790762987076;
        Wed, 30 Sep 2026 03:09:47 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae15690dbbsm551642a12.22.2026.09.30.03.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:09:46 -0700 (PDT)
Message-ID: <77db5aa5-f160-48fb-ab59-a754b100bc34@gmail.com>
Date: Wed, 30 Sep 2026 11:09:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: agk@redhat.com, akpm@linux-foundation.org, anuj20.g@samsung.com,
 axboe@kernel.dk, bmarzins@redhat.com, brauner@kernel.org,
 christian.koenig@amd.com, dm-devel@lists.linux.dev,
 dri-devel@lists.freedesktop.org, hch@lst.de, io-uring@vger.kernel.org,
 jack@suse.cz, joshi.k@samsung.com, kbusch@kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-nvme@lists.infradead.org,
 matthew.brost@intel.com, mpatocka@redhat.com, nj.shetty@samsung.com,
 phil.cayton@intel.com, sagi@grimberg.me, snitzer@kernel.org,
 sumit.semwal@linaro.org, tushar.gohad@intel.com, viro@zeniv.linux.org.uk,
 william.power@intel.com
References: <cover.1790602223.git.asml.silence@gmail.com>
 <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
 <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/29/26 16:45, Christophe JAILLET wrote:
...>> +    for_each_sgtable_dma_sg(sgt, sg, tmp) {
>> +        dma_addr_t dma_addr = sg_dma_address(sg);
>> +        unsigned long sg_len = sg_dma_len(sg);
>> +
>> +        if ((sg_len % NVME_CTRL_PAGE_SIZE) ||
>> +            (dma_addr % NVME_CTRL_PAGE_SIZE)) {
>> +            ret = -EINVAL;
>> +            goto err;
>> +        }
>> +        while (sg_len) {
>> +            map->dma_list[i++] = dma_addr;
>> +            dma_addr += NVME_CTRL_PAGE_SIZE;
>> +            sg_len -= NVME_CTRL_PAGE_SIZE;
>> +        }
>> +    }
>> +
>> +    ret = dma_buf_io_init_map(ctx, &map->base, sgt);
>> +    if (ret)
>> +        goto err;
>> +    map->nr_entries = nr_entries;
>> +    map->sgt = sgt;
>> +    return &map->base;
>> +err:
>> +    if (sgt)
>> +        dma_buf_unmap_attachment(attach, sgt, ctx->dir);
>> +    kfree(map);
> 
> kvfree()?

Sashiko also flagged this one. I'm going to apply the nits from
both emails, thanks.

-- 
Pavel Begunkov

