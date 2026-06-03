Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C938B7C4
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780521469; cv=none; b=g30QYOaQLLIDQPMYTf5nYez8ZGEmnIhok2Ol3JOBf1++H+xAFaYj4EHNoiVuIRwonafE+hXM/dTQ4kqaC/09y3PwM2StYPGepiaZWIs2t4O4k0lbDkJ+vURj3AzbvT5pJNeafyVS7hfZNZXl0u9W3QCDipDnvDqiJkLLEEcWT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780521469; c=relaxed/simple;
	bh=cC2THtMvsKyfTnqSrCUcXu0Wb3XRjrvrr6iNqn0oj+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT68hrIEeO47gFxLdL99dcpR9WW8+n6u2q3s18YD0+K5B/c3igwy1WdsyW9DkAkLMg8Y/qg+R4Wj6kiYaWH5whLOxgjN+/KpJqim/NSCv78AlOrm1dI/K+8i0UMF43wv8iRUiMR25R5bsrdIVyh1VOmfWwOX00trEVa/inun2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ua8Hv2Nj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua8Hv2Nj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490af320e2aso93145e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780521463; x=1781126263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B/50xn270YOFb+RgL3nLDaMTNlbmRRwqq6mUIoXECM=;
        b=Ua8Hv2NjDhBwpbXMMTrtgdqfGxnxB3V4oAlPhNb4DDqYcqNs65iveFVYdULOA1DUnU
         BpQSPb2jqYNWmHTswSPVJ9NuvC8c3QF0UlPm/8Y6sU3UIdwIVsTiTA4ySbWX/G7kpzjB
         l0ldPPRdq3E2v6BpyGFfJJcFjiEbA5EdsGub/5VE2Y/NeEHsqT+A0zjow9dkaNkwP0gE
         bcTP/gNMDjT7K0dnXaNbQ7lvW9XD5QbrGu7z/Ahs5rnw28hEpIwddzVe6hIMSYlDgi0Q
         nXBTLYmGwX4Kbmn13v+r3JrRAhmIQxzp/nLcZ+8uflc/eKgniCrSVV4qAx/jBkQJAuQl
         l+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780521463; x=1781126263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6B/50xn270YOFb+RgL3nLDaMTNlbmRRwqq6mUIoXECM=;
        b=O3EZlBlxJUoI3qv3qICq4FMchQuhOK51ZGeWGxGbkLBMJY891XR9ub0KOfo7X/6nZD
         ph3KeB6nN7qlotZJvc1IaWKJ70BItfLBKf8/LOGVLZx+whN5xA71OYBCvNu1MNbQNTmw
         cPTw87OicblTpiDyp/0KTartIbR+E3v4lUxIewBjlOsDomAez/1teGFIPBmZMyL+DFwg
         AfUJZzInIHgQUlSWGUTcT9SQQP9XuOA83bpn5N/7TjNyExl7OAly6BuEr3vIM2m0eUEa
         Y+1QESLSEhZz8G8ZmEpJR6M0B/LkhH+uJaDbWgp2+fczhpQCEBc1t99/1wb9OgAlwoen
         kfbA==
X-Forwarded-Encrypted: i=1; AFNElJ+6z7yTMm9vwaUoR57Mo0TSR2RQvNY4/Ltfv2C5P62GvXbSrfEViJfURQx4QJ7CJoxZvXN4Qbl2zoPbHXoM@vger.kernel.org
X-Gm-Message-State: AOJu0YxpodOhRJUujVWx+c0ORBLXIOdTgD6WgR/t0lV/jK2QPNAxGcuT
	xkaKjxss0pUX+r8CwCWpLo6cs3/fD3PYgrPLPAitlFpsFzbrL1Jn5lZp
X-Gm-Gg: Acq92OEu7JMVgoT+YBgNTMkJky8tiOFiiWgRTltF4n5crhU7OgOfPMAc6E27sasepvp
	Peio1BCVlWqylQCv1L1tlOQwz/rYKYVky0JlpcW9+MZkd/l5AC4zWnufazuDOhY/iaIw20RY3sL
	3IG/J2RpwpyBe9633dhpBrWRqkHNKvNv/xQkgwITkbM9jX2StIBFs4lWfG7b4W/CCi4ArMMqho7
	pqH6SwMeL3JWxNn2k0aWN23g3eUzFPLCcFoN3svEW9tLOlfxtO+jl+i4NiVfpQsOHm4pnU05g9J
	vnnceut+umR+DchU9fphz4gyDLbs+l07UhVUYoaiENilNTPDhFCl1G8TBoei5y7OJRZEAn7Z2mD
	YCWkGT2Msg+s2DwXvmzP2/ai75thDmeCgR6D26V7pqm6sPSyE54X+FhUJdQrsrLtTdOZk/qOsuS
	vVd6WB84sjoPF83XLkg5RrM/Zq/eGYZw==
X-Received: by 2002:a05:600c:19d2:b0:490:7136:ad02 with SMTP id 5b1f17b1804b1-490b5e94d63mr81490465e9.7.1780521462549;
        Wed, 03 Jun 2026 14:17:42 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b7a273e3sm59171155e9.0.2026.06.03.14.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 14:17:41 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: metze@samba.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu,  4 Jun 2026 00:17:36 +0300
Message-ID: <20260603211736.755139-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stefan Metzmacher <metze@samba.org>:
> Why is 'int fd' changed to 'unsigned long fd'?

Because preadv2 and pwritev2 take "unsigned long". I want vmsplice
to be as similar as possible to preadv2 and pwritev2.

> Should that be its own commit if the change is desired?

Yes, possibly. But this patchset already got to next.

-- 
Askar Safin
