Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4635AC33
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518062; cv=none; b=dNiGvIVeDzQ9RzIlZuICwrNyUKPZ7I4bparJcJY8V5zftZccBTtYnFkkoqddSWhwNSXNm6dqohZ8JrYSW7irgAsi17t+PXZGF2sLiEO+AX0nUcR7ghXEHNPXDI+OazWHN+ji6KdNEYzD0o5rjqy6QtiwfcBmR/j8dn0TBo5rEdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518062; c=relaxed/simple;
	bh=gj3FipAk0mkZ1G0uWUhFzsPLLcHh/3vI4CjUXtgNn60=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MBr49sQx1lsyBgg/fxWVSWwQm/6+lnZBMV2wpT+489dPwhiKLOfNyYI55Fm9TVZLWBRV8x/Gcf06MUtnOImtKgedm07tv3p//PeSAI8bTTuKIZCryrKCBbaCVuqmm3+P5hkmMn1SzB/cebkohjbBi99rmw4INQpcYO44sAezt2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSDc2+4D; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSDc2+4D"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so64723666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 00:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786518059; x=1787122859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8f1xvm/nWHthIx3tuw3JQX6WiPdj3gaDMF2QvCAcy3M=;
        b=lSDc2+4D/CytqsGIAPVkikMapr2jJL+7I7ewGrOzE6fU3FUnsYuBtFQWrz6Z4AsjXq
         PikjE7O5yc9E/EolqVRvdkktiYP9P/bhiKZ8+K6hyZHf+HWYAt0dR9sbgSxhpdQ2TXJV
         yeHwESDX8qh4RUC61U/c99ydvG5wQRWKoePHxHbKsg/AbhyQtEvZLlsEl9Ew1m/izPGA
         xgMifstia887l3sETqQs/UIw41WjVF+ofqq/4s/OKMass0jkBD8Vjd77ePLwOylxN3Xl
         BuB6FK5QCtqSND7iSDphtFYpDrEclGunAo/ReOmvS8v4cRyI/graDQ4QQjSLI2Hu42PA
         9cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786518059; x=1787122859;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8f1xvm/nWHthIx3tuw3JQX6WiPdj3gaDMF2QvCAcy3M=;
        b=tBhpoKq/A+iL0J0LJpmlfTa114VAFKU/c0WvEjyqei7x5Bedcb3aaM6RaJHLsb74st
         1n1IdPwCSuI/YoDNP6Q1A0ZTnPJCOstMLqXUHmxDCmVFIueUq0eVsOnqIna2u2nJ30SQ
         5BKqtjITPgpoQ68T67liTTP2BBpQtvFhsIunusC/VANUKd/cSVYANqWE+jAHr27q0Mu/
         NTm0OLLaTjuSinGw+Ao7IY5BIx0zWuucLYe3lttbWIZ1+aRV05JVzbQ45RJAAbdejCoa
         hs7D5y/bToIa8js7+4JuiqweMqfclqiV94lsSPg0BVwmL45gYV4S293pcyrcd8GKO001
         q45w==
X-Forwarded-Encrypted: i=1; AHgh+RrGuq2PjFvvm4ZzRLFF1WcbOGvGVfnxpc5pOg9zqSgQQskZ5//hGusvUIPiw4yp8QwKth7sPwbVZB1m98bU@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkTv71U6o2vG9Pqixu4mPN2ouakLrbuJRVOsiT1wU30TTtmtf
	/iceN+7cRp5oyIXwsfKmsMcSkDnmdjXdMzJzAttV9tXNqj4MHg/efI89
X-Gm-Gg: AR+sD11mCZddt3d8FpUITlIiG0iPTFYSfGl/8XviGripCahwhktQSp+GFcUgALCu/F3
	v5N3Fa8NmlEzc6kNqz7NU7++WiwTEg0rDynR8ldNUYPGJGjQhfmHyGraX73TLLuh9UzkTnWijfX
	jrEqeuejpd+4cbzERKGdqWUZEBdXMXZibfxUnNZnyHllvzyXXASNVZbXkmBXvaaIuzLUriLPAeB
	wopyvkmvKy/xjEx8lDeja1CAMX/WzjMR60qu952SvRsUAe24qkwD975FbQ8C654H3r/LAL4hDjj
	Ls6pRUVqUfCmtepj8m18EStoCYDIQeP9hiQoBCnCHHu3DYuEZ8yqNi3D6T3xdRikeJscgNnfVUR
	b1KhEyfQjBb0mIEeDx6UXv7guwohLIr4mmp9i44iRRclWcxDiKvBriEgUI75YLpxxv+Na+S52Dy
	649wv+9OeyuBAe9Yy2rZ+koz/IWIiiCyzsbCi7Go8c0ptgZfsI5wDBi8mzxnhgtWBoDfi+aYix0
	LL73VhroIQXaghUSWrQOvebEyfes0hBjycG0NgvuYbMYTaS/jWBkcQp6pT0oYc=
X-Received: by 2002:a17:907:3e91:b0:c1c:332b:74a1 with SMTP id a640c23a62f3a-c20f3079a68mr139534366b.28.1786518058692;
        Wed, 12 Aug 2026 00:00:58 -0700 (PDT)
Received: from [192.168.178.24] (cgn-195-14-219-6.nc.de. [195.14.219.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d4e3f5sm4639567f8f.22.2026.08.12.00.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 00:00:58 -0700 (PDT)
Message-ID: <c334a6dc-37bb-40bf-ad8f-19fd84386e1d@gmail.com>
Date: Wed, 12 Aug 2026 09:00:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] configfs: fix use-after-free of symlink target racing
 with rmdir
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
References: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
Content-Language: en-US
In-Reply-To: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/30/26 11:30 AM, Vasileios Almpanis wrote:
> syzkaller reported a slab-use-after-free in config_item_get() when
> symlink(2) races with rmdir(2) of the symlink target:
>
>    BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90
>     configfs_get_config_item fs/configfs/configfs_internal.h:127 [inline]
>     get_target fs/configfs/symlink.c:128 [inline]
>     configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185
>
> configfs_symlink() resolves the target with no locks, with the idea
> that a hashed dentry means a live config_item. configfs_rmdir() drops
> the last reference to the item before the dentry gets unhashed by
> d_delete() in vfs_rmdir(), so get_target() could take a reference on
> an already freed item.
>
> Patch 2 fixes this by unhashing the dentry in configfs_remove_dir(),
> before the item can be freed.  Patch 1 fixes a second lifetime bug in
> the same path that the earlier unhashing makes easy to hit: an item
> reference does not pin the item's dentry, so create_link() must not
> reach the target's configfs_dirent through ->ci_dentry.  The patches
> must be applied in this order.
>
> Tested with the syzkaller reproducer, which no longer triggers either
> the KASAN report or the s_count warning.
>
> Vasileios Almpanis (2):
>    configfs: pin the symlink target's dirent instead of chasing
>      ->ci_dentry
>    configfs: unhash the dentry before dropping the item in rmdir
>
>   fs/configfs/dir.c     |  9 +++++++++
>   fs/configfs/symlink.c | 24 ++++++++++++++++++++----
>   2 files changed, 29 insertions(+), 4 deletions(-)
>
>
Hi everyone,

Regarding this series, is there anything I could have done differently?
Any suggestions or advice would be greatly appreciated.

Thanks,
Vasileios

