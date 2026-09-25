Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AA49E141
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341248; cv=none; b=mPw2TcyvhLhKPCeDpqOI+IDZawCVjOldfWvx2SRtQgyC4mGN5Yw0cFTSucNoNOV/Pbn/WtvsfDGXJMWwwLJiYmr9VNgOewMvuJneaZh3clQBqeh7V5g3jO+mc4K57TLgKDTyxUIh1UEZDcwbhhvkl/HGOcYUExfxsF4spXaQ3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341248; c=relaxed/simple;
	bh=B8ekT+PUp3P7wgce1HzrjF1OT3YV27elGIMsBAW8Yg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzkLoDJRwdl4aghLElqknF9GyBgxJ8Un6HwcLT9CKE7waVdP3WiY0fK7puKV88sB/sBaaM4hhcnC6ySgFpKrqJnG+gnoeds5KQkiKADr1eB0r32ChKnk8aGaNeMUon+Tp7BMvcjhaJclHR12Grk+TLbOoo5hu2O5h1hGpEp+y/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=F/h2mjeC; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="F/h2mjeC"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db22383fe8so2978205ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790341246; x=1790946046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OrcFZRDnFkiDn+MYWmxCF8cD4rC4Rzquwa4PDTiGChk=;
        b=F/h2mjeC59Wwql36M4rkKs3r/Hv2Xu9l1dAZdrJb7UXzNzVoN/GVybNZt68kCR9LOS
         0X42LqEg3ELZKS2EH7LM5ERS4Sa8yO75W2TAXkw21LRbiqJCtdi1r1LzPPNtcAwz1pBz
         wepxGFoW+o3GJGljlq+/ABDIMAPOmzJtqKa1VPotl1b0L+3mxqUq0q8c3ltKTNnwCewY
         DU27b5yjIjAwxUr2USqOv22ysUvXAjOljy93EX2UiR17Y6XigFlE1RHG8SERhDrmFD9o
         aVopowMvHin1pxlQyNX2tPBFpzyh9yU4IfZjBaU550RMBmpwmNihX8nO8ZuUlwhrvvc1
         tmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790341246; x=1790946046;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OrcFZRDnFkiDn+MYWmxCF8cD4rC4Rzquwa4PDTiGChk=;
        b=ZGrMWK42RXFoHhW9LTmHQAdR8c5bSqtt09VWGydUVB/AX/VY4lhZGF4pyv1ZHNuQhq
         Iw4nDJ0Su9KuAn13pMbT68KK4VeCQ2ja5R1XkD5VWIfFZRAuHgIA3lUa5Obg1ZA00E+Z
         7hSb4VLIDoAS5ADNrdl7+7ta3NrdKetOahRNINIkKD6iccyQQC4+C/vVXhjCuLKKB1/M
         nnAZqv9PNnUDK3v9nEf8JSHxNu2DxpKtjl/hSKUxxoDz8HKfnCYPkOlCIiAm3a2n1FIr
         dm72E+/YmI/ErLSvblBu/Gw95aCNWu6d4Bsy2jQ1zBAOls3p+MJlRNeL8uaGctcUZ6Jy
         P5XA==
X-Forwarded-Encrypted: i=1; AKwUvByOa59IYNxAL/SZ+lqx1onm4Gzp3Di+yrk7XT1z5Tz208epx2Yi1CWNrPoOygWRGwMyUPH03WZJ4AkY+u6d@vger.kernel.org
X-Gm-Message-State: AFuF++mu8r04yjQfodiADe1ehu5xrJ+Wt4QCs5115xLLIvke0UKVG+GW
	87rAhsI2Tm4f6Qwii/ho3mhtSHx39m9AuoQ/ocrPE8OaF0Oket/bD+lLItwunH6n8do=
X-Gm-Gg: AYBFou0xPOph5I+Hzx91CYZzhNiTbvoOqTEDm9NitoJhrwJwMV2YK3EwOWduv7neKNT
	f5zgFh8BnqM6Bjt53TJf45KVVOUyDrC/y32wKKAjkYJvNWsIwSomViUS+j1GJEIXB69PwQHYkfN
	mOQMD0c34guFw4TnrAEKx8DBchSbrSQYesJ79PLI8HArgjPmfZ09tBlWzbxu9k3JpPbWjZ5Uc1p
	HNnKQ/+z9zNsOS6irMJtAe/rrafCud+eUievSHcJGn4SfNnSJSFbBkgiKQdgPV+UUrvuK3BWcFs
	aSxfyXb0q+X9ZhPOvsd7yHwusv8D/AB+C/0l+w3JSQilKdkSq0B8Pi5IFw/iHgaoTgZt/gP+NDq
	C5NTKeAi9EsOdxY4sBaI3ZDv/bzQG+LRoInAFjv6Nkurg54lE0E9WXQ3hqb77QgiqEA/f7v4yyF
	aPaa9ggPiJqHfhafIjYki/8CLGV6uvYNLHWVvQS/K9dF4SZkvUtRfxWSplzvPjE3s3Ul/pRNmqh
	Lyh8wlvIv+5ru2Z23/e4vG4Ohs2Pdc=
X-Received: by 2002:a17:902:ec8b:b0:2dd:c053:82f6 with SMTP id d9443c01a7336-2df7deb7a71mr48844055ad.45.1790341241383;
        Fri, 25 Sep 2026 06:00:41 -0700 (PDT)
Received: from [10.254.237.61] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913de18asm9819175ad.26.2026.09.25.06.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 06:00:40 -0700 (PDT)
Message-ID: <87e10baa-13a8-4766-8d6d-9173a4b0c5c5@bytedance.com>
Date: Fri, 25 Sep 2026 21:00:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] memcg,writeback: flush foreign bdev mappings
 separately from owner wbs
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, willy@infradead.org, jack@suse.cz, tj@kernel.org,
 akpm@linux-foundation.org
References: <20260925064444.3944820-1-sunjunchao@bytedance.com>
 <20260925064444.3944820-3-sunjunchao@bytedance.com>
 <arYa1DbKNeAN-PLl@infradead.org>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <arYa1DbKNeAN-PLl@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/26 2:55 PM, Christoph Hellwig wrote:
>> +/*
>> + * No extra memcg reference is taken: this work is embedded in the memcg,
>> + * and mem_cgroup_css_free() waits for it to finish before freeing the memcg.
>> + */
>> +struct memcg_bdev_frn {
> 
> No reason not to spell out foreign here..

Yeah..Andrew and I discussed the naming in another thread. The idea was to stay 
consistent with the existing naming and keep this patchset focused on the functional
changes, leaving a broader naming cleanup to a separate patch.

https://lore.kernel.org/linux-fsdevel/20260917065759.2643940-1-sunjunchao@bytedance.com/T/#m0d196c3b8376c9b51276f6c5d26ab9f29e170169

> 
>> +		/* Reserve the slot: it may have become busy after the inflight check. */
> 
> Overly long line.
> 
>> +	struct address_space *mapping = folio_mapping(folio);
>> +	struct inode *inode = mapping->host;
>> +
>> +	if (memcg_bdev_frn_wq && sb_is_blkdev_sb(inode->i_sb)) {
> 
> Why do we need a NULL check for the workqueue here?
> 
>>  	memcg_wq = alloc_workqueue("memcg", WQ_PERCPU, 0);
>>  	WARN_ON(!memcg_wq);
>>  
>> +#ifdef CONFIG_CGROUP_WRITEBACK
>> +	memcg_bdev_frn_wq = alloc_workqueue("memcg_bdev_frn_flusher",
>> +					    WQ_UNBOUND, 0);
>> +	WARN_ON(!memcg_bdev_frn_wq);
>> +#endif
> 
> Instead please fail the boot.  If we can't alloc a workqueue at
> boot time, we're toast anyway.
I followed the existing memcg_wq allocation handling here, which also 
warns and continues. Would it make sense to change both allocations to
fail the boot in a separate patch, so the policy is consistent? 
If you prefer to address both in this series, I'll make that change
in the next revision.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
