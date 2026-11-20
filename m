Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795187718;
	b=EXJukanO/WOebXDINcm511qItFI1Cnu46qOZ6xjRQcGcC1ad+51mG7WGFGRUUrZeMhjv
	 UMDCa3CLkpMDh13nseg9WIzsJzatcMF6ROKnWG6SLTIBY0N5EKH8HqQiuvZvLxeTJ6zVi
	 KqIE1JiwWKdBo625+86grWP86BWbUFIHhKb+wggC+oDHbxpU5Dpico4ssyo6Qapx1DU54
	 giNLS/IDdlEGJB5EA6gxRA5J+XevyfEQrI0DjbpBHOXFrfBGoxSgsoDWlmPHYxG1QAo03
	 IQ5JSntomXkbnTKFDLeY8mpBt/YEs1nfom8v7bL18P48utVneG4ovbDaOcY+KIvGXIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+PMgx4pqXLlAAf284WBbeP+ZtkTL8k9uBtgLQ7cbjKo=;
	b=h5xU9Xhkqt/R6JEWeikK+9QinHorI917UuXrc0IZo20f95Uj4FscoO2mm2vKvFX1AG5n
	 pVD3nJNicXNX9LO3pOalVsXobnd1wQCB2r3X23Jcy8VUF7bXvEx/YHdp9wbca3Kgrat14
	 m9T3V1JAyaIvJDR9FJeCLrc1UrnMX6gD81upQNKKQzxaVGZ2dIvNkfStQkb99skWX0Loe
	 A6jEKwa8qRdBMXd3ZuX9eed1EQbErms4HH0CHjbFRiZpE3AyuchRR+8ExIFR7HpMPNamT
	 UwyAGPTa/S753LF/iOP2Mu74oJZitWVKLj+JXXKrvtsvbZ+nBmtZqLqStwEmWyd9e9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WB6veaaT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9676606A339
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 15:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9676606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WB6veaaT
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b88d143160so1224794a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 07:15:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795187716; cv=none;
        d=google.com; s=arc-20260327;
        b=ICIIZp31M9kOD/td+WZS5KOCA9uQ0ox3Mh/GfFubXSoBr8MAhYC6AJRQoiBs/vafCc
         fGVMyklNNWcPH/pwxlv3g8nDhLvSainBIbddyT/qHJAHHu/cyGq6boZ7V5pYlyDSO6v2
         PZ12uMW3xNJqNx5VtIj/309y/5OUdLaaClhpJLV0pbVSRLFSQtuGjIf2od4Jx+M/xTEm
         /cXNAKnFhhAD/r0D3XzuVs6sxW4rfS4TekbgrYSdlFnH60o7ynhI0Gm4mdGTlesGhGra
         9LmvCdDRFACtdSbuCfJzm7SHX5Jbdw0oL0SCHw72ifRbMS2juZjbTNdYYBEIBHRVuxgu
         yPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+PMgx4pqXLlAAf284WBbeP+ZtkTL8k9uBtgLQ7cbjKo=;
        fh=e/slzFqrsIzwKAmKGtPZcsNDPxHj3IZc+uiNSNFLXO4=;
        b=MTe8MHSfnzm3YffQAExaOGkiXU5RimlzMYw7LXLU69O/HjwkKvAR/p1ZKl6LIDFCt7
         VxAMkOYyaoCM7butIdykoNhZQpehePeTho9lJtJqtrHqSOKIod+mPcGXMmmFfOM99I4S
         KBZ+d10/vxSxAc8knadLEqqTrDHEiwTAraixnzwmmqffUYW7cCKq5TAM6K5+UGwxasCp
         Rq6qeZC4791uv5wrdDhWs7xU2MSBydINbSUk5ABxUhn5iMhk6Pjqh9GAHZaIRK5zCCxI
         cmnDEkjyDJU03P1NpZwxYqiexiAhfJGOXhkk5sq8U1tXgBCrWEZPTLAFx9m5/wkp4c7f
         kfeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795187716; x=1795792516; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+PMgx4pqXLlAAf284WBbeP+ZtkTL8k9uBtgLQ7cbjKo=;
        b=WB6veaaT7RD6KXcb4FqtmeXHtv5W/X9xGJYDEGOMSVxam1yIpCuTjCg5pRiQbqFjMZ
         3bhdNk5JPtVQQmso9lVZDuxFUviFSzN10ptFZrUkaOA+9sAqTwPVQ6qaePSivqT+NfcG
         p8fjKrnua2EQdl/GVeB+e94SAgIoKUy3qBJPd/c7SnOwTY/nNRsUX0/bmzwkWkI0VJPB
         dnX/nSPgBoj5BRjUmSR0ANL2F1BhoLtEswxF8nyzPqYmpNUoYn4CRGquYinQtxscBMHH
         w7QqMpYAheZcTRm328UP0sj8yOIpaLIXBgFVj99wv1h+CB3Sp0ppP0+wjqraXewczOLe
         7liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187716; x=1795792516;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+PMgx4pqXLlAAf284WBbeP+ZtkTL8k9uBtgLQ7cbjKo=;
        b=1qvCWFxBxnATbfeyZN7GcXuqTlQWIjQ/dcJNZ3scegQuxhTzQ3Palrf58DrPN/1Yj+
         e75NN/R/bDC7vYsXIzYii6fgQcRVaKNExuLIDo7xscNr/zcJETcll32aQFe71aLtcPmG
         GP8IZPjyizpw+tdnVQNqkt5rq2a7t9pWagzI+BzJxyRMtv8PLhFyy02dzRsm3vOSWu4G
         qEBuPkC7Gn1YmRa/dNFUosqqUL8u3Sl+z6WrcDhtObtIQD1bHExhrRsg/oSUCmC++dK4
         vJc3B6sD97V8WQ9xfzEkE4B7BhnT59I3Wh1MjsU0kLMJRORILw1ntLEiuHPQ3IpRACvZ
         Mo4w==
X-Forwarded-Encrypted: i=1; AL+hErE97B2OkSN1lHscSuFYb6sHnsZUzl/HMlaoMNXu70VpoiF10q1tMeZ9NsiBdsemz0IZJP0l5TpyAbwOnjaJ@vger.kernel.org
X-Gm-Message-State: APuU4Z/3K0/X5FWLjNXLOZtaFMWqL5i7LRTkOP5zs5qUXznaWcrVtW8B
	zUuShjmmHZuAs2OTunScoRHO2sp4GnV/CpGqIekGMcZRFbOqlR4nLnQVqghw7iwKfBsjOnw/PNJ
	ovz5QCCSxkKhC05TWfJg9bkmEzxZj03E=
X-Gm-Gg: AZFdTZf3UZRcbZcGeSo1oJpP82FxieRq6z29kwjeQwuf41988hyQHmCpZRM1i/gN0S5
	hXver7i5JcaCOs68ay/MxNSnFRk9QGmogcktXrZf/1MGafeHKde6BTFnOR5gdW8BS8BmnWbIJ/V
	+2wbwmBb0QIKY1KMOaj976abDD5tDUFUuEBmxiYjRbL64ThoAZ1kY3qbzctvPQF4xl1fun0DFGc
	GGTmBnGQJrpqXDkzMrZneOotXQJHFss2CIG1ob7AxdOwbddYWSn0rWU0Ec5BN5VRI3porZoh7g8
	J39y0UQ9eOXrfnoobynrRRUckxM644yhh93AtVI5whssPDWJQOQu9JGTuEmjhpu8cgzEWoxsoHy
	QDuM6qABihHDrfQVtwp46sworzaVGT9rSOY3Dv5w=
X-Received: by 2002:a05:6402:5516:b0:6b6:ef7f:600d with SMTP id
 4fb4d7f45d1cf-6ba37e74244mr2491665a12.21.1795187715950; Fri, 20 Nov 2026
 07:15:15 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFnufp1LcTCLtCrd=iLxD7DPaOouov=BW=Scj_yXJ+Pn96RKLQ@mail.gmail.com>
 <20261120051457.47753-1-dingf3ng@gmail.com>
In-Reply-To: <20261120051457.47753-1-dingf3ng@gmail.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 20 Nov 2026 16:14:39 +0100
X-Gm-Features: Aa3M54pn-HG5H7a41MND4h2x3VzprW_q2-HWoQeLPusNnhR_Ijaw1bfAmJZdQ8s
Message-ID: <CAFnufp2Tp8x-wddZBpvzFP7brKWU_b9A2kFN=84x0Qy8K9uA6A@mail.gmail.com>
Subject: Re: [PATCH] fs: fix overflow check in rw_verify_area()
To: Ding Feng <dingf3ng@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 20 nov 2026 alle ore 06:15 Ding Feng
<dingf3ng@gmail.com> ha scritto:
>
> Hi Matteo,
>
> On Wed, 24 Dec 2025 at 00:28, Matteo Croce wrote:
> > Following a discussion on the coreutils mailing list[1] I think that
> > this should be fixed differently.
> > I'll be back with a v2.
>
> This is still present in v7.4-rc3 (65e4fd942). On a 100-byte tmpfs
> file, a read that starts below LLONG_MAX but would end past it fails
> instead of returning 0 at end of file:
>
>   preadv2(fd, 200 bytes, pos = LLONG_MAX - 50) = -1 EINVAL
>   preadv2(fd,  50 bytes, pos = LLONG_MAX - 50) = 0
>
> sendfile() with *offset near LLONG_MAX fails the same way.
>
> Are you still planning a v2?
>

Hi Ding,

I think that the only solution is to create an helper
(rw_clamp_count?) which clamps the value and use it with
iov_iter_truncate().

I'll prepare a v2 soon.

Regards,
-- 
per aspera ad upstream
