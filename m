Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103654;
	b=IHBYA3BhKfDqFQirVdTYY8RaAs3DqCLIDkO9/0Ap+TXa6qxZExNaJZfhrdDGj0DIgjr3
	 0RM+egH5rcw0EYWWLZTqh+24ykpppjQrZ1Loho7UFZBsqLvsdpKxQb9zywwlUSzCQlqt5
	 jkwEfkc2yvBRb/ptW8WyBISkgPvUzOu2ZyWg2/2LbDbVrJz3iDBlX4U4hHXKIJqsJmPfA
	 B0tqQ8PEAvpmTjALMhqiM4GzUsCYYcxojEb8TqnH9AHQRQrtoVXxGtugT6MM/e6HJcScf
	 PjXIWSgHqRq92LT6JLIMBk75xpnriXYnSBIVksmzt/viPpQbjTyDgH8VTg04mxlH4CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=ZawY5Vp5pcmWaRt7k/I5GMdXlKlkbCgLu6fGYeE6CNw=;
	b=3DLDqkj/TrkxK8t3g55bdV+pdqFQoaeDMSgKPtyFbhNbrkeZkyR7/idMSCyIv2MoNnsl
	 lORxMTWckmstjIURjOqR6Jkv6sfPKKn4ec+A8AN9irYqV34oGiWXcuM2aZn/dDBUpN1KS
	 iqstQRvtbhJaw62B8SSlDf26LkUgvlXp7DM4SDegojzhK9pAva9deUBIpII1kwdUbvhkI
	 GSQGzEb0/chhqHgzT4EErGyppzhI2eovGEBwZWYsBmWpe3cCR3CsmYHRWcyPzImXxQ5bq
	 S+XiIRHF4Vb6UWqiq0szdviMX/1PLOuqlnuvjzPsVi5DMkzxAC5SZKk6LhL/RGfO38A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=df2r26W2;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F3606A339
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 15:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC5F3606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=df2r26W2
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9495f083657so302408885a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 07:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795103652; x=1795708452; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZawY5Vp5pcmWaRt7k/I5GMdXlKlkbCgLu6fGYeE6CNw=;
        b=df2r26W2ZBo+jQUQyWF52GbDIvFugOnWy+kR2dRsPFng01OShuIbxB0wloJ4juyzGU
         WG3stI3PP15q/oIXtnmIhJKDA/evlwC+qY1vlxC6UBHFOfeEjzjkFomxylsKBSzoOvG7
         +co0v8aFWUE+WwXzxBIz4xOpLBhCOKVzMB0xHpwk6RWzBKUKKwYhNJ5WHpdLfuXK7xLX
         pug2vr+bFSLwDyR+FkvSpmDM5cktTo6DH7gbTOKDhvFixWPCvGbCthmAIHUanNhu6V0F
         xLkRxfwmRKwSfGOxITOpyDXl85julYElwzm0/HnjFVhMoGO8pFcVFhGQ8FOMPfBMC1O+
         9Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103652; x=1795708452;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZawY5Vp5pcmWaRt7k/I5GMdXlKlkbCgLu6fGYeE6CNw=;
        b=seTdixW3JpU1Lt3w2/5FLuelAgGGwZzMTJZxp04iXIaBM8pg6IMw9AdKlNmE//qtwx
         5kU/6v5JIn6WKSEI93XFO+7veNNYuLcEtscphQG127/h5b15YT4cEQOMSpZ26q3bHzcp
         OOAc0DaM+/lbtOu635HpMXtSbeRe7vQEp41Xos5O4kHEiRJE6NOLBDMgf1qGWzx795hf
         bN083E1vDBeNaaEWJhq90Wu7CcyMnKD3+RPwRTf2s31h3PB5WD+MwddW8lTuAjmeOPdZ
         J+X55PncbHJzwOB2vMrCaYRx4ClmQJnYvtc0R9o825xR9ZeIM/anpSaw81fXbIv+umL/
         2Usw==
X-Forwarded-Encrypted: i=1; AL+hErFoFZEoKJ3favLdHeNeWjGv2/X+EJDi3Iiq0yEc/sfAq9ZFjX/pQm3fJ0QhTiDESJ+N+JUB02eX55CuHOxa@vger.kernel.org
X-Gm-Message-State: APuU4Z8XjEckq+UKN+fUS74BYSfuD7n+RTxs93xmrrX53klidWuV6J2R
	C+0zJauIHX58HHl5VYfK6l6jeUdxmds6Prbe0ZEXB/hQF9QSfdpcH0FuNa9uuYx18QA=
X-Gm-Gg: AYBFou2OJ9x/+76TwpxKEXoRqgFYxYjUKxcjgvISGAP9JIh6Hl9HUgykmxS35sr3kIv
	5DqHMr+tYy5uu0CpP3fUwx/AEsHgDvN4IUPfw2Znv4Syn7Oyvo6m0/ZHQlXILN+df73VytkJI/D
	cgyZhEvdm0QcD9OcFAJ5NNtO13eKjIk3iLCb06hEF9pv411AC4oPXdAbs8/bHhLwmhfG5vJHRsu
	klLmBuFzsSRux2/NknFFUNV1Khs5/kKgkRit/eZNNncKj4qQ6VJm1+WygDWaa3BqZl6KVlWhWJD
	suWDYv8c9TUJ+iJlTcrWoMPpBJxkneNSoPnTK4tqLf6D3zeKKF58CV+ekLbOmqDd4v2d+gyrlkS
	qxAQOuEn0kXkaEGhDbUKgweeHA/M8Hf3MWRl9dx4d4jIoKHXkDuiZS1tONiDMkAepgl/u0Za0UC
	TEceb/whyLZUqa/rEbje7y+NB4m3uOqcDVfiqk5np2ujztrR+n1OEacPbrYV1v+Jq4G7OdFIQ+b
	bzIkIRUffGq/DPi4niSh7aU2QYOPo0M7IO8H6Zwo8WRxsJgCpQQxWjfu+q9tIsVm96iMo3IBMJk
	JDSNsqEjsAny5LGQjbXr5T+nMvMaG0spJiNn/bMCYlOGgfAnthrC0jWA4pc1dBky19+KwIOvOYb
	4OFbDsnE=
X-Received: by 2002:a05:620a:7019:b0:949:6fb1:b422 with SMTP id af79cd13be357-94999722082mr1095088085a.16.1795103652690;
        Thu, 19 Nov 2026 07:54:12 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949b9a3fd50sm19992585a.19.2026.11.19.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:54:12 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] pipe: Prefer mempolicy node for metadata allocations
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Andrea Righi <arighi@nvidia.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Quan Liu <qualiu@nvidia.com>, 
 Lee Trager <ltrager@nvidia.com>, Seth Forshee <sforshee@nvidia.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Gregory Price <gourry@gourry.net>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
In-Reply-To: <avQP1aXhe7nQuzt9@gpd4>
References: <20261110065219.894219-1-arighi@nvidia.com>
 <hbkxlhc5y2jkvuov5o2kjgpisx2pavuo3ad4c4ydixeic7vaq6@mpzzfmhjvtof>
 <avQP1aXhe7nQuzt9@gpd4>
Date: Thu, 19 Nov 2026 10:54:11 -0500
Message-Id: <179510365141.412063.5548407366346393690.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 07:48 +0100, Andrea Righi wrote:
> 
> Vlastimil, Gregory, do you think this SLUB locality and mempolicy
> aspects makes sense here? In particular, does preferring the policy node
> for slab-sized pipe metadata, while retaining the policy-aware path for
> larger arrays, look reasonable?
> 

Funny enough I was leaning toward task mempolicy being ignored for
non-__GFP_ACCOUNT allocations but SLAB_ACCOUNT makes this a bit
complicated.  This would be another scenario I have to consider.

(related but not directly problematic with the change here)
https://lore.kernel.org/all/20260701222112.2820098-1-gourry@gourry.net/

As a rule I generally think depending on userland mempolicy
to direct kernel memory placement is fragile and unreliable,
but your results are interesting.

General notes - I dislike direct current->mempolicy access in
random places in MM, and dislike any MPOL mode checking outside
mempolicy.c - but sometimes it's necessary.

I'm not against slab having better numa awareness, it makes sense
you'd want to prefer the metadata to live close as well.

Give me a bit more time to wrap my head around this, sorry for the
delayed reply, things have been a bit chaotic this past month.

-- 
~Gregory

