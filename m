Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB4638C401
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781356490; cv=none; b=maFPxQ/rqsry3xT0MRmlNSExVHhRVrrFmCnbcU2NdQ7lZLvScJr+KMWAkGxUFfwg4k909HkW5+MNzzxpbsoWQgoXxRmNw2K8OolUDcaOkWRX+X4+IDGoCkm6YKKMM3QIlFLRVv6UmKfLirRUJXT+/SrLLW/3Vl+lOHcKMdtMqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781356490; c=relaxed/simple;
	bh=BeapHXvAGCRWREW0J6P3NdbEyUaOKIF7hszp9gyT/dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JI4to3gB1tFf9Tr7Mtu0uGWNK3jq1rxYTQAw24GJnZ4pMk7UZEYBByUahN4LPPG2p+tUjHKF3sd/0mtXFiTfB28j6NlMgoeFgi5HFuXjRqshgcgNYVDHU4nhK8TA8/XpRXLlVVM9R+6O168GQSf+oUP5qDxAzKzbDVbeVtops+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/iC/L3g; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/iC/L3g"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso14899135ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 06:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781356488; x=1781961288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeapHXvAGCRWREW0J6P3NdbEyUaOKIF7hszp9gyT/dw=;
        b=q/iC/L3gu8RyZ1zIw4i7WAah8wrecpn4PeTcnJ1zjkwbiLaq1jtHaokqtl0fMxTHKQ
         oeGRC8xszONCNYa2WY8ySomF62hRLEtYytM+gufg27rU0LiyrAT0tbtN9gmYr3zk7fCY
         VukKKToY567vgYyCk7Rml46UWgeQ/TLP06NZoBFzBCfEIG8542ZrZtuOjKEcNVyUCqtl
         HxiSaIfS+APoV4y0Hjmre6SZoxlBdELDfYpqB4zHv2WEtj+iMu6Dfn5Tw5Cu0pSxLMVn
         Y+llFM2kEuVWgFL4NTrsh+X0JHWi8g1sBsnosM/fO5ZttbOs//DU2BtYLtGKCuPjLESp
         Srmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781356488; x=1781961288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BeapHXvAGCRWREW0J6P3NdbEyUaOKIF7hszp9gyT/dw=;
        b=rpT4GZmGJxygT8WVnjj+BCX17J3QDdnTjgytVyyh73IPqAlTsaBa1hJ0ZoSjQyroY0
         7vVxgCdbulnBhKpVcOFug2kwGQU2v1mbNedbNQkUG3dG/9sDtQwCL5HfFqZzocDG1FfW
         wurMPUH818eKrQ8x8L1GPizd2kukm+2866b8lmcuJZzih3ZLHKxk602mKrH5JksZf2N4
         5hBTG2QirMxJgKxswp4MoqLvSxqO9syAko8LPye0TDcfGcJ7oKK2db7Ql8L3n43oErod
         lxY+1mARpkAStf8yFHsqshyZHn6JIYLU0Tm/Hh90K7PBsNhY9d713/lb37byGf7hxng4
         zjlA==
X-Forwarded-Encrypted: i=1; AFNElJ8oJEGzhbZmDNjIdRyHOGhGiWjHw346spBzhijbzNP5xczkb9TLXRdwsVHwVCyhBBK1Xrk/6zXBDVvGBXFv@vger.kernel.org
X-Gm-Message-State: AOJu0YywFB8JKkMX1DvqtZAo2Z6vRwj9/hroCid2giBNjo3FpQKrJONT
	2NKndSIRnA+xAJe/GFUJZ01AnvWW24UznbExntWf+yVkxlYFxFxWxYO6
X-Gm-Gg: Acq92OH+h4u25u14+jbRbk293t594keBzeypxhuBWhvOG0deRA4Kd3Z079nLRbfCrrI
	3ZMIwU+XXzAhMSe+LWbNlLtnA4UdWpCPV8Wc00ZLB37jy1RcuHfc8oxuAIWJHLfQIoOL1mw+UHb
	IyzAi0Z4fQrMNTdElgdF1+5TVb5PkVpKTSC4oZaft4KX5bGUSznyrGW9k0V4OLDv9KEBjlkhUuZ
	UAIoP2MaTX/8tAu/bAAOjef5wBElbzImDADiNAQUEI5hNjOFGSn2EfMJNDY59X8YvtLsMKVANPA
	zD9NfglVlrRQ9yace7MCR1d1aUJJkNqFpcnfJGjCQKtyUSYp3fgweDTdSYztfds+YQAlXiGMX4G
	m/vZSmC2+OQpogzFWaq/Hv3FNnKIKX5Km2NzUxmg9u9NYm0iryint8fxmw2zvGm55fUe8Z0lUFL
	9OfpW8Kzzmn+xnetDsjR6jVYA9BcRdB0Q9jYdh
X-Received: by 2002:a17:903:2f4c:b0:2c0:a373:89bf with SMTP id d9443c01a7336-2c6641caa55mr42529465ad.1.1781356488542;
        Sat, 13 Jun 2026 06:14:48 -0700 (PDT)
Received: from localhost.localdomain ([47.100.192.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433844a70sm47483305ad.84.2026.06.13.06.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:14:48 -0700 (PDT)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org
Cc: anmuxixixi@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Subject: Re: [PATCH 2/2] preserve the next empty-entry hint after allocation
Date: Sat, 13 Jun 2026 21:14:29 +0800
Message-Id: <20260613131429.229260-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKYAXd8ajKbH1xonEKdRTAg=MHS81qRp6v1B_0A8R=0Uet38Zw@mail.gmail.com>
References: <CAKYAXd8ajKbH1xonEKdRTAg=MHS81qRp6v1B_0A8R=0Uet38Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The empty-entry hint is only an optimization, so failure to advance
> the hint should not make file creation fail with -EIO.
> Could you make exfat_cache_next_empty_entry() return void and simply
> skip caching the hint if exfat_chain_advance() fails?
Yes, that makes sense. I will update it in v2.

Thanks for the review.
