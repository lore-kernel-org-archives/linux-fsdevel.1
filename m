Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF73B2FDC
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715570; cv=none; b=DpWrJsGZwR+6Z3ZAJAihuTf2K64PmrpjDWIIX6Wjv9b70LdEJWkgeH3DW2ZH5DlqSIqyabhflVEl/I1r5ekD1DBQ+FMhKgZiBlp1uxWyqrljRAEW8VrXuEVVzheyFTpaRbw5CjL7BjhWnwwwrqCxXSThpbN0950fTe7D1SvHse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715570; c=relaxed/simple;
	bh=M9xxP6XHlfNMV7GWnWZNCeEtckS3szign5mxnLwwcIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZ0RNkkOpsAnJSZJyGpFUC2TK23qWLuonASc/d2JYIEloG0doVE9l8F8RYv3nlf8Vrz6ENXWroeGaejmk/4llyM3Er5FM017b1tK20dpWb1AKXhUhd+kVjmOsTwmtYNqFTtWpIVD7Z2xMNU4s9jwOWatPTI5DT1LBO2v4povSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqHWKVcq; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqHWKVcq"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so36270105e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790715567; x=1791320367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T6zBsYuvkhCSldzaWUb/rJ1yx0lBA5YccYiihjP9u78=;
        b=MqHWKVcqTAd/lgzgSnDnRSJMe0MOojiTxaZu79gll0d6Vw3aLWBERIj5aPOmzDeCea
         y/DbhQufOgDOf1mz1z9Kpuahhd6ndsnVudDVldGwtF8iF8gEMUk+QBrhKYQ6AaHphS1O
         4Gmk3f4KtMUNsmLRsMaM1beSQs7g87Ft7WWBLUEieRUXMeDCXM9ieuk5RNodPIDMaHRU
         ST74JNm4Gx5qBEYWCHq4rOTXiT+hHEvRG7jszFhCLa05RslRAmTvJ6bNNzyU0AVVhSQa
         8G3imAAvmoGGomB0G+DVKi/hvQXkvn32085FaMILJui5q2Nt7ARoaGeEFRuxq0ajontd
         XTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790715567; x=1791320367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T6zBsYuvkhCSldzaWUb/rJ1yx0lBA5YccYiihjP9u78=;
        b=uSPs+g0ALLzhpPt8bgesnoiKLQEyhFKYOVn5J15QhBOg4B3BV5raYwlmFS4YERny6z
         yvPWy8LDNjYX/w9PqfA2ST/sWsiOfMDWgvdBki4HK6Rd6Zsp47zvzUAwXCEr6wGGFyX9
         ewr4WEPDN5TqIzqcKY6ld7WwbkgeK8OatTeWwYNWfi/msZpKS/NL2c+0BcEZ+Rtp4vqh
         EaGystQaO8AzvK4V5NvK5Ap/9dLXKXIvazVcOX1E8zj6c7wYLvqh/+CxXWPfS+V7ktnK
         +OvNohH1aLeehAFmK5RVgMVOnfhKc475b/QMhEy0u9ppmH227e1Nf05tg4F9sajei8Wc
         uMPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLz75J6/lofCPgtGaHWQatalzSp0JfidRMz3MwNMRTgobsTH6VsHMMKjvKWXKL7VbTnxLrYZhC9fh8dCBD@vger.kernel.org
X-Gm-Message-State: AFuF++m7fddi7u+GzYMuIGIOb6pHqAt9UyPrR4D7d3nAQ7xTRoWL2fBi
	ftKl3XMZPsOcZxZNtrZACaHfTR3job5tvummEoGwN1BmQM2PZAePRS8=
X-Gm-Gg: AYBFou2OldGTkCMZOk8YTaqZHv/Qtwm0UeCniEXDtC6QVHkTCcDWgHXdPBAItzeKyYQ
	Ig4yabw8XUUBMGgIOJPU2PaHg5zWSSNn08kkPOaNBn3XECac7abIDA35RRZWLYDyG1cZjXkAGG4
	PfrXYNkwSEWsnTnttMICfJ54wdidhEmegcFcOXuOMScWzyMTpwymsJz2tr79hGP/JHKskeoR2L4
	0oUIs2r9JX5/HtSrJ1JDeJuIwixFQPIPihH/gV6G+dxK1Wt67DQGM9PcO0dILyfw4WZyI9FfXHC
	2a+PvhTtHH7aipw40GbeuoZmAjM0lvtBIXn+b4JwJVYQMo22AjSFVIGf1caVSQdjq/GMMx6TSHs
	geJJFuuErqBVi9PDLi3CnV8TL5mVnDEWmd5uJUk+73PsIfTWCZF+i3Qa3oeWUxDf1Vw7e5s+LCh
	8S9jrRy5SQQHpQFSaNCoZ7D6gI3g8wtVffO/Pay4j9fE24K5w0e2Mn2qC9sjijqsRkqB8gFmKPo
	8krls1JhwxY7hAkVBsumxyWBGxNaXqslvVJjqUOu7p9QK7pA4NNfitqtxeC8wz1qd2zE4siqD3b
	6PDHUvo=
X-Received: by 2002:a05:600c:c48f:b0:4a0:dca:b78 with SMTP id 5b1f17b1804b1-4a0151397e3mr4412245e9.27.1790715566870;
        Tue, 29 Sep 2026 13:59:26 -0700 (PDT)
Received: from Ubuntu-2604-resolute-amd64-base ([2a01:4f8:13b:86d::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a014217216sm26857035e9.14.2026.09.29.13.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 13:59:26 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: gabriel@krisman.be
Cc: krisman@suse.de,
	hnkz.64@gmail.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	andrealmeid@igalia.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] shmem: fix unicode_map leak with repeated casefold= option
Date: Tue, 29 Sep 2026 22:59:14 +0200
Message-ID: <20260929205914.229355-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <878q4jyf1z.fsf@mailhost.krisman.be>
References: <878q4jyf1z.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026, Gabriel Krisman Bertazi wrote:
> IMO, nack, this is not the right fix.  There is no point in accepting
> multiple casefold parameters and we shouldn't allow it.  If
> ctx->encoding is already set, we should -EINVAL and fail the mount.

Makes sense.  This one is dropped, since Kazuki's patch in
mm-nonmm-unstable already covers the leak with the same unload
approach [1].  Adding Kazuki so he can adjust it if needed.  I'm happy
to test a new version.

[1] https://lore.kernel.org/20260827152516.805622-1-hnkz.64@gmail.com

Thanks,
Mohammed
