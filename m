Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795185362;
	b=rdtvymvfGouNoP1IFob/wI/rKfWCsXVUN48mhPBGbkDeLFuXctV7Kj4QK9wPPnT9rC7G
	 6ljSf7RhSu9ulDsIk3rjZwKWZNE4g42sQMPeAIPbHZCh4xmc4uc1BQcrCZ0MKGpiZL8Og
	 tfMIHsKiyz/3s44LW8+CTNyVy47dNNQGOENsZItDRLDas5kj7XlqE5roB8sUiaLnul49I
	 YLu/UJHMUHuoV69MBf0nnfhSf7eQprJBgd3gXckCuzLohsNB7ehoSdGOrqSltrC7clqrX
	 394l6zQywTkjMkqCnJBWqhspFchGTkxwvd7IFUld4ugR2pKKfQzCTPWfeWndsWt8afA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5uzUR4nNL6/gBE9a0npJTMPxychcKuNTT6IfVRtsMA4=;
	b=0x9RB7ON/8ZkJaepvBp5t8Em5G8k2Z87hNzGZBT1326/SFCkVa73qpcVSenTIuliSSfC
	 uw0L4v5LCJd5TIzGzydKg2Ew9EwNS3DxmYtLzDR5/+hRJsTNu6E4h3ZDy/Cc7peBaR07Q
	 +V/bmwy7RQrZvG/ePaeH7+RdatxYZlbb51RyoODlTiE3Lj+TlBqbKeQU/nj7CvE01piQd
	 L4Efvnp0qx+98NkhxDnIiKcOpBSTeKSMDxSwp43g292hnQux5o0OMxEOZHwqeIaZLJYDE
	 R4D0Jvbwflt6KSGtAd6ceTVzQJGy4Ob206236jESY+MoqyLCBIeXL53ONyL8GSssCsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZmlktTxO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E63606A326
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4E63606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZmlktTxO
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b87408c797so1208695a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:36:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795185360; cv=none;
        d=google.com; s=arc-20260327;
        b=C1iQq1+N5YyPL6VUcUU1hKvw3fA1Tp4DcZ2DouuqEeTu78oiHMemb0WNq/Rtfb6vlu
         YwWM+djXQyQpcRD1f/jXlsAuBGbuvTeQcwdcXhi0LiB/+RsnKEjkp9b66tbFn1iMnefa
         VnrVKbezXZQfThHeSIo9IPJVm7qOroSrDolvUiJOZ+ErKD+8Wbpf8tjHz6XRHfGKFxAX
         0WL4hD6gbfbdaBI7g+nC+s6stePO2t+F0m4+R+OITJkVV2qIcRFIvTL++MW4BsCH5rJF
         NKeRrI7rqWLWbuaURCjTKUxEpMUVBTFFsjRxY//eDNn7zTVxPGHDCW5qhY0HgEzGvR6s
         kmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5uzUR4nNL6/gBE9a0npJTMPxychcKuNTT6IfVRtsMA4=;
        fh=1MfIR/Bhn8Allze9ZSpEokm+H1NFbhLFxwjWOKTmNUQ=;
        b=atm5nCRIiQS3qSD9PrSmbiBbrdsuZlGYIMgvW/GNs6ppP+SoQrNM5PoVZkprtV8ERv
         ndJUl7ompTXZfGao4Q0Clq0ypxHpuh2cfTSaE7gJJT65EAxif5CkEC4JwPdKQfDqgDE5
         kBIrCBiJy8Yldt5E5ylBErfbg23aITzh4g5OzTzq81uIl84XeG5Xf+yDrJf+JZF+hThz
         kdRtmBhE1Rgrzmfl9y5eCATdlKr23jW7gK4KGZQ4AXf/LHcw4BTHFBnZWGVNbCRNKB3H
         v8cul46WaHp6FNO1okVKQdiis19Cm9AqZDdY0miZg1gp31s9WgIg35TAX4wWlR8Als+t
         xBTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795185360; x=1795790160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5uzUR4nNL6/gBE9a0npJTMPxychcKuNTT6IfVRtsMA4=;
        b=ZmlktTxOJqc0gUgZkQM8tVXb/Y0XP5vIjBlg31tczPuc6Q95f4xzDo/jLK66eDcTRR
         yQXNy421kiJhT7oH9vLVwxVroKGeg4J9z03nrEStYvsVMA3xboXgWcwA2+JIMTGITaZ1
         038E81NLDLzYcW4o0qQ4SonrTGr0vzYZ8MzGW8HkM5d16we7L+/rT4b4KMUSsfEHVibx
         uS8nmmaGxZ1wTgmldg9y07wcPtmMKFly5bIu+HgpUAR6RPvU1IG7Ma4/oDa4cuosYPJr
         k7UPz9VVFyx4nQjmDqMOy5HZQrVCpdYWfBCELvWA6ZL08iBITG0L9mhiTPT1o4IF12kK
         cWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185360; x=1795790160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5uzUR4nNL6/gBE9a0npJTMPxychcKuNTT6IfVRtsMA4=;
        b=L77YJAMfh61+MQ/VdstlbqL66RWmfs2ZXQvfduA6zOSQXT1OZz2iUrnw9H5Su+3S1t
         xkeL3Qzxp0xG9o2XAzD8yIkk+CYLzwmh941T0qm1OnKJvr1dtww6KZOIASSfL0QbSrfF
         H05/KVRRHg+vVhi1veDtiPDY26VyuNiLvSINt9VqJwc1FFCakiOGR/3LwxcbVG6Hv5I5
         rHJSLv6eamfiiR1CoW8s/gPHU7WQUMPxqogSXueJGGPQOqu8PBRGdiWmJLFu+nWHGdqI
         urmxmyqi+oxUlaKJE+cJnOlYRiiIzZXzjnJCKOV/qSQG8mNFtJEYWFUWYRxtmm6crqGa
         0OCw==
X-Forwarded-Encrypted: i=1; AL+hErGVs84Di0EfqElo5qlxLZS53sj//iRteKJgXyjGYZluUhyP5zYu/FS6FMU1nlVW3b7D8HeDnAvOa8dy8g0V@vger.kernel.org
X-Gm-Message-State: APuU4Z8YDQVlNAdMSJUOeneNW4m3zuLDjJHVV26Z0SS8qIJ7ZTTU6GPI
	IF0l2Z/3NM4im054lurULE7wJSHhPewi7PyTgND0kuJF8K2c7YjNFsYbtCMCjaAhPjpT94iNPaG
	S6NEVWFuz8a4RfNx3TJw1cVISfaqk+bU=
X-Gm-Gg: AZFdTZd8tMKVhpEO+bRKisZy2ca2QzfOlMqSVvEz2D3QRwuRjLKUNo+dkuHYmNUVXhm
	PTZfY+4+ial0uHhuPTCvzujVwb9SFu/vo24cfl9l+mqlwHJJLSrIm8VtQuifN1YnHwu4N1qAnAF
	CoPvPc82dtACD0lcfLUGTaQ85Qzpm2re99850K+2zegms6o0PdBTbh6uQ29h2mNZt+9xkauS6Oo
	Lnjco/sHCJDr7v8NMAWCIkMwv/AzEGfzF1d5qMTj1hLapbUaOaBIbVoX1D7VTzWrr6S3zc0zBaG
	y/N2n2EeuS0dXRzknAGw+90bsRrwwnBxsWQqxpB2CRPUdh2dGW51NHw4FBaANRtGvzjGXcw2Uo7
	2w6voYo0Ub9ymjke0DJ6WCXVO899445c5gGvR/J0FsBtLaEauBSfe7Tr8+2weavyN9sX99g==
X-Received: by 2002:a05:6402:448e:b0:6b8:7769:ffea with SMTP id
 4fb4d7f45d1cf-6ba37ece3efmr2475801a12.45.1795185359456; Fri, 20 Nov 2026
 06:35:59 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <av4Hn9u80fs8iHZ6@dread> <20261119095943.85048-1-lauri.gates@gmail.com>
 <DMZ4VQ7SZ07T.29WMPQ0BQZGSS@gmail.com> <CAOQ4uximow25oc=3XEN1ATgQvonQaTXtDPmQufxo75tJ=e355A@mail.gmail.com>
 <DMZJDGMJ1RVF.32ES391JKNFGP@gmail.com> <CAOQ4uxjVQ9cjV=_jBjQtNg9zCuWUEJT9KNYMKV+1jwBkHen5OA@mail.gmail.com>
 <DN03LWNSDYP5.11FTQ5KCWU2X7@gmail.com>
In-Reply-To: <DN03LWNSDYP5.11FTQ5KCWU2X7@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Nov 2026 15:35:47 +0100
X-Gm-Features: Aa3M54oxXjJW5NIYEP5VP8q0nzSYgFKLfJAws7Wa7snJYDGBmmJmUUUXbQQ7PSo
Message-ID: <CAOQ4uxg0oq7VjhSQ0h8dBucdPfON2Q6tJQQqUy05sCaE10QRoQ@mail.gmail.com>
Subject: Re: Concurrent FIEMAP on reflinked files serialises on the AGF buffer lock
To: koraynilay <koray.fra@gmail.com>
Cc: Lauri Gates <lauri.gates@gmail.com>, Dave Chinner <dgc@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, Christian Brauner <christian@brauner.io>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 3:12=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
> > With non-zero xflags_mask, internal contact masks
> > can be used for -EINVAL not for silent ignoring.
>
> What do you mean by "internal contact masks"?
>

I mean that users do file_setattr() with a bunch of flags
some of them are just ignored randomly without any any way
for user to know about it, because this logic is some internal kernel const=
ant,
which cannot and should not be documented in the API.

Thanks,
Amir.
