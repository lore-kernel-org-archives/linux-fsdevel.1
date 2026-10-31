Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.201
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793488475;
	b=tAaqKdTQrIrK6e8z+w3OD/MuDLu675eIr1xkCEfTfhiTX+JBpUHScp54jjjqgrXdRYHu
	 qVG+ojibxsJAkhdZjNCGifNTVSMqn9wJp1Ft+40eKRG0s9+fLTRRLlt8Lr9z/hq+Io9Ac
	 vOZ4KbK49hKfGQlJ+b5O/keNwugbTH5UErtcUF4sv49gSsd3NP4sKg1oJBIXDXJt+k4VF
	 9c9Z8X5Wjum/adhqwDfxTGvAoyKHOsUpsOI69bxGzMh704rRuIVwCu9NG9GGnt3a6TUYu
	 4bOmXsSJsYn0wRNpqZGcSUpmaWlGqN42lovR+YWNLGpP1MLQ5prJ/2TudhQc294IDqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793488475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=b5ulenXHumJtq8LULulVlEQpUa3RXUxrO4E8u+hYZGQ=;
	b=VxlS0qwVmpwlgyEwz3eY7fqPvxB/MQPPJb8Hp8dtsXN3q9zAv9eWvLXPJwjmuLjAxveD
	 V5fxvYXQmxrVAMfig9LXELX7JdxNVXmMPysegbpdJER4uAtJydBe1/vDP73heHpnNxpq8
	 zyy7XY9pf/I8WkFUfZ4z4rWtaUYz09//pPT9NFIwA7naCL7GTih0+bQ/JdV+902JvQztm
	 +ZzeSTeyPGxx5NOad39mFb6W1c+31YQx7FA9u7E3GHoYJS5pPjaFJk9OrEVS61+By5XPx
	 HssxaRsVMX26Wj4n6qKR/9KO3LPlGM5omW7HpUSDPviDMutQmI3TnIc8dYCYENKj+Rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Je9fUjsB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.201
Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28BB606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 23:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A28BB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Je9fUjsB
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f47feb5a15so346449b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 16:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793488473; cv=none;
        d=google.com; s=arc-20260327;
        b=KNoAA5qKbVr4yKbhvzmv4bovOOWzXVFQ5fwX2Arr8ECM0o6lekxRRmNKTQgx5ED3hH
         ujpZ3+jVVAb63ikrBibJ+WX/UfbJNedUqax/eFGmQt22eCWtFyO5gPWyZDxccPgAPBah
         UbDfvqZEKViRkRw3hXroBf1cEDlhv/jCPHfj1GhKd4Y1Vb74IWYQf/QXk8a6d4a2imEs
         XkkwUDXAWOyIpXreCNGdDGIxcTGoMcep+b/+mNgaNJ0QAJ9VPMyEiFStBdHkFSr56wdd
         fx9+w0swIk5kvaXHJbxjJFhyEptbktf12yndvCNAT21hB89E9xPXVv0DbtleESO4i+c0
         A+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b5ulenXHumJtq8LULulVlEQpUa3RXUxrO4E8u+hYZGQ=;
        fh=gLpRb2PmbkEM33EP1fI68UPlLsekrOP4dcaHnh9lOQw=;
        b=DSY/+h9pB3heor8rT2DmBBIbYLJowht7OXlLa/mBf+7jCKea1evvme7NLsToKyzF3f
         eKHCGE23dsm/xc04QLSuiScYXYeCfQydu5NHp1xcsmLBIV9apUJoJeMY1Y79CjDkonJH
         EGIBpHq456DFheRxMxTJTZkBE2V1wCm/22vLkK4x0EJlapj/sP3efCNSgnzWtVyvCbDA
         T/3rWb672QImY/whswboOjd1c/RcXBvaN2Yz8ZyWbK6WNB8mBbDHrEWEplxRfZWWa9/O
         r+u9r0HZ2hVGLHbtICw3FTW6so/zdlo2G9FNnRi/Hj4b9r47b+F1zW8D22KEpCozKe6n
         MHHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793488473; x=1794093273; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5ulenXHumJtq8LULulVlEQpUa3RXUxrO4E8u+hYZGQ=;
        b=Je9fUjsBtQJ92yil2+q8Uc8UoBtnI/Q8bDR+y4NYLIbyD+He3PVDmjunJJdsSBgRbI
         u10vmRGrWlrmHGniaTSoimt1PVEuRa6JiVMwGuAwrJabT3wncqvPy1NcEq7qz6Y4REDA
         oanffB5sk0SpnYQlUTV2ebqkX/HBe0WSWqYIj6YTJe1Og3WwwvUoEQNX3Nv1FbyzE2YW
         IN0Jiet/1lx5YHPrN15v7BSH3TOWC+1xTJaqgRGm1zb5Hr83uS36piXrrIR48jaoRLoU
         7N3eIEcC6RqJeT4UbeojsOFHCmfW8VnOU/FNf8xGDWsRn9y4kGHdOBRZTTcwDSsA8soE
         dl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793488473; x=1794093273;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b5ulenXHumJtq8LULulVlEQpUa3RXUxrO4E8u+hYZGQ=;
        b=Ayn3wuNalAcYvDDu0JCN2G2QXYXNb+O47Abld2wB8uiQ/XpsnPI7XNQpsO47f7bQnI
         tIe21iTrq61vrsoQuWm7HXilsRCQSgijo4kOjdLCIxpbxz4e0W+uUqzAG5Xr/mCX+BiB
         t0W9apzhjV6cVoOGw6yBRmtFDcNH/co0p4YjPCMsMlj5MaX2E2sbznFzjV0H/LrT/a9p
         C2tI36f0FniHUGdsZCsid6JtVNjY4tU5w0CYkw4KE5I91AZSQT/cu9Qf5yGiOneqyEDr
         iG9y4JWxFeiaasMkcM667pkj9K5N4nnO8/cjNiByoH5W90mxydIUvMNRrr0iHA9fA/7L
         +jxg==
X-Forwarded-Encrypted: i=1; AKwUvBw16nH6spC963I85b74IIGnQF3Z2qSJB7DtJVw2N6LARzs6qouGQZ8DVId18YAuRwQCDR83o+3NJQseuiTp@vger.kernel.org
X-Gm-Message-State: AFq9FYJN/D6SlTMvhVfF2RrH6jzo+qRVozJMfOV2Bp6Tx9U57BKbXEnv
	PT+wJ/QfEWK3CdIha7YHSiMTHCIkTYSfw53/KMLk/Fe/poju4s7XZITzEjQiPi13ihHEiyBVCcc
	Cfi6No4NZzk+8Cq79fVVT30/R5KX53AY=
X-Gm-Gg: AYBFou1I0002zyv2kEKYlyRhsOpueD8nbhJpHjnrtKFLct+CQArMXyaaucqiuaM91+E
	JAzM8+76cML3ShIldji/BnWaM2s2ELWHWD0eHv1vhyZaT5AmuRow76Ia7I82mFf0Be329zicsFq
	CmDNVq+5+4RFQAS9/yGsnOspLjjRoDcCHzO+p1pO2dvnIcLK9tIpoTUFNNNalBwP0aWFBxdls/d
	M95qx9JNDZHGEuC1dZBHwzSJPz2qxUIo6JFmgBytbkNnSfZ1v8qFb8qDVCgK98HAN6sdBPrOBAx
	Q/UoqjTvWjqms12ol9pMgpdsklAD3OKBlqFqINn6PwydEjI+at2i8kUIadfIhYPHVdoNtCbuUXW
	crNwixid73CB/D1Ssi2KIUDdZz5ftEJLkxLFsW3mBmiZdOZ74eMBbWtpOS803e+kLyZ2iCMA=
X-Received: by 2002:a05:6808:1a0e:b0:4e8:5ba:8809 with SMTP id
 5614622812f47-5640dd797c1mr4730009b6e.26.1793488473503; Sat, 31 Oct 2026
 16:14:33 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030113201.2921633-1-amir73il@gmail.com> <CAGEkeHekpqv5ncd8tFP2v-OAy-ujTf9_RBbed3dgmTTAQrsPzA@mail.gmail.com>
 <CAGEkeHeBcz2Atc7zz6u-Evd40+AOBtx9Ke+REthvTppxw-vpRQ@mail.gmail.com>
In-Reply-To: <CAGEkeHeBcz2Atc7zz6u-Evd40+AOBtx9Ke+REthvTppxw-vpRQ@mail.gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Sat, 31 Oct 2026 16:14:22 -0700
X-Gm-Features: AclHuK8GCKp7TD0QAjA53u4ItOwUZP_Cmf9jolPUWqgYVOzvnXAg3-X3BtQ5-hk
Message-ID: <CAGEkeHfrqbdHW801cjJLu0-to31SkH0Fc2K+OnnjFcsbjVDAkw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Overlayfs casefold fixes
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On arm64/QEMU with ext4 and tmpfs, both tests fail on ovl-fixes
> (1d27da7de3f7) and pass with the series applied.

Based on the two fstests and the fsconfig reproducer reported above:

Tested-by: Hungyu Lin <dennylin0707@gmail.com>

Thanks,
Hungyu
