Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB076347533
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395790; cv=none; b=hLnpfiOHAwFeEmsmVvs8TwIM1nEKT1+HkwLDlaVJzJXXDlycxG9Y4gm4+ksPDuj5g7hj1E1crUYbjEUTD+FHDoDJRCVP/vXT58NYNvq/CMRVlKBF3eAUIjf107xreO1xS5zQyBzKN5JxmTKaESr4rf0H3xJh5wu1LX+1aRT0m98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395790; c=relaxed/simple;
	bh=N+dPJ1vZmBCdqcpBIHgVg/LILATNoPcyjHWT12m+YNA=;
	h=Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type:Date; b=rwU9W5N1mGwSpk3ZQv/+/3Cda1F458cuLWt5mfwOQzzlvHOAUlvr1dTpk39dvPycNZWjl5tirzFM3u3UC705kPxVV2u9H/XazymMlGVPDfwFM10yB/kG0eDVxud2cJh16s1PQxdYSHaeMfxD030YEmo8uxvCvb7PXpY3JWUYKBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SCjpo2wH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SCjpo2wH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b613a17bso22169045e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782395787; x=1783000587; darn=vger.kernel.org;
        h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N+dPJ1vZmBCdqcpBIHgVg/LILATNoPcyjHWT12m+YNA=;
        b=SCjpo2wHH8zRpvauQIs3ZTGscT+9WCqcHLI+bMDV3p/uY9PSift7xcbEmisF6Bame/
         GdYAmKEMJS1lRBcxHqat/Mvjqu5gJaE11WKCvaOD6sv9wA3E2EgjnWrIRG5LBP0W7DO4
         kvHlw5QUvXjA7k5pU2SY12zllc/qKCiV0XFNuc9ng18Z9T1Rsjpms/CSATkVcgsIbGpT
         8onqYxDusiV6DPG0tkbS2oJLBa82NYID5ptVtpcjX+hRqM64jVPZHn69Rto0ybccBK8o
         jf++m4TQK+l4O7DG25Kb4atp/bTiXAql2CO5MuZ0j+fXzy3FtZ8mdFFbE/XB+mBXbbf1
         EChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395787; x=1783000587;
        h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+dPJ1vZmBCdqcpBIHgVg/LILATNoPcyjHWT12m+YNA=;
        b=NH4Z9+bL1rOvIFjM1lSUP0C8h+UK8p2ds3NMRwDy12dGaNpKeLmvPUizcopwtc0T3t
         CQgeQEF2FQZq1q6HUVTyCEgQuZToBPSlgqSwxm/9WgOwVKjQRjUJz9L7dtd/uTN+j94B
         o3D3zqFVAcgGmS80VKr5qtwzCTCGvWNHTKcmYPZYZ3uM31bRebTHzRscwQa9gsHw1cIK
         woa3WfA29VY7aXKEIfkeENHYN6Z1nLZwFS4MYYJkkBUAgSG9dlPBGQ4uCuEaYbaJTE1a
         +5hS8jTRuqpZMStrwstmzpLqXR4JPlzoAQkYCoAxugk9iY5AhyhtD97EH5Cbsb55g8/u
         3siA==
X-Forwarded-Encrypted: i=1; AFNElJ+oXg2GQn6ic3KPW7Ixa1+5DltkloxTO+qo+tSqq7T87NTBuK/C1O94UPJ/QisXrVVQt69JpiGPhD3tPJSV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Joh8YQy/Ho0QlRN+a72gX+rvasWQPW7WkKmKZ6g565Qo57p9
	bnxTsGV17iJT2fC4Bs8fuOuk6G4JuZsYExWp1CHCNXsV9pD9yniVEdeeTVYTkuia5A4=
X-Gm-Gg: AfdE7cnk83jCFNKTRIYQxJhPEPkQH3MXJmVqjbcQh+FawIYxzSQbB78O9hIlYssj6K6
	cTz3HBTHD9W/Xxp0d+EFqwtengnEiv5NFHx94TneshaYE3nyKXax7Hy3bW+rM7+nMxbE7P2Jnrb
	CMnquSntkwW0ta8Nu+mAMqhRoASPsfBPvsmtXg2FHz17qQyTe8CMteTDNQNOtzx5GuVIirxEa+Y
	XEJvlUHVCfl27LGXYLv1Bb7H/2T2JjBFxWlxsJq1u73orPrNRuufUvG9BmAYNw+A+Dm15ViiEE4
	PJpa/AZipIqVYrEU5Tx2UDe2zlyX6qAsQQqj+5ovrMKhQ28dhJ8B+sWma5BuHBQ7XmF2MGNa6wg
	uxHznw+tWaeQfENINNUVHvKRre+pIA6CnhT6hEfn/g0T9gLg1AxFf4efeUG4be62mkRn/KZ1Bo/
	TZE7sjVMl55rEDM1sUauiTddaHloPeOGEZg1rWqyr2xIytA2EslhzXXEJJF4j/mw==
X-Received: by 2002:a05:600c:e547:10b0:492:4c2e:9613 with SMTP id 5b1f17b1804b1-492668961fdmr26659225e9.18.1782395787248;
        Thu, 25 Jun 2026 06:56:27 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de. [79.204.130.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926544dfaesm45103225e9.2.2026.06.25.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:56:26 -0700 (PDT)
Message-ID: <6a3d338a.73de60af.14beb6.1019@mx.google.com>
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "David Timber" <dxdt@dev.snart.me>
Cc: "Andrea Cervesato" <andrea.cervesato@suse.de>, "Namjae Jeon" <linkinjeon@kernel.org>, "Sungjong
 Seo" <sj1557.seo@samsung.com>, "Yuezhang Mo" <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, jack@suse.cz, chrubis@suse.cz
In-Reply-To: <f6318cff-3c74-48fe-9297-368386b3251b@dev.snart.me>
Subject: Re: [PATCH] exfat: implement swap activate
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Jun 2026 13:56:26 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Hi David,

thanks for explaining your point of view. I will wait for other
maintainers to decide if this feature can be integrated into the
kernel or not, before proceding with the v2.

Best regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com
