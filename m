Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB0298CAF
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787202940; cv=pass; b=mmAgW+uxO54Nrgu4CwSoLx0jmqMEO6skZCajYL6IjQRqs1kBzHOm1/C2ScC2TnjY1GCmhtgyZTB/Rr6/ufuCfsVn7D6IGzjjeUduvK1UhOPJls3ZIGaJD2tkHf1thPQTtJOQZf1/kCGEg/ULnEf/E77QMJrMdPV1N/ueL6/dNyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787202940; c=relaxed/simple;
	bh=zTnTEoXTuFEFA/C1D4ThX4Y+an6VucxyKo4Nr/GlcI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4okeI7P35rDZJt7+bnyxIqOjhuVzDEJqKo4aXqtghYpLMYRY4NKaMtiPwQej/qEOb9HIDD+Mc6vCzCHsToafMDeQl9dezu7SqkK11TBxshPU0RoAKIgZ4wTFimX3s/1cEg5JIKhO+RyBBo8LTO7BStbzmLxHl3SU+tg+6fshIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pR7HueMf; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pR7HueMf"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52b6543169fso12423311cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 22:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787202936; cv=none;
        d=google.com; s=arc-20260327;
        b=dB/FXWcCnOBgYqG0nZF1Niq2xVQZDE+b4pWKPuiL2+d147srVehDczlx2A404KA4Iq
         RhwhIJ2+Ce1Gl/da7knLprh1D0CYzGt4/DLkAeA5DmS9vcIeRSiB1f2BfmlAH/SX4Uqd
         uqLGhq9/E0jdM0+M0SmkWFY/cZGURKpvKc6mM4OUcrs4kxDUUZUzMawKYS1PWJLDM7hr
         7C3+DMymC9ZSuM5JigpCbzWC/yjuXwE5Y5iOASCeMlHK8p0NUupZrHQhz7rNbNfYKkfQ
         bENuEJSRS2iRIi7gOsgRohuGKBj7EarWFMMOPzZ1iA0NLGT8c/oIeaD07U8Ezt/e42/x
         Qb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i1qzFHY4MADO+pKP/rYIVSKWuTq1hiwkVURcjqrdi5U=;
        fh=CAmv+v5dDF37XXoS4b1Jl21tonYjwaGJnAvMM9VRSj0=;
        b=LbWsx/gvrDADMW/a14BVBA+BFYtVQ4dlDRJZ65I7+QerSBf2iHhOLNHhGbRBJ+NaTA
         Kk9djbo9K2G74Z3z2u/b9REnlBi1rz6z8g1sTkOeaibndcVHSetin8n47ZsdoVoicqHz
         9/kKeOrhWPs6qj5cqOFVImG6JDST0mtJR+oE+m3VEy5Fj9K4qZIUjV19HY9ZGqMJqMun
         4CYlqgI/ENiMOude4oc/vNqF4q2+ISOxvAf3L4wkoDUZUHYjNaR+O7hnHmMi53ajpexR
         IrtUXHa18cw82eC+q+TSHEtKAOEgySc5C7GPBiCUGFsqlCGWKF+7DifYHcpAYmhAJ1Lw
         0q8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787202936; x=1787807736; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i1qzFHY4MADO+pKP/rYIVSKWuTq1hiwkVURcjqrdi5U=;
        b=pR7HueMfPp5SsP/6XDPqV3w6AakvsUCG6mW9WHE221/ExmC0JJyUt0eAXIvrBlIQce
         OaKeZJhSE6nLUxf6+5vvg44lt0DdRb4U0zCmhK/+AkGn5ccbepOfonR+P6DPnXkjCnYO
         sQ5S7Nerxn7s8+7Dlj91Qv9cdLg7CjgI//4G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787202936; x=1787807736;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i1qzFHY4MADO+pKP/rYIVSKWuTq1hiwkVURcjqrdi5U=;
        b=bvuWflY5OddOLvq0oQ0mMx7dOpL2qQ0rgExME1RmXCQkn8TJ1jq1Kh0tCl2Py5RrRl
         tthLYHDCc3gl8+3bf8lvVi0HDJewiSvk+e+uJAmKLv1GiVEtCByh/pPqDOUboTOkfEfQ
         3DkCV+jvJMqoQLdFvi5nhdo6uPvFt97uE6SfMODVNUp5E+vDdZCd4iLNSdzkhcUmL1lt
         0BET8zdgMcmMAUHrIlLL2HRhsC5t6HOJ/KpDfrpX1OLfqNaA+Oza2cGO/ZekKnjuNCuY
         unPlQ+jFPJZiUc2ewdx61XXySCFHVq0C2a7Iqdt8bvNpMxy2Nye6p4dlSOTth8ImfcC6
         J8Tw==
X-Forwarded-Encrypted: i=1; AHgh+RpYRZechbtboTT23uGNOMjZC5M8lQjWjgVCghdyyxfmN9PeelWGW2oxr4nhEcTvyOF8F/hhipHstFktRG4C@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq91BnInsjhKTOsS0bfxsFIxMwOHZkGm10ncvJAzViEwcs4s7L
	jT054WYKxqDfutDF77YDMqo8Qi0CORaRQ+Y2MC5b2yOU5jJQy9nJWERb3mriuuzKhoaH+xr42hF
	drS9Rcncr4pqjr2yWAMlPDpCqVIhHSNV2VWzbW2BAiA==
X-Gm-Gg: AR+sD10Hq8BRmfSziQMvrVBfbbzlE3eWP9Kc19/q6rEWxY8YaZjkUQAThr8q/IeLuCz
	abUDiIyzz2NY/wH/kWQ47ADOyPo2FfmJCtN3hKvDMGXMmEKtckwv81aAe2YNVAg2YuyEs4xSnDW
	90wXm/P4ju3rXVGhm8Qy7gilPfhyWMTeamhqltKRGgAhW2iDzGgUyTvErHfUzMfc3xONZuMaaFN
	eUgUbh9QOOBuHVjzXu1Mem07QlIbjVM2tRqtIrTcKz84RhO6phKms3g8aIG8wd7GFYWNjBpLPwq
	hAz9AiLjHUwAA454WQ/gyf4Hb0F4XSgJwxPXA1rpuJmyzKYOppUX5jpjFAY5UKuqtqBijPeUVXp
	5JgHb/KEfaQI=
X-Received: by 2002:a05:622a:608f:b0:51c:1e2f:1281 with SMTP id
 d75a77b69052e-52dd5e1114cmr96727921cf.42.1787202936231; Wed, 19 Aug 2026
 22:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717125538.508925-1-joshi.k@samsung.com> <CGME20260717125627epcas5p3f5ad1cf917d563cc061e571b2f932319@epcas5p3.samsung.com>
 <20260717125538.508925-2-joshi.k@samsung.com> <20260721030338.GU7380@frogsfrogsfrogs>
 <71ae458a-a6e3-4c6f-8fb9-7e8bc088bb87@samsung.com> <20260730172211.GF3556460@frogsfrogsfrogs>
 <20260819070459.GA1541@lst.de>
In-Reply-To: <20260819070459.GA1541@lst.de>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 20 Aug 2026 07:15:25 +0200
X-Gm-Features: AcwNN1XXT5xefF0BXUU_TM3qwY6KZTggS9AZTFDK2j8DH58mqjaIjJ16-hbRpyc
Message-ID: <CAJfpeguAkB01swoTKmqcEOQrej3g8yjr2RZSPQQPeo-4UE908g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] fs: add write-stream management ioctls
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>, brauner@kernel.org, 
	dgc@kernel.org, jack@suse.cz, cem@kernel.org, axboe@kernel.dk, 
	kbusch@kernel.org, ritesh.list@gmail.com, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Aug 2026 at 09:06, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 30, 2026 at 10:22:11AM -0700, Darrick J. Wong wrote:

> > passing through to another layer (e.g. fuse) assume that the third
> > argument is a pointer and that it can copy sizeof(data_type) bytes at
> > that address in and out of the kernel as part of marshalling.
>
> That is not a good assumption and things will break.

Right.  Fuse server should send a whitelist of ioctl numbers it can handle.

But ioctl's are a bad interface anyway.  Why not add proper syscalls instead?

Thanks,
Miklos
