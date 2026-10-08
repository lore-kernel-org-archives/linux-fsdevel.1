Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB63D1CAE
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445279; cv=none; b=PWISN1CjIJsqeAueLshUG6Pv3O8Bs7rEsu6IXA4+pL7SkpHDAMK56IJv2+28g0+U3v++9Xqi0kpSPyFdp6qcKt9y4nWDn2CsOlMHrccNfcpiyZBAxbul5B06G6M0eXv76IUGaNf4nZe0mT4TZeIipGBdhfT3hcJDbGsmbGNGF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445279; c=relaxed/simple;
	bh=ef8bxyvnltQ6HrGLLZ1t6ISbnufdn0qldifIe1FBtxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QS6cNBuyNfShydsDS45Zox+etdL7+ia5kUzftFJH1oiF8XXMuD8mzThlaode+LDnLgHs77i9UgaOz8jVUupDs2a8W81aBhm8DUiV4aIRBey0nFRScoqGJiBIw730lb7tOBljcYc7KbqPztIP7AYbcuTqtPKsFRoqSpZg82T/kvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjERULn2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjERULn2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e4b6fe273bso1206045ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2026 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791445276; x=1792050076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=awqJUJaCqrMD3ZNJk51KVYqwLY/lICB+bok90TEZ8y0=;
        b=LjERULn2PuOIE9PRbeK5JfN3eYqVRAlHRT6tNPcQIZ9fP8D7w4Ng3P3hc7Z11IzphE
         rao4c7BCuBsCtBDbvdjktk44Tk49Ha8TBDUipMt/IjP72kdv5qgWt64r9uk+3OBVEvS9
         kFvMA3OeXwt26RUXWvInQ5oK8b90rg4Dg1TnfME0qfAQcgiCDQz0ROgirr6A9DohDFEO
         qfDNT+SP7UBwBUuW4R2MPKYhHrPFe2CWodrj8+6cbsFEgVQw5kobEVkqQprqfttCLJgR
         +FGbgSxD/gn+qXTCK1pmB2PF/n4PiyCBBLOXCw3/7xXOlXitAS9GAvRPjDg9iyWVNj4X
         onbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445276; x=1792050076;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awqJUJaCqrMD3ZNJk51KVYqwLY/lICB+bok90TEZ8y0=;
        b=0waZbQ6mYiAhSic8kL3cMq7waRJXApyzdPNdW9QONu7VAnU1zcrQjtLp3dUsK1ft8p
         tJwNrRzSC7zLTF1/dj2fxVrufC7SBfXAYKkGvfpHrICgsMYxxU6NALXhHYbYr4zjmnot
         Iz2YxDgylRPTjMAKenxa0qAMRF8K5nbg+ATDsIJslbYD6Gw+BDz3HvblIY8RsMxWwmTe
         sttwYKcIp0y0QuKhbAu7qijoWxk+OJO6I9Uu3q2Oy2nwxKTPvnOMMKhO4LqzvBGKcRpC
         d/THHfIXsyxQJQ5ocilD0mUqXmH7G0f989xaBseoQ63C8rsUiKNZuXfjbyoE9N9oDxC9
         6ANw==
X-Forwarded-Encrypted: i=1; AKwUvBwrIQvUVy8HGTUw11T2sZVaYIPGVH1iGEVeuVh+m50xQ+iPncLJL9xLnPNCZgC1QSCLcotDsQcM2n+eMFbx@vger.kernel.org
X-Gm-Message-State: AFq9FYJMXBHlDlcGFQ8ipITDCGQiZoPgjnBviinGhDz28+Sfu1Zw0Onp
	lHKjzximFJ6FU1z5dSApfp8YSU6jkNXP4QLXb/N8jQn6h7tPo3Uid1l+yTy6lg==
X-Gm-Gg: AYBFou2+A9qxyGB4Zk0mQ8bq7PhH35rAh1GO0o7zZAzsDxq+3Jx7Nbx454Qyf6FV7YZ
	MeF3LvKLnt93sfdLljYzqkjsOiLoGLjWDvjWHoXNe8BpPS8n8bCMe4VFNX8ReBha17FjqVAXRjj
	OnvV7N2K6sLFwKS6j+dz6iWwEVM7Ar1qrjs6ctWRDCWFzZiayefG/JoxCjdgRduFqHYgtPn4Yk3
	r8RFogLLAJX1067JUQo/fJmPBASF0MkhtIv8kQODjUiW51T3phkMReIQsTzs5SAXAEjTP8XtT1j
	DMu8rWdPqdIYvD+LM9/YrGPeKPNHwQcJWD/9rWQE+cL/cXY1FrG4kC4yx/C4nfIDA6c/bcyp4Hs
	iUm50dgu2NYSKHclHwT+YiDy5/GKMyxYUQ3hGt7ccGptosK60dCuG/5NM2FQD4zymf3HqfCM7Te
	O/8sVgbOi1G7Wj+ejCszj5I9U8nUG6oEX13Y5Qc4t+aPiMhBmpxgvQPEtlflKHMYXjNvEWqsFB
X-Received: by 2002:a17:903:244f:b0:2e2:d09f:d772 with SMTP id d9443c01a7336-2e7f4b3054amr24019215ad.0.1791445276129;
        Thu, 08 Oct 2026 00:41:16 -0700 (PDT)
Received: from [10.141.37.220] ([138.199.21.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6046feacdsm20589545ad.18.2026.10.08.00.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 00:41:15 -0700 (PDT)
Message-ID: <5048a2c0-8e55-429f-bb1e-4b888a728579@gmail.com>
Date: Thu, 8 Oct 2026 15:41:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Free any excess xarray nodes in clear_inode()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Rik van Riel <riel@surriel.com>, Zi Yan <ziy@nvidia.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Dave Jones <davej@codemonkey.org.uk>,
 stable@vger.kernel.org
References: <20260623192850.1595958-1-willy@infradead.org>
Content-Language: en-US
From: shinka <shinnkka1@gmail.com>
In-Reply-To: <20260623192850.1595958-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> For many years we've had a hard to hit leak of xarray nodes.  Hugh
> documented it well in commit 786b31121a2c.  Recently people and
> syzbot have found ways to force it to happen with madvise.  Rather
> than fix the leaks where they happen, just call xa_destroy() which
> has the side-effect of cycling the i_pages lock.

Could this commit be considered for backporting to the supported stable
kernels?

Commit: ee3f01125010 ("fs: Free any excess xarray nodes in clear_inode()")

The xarray node leak fixed by this commit is present in older stable
kernels, and this fix should address the issue there as well.

Thanks,

Chen

