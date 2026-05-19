Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BCD3EF0BB
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181292; cv=pass; b=XYuz/pIHzAGCwKBAuMj3vXifsmOraoSNwkkvUEfErWstRoFcJncNce68/ESkQlI6B0Q5yTBVDz5Ut9f5hALnLzaibCQORJytjmhRCXd0SASrFSnexY+KXHTpwzBRZGViCXU/K6mNW3yuRRwUx7VFSxvdHzEIImZeW8n8q5Uz9gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181292; c=relaxed/simple;
	bh=71YTs91AShIRqM+RzMh5Wuj+0ahof4Ja5sI1rjvb568=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjWD9HlW6sUF4liMUzUYa+UpyXDNasSfFjd8Dp/MGUhL1APRwll6TOurU+cOHKeAc40XHYdd88Hbv57DgXB05tBVv2mFMMDKJm8FQWmME7pc8555QRX30PIG28icbMGMnce4ugU4uxzyOIdDhTD7tYAjnCsS4ddBoQRFq3ETBzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=egiAG/Kv; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="egiAG/Kv"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e5c5033f6so30779261cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 02:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779181289; cv=none;
        d=google.com; s=arc-20240605;
        b=lBKNafWdZ8mGPteV8/MSshXgLd2cch5d/ecJ1bmLs8v4fIJ6Xn0WRsPixLxpp81b0N
         rR/2cEvo1zwW49OfBBdXTMjTemDa/+SeJMeZHUijHLhr+n38IFTpjoUWA9uwAUgWAHWI
         QTqTJMg6rJnUrAsNkUo5nYj2D4KcMpkABWJmWZlKxnYZpapBatPn+jtQbJ5Tr05E+Cbh
         FvQdHY5Yatyw7rn9+pu6epQhjyNT1j0iJLkWEmPJ58V/kylicv0iqIUVJ8CLBW8SFexk
         lFSrE/frVyuF66sr6TLZIQeQ8WDbZxTDGQsBY+GWn15/Qf5U86mrx6ZCqpNFv9AoC4ZO
         mn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=brclgwnPsvY2TI5Nbw2Le51G4FBqZeBYxMWIMJT0ReA=;
        fh=lPgFkaRNPoKkt/LMUKvR0ufoH/E5i+v1p8kxWbfSHV0=;
        b=Ro23eky97RaV4A0HsICu+6bLsScS2r+X6Qqiw8kgEDk61/sBD/z41ruwtqCDVxpuNQ
         ab2RfTHTFExcWVZFMRuxbkny9aUoJu0uowuC9CaVB1OK0SAmYd8k/otvLAhJesmh16xg
         sTCe4S8mQvjDN7jy1R8oVK1NkvcOn5pywywaQvLIKhfn5sQjRClfOPLhuUdtcAad2AxH
         zrsoo4KnFEkxPs1g0/D51giVeKoc15pSPMIOpEnZ1td6IUFX4tMnCUyaH3cpdS3YUAY4
         SYlwiJTuSu3sqakOB1eXO7pDOSEkoAHMqGwRckBlN0WfwtT7tFsUHHDMa223XE7G86R9
         SZIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779181289; x=1779786089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=brclgwnPsvY2TI5Nbw2Le51G4FBqZeBYxMWIMJT0ReA=;
        b=egiAG/Kvaazz4yZa3ubl/BbqqdeU4RqxgecFvA1pUd/GKbT+0wNf9zjvw1LItS+dBU
         doID1aB5taeRMvo1/+yWGAhThekStCY5w+I/xpd5+aTmg6GsN2CXtc/N4dVtmm7yJnLe
         AIrjaGdtPAfzedoVsmop+10tB2wRaZjCheiFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779181289; x=1779786089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brclgwnPsvY2TI5Nbw2Le51G4FBqZeBYxMWIMJT0ReA=;
        b=geVbnsLs6qWKMLdP1jUdMJNvAINbkF2eWnUkOnqpHDlU8fZFmmXXFI7JPH1DxNGRWR
         eHU54cvI0A82Zf73GXyCrLF5f9+lpREj6QbZ6EZ89vZkYBGEN4STlkuxgp3VeBU88yNi
         +w/UJyvCxa0xD0+N4LdycVBYu+xBCEdVIGUBc2MQ6rm4wEwbVHgMmMqO/K1KKoBlEBWz
         rdLYTvxoAiHCoTfetIdGLNIz6lrnTNn/ICCd67Ab3Cad0TMmq+7ofg6cm3p11TDJIyq/
         9GRp4KjuA6bPRFyYLVmcAgH44yoYip48Nyk3zKP2nGL/UUA7zef8GjJFX6mYjlKxpfOc
         8npw==
X-Forwarded-Encrypted: i=1; AFNElJ8RJy27h1i/s5Kp6iNuqhpfdvZz3jhf9zRmHaEI7N5dBpaDeGwdfM1WhVBw/bXBrBrn/Kasgpr5LGZG6Fzy@vger.kernel.org
X-Gm-Message-State: AOJu0YyjV1HYAC7yn5q0bAH8SX2M7DQtxeDzSMyXPh3GVWx6Whkpi1d3
	SucOeVHeOSWhB5s/Mq2sDh2U6PByJzr8o3mA2FWVpUju705YHSW/6mbNfFJjfpQSB91Ctmi8dV9
	rs6jn76mcaNBYjF7wAdz4aV/aMBDBnTRbdjGapDSU7g==
X-Gm-Gg: Acq92OELA5RR1zNeW1ovKLKdX17jSTLNthHKK3e9bb+HpYsext1UF6Rz07OULZenQ5A
	ifFeVtUZNs/etVesvHnWSR73Z3Dezhk4GPeJXb7PwiPtLxA3F1P0AYuVsBHahb6RqRCTjdTGN9M
	ml6ekeA/AU1VQyybL8Snfvn1pHnnEPMQhW3R17yC249p9Uh+7s+/LU6ALNFZ+c/OHveQ+qmsWWh
	A23/SI0U65+PdDATt9iie9X9XBEErVAgwstVNFCInC8fQEs/ht8eq+AQgxpD9NCh/Jn4WThbijE
	LxWNP1VDQalmxCad50HEi2861skDhKWqTsgCCfQtP9FqhY2XQA==
X-Received: by 2002:ac8:7d0c:0:b0:50d:7cd4:4a6d with SMTP id
 d75a77b69052e-5165a22c1aemr235062331cf.49.1779181289549; Tue, 19 May 2026
 02:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <20260512202336.GC9544@frogsfrogsfrogs>
In-Reply-To: <20260512202336.GC9544@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 May 2026 11:01:18 +0200
X-Gm-Features: AVHnY4LsGJ3qV09PcitXoBwW0H05KllqaSmlQMSmtqW0itEPLsn77ekk5RfHJ2g
Message-ID: <CAJfpegsPqja+MzfmvCE5054y9pv1_cwPRH2uGmFws-wwxJmrZQ@mail.gmail.com>
Subject: Re: [post LSFMM summary] where is fuse going?
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fuse-devel <fuse-devel@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	John Groves <John@groves.net>, Joanne Koong <joannelkoong@gmail.com>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 22:23, Darrick J. Wong <djwong@kernel.org> wrote:

> As for fuse-iomap I'm not sure how to proceed

I will try to dedicate this week to reviewing fuse-iomap, hopefully
without too many distractions.

>  -- in the long run I think
> it would be cleaner if each file IO path (virtiofs dax, passthrough,
> writeback_cache, iomap, and whatever we call the original one) had its
> own file_operations.  But that would require us to refactor the common
> code chunks from each file operation function into a bunch of smaller
> functions, which I think would sharply increase the review backlog.

And so the plan is rather to basically start from scratch and do that
form the beginning in fusex code.

Thanks,
Miklos
