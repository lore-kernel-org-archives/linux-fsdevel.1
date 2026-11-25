Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795625951;
	b=RKUj8kpCbsANSytPI2PIj7FQslsOoqyA92Vfm+yFx+uCTuAkmu9LYO2UR3yFT8B/eLER
	 Uo+A8FnLQ25IT4rNLDGIGbf956C/bDIaC+QW5v7srUl6vA/mJt1OuqLRmUGqDvzgvH59w
	 AjM3OlJRiRctgohJ30NIIvoJaywFdezdtpUyK1SJd24QAJvUMImhOFe6vqKfXSTB0+gOq
	 SkYc/m1B8ut7Jyb+SxMRMjhcRtrI9IeNZa1h+NBSAHEZ6ZFhIWipEHyb8Scdwh/VEEL0u
	 TGpUZVTYkJ1o/1TWpt10TRMAtgUixFPM8yaYDc+AdrL6a9uMrkZlchAH0cq+dcS3jcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ssqoSi76g+LtX30iLsvIWKdf1J/8p1hvBN52gnrjlGc=;
	b=iQzmk3XdOMIxo7uJexm8CkuAuD0sJ1Cn75jmZfT1n39QUzzJwvX4HfFINr6hDLfu61Wd
	 bb2Q+yUqmxGKFihusTBuDa/UdIcH8pPukgKURO0SyhWJ4OZUlZKEfvCKD+DA6OriyQ68i
	 R6Kx0sDL2vwTfcrVV/nzqNOI2HvCAcxb1gEGeIngOkQBWTZTKcUhoISuAzHxgntGwPjVN
	 GcWX9Mdg6nxB+sDnpLaKp2WtpdjLTlmPMSe/mUVHY1hdOQIKyAOaPpxb4dmBf2joaPV7m
	 VGIYDheJzfpQNC/frx6g06J0FvVD7Kr4SUj5vj7Hu2lymGtS4q8RgFAKgbyA9VPvaRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69760606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 16:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69760606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93a40a9a01aso816855385a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 08:58:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795625939; cv=none;
        d=google.com; s=arc-20260327;
        b=loSMws1SDKeYNfbmqGjGaqgGgVbgfzDbK/ayg8FrukEdCgNIBevMrDSIpUnry8meXQ
         Yo3URmQzb/gtWUtWM6/nwm406t/ZjnoBMFtREvq8jh0tKKC3iisIGM0qVAqSvfXnTXm7
         wUalCKb+PtRw5909uCEhWdtg2XnpDbOiCdg6bRxKk1znMsWyHt8Zz/aslufuiOuPXCxb
         7GT66E8sdok6ZuJ2q+LbkMOTmPKXx2yqHNpN/KSogIz8YYZQZ5E12Q5qEm4/4WTWwnXa
         6sABCoAAISIs0ANzyn+cExRULm6uyl9q+H6aVeT9qDrsVk76llQFv3l93LPc9x1qOgFG
         084g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ssqoSi76g+LtX30iLsvIWKdf1J/8p1hvBN52gnrjlGc=;
        fh=/uNEBI+IM0Ws6bjq6BjMeQ/WropqiemNaRrl+2v3DBs=;
        b=M04HvZy+OBIWqmypuSkHV5mSuwoUeOIkiXvWdk0WpeZwqdZL/aM4Xs8zj96bs2IVq7
         QFtjZKiY+wTaRqJrffXO+mUp03BT4sxyykbOPam8FTLhqgwRRdecxLhivzQWVps5lGRi
         cOeHQM63NuWY1+Hz5M8te97XqNn801DmvwiHNu5PGZkgb+MhqPBWfqgr5VCfrdkMt7be
         f2O8H1e6ctZCk4J7dWr1SBgHRCkdkWQbENg2L1xdpFSNtbzAUy1/d9tJqs9GMlfLOHj5
         ACsuxD7Vs+uEUFNnRBiPtASmIUGfHCpOU8ZJcZ8jLXuoZsxvNjKU/9Q/0xv+IORiZApF
         AuRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795625939; x=1796230739; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssqoSi76g+LtX30iLsvIWKdf1J/8p1hvBN52gnrjlGc=;
        b=L14WoLA/qRDg+CVR/tmUvT8uk2Lab7pJ07N8cJEF3gw3FrRc7pYROp6eRI9hl3cXXG
         RxRbw8kEjQqT2sVOeOTRn0iaYrI5Vbok+kzkZlOjQdo5roL87Qxr4UR0kCbTN6pX/QCp
         xagytRSAbo64M+PxvJe5RHFPApTKyOmlSeajE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625939; x=1796230739;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ssqoSi76g+LtX30iLsvIWKdf1J/8p1hvBN52gnrjlGc=;
        b=orhlL7lcErjWpcLSmd74qzUdIhEPGJ3AWEIl7UhLp9xw4uNmSI0miA3gS0Rq4zKVs/
         tPMl69NbS7aThIohSRQ+7TIJd/9IO+0Nr3eRo51faRCK2uBTd/vqGVzr4kGD7BQdYVEA
         oLrLWgWRR3UAgIWiOmUcJd8N7PtHWW7sKlmkaz48SDxWDez36bqg2fNVoZs5oSyEjT1m
         T5rwX/vi4zqCBOZQ08DGeVt/kQwXVkMd8X7YsZLefJBGzqP5XlvNincf+ItBC6Qr5Jtp
         8UCUtxxd3C/dBrtb68tBXaR2mOUpGKXjX51A8eZEY7RJOdyRiT8ki0i6JpRfcDCutbzM
         TDFQ==
X-Forwarded-Encrypted: i=1; AL+hErE6uq/CQb+TukMrBQicKesCMe6VpNKUJuUSFF7j9Km8onoPDKDiIqMhHBHldKtlRsvSuMSnzsGh+DsJlpaS@vger.kernel.org
X-Gm-Message-State: APuU4Z9K9QWv5wF0NwmPqq3R3ZKOQbYzZSsr4ZvLN34oeux0l/bBuZxs
	ueZApxxWLyIDpX0uyh+6rHxTA6a8bs58fKhu7476BgG5TRvQXIZiCoN+ZA7eoP7n5c9lXxTs6P3
	mezZlJGpPqvdITuu33WNnkXjrQZWy/uebCZx79ts9wkrefpiXLSCx
X-Gm-Gg: AZFdTZe8NSvcYUor2iWPuMplDhdLbyppWxYrdqQULT0PjRzZR2Jn1bGaCG4XXU2oqKN
	emWy7rewqT/VHp018dpGTf3OEUJ0Mar80ya5HPsN4ICvVkaVpPI52jLzOFNk7M8Ze87wfp4pvg2
	lNwRNv8Icc+hHAHahwfBEI9GHmDbdVcFItHb9qnL9ryShz5LUob8LrXbOacnSdjFxVXZMPu5T/F
	5oFugy9czlQ50jxqADzm3hNWVua63H2l1SmPgqaDTWB9JOFPUBDcRWgE74QBDLdgfSsGwi3t3d5
	JVfTw+6YDaT+qPGi5Hkmn/JFJSFprWXaJj6077tUBwlX8D/VPEPEYM09n031DB17aEVAjPY/Xmj
	7PP7fOs1C/DJjfp0urEXP9sCg/TOw/H/DHF27ai1df3qx/dA/yp38ZuGerbabv2+ef+wTPA==
X-Received: by 2002:a05:620a:130f:b0:93e:95ce:5394 with SMTP id
 af79cd13be357-949ba81953fmr3086387085a.2.1795625939096; Wed, 25 Nov 2026
 08:58:59 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-work-fuse-readdir-v1-0-44312add01a8@kernel.org>
In-Reply-To: <20261125-work-fuse-readdir-v1-0-44312add01a8@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 25 Nov 2026 17:58:47 +0100
X-Gm-Features: Aa3M54pPfuXZohQGDn5k0h9sL1sElbGXsBZCEsXt30y_HQ67RFbg9tpBWfdjmqU
Message-ID: <CAJfpeguDMe4ZooXec_djQ_Kv2jL4HNum=LvhUtA9iPrHStgnaQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: fix readdir with long names
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 11:27, Christian Brauner <brauner@kernel.org> wrote:

> The first patch makes the request large enough for the largest entry
> the server may send and makes sure we always have the pages for it. The
> second patch adds a selftest. It fails on v7.4-rc1 and passes with the
> fix. I also reproduced all of it in a VM on v7.4-rc1, including the
> memory pressure case.

Applied, thanks.

Miklos
