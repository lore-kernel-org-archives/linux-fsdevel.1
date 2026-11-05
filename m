Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793884160;
	b=CDvwesPBzPbqSSfLWvDG8gTR4U0I/A23A2kzFE4YhrIuMwBmO7tqox27EJcIJmu2ris5
	 eaCT/09wiC+b7DWVtWzXp2EN+AFDc3xCrbt3dIdfcy8FWK6tqqV7zj/Y7mubS+rw4kn8S
	 RILBwpCcjWfuJgzRmuxWOtlO1RlhkKkAevVjzk6sY0/iJBf47EUxvrkloV8j3Gq7Tss/i
	 5199UD1Eksrn9C5OXaXAdYFW4jOBzYh9WUAmHJXFQP3V5QFrykICyA8Ffgw3onzHqmai5
	 3MceFih5UG0gguIE5dWTwrJxR1Aml1e9FZ8Gb7ESmkX9lYx5T+W+bEnV81oPJzNGF0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jkmvscXAvNWOCA/eo1FekQ65BtW98C82Ndf/rsHkNE0=;
	b=wDwEq1HMDJVCmHTY3XJFAbaG9kDS12NhvAi38JKC8TJ0wktZOrYCPrD2Qnl+03hSnarF
	 QjROrHTGxlytjg8Ch0qcS+mNhvM2ecWjs3QBVMKNLVsCB7v5Veh/jBKFH99WK7AU3Lafp
	 Pff0g2iosRgLe6JKA9r6+fatJfEzoDQJlqcAzCiyKQfnRUepW7B0TumrxUC8wlZd+ScOP
	 rpu8nt9FnDFtNRaW2pjT83MDiBBzXX9+vNOe47/MIUQxcNQg5Xr8L8Ou3SrGIunwJs6Cg
	 YMkmE2IHChlHXdlzUMrXRoYnt6c5MGPOVk6nmTkEjk67tWy35J5cGgk4YkxUZ5T5UFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JUs1lRhO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0C606A330
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 13:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DE0C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JUs1lRhO
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b4b7dee316so898713a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 05:09:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793884158; cv=none;
        d=google.com; s=arc-20260327;
        b=VxLbE6kG4Op1hM2X5EQnuZ6eg4ie11er3rltnCb4RKQpd96YluGw9C8SpXn7XYuhWd
         glEDMHIm+Im/h0k2V7qFAIvFwur8ZofLnb+8X83lG7YMgFjFo7XDvwxQuCxTiKmEMmvW
         Yd79XF019+VhF4p81QzhSr+OyLBOJRceS9sWT4Hy8h0QmwLqNQDk9keecTQpaTYKLl+p
         xi2aiVVa48w/y7t/6D9AyZJ8hu3Yd5Lc2zOHZiYR1+/HybQXiibe8oU6aOG1/T9tR2He
         sMGv9FX/s4bx9oPr5kf0xJR+p4p1exxdHa0WAWdxxaaEawVb6t0O5f5IEM+UnlS1Fk1Q
         TRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jkmvscXAvNWOCA/eo1FekQ65BtW98C82Ndf/rsHkNE0=;
        fh=bZl6RgmBrptd+BGsBmmSbLd92esJi4zaX4gMWiP2vww=;
        b=Lv+P25o3B2RSrvvtrJ1VztowBRvF5bYbwyWOeTPvlQF99jobzrDITsZ1Cd+Y+YNTKI
         7CXkvFq+oPG+WQXrz+3Dz6oBDF+A+x8Y2gLIUuJ3dxGEDMbtUgSZQzFwrnAyVw3pFPkM
         Kd+1Fm+N2a2D6lEKTCIrsLJIEgp/WAKBbrwQYc9JMD36/5zL4iesS+NNMalT9xGaceuJ
         c2+cfwctaz4o2nXk0h3PBc6jRu7Z0KhVm28n61a8ceYJvPb/NKgI70MY6kBh9SS37/kp
         UEQUwxO1LnwPFiydXCxE04yYcRJ9TTEqxUstAi5Peom20GsQwf16AOpd2puUbqEr80OF
         sfQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793884158; x=1794488958; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkmvscXAvNWOCA/eo1FekQ65BtW98C82Ndf/rsHkNE0=;
        b=JUs1lRhOPCwcs9X3rlblVurVgqsvLTVfuDmx0GXYpoORcQ3pyC7i74dzdRg1aNHQLF
         AZWJITRvL5mRhtdbsr8lGM+sFvWQX61VodqJhj1l7cTCz5ICtt8F1lblo15BPA2YcWa5
         7IVbEHDilI3RbpZXWPtcu8EVTl+Anod63vvxUuyBkhVsopxvZirImRElapBH4gsNK9M4
         4RQ3uR69ZqWze+iWjxLtu/RIPaHWJz8PyGy9mgF7RgoHRhE0yE/EG/qycT1ui06jmA5U
         zCEu0LR+6OGmJov1v67QNh1fKUqIBpLl1KpYeBAZPuINq/cHk64oQ2RyaCCSyafwTcu+
         4lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884158; x=1794488958;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jkmvscXAvNWOCA/eo1FekQ65BtW98C82Ndf/rsHkNE0=;
        b=TB7eI6KTkOM+d9IMWmnu+Zgo8u0MDI/R45O524TyBftnGrE/DG0kVGdRaDFpJ4omf1
         mx+dXkzVVFvcshFkTRx9E9AUIB56M0lJqY2uHntX8U0cGzBVGqx5aFgh9RwkkUAH0qyE
         607Lq+YIxexOIk+PDOri9rIpDDA3K/3qoiNuMUkg4FEbyROSjXAcwTN3Vg3gT7tHxpQn
         YG1BB3dxtF3IP3NXkhwGXlCnb6DpDacRT4RdQ7mAKePw5isJa58QIsWYU45hU50mBAdi
         wgNCxAhhoL+dYAGgpGctfsKjKBGW9GITgnRC0c3CuXH1wtXgZ2kKI35PYEJb2aKvhviP
         iAOw==
X-Forwarded-Encrypted: i=1; AKwUvBxWvd/CvO6j8zQmOzE+5kVr7ldutr5lwVs8kzfcdmaTFqkJuCgxZSxV9DYO7/VUsFxq5J3A1Wg+02LXXnm/@vger.kernel.org
X-Gm-Message-State: APuU4Z+SlPddC2ev8ivgQbXngKRPXWDQ51qFgBSuSnIu+XdIPDKqSvPq
	f1L9YeUDbiIkXU8r1avfBqo52dRQxkH80h2kfplW2OIS5ogvNUZ4Y5+kIrcVDFoBIthOcLkRTP+
	1wGajGnQXBbtVDhq8NitRsbKgBsweWw==
X-Gm-Gg: AYBFou1kwl6GvWyL+iTBZr1tDloUm5O54dInyAWoB//tzEsXC36582QeVcPYGt+RG4O
	invEicOZu1roe473m/IMKgDOrzPHtjItTrfcXWfsJK1Co1tffbINMToINBzwH8XaFgQZPa1Re0m
	z03zXgZMmI9+p5N/t417KcohwnE1WrrF9PL09+r6wwMhJaUL1PVnAPL4jx0Kx0XA8yafyL98hn9
	ZH57Xr4JKPs/G/r19JeDj6TkI/cpIRxEmzQ04oYJ3o8P9q19gXFINpD6q30sRRn4VIh8a8tGtOP
	f6Z5mKt8D9E/B0vSO/dl+1rTdMauP+r2P9bY2aBMRNq392m3q2SkgeBoSS1NkHRELUFska5nDq1
	p3HAzZfsBLGtwx/EDThs149vhyh0dxiKRAaPVQrglixqYdkne71FhKgj0EymqId6qQ8KWOlvFSz
	La/ZLF05aNV3UsfJNrnNsHKs5H6lHBg++9GSRtX83hOczY
X-Received: by 2002:a05:6402:428f:b0:6b3:e89b:126a with SMTP id
 4fb4d7f45d1cf-6b4d428fa3fmr14003060a12.12.1793884158312; Thu, 05 Nov 2026
 05:09:18 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CGME20261103111022epcas5p4df6a10b70dd9a92992c117669c7227fc@epcas5p4.samsung.com>
 <20261103110640.1000095-1-anuj20.g@samsung.com> <2003152d-5d33-424a-8191-badbe137e37c@wdc.com>
In-Reply-To: <2003152d-5d33-424a-8191-badbe137e37c@wdc.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 5 Nov 2026 18:38:40 +0530
X-Gm-Features: AclHuK_IE3Nm_OtgyVou8Yme1bSHicg4bAvJGhKSCtpmlcsXrhW4foKGrcUBnBQ
Message-ID: <CACzX3AtMO31MfQpxp_YyTqCqza6+NnPOMa4sGpjM90pd7cSi+g@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] xfs write streams
To: Hans Holmberg <hans.holmberg@wdc.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, brauner@kernel.org, hch@lst.de, djwong@kernel.org, 
	dgc@kernel.org, cem@kernel.org, jack@suse.cz, axboe@kernel.dk, 
	kbusch@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"

> This looks pretty reasonable but I'd like to do some prototyping to see how this
> would integrate with the zoned xfs allocator and run some benchmarks.
>
> Are the RocksDB patches publicly available somewhere?

Yes, the RocksDB write-stream changes are available here:
https://github.com/anuj7781/rocksdb/tree/write-streams-v7

>
> Cheers,
> Hans
