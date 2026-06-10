Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E335331EB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094985; cv=pass; b=UaG6EFEs/5XczPlqGUQig8bO3ROyqqO8fqXPVPH8HGN5LE3ifSrHz39o5uVkY/EjM2L6RwcxEqwKsS9QWJ5e0eiuvwmD58B6eTYpBAFOw2zcED00uQjv+WWA13Nk5/wj15hPTGlU0FazfFxdzvsrnsrb93OnM+1IfFqgjg0C58E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094985; c=relaxed/simple;
	bh=eYQTgSAJIduxJqr8HQKf0jhSy5kJGeilzn+gDMaPZJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc9aSkUmVXEbyncUQUReUcGXoa8OH7dmVvMpqioKXahrN0OnWYh+4Wyrrr3Wsl1xEHd4g2MlZDYBI0DS/bcLqnxw/0IphYJA1d/3ac6G+2Uu9tplAa62FQWaDouH/EGhtYLaFssi4wouSdLswqyQZrZ60Oz7za010nPaZIro2nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VdGD0xrM; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VdGD0xrM"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5176a2fd597so55614441cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 05:36:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781094983; cv=none;
        d=google.com; s=arc-20240605;
        b=LqNyhN1NRsK9Nr1NXY99pTDYzO2mb4shSnI8Yy6dzHdO/GlYjIrZNDTHG+ScWAZpXi
         x+eEOIEF8sLK8OWqUStxqRzsMAonEhbaGP5NHWQSy0Qjsnffts62FwaVJYJt2+Op0cRU
         Qcz7GD1WtJck9jnboC9DJlHCaTGA9godv/9EAihyEmQvYjmrLNnembmsvBPUBm20wG2I
         bTRuKcaltgcU6SV1ewufx4St3MjxuGJaM3VECzCNiWJsLkiYowISl1tP+H/y7mlixYTu
         p0kAZ9h6jrCt/DCjKGrTqJ7WOYW8RKNSEHsKo0DM1zhH0tVc8vYw2XN8ssrW2aE0dQRc
         Dxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eYQTgSAJIduxJqr8HQKf0jhSy5kJGeilzn+gDMaPZJ4=;
        fh=Mbky4q2F39OS/YsjanPMeUyXfSJOGifFape9lUj/fcA=;
        b=bnslXSUa13MgbQ9moAadglrSCjmaEhDLFLdN8w4SE2ihiEzflzZKTVhtgQiOdW34CG
         KIWkNKLtq07FLmdrC3OJrilbaOBQmAwN6Z4qTa2Gj4W1dN+SRZJdP8djyq1oT7i1drCO
         byN1136yslcjID4/F+jr8r5mNzbTC3ESraAtk2dmk2CNC7/OjFY0h4x11DGUVzxufpEq
         RfliWTk+KeI9KWffhyJp6vE++3iEAO7osMoVQI72TT2elvUXiy8yz89apGU/wZObJk8f
         1rzEmS2XlNABkMlrGtelMJJAaqKxq62c16Sg+EjZDChnrYospBQTiZgZSxuYdOhHbc6k
         qiIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781094983; x=1781699783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eYQTgSAJIduxJqr8HQKf0jhSy5kJGeilzn+gDMaPZJ4=;
        b=VdGD0xrMb7kwViMXG1GYVN9BOfhVO1vWsmhbfws8VSdxgVYzqTJLMruWEQ/DCRh0+H
         yDo3ZmDSLFcnrvoQYOUBnbjWcDN+6jKVSavpZON3ZXcW51pUk1BLXu6sPIzdXLt4cwMi
         3xmU+tmPPIyZLsrtjPCIV7Ml5uDpQ7jKbNfOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094983; x=1781699783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYQTgSAJIduxJqr8HQKf0jhSy5kJGeilzn+gDMaPZJ4=;
        b=nAdf74qCmvZcg6KBRFa3WCFtCXyuRpIP3RfOhE6mg8NSbndyPKNEEPyXVFfWCLjmjc
         b875bMdQmogYlZoHVklnEqwesfk7WDaumN1R3g2EA8+6xvNUie8GbrbbqyporYRM9wXF
         dU2ysQGllf+obeKB2LtZ8HHTPXhWDA4HCYdrAq1gX9bRodHyuTL0pSZ1js+mf7/RSGC7
         nGVhhVz4DTcxWbLh8kKCvvECNDHKJt25lNRzs/mLu+qOBmsFawGzHW0B4T7dRxSPSdS0
         x+YSAoXHFKAcfJPt5kRMspkcgMF7d0F+SpENwBfveC7W7b1nAc0alnmWdMKEMAq2qGdW
         xC1A==
X-Forwarded-Encrypted: i=1; AFNElJ8jlQKcYb6elWc5dpLvKW8wEtTgNEer8cJXhhBBI7M+p26REdfpIfmi1UtgCvbZNqvDrSIv0wPd3mDSJvar@vger.kernel.org
X-Gm-Message-State: AOJu0YzZyiRnlsGlmyktkhkkYW0xX/qJD8ExTgw5XVO7CXePBwiwjfFV
	Mo5ZtyP2fLnK8Koom9wEoBTD0qzMctGiSojYvCfb1bqVSJHS1dE5idduL4RRGu9UwC6W8+fUGXJ
	tiOlS4bI89xczvQKJYFy+nETif3fkechCqIBtu1fQSQ==
X-Gm-Gg: Acq92OHBUInKYDCV4+sk7R/H7mq2zahCGdLKaFyzU9raC7Mcwa+Bvo8efCFfp/BNYeE
	u41zZQGUFns+lPKZHCb9b3DJk9YJQU7tvC2cdwtW5MvLdEaKiFbR+aluG1XH6hjndlxB7cw28qj
	HCf2fSeTN5p9Qy5XdO+PTn/q176/L0QabuVmoaz2hS0JS5XAS5IzFQFoNLRs2YuwlXGzyzg2lox
	PrsVjF0gfq67CbMX6kS2fT2awh4m25lnrV5IRKu6prcOXDlgO69MkbLrl7t0TORaIWiymNQBUqm
	AHS9oNIHE6DUPafJqjI3/AZRCMoC/fTpQcpNlwgJR+6UTGvBdZk=
X-Received: by 2002:ac8:7e88:0:b0:50e:601a:2183 with SMTP id
 d75a77b69052e-51795b4ede1mr378685771cf.41.1781094983096; Wed, 10 Jun 2026
 05:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522065421.385129-1-liwang@kylinos.cn>
In-Reply-To: <20260522065421.385129-1-liwang@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jun 2026 14:36:12 +0200
X-Gm-Features: AVVi8CfQmsnN2yd2RJlQhQmmjx97VvqHUoLywSCRtX0NSUXPIjK8NUwTawS4j8k
Message-ID: <CAJfpegto2-86wyVVYB2iRz4ftG3R-5Do1kgg7CfHF-oxZu6=Fw@mail.gmail.com>
Subject: Re: [PATCH] fuse: drop redundant initializer in process_init_limits()
To: Li Wang <liwang@kylinos.cn>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 08:55, Li Wang <liwang@kylinos.cn> wrote:
>
> The local max_background variable was declared with a duplicated
> assignment (max_background = max_background = arg->max_background).
> Remove the redundant assignment.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>

Folded into original patch in for-next.

Thanks,
Miklos
