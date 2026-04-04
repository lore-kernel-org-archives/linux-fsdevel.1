Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7AA287246
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Apr 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775267038; cv=none; b=F/ExxEBfcikBVrgOVcXgYt9dUi1SKrDrrp0mjf2tWEim/uh692o9fI/2uDk8OL62N88+DL26CoHmYPzkLNOmJxHH1bRIj0SSo3CfJCw+EzQW51l3ji8Ux3Z0tlfM7ZDyVyoDvyc0xrEUYFYtWtXWEy+LZpmEAQORSi9SdkscdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775267038; c=relaxed/simple;
	bh=o+mXn+mO3TOBOhs6Vj4ImptTHtx9x7UXnCndYtnzSCE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=mHciysPF8Os9ARDNja8B1kJJPNsy6sEWnbXqKrsAxPRyUf+a/F+sUYHGPEf+pNiFlICWL1npPyO+xAIALFJjcOeUw06sItBM47BtncC4L/n2WZpIAbZGh7y3bqbxM3Y7dS98wI6UpETCyDedGTglE8DY6NHg8SqnfMslNkOYI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXr3C9g2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXr3C9g2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad9516a653so11335125ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 18:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775267037; x=1775871837; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mSmUlQx+7wcM8hvk6KgWAN6mYWx05Ua8pH5lZ6mYZjw=;
        b=nXr3C9g2rOFq3lOWtfJXdm1R3NpHTu0T5mbjoqhvOlZ9h18+ISrPrL4zOUB/n+NNrB
         SHEf23xnLEPX/yTwckXO60RlK5cx6bJLu4CLZpJ6GRhUnAxc/ARpRIN/ziZy4zLNrCEq
         PCptii73YhlofADub/f6Z7mOeowVBjS+LTCtxtGz3wN+g06GowochDaJUc8f5zh5mQOG
         fjydkerhn2of1EDtc9N2L+ThYnMV4qQxlC7UvyjzTDE7lwNh5Xis44qUOW9+i/MyDdRm
         IV+BXh6LNwwnHlFIGbXi8u0atoU76iTmq8pLH/Vd/9uhYE51qLVGibdJ41EWk3AlGhKv
         dFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775267037; x=1775871837;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSmUlQx+7wcM8hvk6KgWAN6mYWx05Ua8pH5lZ6mYZjw=;
        b=pYy7OxuxJ6mU3m5Wna3ZjXVcJ+dx1s7KSBF77wo8YYRIhlW+flidJwcoZg4deqnD9T
         o9V3CFQBl+8r0bm1HujlxpGXCYCfdw9mZr4KL0IUkJWYUdHzdFHBNdUPodN4uStcZq8t
         3lA2U+hZ39pxSMcVB+Bw39ZiI+L450VwqfViWyNS1GLEDVhT10Au3YkNP/Xde9gxiPSA
         qFUZmiuZw+PyrsQB0PGJepm1Xps1zOi+XqlMfc9ruGrJ3C3icLScr2Fx+FdHj5jsN9iM
         iVP7qIgjH/TQeYY2qZUiyPgdRvt71h69WJZdTjjEQuyXiToDGGV8XRtbagKm4bF3OKbY
         0qOA==
X-Forwarded-Encrypted: i=1; AJvYcCUpDj7sdRUnOJrPNTvwECMV1uY6VDetmcj9WUv50oNKcYwhTDT2CqrkGciK2mvPRGJTcMkvgNpLhyAnD0dc@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAfmDpIQ9attqzPsq9mAccDTZAtstfpeUKO9GIyYFIDQ+jRQ6
	+9OSk2vfUAx+NF7nJ9yvG5yY7Ej/uJ9MlJ+UWUm43gFgh09kzFIsvium
X-Gm-Gg: AeBDiet9K6paUyYU3YlXcG7YIXVE8AKU8xixIVVDLOpQUNiY8WJR69Z1cIlNXDPUJ3m
	40cz7R03zrO6/+WSWUxXu0c00RafzBKimnKdLRus9QbmreussiaG4okAXABOBEyr82o776GLTMR
	Yt4oVJ18iqnSDDO3ahMNbnwj2oAgRQI8F0y27ksKuJb/qJvogl7+OIBQeUqolaJ2vYYn0KfoeFM
	PHkmDvG7p1+F/2CXjGsZ6ZRc+1zybhnthWBuyvf/ODXdOa5qjiCkEgT/B8O16XOPYY0P356Omt0
	njFgkm+B7fHy1x3u5Q8tSgPJtPCWB54r2lp5JXxbp3JRG+hg7dVXkdvRMABvXqdZqRFairYoobV
	vkPwGd0Y4cjT3770Q6Ev8dLKGkOVbCFV+nOL5db+iDVft+dwULJuTQ/FD6vr9bEh7lR817hTK78
	WKM+X+105aXS2IidKfA4NHkmnU5tr9aVF7
X-Received: by 2002:a17:903:1ae3:b0:2b0:afad:7aad with SMTP id d9443c01a7336-2b2818016c3mr52841215ad.45.1775267036795;
        Fri, 03 Apr 2026 18:43:56 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbca2sm65157255ad.73.2026.04.03.18.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 18:43:56 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Salvatore Dipietro <dipiets@amazon.it>, linux-kernel@vger.kernel.org
Cc: dipiets@amazon.it, alisaidi@amazon.com, blakgeof@amazon.com, abuehaze@amazon.de, dipietro.salvatore@gmail.com, willy@infradead.org, stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, "Darrick J.
 Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
In-Reply-To: <20260403193535.9970-2-dipiets@amazon.it>
Date: Sat, 04 Apr 2026 06:43:06 +0530
Message-ID: <bjfzmst9.ritesh.list@gmail.com>
References: <20260403193535.9970-1-dipiets@amazon.it> <20260403193535.9970-2-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Let's cc: linux-mm too.

Salvatore Dipietro <dipiets@amazon.it> writes:

> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> introduced high-order folio allocations in the buffered write
> path. When memory is fragmented, each failed allocation triggers

Isn't it the right thing to do i.e. run compaction, when memory is
fragmented? 

> compaction and drain_all_pages() via __alloc_pages_slowpath(),
> causing a 0.75x throughput drop on pgbench (simple-update) with 
> 1024 clients on a 96-vCPU arm64 system.
>

I think removing the __GFP_DIRECT_RECLAIM flag unconditionally at the
caller may cause -ENOMEM. Note that it is the __filemap_get_folio()
which retries with smaller order allocations, so instead of changing the
callers, shouldn't this be fixed in __filemap_get_folio() instead?

Maybe in there too, we should keep the reclaim flag (if passed by
caller) at least for <= PAGE_ALLOC_COSTLY_ORDER + 1

Thoughts?

-ritesh
