Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9393B895E
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040864; cv=pass; b=NSRj2VLr8tasDUqV+9P52oe3ho1A3J8lKfMVMKYWD+xnBHuAjygQ+7dZhzi8M1wIA1fkMk13ealfdvySvrgItRZxcdogXJubSIR+42a1aOckxvcSEIwDMAuTNc1bQp67MhxFeAFRgvbICcvHwu/IKuHSlXR+BA0kExTJl9II1fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040864; c=relaxed/simple;
	bh=YgClOUoPYhbQ0CySk92iMsSfAE1Cl6F15iWg3ZabX2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV5qp35KPQsbS0Ha5WaRvf9bOt7N+Ku3I9hv83p/n63CSrN+VL+bth3AayAscmAQ6JLxL8Qg2icEzbYzfppQcQMh+zTKCvSizoM2CeK/R8GFnvaG83O/Hm5EeMSanRQd6xkA2TC8rBYkiGWGH5ShJaR8d5nFZ1PKCFroaYrkG5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=U6r0uvQd; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="U6r0uvQd"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50b4001af28so70310441cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 03:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775040858; cv=none;
        d=google.com; s=arc-20240605;
        b=FxhP1jPRCnSChfK50zmYjVqSRRGmEQdOW1r4EukgsFFrmpWOtRgEkVo8+KL6rhInlq
         +8aBuDJNXBIB4tTQvokvBD52Swpdt+EyuPsYsgt+z+cAo4/Ewf5RRMVFe2taZw4fjcGC
         X03N1DknB/Pf3Je43AjOpBqFylHkc6bUxaGPCAocNQZQFt3rQCB4QX1CUFkwJcx/9zve
         uyHtaB95LFxrbYF+761+oW15yXLUd10EiwfzWeJUIc+YRStt91ggKrcB7os4sb7qUHM7
         pqxzhSv5OkmNl25rK3MF63l2jULz2hzToCp2F650bUAcqhP2n6Dmrx1XzS7H7jnxPcG+
         nXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YgClOUoPYhbQ0CySk92iMsSfAE1Cl6F15iWg3ZabX2c=;
        fh=nQ04c0m7hU25nxqmLMYg8ACSj/+00IerUFfdxZ5rb7c=;
        b=hNULT2SEUKjyqkwIAS5hR2euL4C+r7TVMqsSjEm3U/t4sx3ztTNxGVt7pibVnvjXFE
         kzfrICMPntFQmsnbGfnxvqkdcfJCevGMJeLNpYIvZPNIqUIr84k5l0lc7K6wUFDNaqge
         4IdMo+lFdO7o49dxouJW0GRdzMvbUSMIK1NXZ+9eKsHdcP2B2l8b7qvP20ly/KaeINnf
         zR6w1+wHz11helQ3jcxeWEZZLUABuLFNRmdT57IQH7/R0p46vIiqvdt1l5vc/cN3AQMK
         tS7kKmtQnBBOxszqr8kBoDgJE2NHBGZVzRVQJkqQogx1rKwv3Iy2w6qNRbNAhPFV1tSa
         83OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1775040858; x=1775645658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YgClOUoPYhbQ0CySk92iMsSfAE1Cl6F15iWg3ZabX2c=;
        b=U6r0uvQdgkViYEytXgAWWiSGOLz4dwonC8L1KPm4XwfVyysa9cPIcA6d0UN9WKdG1v
         TeLn6Hvzuvc/J4pdPhxffUxOAxv0NVADaIxd8cnvG8UsPAl+VOOAdbAHORPnyS5+M/6B
         eqpzZ8bBU7hn+QOzA5ermJmT7tzh4427vC5+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775040858; x=1775645658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgClOUoPYhbQ0CySk92iMsSfAE1Cl6F15iWg3ZabX2c=;
        b=fR697KaR+4I2uIHS6jVmfFkdqDmBMTO7SbMlyD7e6IiN1pw44/Rj90T88yvetXpbyX
         w4KaQN89WZCO4l3vy1j9V5q1/4PRthzOdm7q2OmP9dlC+7PNG1gVzrWa2dWSvEwHuxrA
         Q1XYMRGruxGIccca1PnABZF1/Zt5/NU+/EqdRBo7OCIYykFu+AET9G9zlA6ushXlKXpT
         ltPfHIn+GEWFaS4wjPeNQ7rkBmZ7+lpxY4ns1V4v3qyFPj8fiWAyxyh05esBw8FhPaPy
         Lb5B3lQB63Upx0UyjJUxExZvoQ37VlpKzhURhVItURw9JHC1W5igcAQkNsdHnXNvibIo
         7zeA==
X-Forwarded-Encrypted: i=1; AJvYcCUs2kGlFrQOUz2dU4mlRdZH3Yd0xkRROFf2gixWkzsS8Oxy6m+qR/7ipoHsFcMuUGBWoVKhJ6WD4dTs+heU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4g8FgcQRvkGbhC8MPip1sZQ8kO+pER3RMEhshjBAYHCqLcF2
	twt4upE9Hqvz0LNpjAc3z2j0V7YVyhHUxoTwyDPIL0LRfQIDsBH4mirorDHUWDFobIOYOzX/w/W
	oUehOa98VZ7hgFGsVyihQFn3cA+AuLX7jreJUSyZmhQ==
X-Gm-Gg: ATEYQzxHHLt74O37TObH2aevNcPa9hgPW78o9XHSaep8FhRTJgRhnIkjcJxpJ4/eDyV
	9DRFO+VBvI5N23wmC5IHxGh0ta6USdBzTERiHPTXjGEAie/XPyF36rYbSwA/Pca1iBkzu0LJyt/
	EYanRAuUvPPlbzbIk5U4izj1JHaN0lvS2PICWg2J9oXPN1Jo81SUqlq4xRUl+DivPmEZ52W3jki
	U5O4fLOKqGceysSkGGKQfbgjwTl/PNt8diuGwxuHneO+CiVoX4AMLZPQYm7xNyk5HF3JWuYieSK
	KMlmRFdLjXzNzOum
X-Received: by 2002:a05:622a:a14:b0:50b:40a6:29b9 with SMTP id
 d75a77b69052e-50d3bcef34amr46029841cf.51.1775040858436; Wed, 01 Apr 2026
 03:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327-fix-inode-init-race-v3-1-73766b91b415@ddn.com>
In-Reply-To: <20260327-fix-inode-init-race-v3-1-73766b91b415@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 1 Apr 2026 12:54:06 +0200
X-Gm-Features: AQROBzAiI12qqZ1QUjBTfI8PhJoHMHYEG-ghARZ2Qulha0LQ3AqbrvANzx33uwM
Message-ID: <CAJfpegst9X9n=z6ssWjSNPKchEDJmut+jqaxi9SicJnM9jx4Fg@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: fix inode initialization race
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 18:29, Horst Birthelmer <horst@birthelmer.com> wrote:
>
> From: Horst Birthelmer <hbirthelmer@ddn.com>
>
> Fix a race between fuse_iget() and fuse_reverse_inval_inode() where
> invalidation can arrive while an inode is being initialized, causing
> the invalidation to be lost.
> By keeping the inode state I_NEW as long as the attributes are not valid
> the invalidation can wait until the inode is fully initialized.
>
> Suggested-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>

Applied, thanks.

Miklos
