Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793548024;
	b=bJ77FGnbAHYFTPxkPTxx5GuIkrezgxjskVjdLCEJDmGMfaD6GHYpBCoHOyEJ3nl3Bjrf
	 Vr6NHtur5EqA3O4tuXiNb5jEDi79EIbednQsdHL5g5ydrGoO4CRZeVfDvAr7trlQLpJwb
	 aaJYWnj+L77G57v+Q1CKPUvH7am2Ql3y/KF6a+KJHE6qkqmaiQnTvgxDJNEUBujmhzN9c
	 kMesg//+vTQoDAx59UJ4gRkPzxpnBN4XlBzMy0GLtEsd2R8l+1m3/7UtE2sggc76gp/Le
	 aGv0JMRKR/CYW5pE4myuGzbOz34EhcZntNUIzMngDIgnjWZPJ2TevKtYj5fjyhSF5uQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793548024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Rnvo9UG8/PyUCxjRTNkK2BrtMq0/hvvsz56LwYy2AKQ=;
	b=e1isKSZjgzPUHr8baR1DX2CeuwhRrwjMv5CUQiKfimrZ+i1wb73EBXEsqg9ZoZb4JBsT
	 U6o6GmpII4eQrINFil1hiP1VDhDZsL7fZyTs6VnwnJGNTQ9ZtxYxHJP0L2tqPT6sEaJpW
	 ZtDokEL9Ejy8iJrV0KWFmmjsh/NQ58dSHDkIMR0m1Pgnc99H/2CxnlmrtqJdof088n8Aj
	 2KXo6cwfWWgX6z/9sRoc2M1HMZsl1/qML4exBzHktAKqsq90rCiLgqEMgwTgsMF1MSiSn
	 WeaIm3mDRWUrPiTetFuF+xBGhTHsjywO2ZElRcy4k2t0H7VtJ0W6ZUMxANequYxQU2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=duqAjNoz;
	arc=fail smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D72606A329
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 15:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30D72606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=duqAjNoz
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533202fe429so263881cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 07:47:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793548023; cv=none;
        d=google.com; s=arc-20260327;
        b=C4E3Pl8Sp11XabStladrCjgLNtwsRlBXqh6f1wIjjsPcJDFyUAXfC2Jttzk9AlPee0
         imZl+N0YctVz2FgN0pr6IUsKokeDZXROr3ukKexMjVfqaR5l44TTUaG0Isn1ol2t2lly
         e7WVQKZ7YFHyTuZgbYBw0YTTgI2rrmrcGTNX60/5nSVgCGWtKOhZYa0l+mxymfnGxf4U
         e59V04oDbNyU+F7fixwNYc5cIwl0DURbKe9CZxMIVEU/Zpzqc1Rs64zrFdSS4zWRSmJT
         aJP3XXNbsN9xzthvRZagDZvQaDPUHSuBH6fEmts0IbxrYAQXPqYx7PNbhVmRyCZx2aBA
         cKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rnvo9UG8/PyUCxjRTNkK2BrtMq0/hvvsz56LwYy2AKQ=;
        fh=TJ8NgfpRRSvJb5pOYUwqfuwQ9P6qE5eH3m5F4RzIuxQ=;
        b=ZqISTEIYl2CgSyCL7y3u4yTkJcH2MJNrsEEaPGQ5xbDFmSEtZ4Dqb5ax7M9ieGB8x1
         WqEnz2tNmvuqYjIKZ+7tfsuMZ0OAzK+3CtLCNzytUykytug8SpKWsDppk8cpi8b2i8Na
         PBZASXlwLDfDz+6qFg1FP2xTW6HF0NiPyRhiQP6HuzbxyT9tw76/IoxHAGsUyG+Ighpt
         JPW/78FnPadYoHHMlTq7vf/pEB78gyfBB7CBqqu1SgnEepqA1WpULZtGKDotST1WnhYh
         tX8FwyrAUWZ5nICAwnNgG3mIaYkluDTxW8+OOquoeU2yjXBE7HfZo8Agmck0V/MWZlGW
         gWPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793548023; x=1794152823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rnvo9UG8/PyUCxjRTNkK2BrtMq0/hvvsz56LwYy2AKQ=;
        b=duqAjNoz/dFrCrzZ1BFFcB4+4xl0U9zSzpUZMbw91EDsMC+PYE2AOFDIi7bVmxaZaw
         BQucPtQF7jA8/IlnLY19d9Me+/9LBKzDySBEMkMYqmWe8RjPH9jt2BciATQklkiq5eqC
         IWjfpHaJV2UdAG7mkb6SIxlhZc8sTud1E4uoWIDgM6muoYXX7v5njA9NAEQHk036tpo8
         RGzSafP2jmZx0Q1T7XL79dPjL5uPBuD04NLCA5A9wOmWE/06tRgndsPKv8Ei9DuKT/IE
         KWNg9jRBYL9b2MrlLz4aQ0G1qV/G/+cyhvLWl0UvcrzhoxZVbAvap0D0ve9JU6HAoyp0
         syLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793548023; x=1794152823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rnvo9UG8/PyUCxjRTNkK2BrtMq0/hvvsz56LwYy2AKQ=;
        b=RofvDtlQKoVVo8i+UKVhvYUYdSt++Og9pQRLMKegvLl/LhBM58XLftkn4IkSOFjjzq
         VNwb7OOfH0DOHY9rW5Kdg9FtV3twUXQvFtERlgphLGt0cWLoOaVohxvvCRAfEyLKYUB4
         RD/U+ZCeZgL9+kvumQ0e9MB+EP++iTUWCagZQHMsJUN5abWvj6KPXvZ1I+NWj2YLaDyB
         bjPNK6pkZprWBcZcTb+k/JMx7O5KU1/Td8CnEDKxGgl023eGqOB2a/K9p1+M3F40URQw
         Hb7jw8O0nj1SAXu2NlkiW2UrWlnfiFF75YsKyrrXslji+ZKbK8HBkPK6JfT0Ss1ChXNM
         LkQw==
X-Forwarded-Encrypted: i=1; AKwUvBw1HD8eyK4xAFtgEsIyX0/GnRKdYnAUWV87eY6FW6nIDTdj3CvyrwwfXL2fxe8qFXwajG9bAVle311eJyvS@vger.kernel.org
X-Gm-Message-State: AFq9FYLVZnYsXhGfEkaqy2jXA6r/ysgDVsB9WZ5I8JWfJBPV5OpBrQES
	gchItMKEIGJ7i2AoUov6dQLXfWwXWWywi8cQb0yc0OFPi/j4uYMkTpNU67gP5Hoo41zbZ919GJ2
	N+mhdsb5T3EMXpDi+apJvUgqxO1eZLSH+IXkmrNgC
X-Gm-Gg: AYBFou2oJO8e0s8xTeRGioPujNnae2CKke5rdwF6Vwgtiu4LMlDCTlQUsvjsMfCKPiU
	9oqYsmXaTIZeCYUHx0LFIlwz8LsYCSnSk7wwaFOiJ9flSLZdd7nFDW5hbSd2NxZUqfwWEvNnyLS
	U5mE8FxjBn7dFhg2o8V7Usyqf0Jq4HkrG4Umvj/1nRFdLlPpSqT2wsn9A6fUtkKbH4IYv2GHsL5
	rq+2r8Oacqy7k36Hns1g5ZZajIxidSkHHSGmqe0K99s0FjjTU56coGkI3pnDLNg7t2xvA1Bi9Yj
	kpQ+p7choQr+PhmJGm5xdNJNhiG9zkrGW8vLYW+uyLHZJ3rKOEtW9BAmfeaCQe8rNRXbMulEiLS
	ZOyNEXXfLSGxkkNjUqy599zqD3DzYLAe9COiEWFaCYO5Gwh0No67FJztN
X-Received: by 2002:a05:622a:2b45:b0:532:eff8:3491 with SMTP id
 d75a77b69052e-5414ebdf590mr76624581cf.14.1793548022450; Sun, 01 Nov 2026
 07:47:02 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028051312.1505295-1-surenb@google.com> <auHK3k-W4gfL_MhI@pedro-suse.tail5790ac.ts.net>
 <auJO9al4lmAczLAu@pedro-suse.tail5790ac.ts.net> <CAJuCfpHAFXDXs4ZBrd8C=8hkQdJxcWCz+DER5BG_Ki0ndGpf9w@mail.gmail.com>
In-Reply-To: <CAJuCfpHAFXDXs4ZBrd8C=8hkQdJxcWCz+DER5BG_Ki0ndGpf9w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 1 Nov 2026 07:46:51 -0800
X-Gm-Features: AclHuK84MQqzMKZd-OXYE0wk48ZMx_UhE8Hg8QFqNvu-tilXapmhIB4d1-01OeM
Message-ID: <CAJuCfpF=DdYZ7UFH5vNJT-qoF9qrDBW7pgk7tHeD5Z9X7PH1og@mail.gmail.com>
Subject: Re: [PATCH 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
To: Pedro Falcato <pfalcato@suse.de>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	jannh@google.com, liam@infradead.org, willy@infradead.org, paulmck@kernel.org, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:59=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Wed, Oct 28, 2026 at 12:42=E2=80=AFPM Pedro Falcato <pfalcato@suse.de>=
 wrote:
> >
> > On Wed, Oct 28, 2026 at 10:14:19AM +0000, Pedro Falcato wrote:
> > > On Tue, Oct 27, 2026 at 10:13:12PM -0700, Suren Baghdasaryan wrote:
> > > > Pss metrics can be affected by map count even if VMA tree stays unc=
hanged,
> > > > therefore test checking VMA tree integrity can't use them. Use Rss =
instead
> > > > and pre-populate the VMAs so that Rss changes if a VMA gets skipped=
 or
> > > > double-counted.
> > > >
> > > > Fixes: ca5480fb53fa ("selftests/proc: add /proc/pid/smaps_rollup te=
aring tests")
> > > > Reported-by: kernel test robot <yi1.lai@intel.com>
> > > > Closes: https://lore.kernel.org/oe-lkp/202610271934.fd287c3f-lkp@in=
tel.com
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> >
> > Actually, now I'm wondering: isn't Rss also flaky if memory pressure oc=
curs?
>
> True. Sashiko's findings are also interesting, so I'll need to figure
> out more robust ways to test smaps_rollup. I will post an update once
> I figure it out.

I posted an updated version at
https://lore.kernel.org/all/20261101154503.3203036-1-surenb@google.com/
It should work under memory pressure and also address Sahiko's concerns.

> Andrew, if this test failure is causing issues in the meantime, please
> feel free to remove the ca5480fb53fa patch until I get a better
> version out.
> Thanks!
>
> >
> > --
> > Pedro
