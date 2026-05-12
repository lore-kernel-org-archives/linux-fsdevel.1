Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB304BC001
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579841; cv=pass; b=mGwpxX1jZ0zppVLGdyh4SbYoTQE8MKr8xMVf7j8IVOE7CvxKL7yONqAhjOti0LyfuhUkggVu66XWuSXoXPfgbwYu4+0o1k4Cv7VvGjDdOSacc3qcMekgfoOSn1H2xuTxS5i6xl0MeWew7bmfuMx99ES7/upBTksKbhHsjsrG1ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579841; c=relaxed/simple;
	bh=Zk6pQSppwI2XUO+9RM4L9RA06qaWe+fmCGIHtby1NVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=il2s/cNSDIDwyqz2oEVDO7wOOIVdDKtL5yYtguYAVNU4lHshQhqXJ8NOr9H0w2tL2GC6Mlu4eyrIcYNwjVYkV+5l9JU9Stkz9on5dBli5WnGgyC1c0u750SxU9ECUoIEEcnuM2zVQai+y6VlRAwgaJfgg2g9w3XL6UMSJctEE7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=egdFOswE; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="egdFOswE"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8f15e900586so272659985a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 02:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778579839; cv=none;
        d=google.com; s=arc-20240605;
        b=LyWKqUBwDm7Mkb7Hyb/903mraMcaWqH/LmzMfBoNhLdkAd9QVxpsi48VCOkpyWyEqc
         9yRQOUdzEHjebvAmy4TbmYxwORGJwmg52GDJ+TjoeeEMC+KyLJ7+YpEMh6Pz7ivR+ha+
         nYgVOO7wpzJ2cp2i0yLkQaguVFw/bR9NtNir6GuBBPzYA48q7Fs5HOkkGFNqsZv6S0e2
         ZIjmbfPlxUjs8RedjBO+nsRvJ6rlQZmg08wkJmSfhpg7MWfuot0sWp20Cu2NTM6EJdHD
         vmBz8D7ueIV8zooqauDSPAGVIP4KQHvtAfEJvWCDtb4HZoZsVwq5gy+afsLl+QnYE3jP
         TP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZZ2aWyO1PAZw1uRtjKrB8uu99TCDOu0IFeyL5zerHpE=;
        fh=QlQpfmZxbsQz4acsD8D3t2U7/akNzw7I6vbYeZixbe4=;
        b=ETOu2xrbuF/dabejrq4Zo8oZX3yt+unX/mx3mHbad5eBQ0lyU1FGHA4lnsMG9vwH2w
         i6qge6vm/vjdRMjdACmtDr6BApGA28lHrPIOqSbJVK3fevvSTBicd5ZwQF5QuBsIIvL9
         bmdA7xOMt/TasvsmXYkecEuQrfVAAmX+cMqUw88V4HzE21tmU3JNgYoyxVUzAVJC9QZl
         T6WIMYlPTCdzyJUfsg0iID3SAyfB0sB2HaRF9hzilniIi8RxFk+4h3uuAPVhIfrhKW2X
         E7ce258EyRYHkabI0LGIwgi32iGM8QN4wHK/Z+93t6vt+V0qeiVuniWVFEeVRZc26zyZ
         2j0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778579839; x=1779184639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ2aWyO1PAZw1uRtjKrB8uu99TCDOu0IFeyL5zerHpE=;
        b=egdFOswEDqGGEbaeFa+VrOtzXl/QXHjQ9hub6PWlge34AxP2HXsu7JsLE1CwLupzH1
         OBxsWz4kTb0mtNdtRbAT1Vc5spUFCXt2wLyXpC6yZwigx4xedwHjIAqDZr9qyCzF9xn6
         h8dkTBH24+RF7cuqTsuZTzxLGCYErhufGjMYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778579839; x=1779184639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ2aWyO1PAZw1uRtjKrB8uu99TCDOu0IFeyL5zerHpE=;
        b=dzfXRQdHYde1iuWuzdUznjQD5rqTY+QUhfifaBcolmEiSsXFAHVW5nVg3at+Ir9b7O
         cu5YHqtDX+xjwdoS53/KUPYhvLg3l7zfaiYMZt4Cv0VJDGlKx9Uq614CgJegYpj+L5Lh
         eQPtC4rqsecmgNtVgMhvnOWKouW0b9K0vaiOVGmrQb+REIL0CkIB7xJZoLw8hmZF/nO9
         JkjkbMlH4//FljEynXTCQ5h4uq8Qks/RmzoGhPpQk2NEJ9IngCwHyQkPrKRtTLGHDmfl
         oX9Pqo6z/gtgir4m1smMLnynZAuSiEaxPNXkr/XdfOrEmd6uPDP2U91UVEln+NlXzRxq
         O7Jw==
X-Forwarded-Encrypted: i=1; AFNElJ/jjcd4jyACdBtTgCIf8zO5s7vvXlP2CHhMi5fMN2OOgjECow8rzWlH3C7/yaM+zMQlW9LAgRqwsJiOKKaY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4b0zJXTJUoSsHZIL+QSp1cg+Yah7jIvxkHE1CCp3NrCz/Bntf
	6uSb5/IcTw/+K4aiN+v7A1d9UkBcpUpzJmrjEv7CegweeZgmJqaFR8b9e/bu0klbrduzjrZCw82
	G87bAFS6KySdXBMrkGNqUPskiwe7skGAoVw+k+/DR+w==
X-Gm-Gg: Acq92OHwSBpG5OddJdOHE70uLPmbCYEWez3bAO0czszR+DFFnM6ldT3mBIadvMY1E9h
	/809j5CMGavXX8b8cP5TxL/ZXoQwwxZ9QmBOlSu6xD8+NxbgmQsbeEpAFyHDf943KYCoN0NiPRH
	N/U+WIoqw+PFoEf52aSuB35LWsq3YRcjjaSOz3Nwfpq49jazZsXFGta9GlhyoK6EAARH/rIMBof
	U3OblSjxW6SuwDHeXewwvFAbZEGglesNbL/fPmzUjXh4BAEedLnPUghp7Mki8A9mpF7ozcGJeL4
	74qEpKEBxTam67z9LywwRyjFm1OaslLcdfUY5VSzFckstS755g==
X-Received: by 2002:ac8:594f:0:b0:50d:998a:2d with SMTP id d75a77b69052e-514621ce49cmr385975601cf.50.1778579838763;
 Tue, 12 May 2026 02:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <87pl313ni5.fsf@igalia.com> <agIqECaAKFuqdi-i@fedora.fritz.box> <87tssd5829.fsf@igalia.com>
In-Reply-To: <87tssd5829.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 May 2026 11:57:07 +0200
X-Gm-Features: AVHnY4JwTJeYDTk3FgmCsmv55SVNa3W6RrX7L-4ua9syJLQzzqv6perGJywjg5A
Message-ID: <CAJfpegukELeLG8ksWnxANBaGBpjjyq=3mZbaThNhi=UtcsoyOw@mail.gmail.com>
Subject: Re: [post LSFMM summary] where is fuse going?
To: Luis Henriques <luis@igalia.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, fuse-devel <fuse-devel@lists.linux.dev>, 
	linux-fsdevel@vger.kernel.org, John Groves <John@groves.net>, 
	Joanne Koong <joannelkoong@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 10:46, Luis Henriques <luis@igalia.com> wrote:

> Miklos, do you have a timeline for when fusex will be merged into
> mainline?

Haven't thought about it.  Could be merged as experimental with no
guarantees of api stability for some time yet.

Thanks,
Miklos
