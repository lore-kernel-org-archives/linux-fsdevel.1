Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E972EDD40
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 04:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789963349; cv=none; b=GY5qhbUhDYuebRteZRqFcsrhsRnb1vfxXGhVHn6BaYmToIlJWIMr4WO03cUdTStWkF7nz78HR4hvxO+SIUrQI384wvSb31lRvpmWda7+2rCs4bqCCA6p+nwmTYKv6kiBpDf5282rrkPxswHCTpXuTrFAG4sxz7JIfPZ9ktxVrIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789963349; c=relaxed/simple;
	bh=Ciwd+HjJpBnwHVYXNB2fo9MOUQS5c2QyhgXBMzQ6itE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bEqh6mCJUY6Cb+CF60CHJlcm6zOpYJrwti96FOlXCQwKTP7R3lV1E2baKpTewEdty9xYSH6+mTh6ARYvGnRmCm/LMslfeTjEBVNJnxknUfsV3K/Eeymg9tBELJYR6CYMFg2rEt6aMCz0WyUpvfixHhnHlOvactfFSOe1N05wkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGGfpkxy; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGGfpkxy"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso10356335e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 21:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789963345; x=1790568145; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0juRQzdf6nmFbDGjlJJGsvrFrjljT+sRU6VdT0gPqE8=;
        b=AGGfpkxy2yJECa7wo0zerf3UQtMdVQSC/L/dVWpobxeslrH1YbV39UmTgmSOACRAww
         UTjS4Z2AsjdTr4PEdxy7SJzAY9d4pJgfXp7ahxl17/e6wNf0ZZaqey3NZCf67yb7eiAE
         EhrbHmhrTUhh5xVRxXyh3473JTe/6c+ERa9WTE6TmWed4T4/8fL7FomyUVtDNS0QIU2E
         bepHgckQMmofBMdgXFtG5mmv71JcEUQVBp699mu+JA/93LBfmlYEZAdjPZt8sdvfxU9v
         QXlz4GSRexerwRdRQSDYeYi7Nz+qG+ZP6oSLDYyPsgyMYYwRu91YctJWhrpjvnGtrLKz
         vODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789963345; x=1790568145;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0juRQzdf6nmFbDGjlJJGsvrFrjljT+sRU6VdT0gPqE8=;
        b=pawyoMqMqfw3kdhEOSjOIQDkjbiA2FyWRvYa34dcCA+CLHnIi1nOXRPJqfotQOf1Eb
         spN6wgMvHi1R7j1PVkbrwVKSSSN81AkvBcA/guXxWUV3PLQpBwN2otZ+qZ9K5+7ogcr9
         hnuJ0caem+MQTOXxvpKkHgBY4DurNtVT4eJFUNs+TpqKcd7FflpszO07O9V1F9U5tDkP
         f9zRq+2DoojnbPkmldVA235R6RPAeD3r2Bg7k5w+dwO8uIiJtO67yl8+9uLep+xGdQ2e
         q5RF88r7TDGI376n0XEWBPoJmC5uw0Vfjp61e/s+bt+rY/hm4wp9sJD/u9fU7I5xtfy1
         o/bQ==
X-Forwarded-Encrypted: i=1; AKwUvByHuqkyWBbR7fy7Di0vpHzDn4ZN0Uir7eeVa3/eYcm1BQbYH4sH/pFlEuUVfSOKYwPYm6w9kd7+eKUAr+sq@vger.kernel.org
X-Gm-Message-State: AFuF++n3W585lYBZuyaAQ4ySurTuk/i1iZTbwN+netrkLwoOIzFHmXY3
	9hdwbRkZuBkN6D87gcCpPrx3MFgPvV/oEIUhZFeuPKBuGYdEBBN71a/Y
X-Gm-Gg: AYBFou2oXNMy3vx/T4Cf7IgV34dWCwlf1XtGHKNfmGS58DGS3KLUT2eH0nT/3RiIM/o
	G7qY6D+hU9z4DtuRzBBBg6yxfnjFMtPLx00ApPepvLpwcsu1SK43g0w5g8j02aDSXxlXaSksP7B
	FduAZ03DosKQnXCsz1oMtvR+b0L4Sn9PRwLYUCFAiY7Amm/JdY7oQ4uLzyEOGfIHuh8Vjc82AY+
	xYgGOX+JTU3Vr0dK48QrbZrmWb28RvgUdST0r0N3YT64GmQcZhlymiBXLDo9mqVhTpXkMU4j3Wq
	1Uy5O+MLjpRUFutzggBBtmiv0xw2JSGOEbKoQWZsgX/72B++YxjfHAWuoCL2LJiAmHRliLRZT4D
	vLYWHf/J2QKXly6tXolpyIGUvLxsZkYbBLi8jWurtDnV9eZNd5WzJljwc1lqcF99W8aj5+no8yT
	74MlIPGbGJKm9QtmKARtT3O99X4haIBeyhKvJOP2eyKJJEzwboRlZn+1u7ff3vACuXY+PQxEkgg
	jV80VXFaKRl5l+agqevmnhKbloaD18Uws1b7ccvkO04zoV7uO6feeqSRxigcMyEZc0NCSy+V0zJ
	orvZ03qwB1Fs9esu0WR8vApRkO6ookp+6n6yw8xWPq/amFly
X-Received: by 2002:a05:600c:138b:b0:49c:f89b:f82 with SMTP id 5b1f17b1804b1-49fc568f8dcmr115799535e9.12.1789963345138;
        Sun, 20 Sep 2026 21:02:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc55cd8a8sm256725075e9.0.2026.09.20.21.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 21:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 06:02:24 +0200
Message-Id: <DLKP1SE3XQ41.2QNDF51ADS0ZT@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH 0/2] binfmt: fixes for kres reports
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Chris Mason"
 <mason@kernel.org>, <linux-fsdevel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260918-work-binfmt_misc-fixes-v1-0-647b24bc1c46@kernel.org>
In-Reply-To: <20260918-work-binfmt_misc-fixes-v1-0-647b24bc1c46@kernel.org>

On Fri Sep 18, 2026 at 11:19 AM CEST, Christian Brauner wrote:
> I asked Chris to run his kres tooling on the binfmt with bpf changes
> merged for this cycle. It found two issues that are fixed in this
> series. I reproduced both of them.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Chris Mason (2):
>       binfmt_misc: fix OOB read in bpf_binprm_select_interp()
>       binfmt_misc: fix racy checks in bpf set_interp kfuncs
>
>  fs/binfmt_misc_bpf.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> ---

For the set:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
