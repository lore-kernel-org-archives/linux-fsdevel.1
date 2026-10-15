Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B215187E0
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065284; cv=pass; b=im6h+8naOtmSTe3gj+Z4LdkuwUsKhbST41qX8FmH3sqMJ7RoCSmjoCNv+p/lnO3mfFa/D7psfWmd86xMsk6DFc6R2Cx4+QcCVg3PKZ1Nj+0qbdukNXDffNlKHYbuWUQ1GebbvqmvmrVorVesvNZOmzGVvobLrS5CtLVQqH/NP8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065284; c=relaxed/simple;
	bh=ttWWCBe5s6LvEvuhu7UMsF9414H3CKAKMZfdr0bsCwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hq+NUJo/xug+ErMVEl7+k0WnZ8OwVotnm7RGOHwKFVNJKgnA2HYhMX9BxxKwIMhwDvU2VuopwUH5+ZOxFEoeaoUZWUDIpGveUrac23yPLzWGOFB3hAWjZB7Pi3r7a7FpU1TEz/y/yXkMq8//8hdHiEDkN/iHjWfrEJsTv7t2jZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MPLi660C; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MPLi660C"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-535f9de49fcso8596461cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 04:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792065281; cv=none;
        d=google.com; s=arc-20260327;
        b=Qa763nsrJ7y+zcB41cDlA34ogsGnGm7b7ASoAlsQpzS4f73KL3G5FFHb6YfPBeiWmp
         yCWtWqRly1nqdTi1TrETDpbtCoyy3u1iJwX2T9igpvPxvv0DzBtQCIkzYl6OM41RJ2j5
         noyRzeg78V5DM64fRdSGYt9bNm3b3HYS0RaPmGhtjbUX5f235zLwjm3ISBpjHqgwwq/u
         hciNE5lHGaQgkKOfvqSFn0sBfY2Q0MbISw4IB56D7ORUNRU+i/7lP5jVcWfB60/wIU7L
         8tctTxD4PtARlnGmx9hqh0nb5xKW5l0SJ2ntSnHSx5d4hIaanJrrC+IL9ZMO6Rf7QIzO
         VMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ttWWCBe5s6LvEvuhu7UMsF9414H3CKAKMZfdr0bsCwA=;
        fh=wYnim7t7efVLyymryFfoK3qIL79Tf7RlSvTkY/QzdOI=;
        b=rffnQC9g6HlkUn+R6JoolbGcNDlB8EMkqdIYrqG9Z9HBFaLEY3Ea/CpC5fbP1x+FKy
         AMY1rRKJfhwReVRvtb2nJ3G/tRdKd+8/MAUv7xLpqSwX3NjZ/scflwhmvggLsvm8uLfZ
         DhCAtDlxlJsxB4dUJz/R7Rm5SXF5CSNHwdCLYVOfLeGtaC2aEwjMnEfmTWle2UYXwRqa
         ctnLAU1v2rfY9OK58Ne019Mh2lhtED9GJpLc9qpe19UbIZdqWqkeNezwCC//ByupVVIt
         8z7ZKAG+jry6xdsSiOkCZT1v9tu2T5K3FEHOa56pjCOvzgYy5zsbx59LyMQQw8+BNjAx
         yh0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792065281; x=1792670081; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ttWWCBe5s6LvEvuhu7UMsF9414H3CKAKMZfdr0bsCwA=;
        b=MPLi660CpE7iDEQdEqqxCBxE3u1R5P8U6K2n+UGZxK3S06oo3bvGxxYNLTHMYcwPGD
         emTjRLjvcIJ3OfqAqFvo4s0sxpPYEiSv0HCGGYwVw2nu3qhbnFC5M5Iae4HaW4Qoby4f
         bAaiYdtp1Uj8O+IdwrysOZFjeIcm4+qJO2D9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792065281; x=1792670081;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ttWWCBe5s6LvEvuhu7UMsF9414H3CKAKMZfdr0bsCwA=;
        b=VKWnbU4/Hhp6XaED/pdFztNsc07LMKidn5IfG/FdCJ4uXUz+0Xn9VR9+oRSswUxSO4
         2UM63x8qjyjyXEaxcdslsVHx1oPFNO9QWybhyx3qjCEH4CL/QQ4SoWyfgMnFjYpf0e8+
         OIHjTNA+bhf40UkiXePDQOKlAN0FMEZyAkT2cMhOty2fVHPC+OmVXZ2qe/bvSSlEFrqM
         9qbV7PlS0ZRexK3MFLXTFy9OEFILcFSg6P0nAOcJVNX7PYMzUtjdu9YSVAwiy1cS90d+
         w14E7WQn1z68hw5s0xf0nZD3the4wBAJ0i+Jf1oJQltpAynlZtQVSqCrx+AaRJNhlbxN
         M5mA==
X-Forwarded-Encrypted: i=1; AKwUvBwqNWA23bzk5zby/s6e1tpzPPey01BQrcBD1oFpo7LrqPmm/WdayVu8gQuwuscEUiYNFS3ZObpP+aaekW25@vger.kernel.org
X-Gm-Message-State: AFq9FYI672ldfRV+Q5yD8YXK5ChCy4rk48A8AQZhlPJVGcLw34ADWHc5
	MfHza9ML9l1Zv28o5dcUvbX+9QoTfEcQsKg71aj51D0OtDm2sOAzUZbeDMZ/j3eRDitmi7opZnX
	ynfXO1F6/UqWAZ5eqN2tgEGdz6Diq+CMg3uYNTdUemQ==
X-Gm-Gg: AYBFou1FoEhTVf7mwlUXFKwgIhFdhY//16NW2Ww/Dzy7OXeJ5p/a7RXhHd57u+BoM7o
	GAXfxBXsx09EDBwoqIiUVm1XMbnpvHv/sMwJ4AQebJRfVddh9OfZb/KIi0VfW94W/4wbC0xyO0S
	bheYrWgTIbyDjonqq2WuGdfefPk28Bnm+RP6AmPjGw+5HSN1zmYdtPxYZqVXnIpMwLk7mhnA3/Q
	eIgAoIfOkPYT/XpcDZp/GcB4jScFqaR9N8cb+Kj8444ayr7uBE557n/t48XZUk8LpNqRIpVT08S
	/X43oMhBTXDSV/02/Imko8EHrj6LnI9MTqE2xlw+Mxxy/s5qyXue0nTWJh1V1X+1cxBm29WUOFg
	X03TKJhO2533eNDu/Lg==
X-Received: by 2002:ac8:5705:0:b0:532:f0a2:ef4 with SMTP id
 d75a77b69052e-5359fa9f9abmr292049781cf.26.1792065280681; Thu, 15 Oct 2026
 04:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929094812.93374-1-tkhandelwal32@gmail.com>
In-Reply-To: <20260929094812.93374-1-tkhandelwal32@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 Oct 2026 13:54:29 +0200
X-Gm-Features: AclHuK-b14bcg6mR4vOtm8iYsjO-WDFkkV-OiklyH6IKsJTNTAuDKd92iU3RYd8
Message-ID: <CAJfpegs1Zq1zKfGDOucL_PZMUwVuHjandRn-rrNrBPnKex8hcA@mail.gmail.com>
Subject: Re: [PATCH] fuse: propagate SB_POSIXACL to submounts
To: Tarun Khandelwal <tkhandelwal32@gmail.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	virtualization@lists.linux.dev, German Maglione <gmaglione@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Tarun Khandelwal <tarun@supabase.io>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sept 2026 at 11:48, Tarun Khandelwal <tkhandelwal32@gmail.com> wrote:

> Copy SB_POSIXACL from the parent superblock, as is already done for the
> other superblock fields inherited from it. It cannot be set in
> fuse_sb_defaults(), because fuse_fill_super_common() checks whether the
> flag was passed at mount time to decide fc->dont_mask before setting it.

Applied, thanks.

Miklos
