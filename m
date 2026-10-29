Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283830;
	b=0f4YSvrEglncHMiaP8YAnx6mNwaHQhghVcJsMuEj3og79l6GJ0XRuYH15kGbBZjwx4aM
	 6pME5y4vTQEJNiXUNeRGt8s3/7+MGzVj1PzqYzdIYcx48rVqFIj3b/c8Dr2NIi6Axro9M
	 /1ND6TKQjvB6iEV0R9palaRbZaW0Vhcfaa7gT3LyZ4qh7q4MzA7JaB040PO7Bl+YiLh/b
	 igdhy7f06SE955yKcMZ2uonnClFSIaPtK4bJ9p+8vZtENykqpWd88INXbkYKN8paC7K64
	 cuMraBGP0atmZr2Dm2Dx2ENq/4efmt01eaRAHFAQTXNbY4+0Ha+ts76rk6Z27eGWxxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=JJb2/HmhBTTuuyxE/cFYx3WSBj9uBlfuHJGXiko2698=;
	b=rdS0UuRBKutwjy6hkCKeFhlYayqrUID1jx6hAbtphHyEaD/SetMbjpN9tWYt1Tcm8Zd8
	 o7GRtkoVWZ+Oc9UnNCaYh8WgEB40CUW+wgq/ozqLxRJjblfRywl7blyyy9MXk4bDQroLW
	 6Rqjh1Q/sT9qupO/R38simGBPqvNYe5CrLMvB6l/lUdQHMJwtrjsaKDRIhBHK+kpHXUdX
	 X0wEchosp25or8PVHkoVcdWxXhpBEI5gtahzF3wyZ4bi74Yxp6R2qQwiUUbDu8aHRzxhP
	 XOc4Zu0waALPf+2gTi558fMKADpt9hNnkuU4n47QJlZ9DgXDQ7EA3u+frPbTTwrMGCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=StriOHIQ;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1DB606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 14:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE1DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=StriOHIQ
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ec3561b07dso685748e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283829; x=1793888629; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JJb2/HmhBTTuuyxE/cFYx3WSBj9uBlfuHJGXiko2698=;
        b=StriOHIQf+80IcpztMZC6WmRaOUquypoVvVFjMRA1RyioA2j4XuUDoIvuGqT89k+St
         jaOT8/F/vK+Wev/CAC69+r2h32P46yi/2FlPYf0TlgE4SPmX0ZwedXcBzHUTg/BT5oIv
         UDvY8X4wUnf0/snq8OSZKV6gz67h00wD35i3ovSD97StybS+b17hNiGCxwmTsxRcsZmu
         t4R1TDAwjkuvA5/SIoobEWGQinQljVbiD7W2UX5TECeZOXXPxuV+hAvFe8Kptu7Jodny
         p7ZLhxewM0YLawK+0pPI8sso1nOmqf5xYS9wRUqtcrjeNgnzq1b4d22E1rRzT6fSetKg
         czLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283829; x=1793888629;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJb2/HmhBTTuuyxE/cFYx3WSBj9uBlfuHJGXiko2698=;
        b=b0T0mXyzLmNgCm1eUF2pMAsMRpplnSHjSh8pPUryQl+Pluleh98GhUulVyUP7Soqy6
         v7UtLN/Voed2Dm+tHL6pCpI+e8zPToMVku2c9kylJ+z3kaTDL9exbU8qZ+qkim1zTLbe
         FU2ewN878DJoxVdj5XMT4Y9oTVcW+OS1KifryZS2AMa7jix0eU0y8LJQc/xDfUS08/DP
         NfR2sVZCaNeqQ+9TjdENGRxQIzwhCAr+ntx71hXQ9QuRQVLGOJrfY7ZcTtshR6Q7T+Ql
         GovWxkC69+h3mGwrbBo/rnkiNXX4m3wrbYtG5NPe2oFR/wGP8MttYi/5tS5CbzL0gybQ
         f2cQ==
X-Forwarded-Encrypted: i=1; AKwUvBweYjZd3Ydra8uA1PsilEY+k2Zsbw8KTMScJ1QQOiCXXwoNj5SYdGdeuksk9V/X7lVfFR0ZXZGXr2eiQ0UZ@vger.kernel.org
X-Gm-Message-State: AFq9FYLjggiu0AUP2fvNLlkxfwigtNcnSC28WrmR0wcIoTUVmSbxKy/S
	bJznUMs3HY2GX/pDFXPudKSpVJe6ku9zXrTj/HjtOwJEw9IZiC4VPIO+
X-Gm-Gg: AYBFou0gqSz6MFMEMi/yZd/sM5FHKf7dvC5u/ezDwy3ZdF6eY+PPH2BTeeG82uqK4Hi
	yJVsZFJSf+F9rdN9SN6em6M5bz2YrXLWeeR4w0qw4JuaBfv4x5ufRAZUa6YXvwzDk78ZdN1V4ll
	gBY4xCMf7RG/WxXBU4lockAtpYeux0DfJPSmzBjqnwgkRmRYEkUY0Y433Qi/3rWQuziNH16+mPy
	VbBD67Kc9HpjaszuoqTuWBrXxqWZiGS/42YgY205kOTVWx/WdMHz779TGltxPRbVyV+kzSDLdFk
	oJ1jqRz/uzdUah4O0zatvae/hbh+uckKV8Kj4uk6HovVoQ7X1gRRxti3O4JcgCMG2fswyN2CCR5
	PUFBezTnhnuaDTr5amE2sD/UTZNnCJs86pmIaS16Lp+KTAhbaAG8gGmMsyaHutnQxKFVGcpDuf0
	buCyhX5PHq3Ph+EMNqgFMBJnQHhpnH+UUoakCT+CBJQ3kMGrLUWc0UNm8Hf5ES8jfaNSNFKDI3x
	+wwX4UchyMRR1Cp0VeqhGs3FoN52g+dNe6hQ/o2lVANj7tKrEYNCRWgWYGCoX9EIOW8DjvBJxFq
	Ltr+Szf3VzGru8Vd6coT/xX4WrO8cvXRhTx93qWEivjf/8fieQi8+gYhsgScchLichwGa4o5z6D
	OeCPMjvKjEB9E
X-Received: by 2002:a05:6122:e46a:b0:5ea:bf30:851d with SMTP id 71dfb90a1353d-5ec587ac1ecmr879502e0c.16.1793283828654;
        Thu, 29 Oct 2026 07:23:48 -0700 (PDT)
Received: from [192.168.15.16] ([2804:1b3:a2c1:77a1:5cd:8fee:f3c:4da7])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f92e3e3sm5524139e0c.9.2026.10.29.07.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:23:48 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David Hildenbrand <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] hugetlbfs: emit hugetlbfs_free_inode from ->destroy_inode()
Date: Thu, 29 Oct 2026 11:23:37 -0300
Message-ID: <179328381770.67441.15785036410268577790@gmail.com>
In-Reply-To: <acfd9678-fa48-4610-ba90-278cab92ee9c@kernel.org>
References: <179324176522.32673.7602596908234555806@gmail.com>
 <acfd9678-fa48-4610-ba90-278cab92ee9c@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On 10/29/26 11:45, David Hildenbrand wrote:
> Should we rename the tracepoint then?

Fair point, "free_inode" no longer matches where it fires.

I'd keep this patch as is, though, since it is tagged for stable:
the event name is visible to users in tracefs
(events/hugetlbfs/hugetlbfs_free_inode), and renaming it in stable
kernels would break existing tracing setups there just to fix the
use-after-free.

I can send a follow-up on top of it for mm-unstable that renames the
event to hugetlbfs_destroy_inode, which also matches the
hugetlbfs_evict_inode name next to it. Would that work for you, or
would you prefer the rename folded into a v2?

Thanks,
Joas
