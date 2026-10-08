Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609043499E
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464844; cv=none; b=i+9ghXFY/Rono02BDMeFkCWvvVAEOxCi/KADeFmB/sVdFIHwKHx17t0hzRgEAVELdfvD5KDakQb3dtvAdw9nWLr6dM2UaYQGm5FlCgJPu50lm2rB2aC8HQtvjHCvReEn6ZGoLKsD3zdKE35EQ1upv3NaiH+b3paP3nxDDOrVwn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464844; c=relaxed/simple;
	bh=OyzQ4UDKaiyMoT/NVzqvh75hv21N26cEww1Tjs+Q41M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvfJs/v69K30g6PhhrtWh4x+vQPNkxoFZQzyjUqLx8jTxCIUY1huq4u7r8aqA5yvKfMUYiABM6BZU5pjXlSp7/11IJrfevEJJ3gc47ZeQMb+Vq8qMTH1Vbx5BRmxML+yL0aVFy8vMAdlT4ev+7GtM9UJfYoLi1wZWdHhX7IWJDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KwuWXawi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KwuWXawi"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b0584ad71so2022489f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2026 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1791464841; x=1792069641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7t6+pTQP1CQbEVM19QS/h21zu8MNABf/SgAoLNSosdM=;
        b=KwuWXawio7HYkh0owZWJE/gmRDJqegpvYiTo3uIgFd50s20QWZaiZE20LTt3gbn0hh
         Q681zeE0ck52Ex+G9uog/sx5MNUZU1xdC95+XttmEQMqMMSeG+5Rw5yF1tgyc2QxJU2I
         FnGVP/i97hsmQtS7YA4DH/uDLNuyIpEN/WBaSAFy0HzKpZImTHs7IkJiY6EAeESXzVIt
         vKJYU4t+u84YPKMygGxawREuZLUmnyl+WK7fTKc5D+G4VGPCJWM//5tsBvUJAReDAvND
         CAujULbFW1mK+kWM4W8emBVg85qUEUnknotmG5LLvbIG0kAIxjY9kUlyXRmk5v4a6Iwu
         0v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791464841; x=1792069641;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7t6+pTQP1CQbEVM19QS/h21zu8MNABf/SgAoLNSosdM=;
        b=IqTvA+ODNY28qZIcCDPMFrzqSGFamGfTc+AgqwWd6u3goddEdwDUWlRBN5EPW+s+rR
         tlY8Vu5C37Yfq6Ga4PAggob12bKoPjiCVzlWsEsw7E6MwfC3g9oIl2Hy9Haes5k8OzLW
         zPTj8V6muSEh4zrQBB/RTObr3xd5YLRo+e54Nh9+RNa10pG8MddtN4i6VGwdOmFEpo08
         beLvJcSbCkuejFgTMIbqJYGZ4uuDeksNG5E9qUEOUNTS462/JsjAS8ojYiXfMBmk2grb
         jGAvlJFMfQxsC+0ejjATTpiZQCkdDjypakD8QXLO5AmaRSHo9PqgGBR2nb2uLDShl8NE
         J2zg==
X-Forwarded-Encrypted: i=1; AKwUvBzYMauWH1IRUdZjOQ/N1J8nJzv5dFaIK+gndIq0MiPWyjepxoEDOWPw6O4OfwJZ/rOesg6GMbsRMS4YCWLd@vger.kernel.org
X-Gm-Message-State: AFq9FYJKmQxZ1wWDysEuBwG3/sVNXSjnxzy5NmuIFzrFZn42CruWUpks
	10dMVx3ymas23ItVG2jGVi8TdVorMURyEclN0YEsL677sVY5z//UyZ9Mk+uVAgQSBbw=
X-Gm-Gg: AYBFou05F9AEDS9pfzPI5BCP7H2pj2haF9NXkmVHCbA/pl4T2+Bsw0OX1JwzTseNsJm
	1WvpBdMh29U4XZtoCWZcASIfKSGt9Jx//9W+Y5g6ETEFPfgOZqw2N+lzXLQj7j3dIfDaSO9GIfK
	9NcAXn5iyELld78lF6CCw/So07NdyNUEQsp0PPqxSwEFOBOuawpoHawwcV+gVfXNmBOlBKTVbMU
	BtwW2Kn4+16X2cAd7Hz1TNOh5sYYJ8FznX4SB8xoNuEDZ03LU1mQq1Q0HN5LYwbXXIrmgTlhWHB
	I9T5OGFj309hWj1h/GAYWz2ZpHQn41E4EK0u63xPUZCr8ZxsD6MFS3Osn7itboJ4diSGH51HZ5e
	/uhBMEwyRj5f2g9hxGE9YuHkh8FORrpQrGv1+zUtLTtFpoaFOkZ1fSoqhBUz6DDkdH3ZrsLvyNj
	QJbW3KYuA9A1Su7qL/AmQ9n107dEuZsQnqXUxbVphZJQdyyRgV9jbAKfnV1Fhx1ureZX/4bAH6O
	lmLodSrPg==
X-Received: by 2002:a5d:64c8:0:b0:48c:43a3:6a74 with SMTP id ffacd0b85a97d-48c7277152bmr11130200f8f.12.1791464840586;
        Thu, 08 Oct 2026 06:07:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([185.194.184.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c724b660fsm10757165f8f.18.2026.10.08.06.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:07:20 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:07:17 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ayush Ranjan <ayushr@modal.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts
 page cache / rss counters
Message-ID: <aseVAm3vczSTvBwN@gourry-fedora-PF4VCD3F>
References: <20260924061708.1645968-1-ayushr@modal.com>
 <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
 <20260925053027.1998394-1-ayushr@modal.com>
 <20260925065013.3682431-1-ayushr@modal.com>
 <20261003033107.1488699-1-ayushr@modal.com>
 <20261004222831.bdd648a2b406f02747dd9e40@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004222831.bdd648a2b406f02747dd9e40@linux-foundation.org>

On Sun, Oct 04, 2026 at 10:28:31PM -0700, Andrew Morton wrote:
> fwiw I made gpt and gemini argue about this for a while and ended up
> with the below.
>

I thought this was resolved by Zi Yan's patches, but it seems they just
made it harder to hit.  This version looks better than what i'd
originally conjurred up, so if you end up taking it:

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

~Gregory
