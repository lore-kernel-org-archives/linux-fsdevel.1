Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC592DE702
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143256; cv=pass; b=i1ZblFEHo1dOa6+3T+/AESj5vgWQhfPzrrbUyYeHyQ88z4EJUqKmsd2Ma55yCFmPHtuS6WuAAGNH8Wn6dkOLCRJkO8mkwf1hDUw3LMlVYqRXdxZkelduQpI0wnTS/unnpMkTq78skHMePC996W9HRWBvLgLe1VX2JMtNrKgFxMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143256; c=relaxed/simple;
	bh=FMMCeXsWewqCqSlwRq7fpQsvaPxdERiuzxMm3uJ8O5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYgoVlzXbg92J+FP2qz8XvU7BPf/kSDe6H71Y1xzUjEac7PYVAZzya2IL/Q4Vtuo/knpZ4UP2TGSrNO+3pRE/RmpCi0Ce+RvUuEvLYQY1rZYjQg4IGQub+K7yHflxorlwQty7cZPh7jY1bXBd3skeRDfJ9YXZK5DpwPww59gla4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lGy8PypP; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lGy8PypP"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c1372f84dso6195821cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 05:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787143254; cv=none;
        d=google.com; s=arc-20260327;
        b=gXrYh80zA/0f45p2+KTU505556xy/6G9vvZbaVfQvKA1OXcUEoeO+J5QbwVWZl8itV
         LMvfai66BmamnhwtyZLA3+UmiN8JXnHSbzzAaGB2jBfUtinBgd9uY8moivjv9LJQbqmb
         VBbHD/088cxjER9IWSe6zAYCcRgvmJynTNs2lY6EV6ntZ0bANph3t+acSSXxVNtU+kMX
         959bh6s0tu/tbpHxA/gD+79UbYSO7mYP4BOKJP49uffoqdUpm9pzXnJ4gJ9gGecsh/rT
         erjb8IJ/Xfv13evvLldTRS+UdBXX+/NB+CC0sziIXXcw+fjXd3j4Fu6v5f0Eibdp+0Qs
         xs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FMMCeXsWewqCqSlwRq7fpQsvaPxdERiuzxMm3uJ8O5Q=;
        fh=NpnEkye6iBJYEKapSlkJu6pmdVWzopKP1uSb4BfVqps=;
        b=h0VWCPWKVXB157y5f29oPnYyQXOPFFNzvGzGsPn33zw0TySf4SPRFhsTb1LIhmZxnX
         ugZWyHo0pjrEwPzDZ2x2RlPi1OIAW2fsE+nfC/eIcsjBR7ei+MUbWPWW4XF4IYkwwMQL
         WSJZp7VqNYN7n693Rwzx6RVWw1inShIXTankBsZgpPJinjfqmtt6PnhoIR3G90uAFyvc
         OBa8wx5bf7igHmLBYtA92VNTZW/b+VeR3qmtBf2e5qrWJUcGQU+d5y+7alR3ISze4dRo
         WPrbYxHdIt6v+6glSyeqdl+1d9E7RgWl32GR5ssioTzjZc+bRpopcjoj9ItaPC5LA+Dd
         axOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787143254; x=1787748054; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMMCeXsWewqCqSlwRq7fpQsvaPxdERiuzxMm3uJ8O5Q=;
        b=lGy8PypPc+pGZBoNU70w9RKP5taCKfx0cMspfl56geOb+wNf1Rto3P3CETOTxKq9I1
         tqEVnpUEJDBaTZSTQ18iv1/gvfp5DDf5co6FK12ZwFzUZ4WylnlN0nVXtcCKv5YjhRHK
         +/fs0MfmbLq3qIaFgIV956bH67ZvEX9lDbzgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143254; x=1787748054;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FMMCeXsWewqCqSlwRq7fpQsvaPxdERiuzxMm3uJ8O5Q=;
        b=QB89eHa7Xmlh2bYqN/wDWBYMwCD/8/wCKQQE0xsNsKb0KVTEh7aH2NxDwvIGL7woLS
         kBpIqkYO/eVz+pv6Oal91zekVu/wdIIeFQbNQcii6hJohPUAm9/axMlOdmDX62k9MEAM
         aUn0mFzqJyAXr6Zqii4bTlGopfzd2Mu+CFNkKURFOTI+aWUXmKj/4CycM8tyN5MaL3ID
         DI1MjoLRVJTwhR5yhqXajw0XGSC5OnqRjatX3sjw5MTSYorSKkYk96XBGslal1zJDb94
         lwKFyEcVmeSLP8eICdteKDdHRVS4rOUZIK+ym8g5xbkDOxQBYRTOeagW1mkl1OepAt2M
         w8Ow==
X-Forwarded-Encrypted: i=1; AHgh+RoupwvExxKuUPqsm5r2q2/P9cEG1kl0wts7N0BbXTnf32dYddx45zIwQS3RLARMfPYSgxfvNQ1O3eIYmPv8@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9MY7fPn0nzyzG8qIWw7iHyba302mx0gfjxsIlzXk6oAz8Qfx
	tl5s35f5FMiSnXeL0zU8T/RWF/kCTOzArxGmk2UhT2nVkoye8ljGpFFSbct20DDarSFLDnT/GNz
	hyPdJwvymB55srub9imlag8UUV8z14PMPAUbYF5muDA==
X-Gm-Gg: AR+sD11GXZWRn5iiA+pH+/PHtSsPGBjfxfKMnIguVqkSCeh2/77qtj4s1IdFESiPEyC
	cer+A5QSBNJRclCe20N5U6fW8CNu3hC0NvLp9p7w0+QS1Xub9GlimAVrIEyFbq6sw+7t9Ub+YfN
	VoGA84zrj/Hrqd0Eje9/h2tTOWFn+vtlg6abbVKpRfLrWI0kFhDWrVnsbAZzgsNfXpB4j0mKSE1
	8oEd5+EnOitPxRyht936ZXqmBYekljXrGw0+CKeMYejjytoK2rnh12QyGbcNE0ljtqCrYsHM2+A
	VvvxvncMgLx5JsXbvpLP31phySCyU80DXJZWBZMQLvU4PiHYjCHbIEeMFR5EFvEjAcD69ue6VKG
	UVy/qqY8NFIE=
X-Received: by 2002:a05:622a:1b23:b0:52b:4f1a:5ff0 with SMTP id
 d75a77b69052e-52dd5a30b5bmr38809341cf.19.1787143253813; Wed, 19 Aug 2026
 05:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819090728.3331501-1-libaokun@linux.alibaba.com>
In-Reply-To: <20260819090728.3331501-1-libaokun@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Aug 2026 14:40:41 +0200
X-Gm-Features: AcwNN1XgdaxcmflefGTSqkwgePG2e0069kE1y5nYemadtLfFV87ZKHogKFdV5KU
Message-ID: <CAJfpegvDNTf27Fcgxc5wydQ5SQ1EKZeaUadx11MZMYP6m+TbQg@mail.gmail.com>
Subject: Re: [PATCH] fuse: invalidate the correct range after O_APPEND direct write
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cding@ddn.com, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Aug 2026 at 11:07, Baokun Li <libaokun@linux.alibaba.com> wrote:

> Fix by reading pos back from iocb->ki_pos after generic_write_checks(),
> as generic_file_direct_write() does.
>
> Also fix a typo in the comment ("may have" -> "may have competed").
>
> Fixes: 2b0408d0284f ("fuse: invalidate page cache after DIO and async DIO writes")
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>

Applied, thanks.

Miklos
