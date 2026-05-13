Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EC3A5E8F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658784; cv=none; b=RdssE70Bonzijjnw26g/tJEsMpB/vqqiRwdBCPo8daYedLDL+E6/1XA3rpaeNYzAubV9eMGTlk5G1CEuBymAGj92fFyS9Nm5w+r2j3C4oXZQ9SA+9dBWSNT3zAAWkyi+gKNgFVowyZy6wtofEUPPQavZZtE3xm2m1opxRe58Vzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658784; c=relaxed/simple;
	bh=Dop4pZxScudWKS4ltQhKDt8/6TrzV1cgZE+0HEmFWHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq/KABUPnBE1cn8Fkk139GtGDsLoyx0+xfyFsbFukROv58CAcLkviuqc048iQOhC/ayAKCGkWIXY1kRLoic4pOqB/5OO2vvBDPc+cG6qqzXPLgZYsoWYR30ehewHfzLBsTa+UVb+ifVcNNO0ZrbFoVAvLZ9noUdTaJJ4/IKGrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pk1CFyd7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pk1CFyd7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so27079615e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778658782; x=1779263582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STHxK4qvqeQ0RbAPJE0Gc4vNM5XKJnXw+gBlPnD0MgQ=;
        b=pk1CFyd7hpkOm4FQQ0MjsAtq36sY5yKyxGc/A9U7mNRYaojpTwkdalTEv0UkD0s3eo
         QPrt+mcEcloFB1Jp7uVQHCp9TRrC9PuOpSDPswLwUapLuxyhExRBXGUQld1f9ROMRe+b
         gikTUfItgnFZLNNycwj+KdOIVVkOzIsbaTDinRJ59rBFsgCRIwBF0E471ZORDdg18J/D
         gD7SdRtZy7VdB6gBt8E8ncyVoTc+8GnmxA1Y9HtoZaJFlMUpyscL2JEVVtJr/QrfD+jh
         He1LBFfZ4n3krTXkPOOF8CgHQJxG+dPeWlSOKoG/kwh59TggSbYhEJmcL+hIFQOq/EJR
         VSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778658782; x=1779263582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STHxK4qvqeQ0RbAPJE0Gc4vNM5XKJnXw+gBlPnD0MgQ=;
        b=j05GxiO1g5h8sEschZGv9jyWz2zs57fEXEIa3CWBIJW7VYO7ewquG/6rbgKX1P3Nke
         Lduh4hvWBP7kGX2n7tpL/HjcLw9mG1/weollavherY/vc5bgdOCSzhabOWL9Pz8pLPfv
         HNGcWGZW5E/ZRX/U4KsleyAIASOJ5d9HHRXM4da6a4LZB5MTbVeM/sZoR0rpl85Lf0Wf
         l3urddg8KbbkGbcqro2nxuLLC+zkQEqP+lzb6IaBQEzpByPHvO0AUZc7UFv88DrPTl5T
         PNsBwG9HK+eUMC61ZBCm74m9FB8TckfCNpsXei4oXJXWA342eLCBWdyyTJte6DJUmfii
         5Pig==
X-Forwarded-Encrypted: i=1; AFNElJ9iLiu3dYY4DnsbpcDR6LpP8aGyStmHU8y63hEk4/5rEAMvHDk3kPGVj5NR1w9HKRRCa1zteYk/OTvmK7va@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zQNor3n8fx0eKv5a1dMsCvk7WXCNyLzJWp4hJxNgOOLuGPVp
	jUdVlGlzlAtqc7UcYxoRxBjI9hx0OnfUIa7Y41mLEkeIvLinpFMNBmkU
X-Gm-Gg: Acq92OHT5R02pqndXBU+G1HkeQEq7JTpFo6AVsTnWpqKJieFKcpl8yDaazDP1HNzLuZ
	1YnVqJd/NeIHFATIp2d6eld76etHXo9jFIovmzuOphXnvhpDmn1auk1fOYeSVW1t4Ej8q96rBlv
	jOfC94pkvsktnMCCUYLDMbqs6ocMQrScmsIZ8FLR8qfK2K1k2FnJ1QQyOuCIdyOh1fIMXEiSYJV
	Q0wJWNr4OgK3NKixITqH7c6+Py9qWbO/MqQHZZQsaTMzog+o4hCzOcrk4umcb2cOLzJF/vTFFzY
	KPvf4A+UbpFF/Gg6owsm995dcvWUsgIQ2Q7fjzml20Ab0iBi6g2j27PPbOFVqNNNA1/xE2qgW/0
	xQWV7p1ByicTTXWGzDfTckGvYpb4Kzy3qxaxAue81oMO1uf/zMPjbdM3mhXivCXhu/lBlHOR9Ts
	osieeUvfZ4PzOw4LUnkxCnjJlGuaGurYf4Tyd7QChJSlTXe8e8ZfxgdOHQ7ln4fNeOE2GybrahA
	Wa7mNmp1BmP0flHjaxLVQaHxipN1DYw7LX4We50I+UQ
X-Received: by 2002:a05:600c:1547:b0:48e:8499:4bd7 with SMTP id 5b1f17b1804b1-48fce9eb099mr21737525e9.17.1778658781539;
        Wed, 13 May 2026 00:53:01 -0700 (PDT)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d19974sm52175545e9.2.2026.05.13.00.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 00:53:00 -0700 (PDT)
Date: Wed, 13 May 2026 08:52:58 +0100
From: Vishal Moola <vishal.moola@gmail.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: fix page_cache_prev_miss() when no hole
 is found
Message-ID: <agQt2ohpc3TwR2Xa@fedora>
References: <20260512-prev_miss_fix-v2-1-4af8e5c1ae62@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-prev_miss_fix-v2-1-4af8e5c1ae62@columbia.edu>

On Tue, May 12, 2026 at 04:45:59PM -0400, Tal Zussman wrote:
> page_cache_prev_miss() is documented to return a value outside the
> searched range when no gap is found. However, the no-gap-found path
> returns xas.xa_index, which after a successful loop is the first index
> in the range. As such, that index is misreported as a gap.
> 
> The sole caller, page_cache_sync_ra(), uses the return value to estimate
> the cached run preceding a sequential read. In some cases, the buggy
> return value can undercount the contiguous range by one, shrinking the
> readahead window or pushing borderline requests into the
> small-random-read branch.
> 
> Fix this by returning the start of the range - 1 when no hole is found.
> Update page_cache_next_miss() for clarity as well.
> 
> Both helpers were previously fixed together in commit 9425c591e06a
> ("page cache: fix page_cache_next/prev_miss off by one"), but the fix
> was reverted because it caused a hugetlb performance regression. hugetlb
> no longer uses these functions and next_miss was subsequently refixed
> in commit 901a269ff3d5 ("filemap: fix page_cache_next_miss() when no
> hole found") and commit bbcaee20e03e ("readahead: fix return value of
> page_cache_next_miss() when no hole is found"), but prev_miss was not
> addressed.
> 
> This was found by pointing Claude Opus 4.7 at mm/filemap.c.
> 
> Fixes: 0d3f92966629 ("page cache: Convert hole search to XArray")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---

Reviewed-by: Vishal Moola <vishal.moola@gmail.com>
