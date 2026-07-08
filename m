Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5843849B
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535398; cv=pass; b=qxNxahVfQGnVuTWLbmDEDt45dW3SlGM4YlWMMrfHNU3lvoLSjap3swLv17rjOB/r/RqnndXfjBSUVr6ijABiGfjL9uVj0Y2D9VkQE1ZaV87uCuxsvYjUfmUmQyj7U0bR2NQnhgORbBM3QQ+GBrTCBy9/CgjZzGfYp8SvpFaBo4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535398; c=relaxed/simple;
	bh=pQeqcIXmxeqjoaVrCDS04nFvHctcdWxWhJguSVtNa6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqK+5ohVSqBHWdkn06rF3yEv1cpta9pUpgorBp8kAe7qMnlFf9/b8aHSJeYP3VFYLaqSZ0VskE2qghXcHJVAMID/PlJBWi2xnxsA9tzeIzk5Qw/3hGxwtKtnIqScgwuIVdA3BozdtCrzJx529qA33lO1ocyKFZvl4iuCGcrG47c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZKU2kPb; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZKU2kPb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so950946f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 11:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783535395; cv=none;
        d=google.com; s=arc-20260327;
        b=ZpFhDOe6wgj0H0fwS34/YfMiQzhMpwLKTmoVPgp0tsKDkKNhPFtFDiMUZjsVWMqugw
         5idstWpiKfm50KaEQGamt4xHMz/ZbinvYe6nC/g3qNU4STtm/AxwGS1ZhzxM0ACqdWsT
         N3j2UWZysXWSuf1Rkd3Btd4JYmx23xMOqwBfAXpBl3fBG7Gh4QOC2J1YtBTdrI9h9q5a
         AaDFbrG1LqwkF7S9Hw8OetPFuecZuYlc0crikgUBIw38taYFTRurlaUKS4HlxsASWi89
         mEBxnopEnEsaMzm+tbadcE/zePNVdUtvqPsRdJPWM28yqRpuqH+vu6vvOXY1TvZ3XeyK
         851g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pQeqcIXmxeqjoaVrCDS04nFvHctcdWxWhJguSVtNa6o=;
        fh=47RDgLaJUvxfy+9haJVy7AQGTDjAvInnRQx5JiE73Z8=;
        b=efxXZQS5/Fg15/5sOz4iRQLUzzdw47Xksqcq7hHrasZshyzzIuy5DXSQ2zbs8MAiD9
         laHwRjjbpwgNe+n/yc/lBd73EI6C8TmriNMQtMktJoHnMrSwnnjNJ+ZmhMZO5q9CZi9g
         ATfLJ9DidRFeHhl7xHLBT/f5QIpQ4dhcF+iEztiX/v1X3+ItCam+QgNdwyefC5FtOyoT
         ZCS6m6ZL3fvYJzP3kWZag5NBqZ+8b0W+caRg2/vZuSPfAQh5mdbdUdHevk//LUDlmKup
         YTJfxF4Nx9Zo7mPZV/3j2ALPXXimVHMYXlpMiy1/Aer+Bt4z2h2Kl+AjubcHHH3UGljf
         nqkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783535395; x=1784140195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pQeqcIXmxeqjoaVrCDS04nFvHctcdWxWhJguSVtNa6o=;
        b=RZKU2kPbw8HHHfhWfZb863+Ls9xMdtYHkeCYY02EqepU2VT4ymi9a2+kxMtYlaP1zu
         piIEfcVSDknSdhM/JN3edfsPoXLG3sHKf0xaL5JGo6UOulVIsDPXnYwjg/O/NO3FDKJs
         uDyRzTbEh9xZH7MOVBEXaVsS0xjnEqyaGUGQDi7mdaBv5G4SYtTshPPTT7m301+NuRd/
         l7Ovupmtt1jBzoUmqCKDLxYxqzSwR4WBugXVu5WJh28LtJ0Q96wqxePI9p61mZLOMAMK
         Ej39FY7rywNQ2+WtPFbQVEh2H5PHp3FASqcEArT9XkQHEsObJG1BodECeow53KmP+81j
         SCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783535395; x=1784140195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQeqcIXmxeqjoaVrCDS04nFvHctcdWxWhJguSVtNa6o=;
        b=U9Qs5gjXfTofpeCmGqDKVxrHqQlf/rSi08a6LHjLukMX11UflEqO1iJiY5rsAwx6QG
         enXk0W+gVomxNuMWHGmriaWsxGQJ0EhaMNIDwLAtPPiyZpSmGUJGeKkux5F8U85ae2gF
         TFSgyvsPH62Hcm2NcwRzNAyb5IXglu/GGOAmg5HP6E1b231K5K7/t2V6hwSFiOyYhs5/
         Nw6zighpZSqeOsJJaOSGg437NSZqRzZU+GwFXS4OprDekFLFAjIDb0Vz6kOm563m8x1b
         /yoQ+0FlGxl6Ew/+X6sdVaXAFmzTBOzroMwYTuTT9Hhaz386CnLpcZwkK9b4djlBuI7i
         JArA==
X-Forwarded-Encrypted: i=1; AHgh+RrSLRZYMoe23cgpBR806PnTybVTXn8468zFxf5p0Qhjw3jyAntzQHtjqz1lSb91thclfJU4t5dXJhr9RWEb@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKoV47OpbDXSonB3NQTxaanmc8jKJqMQiAjotV8MT4AoRrcyw
	hmhTqFyoiFjK8zP+p4d/mITYAiiPp6saf7CAvw3v2IFDPcPj9vuON/w1E0VdTgyZ8WvR/dxdgrJ
	TjBL7sHxmKy28PrR8ml2j+MyNKNEb5L0=
X-Gm-Gg: AfdE7ckk/WoAyLPy+5vsPp7bx6PPhx2Qeypp2RliOvDCy6Ejwa0AG0JQcUV6jpq9B4X
	qgQYExIwUU0guXUVArB2xE3fASZ+KglPOSluNsGIvi5UboIa0zFIKpk45SCfy5vSeLSAP1tJv07
	N7H0PboZbCTAAstrGcB8WKyCPjks3ngX+ahR8dQ/J1XwTbRI1lsi0cyDm0E/0Pw0RaMymyAihzn
	POLbQLTHx+gnmTndarZQJD4/oNQ5mo86wclKJd09gIT2qSHFD+MFtP/seli8pJA6bPPNHjrt68m
	dxDa3UaEH//Bq7rZfJu1BGDPmsJkjyiqwokRxmm+MQupA3b/hp35
X-Received: by 2002:a05:6000:4387:b0:477:80fa:f44d with SMTP id
 ffacd0b85a97d-47df0767064mr4043753f8f.40.1783535395354; Wed, 08 Jul 2026
 11:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707220450.1200943-1-joannelkoong@gmail.com>
 <20260707220450.1200943-3-joannelkoong@gmail.com> <CAJfpegv4t3GBU9efQXTWgPSEsGRRaL0OAeZeph5-84eoyRyFqA@mail.gmail.com>
In-Reply-To: <CAJfpegv4t3GBU9efQXTWgPSEsGRRaL0OAeZeph5-84eoyRyFqA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 8 Jul 2026 11:29:43 -0700
X-Gm-Features: AUfX_mx27aKltMWTZ9oFz9G-tRcUlVFiaV8_kmOpuUyW1ZdshqDZiXadYtlPtPg
Message-ID: <CAJnrk1bP8K_LVWOHwiQ_PGw_27HnO9O=XVm4L7UR4+0zvZW0Bw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iomap: add helper to mark folio uptodate
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 2:17=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 8 Jul 2026 at 00:05, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > Add an exported helper iomap_folio_mark_uptodate() to mark a folio as
> > uptodate and update its uptodate bitmap if the folio has iomap state
> > data attached.
>
> Sashiko has a non-regression comment about this:
>
> https://sashiko.dev/#/patchset/20260707220450.1200943-1-joannelkoong%40gm=
ail.com
>
> Can you have a look, please?

I think this underflow issue was fixed by Zhang's patch in [1] that he
sent out in May but I don't think that has been merged yet. I'll
follow up on his series about the status of it.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260514062955.1183976-5-yi.zhang=
@huaweicloud.com/
