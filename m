Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC2495050
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373506; cv=none; b=kCEI02qezIGeQa1m55NdHMvPachiIRdT2kX/MJc4EjouIg6WZ6Nv2SzIDt+gwQER9775DriHz/Cwty/fomrhsgeslv9NWWh+zOsmf1jbWdeV7sxGrEwxp13s3pYPzvhSHPahOQtcsaZHshAeNbjhcy8IxAysx5k5glPxTEan++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373506; c=relaxed/simple;
	bh=j5z05H9my0ZEtJmvedrVdfeQ7u1S/6Jb1g3UIaBPI1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMPjkK2xwXroSb7t7926HrjA98EuVPgNonfShd7EUAGFisxPJC4A1kzpftdVpUhTvXIl1g7RIosCw2gAPsKsjkzkA+XXfgqWNaeeuDw+peRh8bis9AWU1zN2KooiHWgDlmmzzFMhFk8Jl5yb48hhRTjZgOII5GtQ9SzzB6Q8inw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bg7Ghj2Z; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg7Ghj2Z"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so1566385a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373505; x=1788978305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6AXQi4howHroN7DuyCWjjvFV0b8XeXdQweCPbXwE3Wk=;
        b=bg7Ghj2Zg9gHrAQAB507FCOukWRib8exoNHTU0g+SZiZ0dy+W9CV/Jl35z69LOeTwX
         AtLZx8i6dsAI0rcf+Bungk/qWi9XdEftQzLaZ3FLhNGh8ptAi7ymsZ9aiDf7w0IKzbRu
         B4yd37q10dldPR5FT4ZruigM5dp4eJA6iNYEOuj7ksw70dvHbmDobQWYWq43N8Y97EyT
         QW9nFg/mXTbkHoEXKXDiA4U8vDgmZdb5Tg7QOqd/cQahNUmgg/lUeSEbGYjkLL5ZYdhB
         Qvv8y0fUMj8vvYDBZK2SM9llX7yZQbDofyRET/MfDUU1cjK1dFbHw0A5Jx0vOQj1y4yD
         8/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373505; x=1788978305;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6AXQi4howHroN7DuyCWjjvFV0b8XeXdQweCPbXwE3Wk=;
        b=DYLWK2kIuGB17XKFzzAtwRt2hkV4rT8SYgCXWeCiujIKXqCUoaCPjVgcgtm08e2LVJ
         M2Z0p4gsKvVLsTtFFdME8e7QTl9TfMszXUYWCJrZJqYvOnIgcoRqv1/Pq8VZzqy9uKeo
         AuveeTweVQwR8uSDnCxzQBJBoqlVgW3/vkKhpnvvRHvUkMgGMTzfDba3LQb5An05kOad
         EhdaOS8R7VbkEF/gq4N8jFHH5IZWZKXOHNArBQBM4x61SgzXn3yq5pUM+zv1qD+xPiDV
         OAKNjKyv45PPWAfgzSZgQiRKdJk9sic7/iT6sNGmlMvhT+kRvH6EqMkUyCo0wM1/5dv8
         FXnw==
X-Forwarded-Encrypted: i=1; AKwUvBz8UuSVsxFiX3mbClKIsn1oAbqocFGoij2Ot/aMnWB8lrfX2ToUdJBe/fxMwDrdJiEklQkto+rv5VTtJ1u8@vger.kernel.org
X-Gm-Message-State: AFuF++mP6b4clFmhqoZRwgBQHUKsVxOLGIgLHgwWtJS8lLz7p+FH570p
	ESxdTA4pqOugIOZmj0ZqMpBzD+eUzkN+dapoV4MXESmwpIYi2cbBaoQ=
X-Gm-Gg: AYBFou2IBSUNKs4LpUsVzwzafJswccAyqiJKedjXfh9hZlTHjzFbzX1fH0DXJaxmwlJ
	nKYdti5/90cyZm0/hWmZIL2DXrgW0s1ytmCqAHFFa0/GgJ+ukhUPK0Xbr6x12zyuM6bkXyirDvc
	1jizuIS95DcPRFyS7JU3PaMAaxcnzNwET9SPPyp9T/KLhjo82CKXDENKV5bFzdxvPw8yHRFN4RO
	cnDy+rZq9JWXNeL3tEbcEM5dCexAzHWGtelYgksRAWBP+dgEb4GKsSCSUPuHZFpiN2YV+ui2gSt
	dCs8TGGaCqSY8RVdzr7upJRrUKfDpwqLzEB5N4BbB8K1BAYzXnMMUuvrZ5sNWLgQ3DPAFgWI/Pi
	/wyS4bMm2x5CfWkQ6p4rmNgd7ASFEiYw1cV/dOy6gdJqGgt3V6qjBarEr03bdZfxFtFyvm4f6tL
	515nzxxs/gJPKIHZz7ovB51QRGRK+vPqqQj62tdSv8hjbOhXU/w9iPOPmjBCdUfJVAVakjSnL+W
	aAP+dlG8mEeIEZ7O4jSd2FzDdD+
X-Received: by 2002:a17:90b:17c2:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39aee13cbb6mr8049325a91.12.1788373504937;
        Wed, 02 Sep 2026 11:25:04 -0700 (PDT)
Received: from anuj-MacBookPro ([2406:7400:63:f76b:3efb:3463:cad7:ba39])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079bd68asm8704512eec.2.2026.09.02.11.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:25:04 -0700 (PDT)
Date: Wed, 2 Sep 2026 23:54:56 +0530
From: Anuj Gupta <anuj1072538@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/17] xfs: add support for lazy direct read bounce
 buffering
Message-ID: <k7ugcithodfdkswsbzshcnwaqwiubmhf2zq5jp2usck6finbhk@xt4pbaimvl6d>
References: <20260831064010.2574896-1-hch@lst.de>
 <20260831064010.2574896-15-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831064010.2574896-15-hch@lst.de>

> +	/*
> +	 * Free the bio integrity data for the original bio, as we'll allocate
> +	 * ons for each sub-I/O, which could deadlock if we keep the original

s/ons/ones

> +	 * one around.
> +	 */
> +	if (bio_integrity(bio))
> +		fs_bio_integrity_free(bio);
> +
> +	/*
> +	 * Reset the bio to submit the bio to the block layer again.  Switch to
> +	 * an end_io handler that simply complets the ioend, as all verification

s/complets/completes

 
