Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479733FD14F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536693; cv=pass; b=lfKdnH06zabMaAcfkrgrP9WlAGp7y93qwZUjDNGdPpf3BTd1QbAUnXOjcDOkSo0pw/uxjH/C4A1GZgU0bW0gcIrG76MH8dH1kwwSzagTEyK10/Z52bVE45nQAlMRc5iBEUJQ7nLo+krH/7Uh9W9HlNym0buktdMt/t2lzvz4kic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536693; c=relaxed/simple;
	bh=b0yMOjJYLY714twYY/OS/c4bj5x7P3H7/YVeCF3Up8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7FYMdGY2VFtNqXCuoi6WscYg+T0OLpGtpuOsoeqbf5wjL6ZnJUGsT0+qX4/pjTRVD8M+lXjOkEFiQWN5MCpiR+h7K2APxm3to4ltcebYvNBcMUX9pxy/8/Nu3VHCPD3PTd9KmJOdjgQU5BNmydqgJWb9422eMpFBMmApi/LAw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=P/HWCyPa; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="P/HWCyPa"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b2b2aa276so9547961cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 07:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774536690; cv=none;
        d=google.com; s=arc-20240605;
        b=EYeeVsX3XlozZcccMxkiPpkTJKgI5Zc4iJuRwfgqG83ruM/o8DcnBZqLenEPwW8oBU
         ocPCTejYNnajbQTJjcInaZplQqqbHf13AnK1H5H639pguwZ2TEFDt05OvTRmb70i/mxt
         P9TPJ7iytlVfvfTKVCZtNVayQYALujCGoQSZBNdSThTIo8z9M7y8msdlDbdM+l6znIT0
         fYK12PjD5yhkx5OIcWeykaXcY6oY8ltlkDJ91XRJvOlUXi50hLB5yj6dk9CSbquOtjdd
         ERQJuX8xbBRx3nTKsxHnI0nYxSl9AOLUCqawabVKZJgAwEz/sbAKrF3YA1lLH8c8a7uB
         qlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E7jKeSjjUyOo6W6SWg9UQKyAMu4Sdj7mUtRNcd2n1f8=;
        fh=gSLitDY5JczemUjg5uPxR3ePePnLkGNcZ35Eu6f6S3M=;
        b=lp8FgWFoUo7ncjxbptNVR02mtKyeMXnDVb7ovXdHeq8OOdMa15zqw/iBKOeTLdZh+/
         Um3ZaObAMJNKHFX72ugE/6A8kA3K9+UKLnmk20uydarXY9A//PfMSMxHdNe2QPsdlBQ3
         baRTrcJQTflEbbTxdPsjlG+vcojZvlC6GIKW74FaegEsGYVZoueD+r83wlZjggzQujDp
         0Mm2oDVaN4vMQHhNR+WfdvTFvLQhrqMnIaZkC8xqeuA/ximIg6MIQcsPjFYFUx2eiVpt
         QaVVTSQR982S46kmGA6B1HQbnkMaAD5srW5UekU3eFu1zIQmH+TQIBD0xgGKgujqIiIF
         lrnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1774536690; x=1775141490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E7jKeSjjUyOo6W6SWg9UQKyAMu4Sdj7mUtRNcd2n1f8=;
        b=P/HWCyPait8npIvB/jgkXwUQA5cGSUamrcoluDAo9Ssfgw26aISUXHjg9YIFZ4II/Q
         DlYb7F8E3fviq441o7WKFLj9sq2J77UZRtFuLurCe88dbfGaqO/qLho2Vf3NeXwPRfnU
         qTFOl2o6MGvZxXLbKE7bQIbXqueYeNJIzB5xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774536690; x=1775141490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7jKeSjjUyOo6W6SWg9UQKyAMu4Sdj7mUtRNcd2n1f8=;
        b=E+c4I+eoerJB5oOfLqL3lMjJSyrElDW4Buzu4RdsDrYx1ivvKPfm6Kj8zOeRUONzfc
         vvGRsWo7vo7ZrpsPV7eW/ZDOkUhpSJhyV6FDd+Y45XlE9RrznmqqBCmGjeOYJE4S412Y
         QegvX9zQTcpx0niZawD7PErhdrSJMbV/lBH7XE77YfTPKzFx0oMdfLPGck5m2cXkWE4I
         lSmhv+QBoxGSnl4qSbKR3UwF79bvh2I7BHsgDx+dHliE4XXSX/ekgtgUYZq9lsgOXsxR
         E8djfcb8A6cQ7YUut07T26BsnPAprR4cn4aexCp8G8X6oAsEDcpZfcV797YHHdeE2+AQ
         RG6g==
X-Forwarded-Encrypted: i=1; AJvYcCWmQgIZo/W3wFsTQ3hWmdALz1RvIP8w3daNiFvsWkYjTjIkOBPa3toZkbDK/mnjr6+IdaODx7Q8xJtjnY7J@vger.kernel.org
X-Gm-Message-State: AOJu0YyksFJjPQxfD2bAiYcvTIkzp9RSMh+oauncu934ue7lwdZO2/8x
	YFItp9Dm334kiCR06LcdJdFE20pbC3sNf5IS5L2WCSyghIpsAP5dgbopeGW1qTfIvtHnwQw7cr3
	cQkjk0ISAaOjgVWF3yXpsDXtmRM3qsM5S2YhJDV3tSEtIATJ0g5ZP
X-Gm-Gg: ATEYQzzoCHqPFWdPM/523s3jlDXXSRTQeK0Swxwug3qfbt0tlHnQ6S0gYdgjfLRgjs/
	GZojbTwWELEmcm3lwuM/z71qsGaZId1fH+TELAaQ3Mo1VFCQxwJCDGnGb6WQzxMvT97IM7kkCLC
	eqi1A1OarUEJODgCZoxge4lbHHVYuagwfLlqk24s+GHC2PMgefYlgljQLPdt//kXGxUt6aDOE8C
	HUpb7p3l1Emn0yf9eaR6TJHqkdgjSt733lr4rO5dXDLVJl6oLaRBv4dSu08UDLL5/emY6MJNSRf
	bs+wJe1VWTihxJSZYwQp
X-Received: by 2002:a05:622a:180f:b0:509:1766:2f4f with SMTP id
 d75a77b69052e-50b80e67188mr108079201cf.54.1774536689795; Thu, 26 Mar 2026
 07:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
In-Reply-To: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 26 Mar 2026 15:51:18 +0100
X-Gm-Features: AQROBzC2aUzOMKRBrJAW0CiIRmg338OB-qy1CcFy3D72_eaWFgh1hOsAIym_Vtw
Message-ID: <CAJfpegu9hjgwmCtM3xF6rjhY6jSvLnH+8wkr6a++RMPNDUpgWw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix inode initialization race
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 14:45, Horst Birthelmer <horst@birthelmer.com> wrote:
>
> From: Horst Birthelmer <hbirthelmer@ddn.com>
>
> Fix a race between fuse_iget() and fuse_reverse_inval_inode() where
> invalidation can arrive while an inode is being initialized, causing
> the invalidation to be lost.
>
> Add a waitqueue to make fuse_reverse_inval_inode() wait when it
> encounters an inode with attr_version == 0 (still initializing).
> When fuse_change_attributes_common() completes initialization, it
> wakes waiting threads.

This should be relatively rare, right?  In that case a single global
waitq and wake_up_all() would be better, imo.

Thanks,
Miklos
