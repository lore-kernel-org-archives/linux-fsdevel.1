Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51F4156F0
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471934; cv=none; b=qv+Ak/SzFC48EElsMZmTjT+jPutfAXaZ6q5s3CEE2ZLz/MR4wmrJg9eBIDlg5f6W3kcBnaq3uryPRNEoQQ7BWmIYx4okG1pwCbPGtkXzMmoFPikWPmciIUN4HpSAsk/06rWEBN3UUo6rcjSFfzE1dO8WYUvimBCSNO5ziOwyEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471934; c=relaxed/simple;
	bh=IhQH8rXDBJnnCDiNzjUrT9gJ/kgPuB87MEOyHh/gTqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amVR/KmUdkUCTE0WujAxbBp3UiuOFOSmHDoOeg/OJJpBCft7KC2bBGx9ZSXy1TnhUbALn0xHVwCI7XdtkEvyJW5kX5tJQyn0XUkPpWkrHny07Hi+pVmEQgu2C4tom1P3Ke9KIt0pcT3vUYLmkYfMsGRpOgVG4+6YGVuCixMirmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net; spf=pass smtp.mailfrom=bobrowski.net; dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b=Ts4PUw1V; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b="Ts4PUw1V"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f01363so22469605ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 04:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1789471932; x=1790076732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NRdFWvI5Xtf+HxtHvvZT0bDvI1yyYtPfHeYAbp/3rHk=;
        b=Ts4PUw1VrKr8oYKDMT4/YF6EXSiZr6C92lryHPbx4JqE+NjKqQGxH/b/z/BtjNhHys
         v8/vB3vSFK6JXdWD/slhN1OwouAhXHxuxfQNi86JHLf0MaEnjIFYvPUdYYKx2UVJOMa7
         ZxTydJifoxchWbxplbRfcgDFWBBjWll2bJHgFbjdnN5xvQ33w598FL4E1aaXrzCRSllV
         KBgnLasROCIjc7fc5p4BZj+GHi6lgz7ZpCgOXtTPYzeQpDDwc40Nl5Y+n3Vxau6oXx0c
         ne3SZ82S1Sv5cOdSQRrRmnlvbWbwtPvzuDXbg7+FcE1lqoZRdShRZEhIWc03YH7Qr2JM
         RgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789471932; x=1790076732;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NRdFWvI5Xtf+HxtHvvZT0bDvI1yyYtPfHeYAbp/3rHk=;
        b=hqN6B/8Gs6WuXOOOU3RhPPn3BGSLX27mxnjLBFhd9W7+77gtlt/rJaV56Q2XKf8+fA
         +kP5SFLa91HfXv+UjtcrtN/dL61lXODdrzAz8GP+XCSZTJjKAUYpXQixiOSPbBjENY5S
         hYTyv7srY/IFxYE+3GI3/IyebK99wPHhhSq4wTaxbVUMdDA8Kt7otHAgzaeV5bVhLdR9
         HFr56E0LnNbFYjTQFEVB6eukr1jr8wP25fhrsa3msS/ukldbkuPuAcu2iRPmTRDJlrII
         CdB2kdS/EXJMNQOzlgjUlYMRgrc5jLudv1K+NEGUMRCmLzR6Thh7xyGDQ6TZIfoSPCOD
         CZ3A==
X-Gm-Message-State: AFuF++lCLHZ4d5HSlSsqVPI06Rl87lz+4195jsiWVg56usyNT8xAJKmG
	Q7jPlAYGzMjGZhX8wYP7eim+9h07VI1xTlpx7DQY5ctF1Y1lp2oc/n9juIAyt3+z6KZS
X-Gm-Gg: AYBFou33HS+ni/SKfPIycldtz7Aa9kfmu8GTSwJnWHgHuwWKVpJL9zM4z+XY9OWgTH7
	FS3lb1NT4eiyD8HNqIZkrDfIYJGidBmG58aVVQ2avuh2Et02UhcrkZ6sJCd5/IQVPrJEL1Awvpd
	Z2Re80/ho2E+hChzj+U8xsOBouSAGzd3Gpwh6FnDhz1vFsX1cnG5FriLoZTddd7FPkX/URojtaM
	7bVnFx/DTEar3OobTC+kVLuFmEpZ25WT27aadgO0Ba+gImxsgyvay2oD8NfRIhWqF6EsfVEguRJ
	ronfCx7/QYbFgYmmy3lKbTgTOW1sJvyEXOZ/Rr6PKOrHvvtjGPMenYvh4hf4CFX54O13XMOYrLy
	7NR5TfMlNqLD9l7KjJ4Tx9hLfqySJ2v6EEAs41hof5AMvQ9wu9NcvXBrATem3hMV3D2j+t0cFbE
	bA7FAoh5AwWNxb8tke+6pux513J+ELk7guUZO0f0YyYqJx8WQLkCXUyEfSys4jJulEv6fMkjYvB
	fGB3U3SDgYKs8VUdGhq0nTNNv2U
X-Received: by 2002:a17:902:cec5:b0:2d9:484:861d with SMTP id d9443c01a7336-2dd6c6ea2fdmr126626625ad.10.1789471931973;
        Tue, 15 Sep 2026 04:32:11 -0700 (PDT)
Received: from lima-development ([120.21.204.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ce959a4sm66724695ad.24.2026.09.15.04.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:32:11 -0700 (PDT)
Date: Tue, 15 Sep 2026 07:32:02 -0400
From: Matt Bobrowski <matt@bobrowski.net>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fanotify: Re-add Matt Bobrowski as a reviewer
Message-ID: <aqksshysCSPhDbhE@lima-development>
References: <20260915094719.2034706-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915094719.2034706-1-jack@suse.cz>

On Tue, Sep 15, 2026 at 11:47:19AM +0200, Jan Kara wrote:
> Matt has resurfaced and I have his working email again. Re-add him as a
> reviewer since he hopes to have more time for that now.

Thank you Jan!

Acked-by: Matt Bobrowski <matt@bobrowski.net>

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> I'll merge this through my tree.
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 627595e245f3..6b698f8e52e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9975,6 +9975,7 @@ F:	net/core/failover.c
>  FANOTIFY
>  M:	Jan Kara <jack@suse.cz>
>  R:	Amir Goldstein <amir73il@gmail.com>
> +R:	Matt Bobrowski <matt@bobrowski.net>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
>  F:	fs/notify/fanotify/
> -- 
> 2.51.0
> 
