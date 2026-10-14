Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC0486430
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983225; cv=none; b=szYVQz8WU0lgHe85cg2X1jrTljZfaqxSBqs5SoqrQoir1VzFspQQo/p0o7np+kojgRF/hdHpnhqa6rWFZUWt9+vDciAMaZGldeJ3a6ETM5hpS+xT6FGYfSHcVYtsUMFGi1PhPeEXdtkEafJarVlTqwRePAv+FGzW1v2ItDlV5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983225; c=relaxed/simple;
	bh=OySODPiskWWvzQQMx1Yq/HwVMV7iyUkBWw0BjUbVY6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PC/1zPuqx39FReeg2iFdrv6otBVGyoFDsEXYtyZzBPjoxx70G2QzL/hCZUqwAfcMrFpGhv8lkS9xWVKDJyjn7KJ/h9Vt68WVtcIpvjTr474HD5FmWpBuBTM9DUavNoJ3l9ZpnpOPHw0FWJJ3/HKPgrS+Dcv7k2NDQZBmLmG0or4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LttP+57Q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LttP+57Q"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1ad2e2391so13566985e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791983222; x=1792588022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k5Xx2GBklmLYql9VZXZ+CeE2dU9lwoFm77pkgYHcd38=;
        b=LttP+57QkPAzmVVgUvRW/Pp91UXzLM8OE6jaXUaXULC9NYjzeL97NCoVyX/bypkvRk
         peQUYRfnh5Y7MVpWP9KRooCb+/mVQrAcK3pfdPbFtHqN7CieKU5nDRqxKJs4KaykY5Mp
         47FHCnhxBfn95ZlIQUM5t5uirtgnxgVmEnAsTSU8pPnjLE6qTS4hZ3q7rZwFqBphpimm
         LGq0XY1fMplM7a0KAexltkifQNpAVK1FaCAC4DdwrUBEjs104BAMvmB6DmZ+xRfXWIk2
         z3vVscEpYOosS5Z8V4hkMt6vyU+dMBCChD6MxSCniSCY6yv2aP/zXSFRlHwh6OdTiP4w
         tZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983222; x=1792588022;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k5Xx2GBklmLYql9VZXZ+CeE2dU9lwoFm77pkgYHcd38=;
        b=T5zeXhSeplTlpupoXSYSjJ/M0K+Tu2s/QTqZEJfWbu0cj0ApoerR2eWHcwPJ36MlQc
         Ud9pdg6LsuwON3No/k8079MrCSDC4lh9+x3IGcFurGF+mg3E6snFQu5z51s4IKXfcigI
         fxOT6r3q0fd7Q9JDPdQRbSqJEEoxjLUQzPejD5XJqE/MWMn/7jNwfymmNa2IC54uU/nq
         4chmtxdeGmkfIkqURtNn4GxbhLTIhjQw5li5E4i/0nglDFxJ0V1uZmL+2hWYXcltxmFp
         0yTPSBKRLQ1cLDWam/rR3vbKU6YNSs6NLTnmNav1IpWRCWWN2bMQDnUVyFYYrzIXuHKP
         9/Bw==
X-Forwarded-Encrypted: i=1; AKwUvBxPvOCooUiYTTVafqExWg9VmLtjkSHPvFv3yOx0N72K7jdSqYNfn4gRR442KfwU6izcjZ2dm0/P7QFBrVbr@vger.kernel.org
X-Gm-Message-State: AFq9FYJFZT5O6/VodUonQGs+9aYeq/3Vi4J0KsQtUKHmzuCC2zEP3v/j
	+BgftowX9L8q8np8SKHcPTYwbrBW08aaE074+3R5VwqMvLbKC6tARFCS
X-Gm-Gg: AYBFou3JzW7QJ0/O4XAdvCPeX3hL3M/lmj2pP4wwZaLNufuiKNg5kEBKvcQJryVY4Ck
	a53ARZJPX9WbHxxBzjWHk1goNdWp/xYt+NbKJA2wAuY6zSw+5PHtBks5NlFZG8IVlq5ztW9nQeO
	p5oqlXDgW3MpFkDFhishXN6vOTUPY4JxInAjG9JndmBEbwSqIkQR31yGYT4mgpBL7mA626dfmJc
	jAJKs6XHU5DeRwzidapWWa4YfxubjDc+dSvgxV08EXPINi1pTlb1FzZO95F07xlV1B36FeEitiK
	78CSoPgQoC3mw7sB7WMg6SRWTbpLG3qbk0xuZV78BMHhAyOyZv86Tsws33m2yUihvXbbnqgg7/f
	r/aA/24Mo0x2b4ECFiRrkIyFivq0v6Pg1UNN0J/4qFpIFtkawujM63K8gsoB/oqXAtrrV6TrvBO
	Z0maJkr+HzFZNVX1eCCjbyC/KFcDHP4AjUYMUC/pqdcPB7CnLrGvjxGi94W2Lo3Lf7YDX55vUvy
	yh1VcHi+WW//PILWVFWoVNuvkA8TxiKW2QycYS8vxYhLoAkFOPLrax5ssamvWt3v/1EpAGSgTm/
	ATPqzaPBh7MB+IDW7BDL+ml/ojwtouWpnA+sM/KSV4L1Y5ox2A==
X-Received: by 2002:a05:600c:6994:b0:49c:dada:30b7 with SMTP id 5b1f17b1804b1-4a18e446f3bmr313643615e9.2.1791983221508;
        Wed, 14 Oct 2026 06:07:01 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b3602990sm52779585e9.0.2026.10.14.06.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:07:00 -0700 (PDT)
Message-ID: <8d0e7d1e-086b-413a-87de-20e21f519daa@gmail.com>
Date: Wed, 14 Oct 2026 14:06:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, dm-devel@lists.linux.dev
References: <cover.1791975048.git.asml.silence@gmail.com>
 <49e24334953262e85d5616c9afde88c680e4f3a3.1791975048.git.asml.silence@gmail.com>
 <b461d367-8965-4798-b7ac-cffd4301cd1b@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <b461d367-8965-4798-b7ac-cffd4301cd1b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/26 13:30, Christian König wrote:
> On 10/14/26 13:01, Pavel Begunkov wrote:
...>> +static void dma_buf_io_kill_map(struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct dma_buf_io_map *map;
>> +
>> +	dma_resv_assert_held(ctx->dmabuf->resv);
>> +
>> +	map = rcu_dereference_protected(ctx->map,
>> +				dma_resv_held(ctx->dmabuf->resv));
>> +	if (!map)
>> +		return;
>> +
>> +	rcu_assign_pointer(ctx->map, NULL);
>> +	percpu_ref_kill(&map->refs);
>> +	/* make sure the map is not visible via ctx->map */
>> +	synchronize_rcu_expedited();
>> +	wait_for_completion(&map->drained);
>> +	dma_buf_io_map_release(map);
>> +}
>> +
>> +int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
>> +			struct sg_table *sgt)
> 
> You somehow forgotten the kerneldoc I asked for here.

Ah yes, missed that function. I'll add it but perhaps in a separate
patch, if you don't mind, depending whether we queue it for 7.4.

> Apart from that still looks good, but I had only time to skim over it.
-- 
Pavel Begunkov

