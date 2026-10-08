Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A723B9D98
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459858; cv=pass; b=BAss4o5IBVUaLSRUmZrG+5YvG7tORjJIOR6q9A1mKZCOVmiEHX6Un7oUAzRWUf8pebH3Q2te1xiS/dWEzcajx8KCq3dVqonkSo3s2VvJXVnTnqfTee/7aCp3V0x/9kwkkg1fkxCcVeKyAQqvdS33C/cct0pJlnLc2v1QhaQiN3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459858; c=relaxed/simple;
	bh=F2zqmRM3iI8PS9kUAZsutdB8oUyV5WrW6uLyCJ4oLY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUNNzgpRLGlhFpLlkYqZ6qOC18/rd197EKN1cAwINB0i9idraGO66I10aRcU4dk/AR29XwdlGN2+djGOBlO2YPo0AbhccykGxxy9SJcbYSW9369/LKB4Jy3Hhnz7MtHIRGwmDf0GXLQ40wvzN4NSQjeGdDFrryMHl1LMG6N0xA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV/LqYgr; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV/LqYgr"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2e43f3d1fdso698937966b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2026 04:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791459855; cv=none;
        d=google.com; s=arc-20260327;
        b=BQYrOlOHnG6CPnOxs1Nq626a0fMx7J+K2T5+ure7++F6FTj7C2pdgCbeJS1a646j4H
         EoXUcqVXjqnuHHfjOl0Y+fiGMjSjFIIh4eBST+9eoqxLY5+ARkmLdpFUhCcbFZoOjHfW
         d5ePUeaYlcpOtmDwX+DRdhOIDm/drNKtxqK5LjfNq+4NonFA/g1fM4gzPvKlULRQBOJv
         6tcbu5V51whh4e5uQuDy4sRu2wATg7fxb2+TuIWIObIswHUmNd4cB16NBbFVGGLx0Iad
         y44i04KqsGeKSme0V0dy4X1g+mNxKElpesHxgL1Qkb0HxTZnjW1srmRiXlnjrrmK4MnX
         kfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KgCzrz5MTmEOiMmZEKQzXUh1jqi6chxJJkO653u8cQM=;
        fh=CEyx3vxKHwqnH7F3oBuWKn+fhkFYqNhgkudzEz7Vnfo=;
        b=pEpMu7MPhnKFhw+SPMS1WXmb9jJlIc0eRxZ/luJMpBCdPCU7hEVAnhnaHDbGkp3anC
         02Zady6KBJnylX6pWVcrk9g5hvThyNhGYkFFPdr8p6l1AprTaSMll2DU/UojKvB4eSW6
         BGYiIyD7mPNmlBZMNkkhVl7VyDv2f4qxWD1XI93Ze5ArPUJy0e22tuouXP4SEke6pUyl
         tT/QOTnBfNWBQDmDHr2+Xdgon4w4r4YbTfZA8TJDHCeIQ+x8kQixJ8meQHeFXdNK0uDa
         xrWiNaCmPFG1T6dI2gR7K7vUZACUhWgysQOd0bipRdqfad+IMQoTxDOfV4LTRRn2d4+6
         ZmVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459855; x=1792064655; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgCzrz5MTmEOiMmZEKQzXUh1jqi6chxJJkO653u8cQM=;
        b=VV/LqYgrRW9eEl12HGYoRR+wMChxl2LrM2nwtyU0xEbl1cukRqaYwZJ7oCPH12F62s
         fqfVvji06WvNhJZDcwUCXqBTbk6B6RehQHk2E7bHDQRkfGr2QlWeR/+1L1bR9Tt02WNH
         KqMSK5YBUyWVLWEZ+xn8bTPelsBxK5qu0yJUM8J20GfrogldibkSuB6lHFlpctmVLiHw
         /JN+MuXX6sxIHFgo6ABcPkLlxQH7/KTMmOQdtnwjFhSaPmI6tUyF7xHG3P/X3O4HqcZL
         xZzf6AigYpZoKrCsyngOzcMPAwMH9eFoeP3+SF/bZ2fjDa04Rv9V+M+v160az0sghyZt
         gGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459855; x=1792064655;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KgCzrz5MTmEOiMmZEKQzXUh1jqi6chxJJkO653u8cQM=;
        b=d46R+dS635f8u2rSpaA8wPqYoVBN3gFf6rwlwlyodccohTpx5wC2yANzZYi/Tse6v9
         txkKACOTqPWHAokcPo99rvOHgH7Ynl4gjRi4wEYqQk3LXUdUrtLH73krDrG//2VjCh0y
         kw4F1QOEby22VrTtCvuDys18LW2oJ7gVUJ4J4CEtn8ohck4964R6lwd/tVsHFDWj9/1I
         PpSVUUdZDe9FqD7lFBZdu2YqclSdOzxg5i7LKDgwreOWW7taCUGRQ1Wj8hcWlfWmHF2i
         9dTAaiNjqoK3i/PsAHKf5xr/Hi4v4BAcJF2aHg+Hh9YsE3+NTt/w+am4mRTQ2+IsezXK
         I3yA==
X-Forwarded-Encrypted: i=1; AKwUvBzHQM1nY5ncBo31BBaZtUY24FPCZjPZp7x5ISOPPrF30eEdiUotQeq83X+4QO8xqI8EvoYGXGOeei5Q+Oin@vger.kernel.org
X-Gm-Message-State: AFq9FYJUUpDg/vKDhANN0iBe/cV/rKKY3DDz8NIyiPjgyIL0GHsaCiFt
	vNM1cl1WBQvP+0LhGauohfAnyZ8NTtEdaEOp5ElWPv2kPSBvJs4U84wyb6cfg6LbEUl0oUOveDL
	JLMp5EVVW+Yu0RMQ8RpbFNpFzKoqs+Q==
X-Gm-Gg: AYBFou1rOskw/uHppho7U1oWjGEphggC4E/C1IbMsTPb50MhiTbO4o/VTZ6aWZxm8x0
	L+EqVpzFE3ERvBjWPcd17b1QiV8PaFxbL1CBf/9A5XD4GgFg1bxgsBKModK+1QoT0scB1JfTbNc
	hQ1YXSB7IsWFHjUZ4p+SRkoxO6QTUq6NGlSV4O4+KocX5Y99GXy32hQ9V5BwvvPynWOjmmCuUTv
	Hkmza6O46N+NqBkSGfsH7tb5XQgAWb+hQ3yt0h7M7zFP/DtnSNta3y9VmnROT7lATqNU3ftLcfn
	BAm6E893RHgZYUxKvVT19xunIe/lrFyerVA/uSJr9TyO97A96gvYF1Z+so6z/r+pbijhb7pKiVH
	hvwfbA1AyivPkAacUxsiNImbgR9sdg8RGX4X315PHe+QbYTMAJK2E
X-Received: by 2002:a17:907:1c94:b0:c2e:32d3:1b5 with SMTP id
 a640c23a62f3a-c317c0ad02fmr523121266b.32.1791459854813; Thu, 08 Oct 2026
 04:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924100032.2733101-1-hch@lst.de> <20260924100032.2733101-19-hch@lst.de>
In-Reply-To: <20260924100032.2733101-19-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 8 Oct 2026 17:13:35 +0530
X-Gm-Features: AclHuK9ii9nY2tZvVAGfNbbhZVmNqFIbUD29KvWXyt6MDnjdmu7KJpQUpIenNsM
Message-ID: <CACzX3At0e+qWoNrvrPuryGrOxpGcH1fr=Ymq1spmG0qqiJ+d-w@mail.gmail.com>
Subject: Re: [PATCH 18/21] xfs: don't try to verify checksums on empty zones
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"

> +               error = xfs_csum_verify(mp, bio, saved_iter, csum_buf, bno,
> +                               false);

Could an open zone be verified past oz_allocated here? XFS_RTG_FREE is
cleared on opening, but the verification range is not bounded by
oz_allocated. xfs_zone_rgbno_is_valid() treats only the prefix below
oz_allocated as valid; should this trim the verification range at that
boundary? Otherwise a whole-rtdev XFS_IOC_VERIFY_MEDIA request returns
a spurious userspace error.
