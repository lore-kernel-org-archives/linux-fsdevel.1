Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B9A3AFD16
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976805; cv=pass; b=iS3H58i0k9mjdJZlDayuKv3dq7+2JQZnrE+VhhgT1x92gQonMMb7cEBIh0joWlVluTa71hnH7Ls3p0APES9uJqfhDS2R2u7isMNJ0W2qFD9ZWgUNOV+IpoCEo4UrvPhgBLiSK8eqTfCJCpGqWebLxOW/E9bXEYR+hRvZCpQVCPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976805; c=relaxed/simple;
	bh=H5UNg7J1Mi8AtNfwDPiv7pfF4LzhgoX6aYURLD7VVVA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qQxzZWBeSQ4tMftpL2g2lZ1OffpmQSSbGS1G3y2RqqyVCc9HUj5mTM6b92I+ECGft/mDD5LTZJF2eP+QpNPXD2Gf6rTdPcUjwB24NualC6fPzDpn7oOfD9vSy0gjjK7RLJLyRqrIBGAh7hEJm4WqKLQ7JeDkIKaunQEU/FSpae0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB+B5R/Q; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB+B5R/Q"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a17c04563fso5049789a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 07:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786976803; cv=none;
        d=google.com; s=arc-20260327;
        b=he+/F2AehV18PNn+kZegLqAGhFvTP7GQKDGMziBYsoAC7TAktCdP6P2m3Z6RReBd8a
         86ny133qui8XBsAgsfexHrbEP8UgADLw+zao5/nt4lIkeHEh+N0SPsOaq2RPs96epe/o
         juEiE0QzcLc6DgUk6vhGlJCse/BLIHr53SQ/Jbu3mHuRCwCAHf2VlSQ+XOHjNl38AzQn
         TReJ84WqAP0SGs2PZhEf1ARqCesG2tH36IoytIqQifeRK7H60pCj1oLe55DDCjJM44CX
         n/rGtwV7jya4XWyo84lWBNijUMgqBcvebVK3t/PdAYzC49qLszv00OK5xTDC55psUNZh
         akuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ILf9NubHRq8/Yf/8qGSonTMm0brZwMArnnCdd8N7fxI=;
        fh=j2CuoO7HB9ZvJUEjNIunpBL6kpPKR1nI9OIDNKYUU34=;
        b=kx1GygwRtw9J0znvGAZe0IA7UjQOTkD/NNKYmvM3pgCkG06MVgLx9kybF6zdaHGZE5
         X9keu1MvF5P42aZa9Ngf4wE5A9cUjSJcUSeHv095feaPO78whbEaHKsMka3lYF79Jqcr
         nrt3B3xKIoyKEGENA2b+9IE5SZ4RoHJ6cmkALVtmgh/Egju6NdsDPVscq7Vxv8Dzp8aN
         set5O2iOZIfJi8LIBROWb1fSW8BppNutlcYZDFFxC1otwpFbsuJBgF9ozuSTw4ZAAahP
         508vj/ufwE10AtUUXWFHep0Fg9xuuNQJxMMmkGUiXeKGJZLW3re1nrWM++KvxBkOoKdE
         +PFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786976803; x=1787581603; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ILf9NubHRq8/Yf/8qGSonTMm0brZwMArnnCdd8N7fxI=;
        b=QB+B5R/QUdjLw1fBgO6uiPEMVVjZ8nSAuNFQZf7qaXchpEW6ECAdV3eJTJ0To0jZ3K
         jj+BKgy0RV1Ruel5NhEyvhNqFGY9+Abjr2PziT7BYvyWEkrS7+Fyur/Il48X8l5JVadg
         EHZjJoArBsi7ACMXKZEX2JVanlT6kTVaoDfgjDg8B5ZL/Npf1mBqCm3Cs5ECUEbCri8g
         EQkZEtaX5TKuk5sVvIdd8ibzZ3L3laguOXsMKV8xOeBO60aPfDKmI4gmp6RQhjKOsO2q
         BcDEc5M6GXAnf2lxs/dLlIOsy/rnbmFCLaAQt/ydDw9j/siek3VgokBrvKgbPM3+PzPp
         8qCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976803; x=1787581603;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ILf9NubHRq8/Yf/8qGSonTMm0brZwMArnnCdd8N7fxI=;
        b=hC+ClDd8Sdhs85rpEaAuuK/NgyBoNLLH29m6G+VqyGydGwpvteoxR25koVAtUgoQfT
         SWzE5EkMj7Ko1TJmOarSd9gOvxBxEFkK6PbbloOlmj9U2+TtrRdrJUEHCV1fo7ePkMec
         1LT9O38hlFb25WXyi3jkzUbUGJJaNcAZi2OqWjgbBXNOrM/ZP5dDTd5CfWnefi585oCh
         bQhsuvpt+ji5GL/3YFPfap6PE1NWM39Ba8sc5asVTPx6jKdL1PIPjfiHTkt9QyAETA9m
         uzCHHnsYDj5ivNPusXnGcLHe9xmLCj9echcvFexxcG2RKP3rwUGjPvZFXCMH3scLvBC/
         IMWA==
X-Gm-Message-State: AOJu0YzcmKP0br+06xgw5+tnpm/s2av5Ns3uVcdwUCjUQ1GsvORNkmOc
	Ul+N8sjXjQpSGExEmDs2K0V1PGGqU/JP+8Xros+9f7Ze2kMjv1NtMAa/yVNN8BfRGAOiGd9qMgC
	lXbBOId7EAy8inOil3sRZC08+SdutDkNNjnJ3
X-Gm-Gg: AR+sD12StIxTehj3xo/OfEnLKx1dRCWUH+WbEcxXEjfwoJvWksrR2Wc2H6qdX+5b7RP
	+2TBtktvKGWnvLvIe0BJC/NCWl96O9DRNJhIn3+WpgRR8082ED2ZsX7Kj9V3B4yxiL4ndj+JM+J
	aS0v9wYUwGxfFKXj03xp+OcxZwrGwpLZIDwwJPwOkV0VTJNfXLO13KxAT9H1z69pJgNMlXKwQeW
	tEDELjL/6qeG8WJNZqTy3GCyfUXc9ogLp3Jn9UzXPNyirGNbgwynyIgYEGN/FjAlzAnC0A9hLHc
	/qf7yJ67raap/S8GAArxNbQEhCIdIKkMAqGTdLyOK7Y3C3QN/dVexrIizveoN3BwcfswmYvCkc/
	QOaAWYoOZWBrSNJ+ZiRmIEoP6Un3mcHBh1DnWrICMH8yen/7L1J4VzbvWXE9sXioWNQtjNQSGNx
	Tm05fKsgveAcnc9grkxRze
X-Received: by 2002:a05:6402:1f8d:b0:6a1:2863:ad84 with SMTP id
 4fb4d7f45d1cf-6a38a9986damr11298508a12.11.1786976802672; Mon, 17 Aug 2026
 07:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Laurent Lyaudet <laurent.lyaudet@gmail.com>
Date: Mon, 17 Aug 2026 16:26:31 +0200
X-Gm-Features: AcwNN1V5cAkRzPIgAwEhP_UQwCtxhVENNdxRSBlkE2J4bEJig7hHaeaupu83B_0
Message-ID: <CAB1LBmsQ2xFHQeEDFspwpFSNkiFUefBCn559EJsfEz5ZUAXYiA@mail.gmail.com>
Subject: [RFC] "final" flag for a directory
To: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I had an idea about adding a boolean flag "final" on directories in an
advanced filesystem.
In the same way, the "final" keyword on a class in OOP can be added to
declare no subclass can exist,
the "final" boolean flag on a directory could be added to say that the
directory has no/must not have any subdirectory.
So here we see that 2 flags could be added:
- a configuration flag "must_be_final" forbidding to create a subdirectory,
- a status flag "is_final" telling that no subdirectory currently exists.
I think it may allow some small optimizations.
With a very limited search on the Internet, I found no similar thing before,
but I do assume that I'm not the first one to have this idea of
marking the pseudo-leaves of the filesystem tree.
Please, let me know if this should be discussed elsewhere.

Have a nice day, best regards,
    Laurent Lyaudet
