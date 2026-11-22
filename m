Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371986;
	b=P0HoWEGiDhPwXMpBgXNgX7EXvdDT5mgurjE9iSWvdgesmHTtzF6kw0tLs0XpAMgeEb7g
	 6VPR7lRgQhoblFo3CbxfptVislRDKX0MyhAXYgsRK+NGlOT/lf48vr5+g/hTgNy1S0FUD
	 qWVJU+Tb/8mI/sQhbIL0rR/+SYl7z4rY+HHb5ePBJ/1cpFzTYDgBQBtFcdvvGsQIpT0+p
	 2f7dI82ZeUSUODgK9rQkNyEH/Xm8pL3uiCRpR/ci0WyzZ2dxk3LkUSlvbjvqIoLNUOhCZ
	 +tkUg5Pj3Zq2QFvmz9BjX0XsDaOoh+ccdReNjPBrYqxnQQknT2zVgrq6WCqEKKPDEQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=4C6duPyG5vPlqV7p+o0/kxHKLFL7wRyqvG6Mw43QO1E=;
	b=qNNcM9erouGtE44xTjiHFIeuYkSxDFy1Gxazzj/nupSCpxBIYcwUjZp42M5/kN3IoljN
	 VEqMylfVHHHF2kS2hS1eZpxmVoYi78hr70fjALezd1TumAEKxLA6nfR65xQWUN0mZYOO7
	 BnSdc7l148I1Sm2jrptq8cB5Z+XiN/STsWBCT3mP+l9q/WSnQY0ny/clGfcXDSpDPfcXv
	 1WcTVmXIb1Gu7E7rj8I8wIXr2wb2Fw+o1IEMaHHOqK9Ajsrj0FiAZ+uovioe8pCLUCdyS
	 Zl0Z/j0SGOgj3KPef02RtYWZTEhGDAL7kYocxVLClewYscSSZNr4RW09Bq+cV9KP9Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=VNww9GMZ;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD079606A338
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 18:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD079606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=VNww9GMZ
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c5127c7abd5so420834866b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795371984; x=1795976784; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4C6duPyG5vPlqV7p+o0/kxHKLFL7wRyqvG6Mw43QO1E=;
        b=VNww9GMZot4OgfbhbLhbPpxx5e8cl1tDMZpJbMjMx8XqzQOApUCluYz2FUwvOvLy4l
         qKvzd67uXh2hj+d8vV8dhqbt2uLvqKog3SCGIEQRBUuJ43JpFXDdse4ZrKCDpXvSFBYo
         6uOr2M3S1El3ER96rJMixdt4/5U64+pW1RUww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795371984; x=1795976784;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4C6duPyG5vPlqV7p+o0/kxHKLFL7wRyqvG6Mw43QO1E=;
        b=FRXy9bXZcpCNIQQSzVzMfuMnlnLEn69ZJivck//ueTqwsj2LY3pIfp0RAB94yLhsmX
         xGyNuC0fX2RSb6qX0H91WradWiXG0MV+HBEXmewXvBrtu1Vpjm+yelVtbSHeEsssaZtC
         /LanFYaLO2jdeEVf8bwCMlcPjVPZEplzr45nITcVxMjMwXjSErTsfiY5+SQwIBhXMnKw
         MPHcQ7pkHVncFdNoshNikx/ecPT/3QPDsjMAq+ZLiQ7tio0IERDrACYP7B27Njvswgj3
         V3lIyBqi0R31R5mZwDCHE3FQL2ohc9Rts3cbxqMDRL3qGB7lkDhhZbjpEyeIeGC1UIVG
         7EXw==
X-Gm-Message-State: APuU4Z+71ROROvJigqZG0weaAQ1SSnqH4cgqQF8k9mgd13taUXwUrV3r
	rjLr7oZPoQKudMYQVkGWN7CZxyQyYfP8t/6ojtmx3dx36NFs5HawNzINt/VqWl8T4APpdCE2ioa
	C6yipjhk=
X-Gm-Gg: AZFdTZeKIwNsLMvCgOJ3s89GYKafCnZpypOkhuv7K8gfSH2i3QUqwPWfCerroV7BsuU
	7qYnjXZs9zZxbCQeesk4DIGh4AGRN+ibY3evgZPNuI1JCV6CAqWInVGzIyp1dofLuQSEVTvEEy/
	Cc7mJgGSp1ls36RhKhmsA0eGXGKccj8H+efbYWKncehsW684pJwJtEUK1HHVrDSgT6SaB5LT/DN
	0aDA6A52Xa6AK9AqyYPCOBNgB2fTBscOrPV2LZiLp38Jx0aHESol39Te6acq0xweJgRSool+JVo
	ox50JbQZ4Nu86z3D70RrA6ApMwlkF0efxj/5Kg3ypSyBDl+JF9Ob67pG47Cb0QliW8uwAQCcbDL
	jcRP5lUDPWw+R4uFYHKvm6sF74r80IZO5s1h+sk/Z1plcJsAmP2FOE8w/Uf3i4KQXskvZh8CEqS
	bBvR6MRRfI9b7h6kWy+ukcxF0vpnMKN/Zo9r1bBn4VxMFJO0JJqgmP3hWe5P+aaTFo9s1DrgZUU
	/1RQ2S7yMHPCXxsUdJ0UqccpqdWbMWDt0k/By5Pn0w8v03pr9BQQ2JNuujZ/d0GZJQVvVGycQRB
	IuHAOOpDJkYv0zbG04QJNJx9fO2bMPQb0YfXYouVybJcA9NF6A+FoRmdNX9ZdVSfefidWlzgekI
	/IMEKogzDtfeBONSQ1VtneIfK
X-Received: by 2002:a17:906:d14f:b0:c29:f5d8:9c82 with SMTP id a640c23a62f3a-c513aaefd6bmr640270466b.49.1795371984156;
        Sun, 22 Nov 2026 10:26:24 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afec08asm335066266b.73.2026.11.22.10.26.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 10:26:23 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c5127c7abd5so420834066b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 10:26:23 -0800 (PST)
X-Received: by 2002:a17:906:15c6:b0:c40:231:6eab with SMTP id
 a640c23a62f3a-c513a5eaa3emr601872966b.16.1795371983466; Sun, 22 Nov 2026
 10:26:23 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-vfs-7.4-rc4.fixes-0bcebc1aae75@brauner>
In-Reply-To: <20261122-vfs-7.4-rc4.fixes-0bcebc1aae75@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Nov 2026 10:26:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNpMo-uM86NEEguFtBa5N7OLcQ6fYd=2gZGuxhJv0SMQ@mail.gmail.com>
X-Gm-Features: Aa3M54qJFxDloCRjJVN16I8Xt2nbOI9mFuPP31QMki8fcNEx3MxbnOeXxz5hNVk
Message-ID: <CAHk-=wiNpMo-uM86NEEguFtBa5N7OLcQ6fYd=2gZGuxhJv0SMQ@mail.gmail.com>
Subject: Re: [GIT PULL for v7.4] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Nov 2026 at 06:42, Christian Brauner <brauner@kernel.org> wrote:
>
> This contains the procfs fixes from the procfs rework I've been doing.
> I've mentioned this on the list. If you'd rather take the fixes during
> the merge window, let me know:

I think the changes are good, but none of these are remotely new
issues, and I feel it's better left to the next merge window.

Even the bugs / misfeatures tend to only really trigger under special
situations like module unloading etc, afaik (eg the "sysctl unregister
can be held up over user access" kinds of things) or actual active
mis-configuration.

             Linus
