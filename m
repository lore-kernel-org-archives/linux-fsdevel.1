Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793758033;
	b=QlSVHpZ39o1AZb8hIjNmLX25JQrY1SOqJN2hRcmCfrqoRWY0UPEoxKYbUITM/BPFtfe/
	 EldfbbGllLvBWy4d8db/lt001ZqVnBON2f8M+ihP2dYZfFYaEHkPWR25LvaULtnNFf4t/
	 U6Pqq4YwqwcheGQjrcjawVVsznU+dTbKudCFGulFpRnXUyDKXxcsz1VI003T3ZsrH5t1j
	 bPjdSKUrlvoUTlTP4cg7J8T7lgxcyk5E7FnjY5WwKZ7Kq/Ci/LcWnDuyWOb2Zfa6Y4/1m
	 paZbuDHZvnW8dk0YjqLxIQ1EEMpm/IU2WJDqVnWjDsbdoyWwOyjIegXpFYQh/0g2W+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FAiexPt9F2m0rkGdx3cg9FXpp1bQGTobMFGeTARij3M=;
	b=C+EEpxOkxR0Y2eiYBOIK3CgACbGwtOz19T/mEcThtvdyiDYdMaE0fJc95eMrkCJh/ihj
	 Bx0D0ApLOqHpUuvjh8qSU5qm6uoPab27gF6wFJeiqXKiStV8HmNczjVcKX7ic4ardgn4K
	 53OPavJzbF3s9MZdMh84VEqAQ/npJQ8GTKiTVV9o3v0c7dJ5aRp7OuY6KzG4uGO7VxJGZ
	 t27sET5oJT21X6E9hCxn13jVSHvG5lQMLVeK/SEp/72wF2BNlBYueF0EKn0iAn2DhTW/C
	 5/JmYz/+JmLYX3Sgf3kcnIxlBGemvoFCMl+hW29l4ZAl/o4Z1l3RSTBe7YdeleEJjOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Avs61lsh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C56606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 02:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88C56606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Avs61lsh
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5383c97c8cfso80991cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 18:07:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793758032; cv=none;
        d=google.com; s=arc-20260327;
        b=cOVL8GYXrj0POY1pvkGX4daTbf6xnKAX/eT5/IomMVDd3b+r0tIee97kc49/VzvY+0
         nzIF00KU13aQR12r8zPupJjDIBrTpjDjAxQgSusPo2VUrVJlXp7nYut/55LmIzwT4tqJ
         4BNCtDPQNxKroA6KsUgSr2zFWPZMdsebOE0si6VGdidB8VXtltNsa+CWX432eWXe9EsV
         pJBLfKu6Tpb8Ur6pATsjaOv+F8yLUyuP1RU4O3XPHwJQl6ElRDpz8N0ooGVuDuYlYoa+
         mvCRIbzZuOMnq34mI9YJ1LYKwN6pP9XsUFaNH0Yh3Iig+W1h+YRo8G7sNRgXAJjw7PXP
         zZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FAiexPt9F2m0rkGdx3cg9FXpp1bQGTobMFGeTARij3M=;
        fh=e6A2N671XBvUTnnsVDHWGSlYFvb91JO6bOg/lQfHyis=;
        b=njKA3yx17+akLxJY4VTzG7g7kCBNhs5dXp9T2mV8jAMjRhvONDhhUDhBe9FNnBqzxb
         doBS5WePffOj+DIDznbzRieDTMVyWI3CrEyQAI+oR+8pKmHhvD9H7XcFFYSNYl8KNaqj
         1gdhGWfTAAjeH+45/ZiDvEO+u7JXiPIk604oF5eJxKTYzcXWGq8ipm3zq2CXowkZhoLv
         bwDAM8ikfTKLhcyKES9wOgEq4HNqyHfs08iUDAJFL7nTtOHnGFjK+0ANJj97FHX2iyVB
         AsPKQEPsbVY8Pk/a7zEO8ziEUl2xkrijARU2IPtve/CEa/Ax07fbX1lNJ9FS+t3Hv4ue
         xV4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793758032; x=1794362832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FAiexPt9F2m0rkGdx3cg9FXpp1bQGTobMFGeTARij3M=;
        b=Avs61lshl+ISopFP491Bg4dT2MhyEf8EGFL9ukF6FOOtmQL84fh/pCfUMx1tupqtFv
         52RgWZN0Dhga5IMrkWWQJCL7vYjYp/Jq5rECU+9Vimt4yqvcedFmHrvRKjqpwAcx8Par
         ART/E0yZsj2/afiLYsrqw/ZJisDwG6rxw4uc62V61BXkSL64zNsahvhmvLpz2Vi/NOES
         JB7O7pJMIe1LYMflv3Jaga1idg3UstxaNQ0DW+5hiMijr5bqDNEecp/3zxHHJeQEBazc
         eCad89q320Vgdh/Hl8Zq0Yd38Xm1szZtKvw/yFNnZDUni0MFe6UeRm7TggfudP9sWVTk
         +uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758032; x=1794362832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FAiexPt9F2m0rkGdx3cg9FXpp1bQGTobMFGeTARij3M=;
        b=wtHlLoV9BODrzIVNzwu1bAltlx+0Pm15eJftvUpmjjC/+wtIcx4Mfex8upj35X0tGO
         0pXhYoTPVZcEPbmfxhvTQrJfxwTD6sodP25gCIYM9wk+xrugMhQake1QA1G3KHBlEj+I
         UHczs6t1PNlWGxjeczxx2PXZBc8vy/l9RhTTx/XnKplSiOWbi4aWud8En5KrYUtvtmy6
         FM2Nuaxee9BrwpuKwHxRi26D5d7+NitmDM9uoZDXEralL+FJK/CxW2xqgiyVdfMBd+ME
         sTblu1kctEkbJUlMvPoEECZdFvW1e03+6h13TedWpX+V7UpFdlWqadq1xv+YR7d30JPY
         XWRQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5DB2c5T5Be3krijFvaPlLz7RNY5FZSAqzZOUZE7awAwUc7rYeOux/bu+wCHRyyNsnrmqrRIV2fsVzJLvf@vger.kernel.org
X-Gm-Message-State: APuU4Z+swkWzK6yHfHrCNgRYn6rjzf8A7HztowekRY2kgf7yGEVlc26d
	0mnYF+6t4wsMgICna00mFn2DUmeFQnm+K1TVskkff0iUSAJWTtWU6tGCQ/ZLNpoKu1gV9GYlXKg
	QqCRQeV5bTJ8yoPqUzAzA++fSjfDReoT4Mt+7nf5L
X-Gm-Gg: AYBFou1XhwKgeLZkx83FMIXiCvPg1l70r5xXPhbU7ITWLTHIwDmikzZkKwdj5ZATOGA
	v+XdTJCwgaP3z58gZR/HXhfU+nJpM3bAGp4mRzfldU+J8LkwwyuIg1a70vJagbAxKU/1/tdw+0v
	MHlJ5xOd+FGAtYz/MaHkZ24irk85jBXAFQ6iIpmSsPnhCHFDXixzu2ZMQHhQSYjWqwK5InHPbTE
	DW838CbwSzUzl6qkGX6qxFwax0XHNK7FMEjkCJtYCibPuF1Uq68t0wA/AdmcFjDJwWrgo250Kmi
	6UZB/8414pAj6z+o1rGOjJsTuw6uRJUy4L5bDsTGN5Oz427bsqaS2NmF/1PeOjA9TpOojm+eJ0Q
	1CgWkQss3rBOPrCbJHmFObqI6VG9afJyLXVgwsuMcvr9uoxxjQqsr4KgadmB5KSFBqY/iQudBow
	6sP+4ywQ6mGIKG
X-Received: by 2002:a05:622a:4d86:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-54b227f261bmr9698371cf.0.1793758030925; Tue, 03 Nov 2026
 18:07:10 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101154503.3203036-1-surenb@google.com> <20261101110100.90796bf33ef50307a7698dca@linux-foundation.org>
 <CAJuCfpGmPLBRhHa_dmyP10QzyRyvcWMYDLU0+J9t-RCLBsTaWA@mail.gmail.com>
 <20261102080103.6e3f602364747ac6adb13f5c@linux-foundation.org>
 <CAJuCfpGmHWiu0Hmob-PgnvWAMn=CD0-xgiyGztP+P=OFrwwfTw@mail.gmail.com>
 <CAJuCfpGwZqGkOm25=BWAh2QgA8Y00OUmwxsDU+_qOsVsc+KHhg@mail.gmail.com>
 <20261102090125.58a2e80d1669c681c33ed20b@linux-foundation.org> <CAJuCfpGvLt+QDw+n0QnZmBqryMrX+SRZJUTqFhVNR-EXpXBRpg@mail.gmail.com>
In-Reply-To: <CAJuCfpGvLt+QDw+n0QnZmBqryMrX+SRZJUTqFhVNR-EXpXBRpg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 3 Nov 2026 18:06:59 -0800
X-Gm-Features: AclHuK9a3R3Bk8Y8NTBpy7q1LcP4CVXMf0d8lIiveKtvu79UpNEuQo-0lJdArDQ
Message-ID: <CAJuCfpHxk3nAnH7xsqGEtJFDo=ZVWKwWfmck5fSvuLmnrG647Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, ljs@kernel.org, jannh@google.com, liam@infradead.org, 
	willy@infradead.org, paulmck@kernel.org, pfalcato@suse.de, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 9:21=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Mon, Nov 2, 2026 at 9:01=E2=80=AFAM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Mon, 2 Nov 2026 08:15:47 -0800 Suren Baghdasaryan <surenb@google.com=
> wrote:
> >
> > > > Ah, I see now why handling READ_IMPLIES_EXEC is needed. Then your
> > > > complete fix looks fine. Perhaps we should mention this pre-ARMv6 C=
PU
> > > > detail in the changelog of your fix to explain why READ_IMPLIES_EXE=
C
> > > > is important here?
> > >
> > > I guess I have to ask whether you want to post your fix as a followup
> > > to mine or if I should fold them into one patch and post a v3. What's
> > > your preference?
> >
> > yes, please just prepare a v3.  I don't think bot will be offended.
>
> Ok, I'll wait a day for others to take a look and will post v3.
> Thanks!

I posted v3 at https://lore.kernel.org/all/20261104015447.363602-1-surenb@g=
oogle.com/

Pedro, I confirm that page migration will not change Rss even
temporarily because pagetable changes are made under the PTE lock and
smaps walk takes the same lock. It will see either a present PTE or a
migration entry which it also counts in Rss (via
smaps_account(present=3Dfalse)).
