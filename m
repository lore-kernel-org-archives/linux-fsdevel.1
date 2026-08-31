Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726249F11D
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199306; cv=pass; b=qlarC0Gzbo6Eff13pk1l+MFcWe/wUjn0NAyD2J0Qm8uZcNpax1huK3JQn6v9lDtKGxF+N+KabkgsUl7/VH62W6w1JXMqLBGx9vlKJ6MuxsTukVLP5ATeqYusEr2hVU8lw5z+Fn33T4/1Ml9lGaznjGBwxAHLdAtu6H4yU7uv9G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199306; c=relaxed/simple;
	bh=DN7ajB5HW+161pKga12XB+ux9+zyLcXTHDVln4XJ3u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnbZUj0a+utJrcR+iU/uDPkuwkw2FiTaQFWiFqmhbynRmAgd8Mfz740VJ0orsRO+C9/6fM4R7rYLMfTMmV/d68axw/crPwhmfYyOwvxTaIVsJrEiDbLpifj8n2QQTgiyrH7GJRmQf5MWKGSGgctrAcf+fpDpqf8VNeIW2g2Z+TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TmgoL+AX; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TmgoL+AX"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8535a9be75eso2872238b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 11:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788199302; cv=none;
        d=google.com; s=arc-20260327;
        b=NVtg1yjpIVb6OpTP5B33TBmCz+Rsr4HQh9VBFN93UCGmh6eclqCKK3Ao/aEC+5MkCl
         28gAtD2Gj77YrU4R9GxHLwkhd53FNOEPBqMEJ/Z3XSOoXK5IDMN4j87o8V1lS50pVEH4
         kxrKZ/T+3ZgnEbDmOURYSkT3ICkztugXsSCcb8ZbOQtPfrNSWh+I/YbhloS44ATJYZn9
         pxgoSUmeGGP1tH/RD2dzjXDz6DPWKvqFuUJtShPJ/53qd2CVqSg2qMPbobDupKi8ZFmS
         g2n9Imc8ommKW7dSywZrNfD+sjXoT+Cqu4wn2zUFAmLHoaeMGccIzzqx/wR3wBTQoV2c
         BKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qcH86xjgshAXJpFP6qrb20Jfgu2TTKubE4sb7Xw/UbQ=;
        fh=5f0cxze56e8Rda8MlgxMTxI9i0Dd5Tkn24S0vzrTL0k=;
        b=aQTqHBBWRKB562+rJf05iDFbuLRp+1BdeNgwOm4gfelZhUYsgzHXotjC0Bing1LbUI
         d56VfKZDa7j1YxxuGfdRNiCJZ51uzJwYESY6FiJ9puz/jaQb+A9Fa1FhsLGLCFG1lEb0
         0PSulV60pKSeSEImegkqas09I0dn0lqGcdS0oSa2fqGVOs5ABjNkEuDDcP5aCGU+gw0X
         lb0R5srbpT4ClyL9D9Y8pyosq9kyEpGTpqThVJNOvxcauoPnzoh5U9TWPTTiv2IcTkfv
         9ozejWLug1cYgSth4Lj73y8LU5K0blxzE7cDkVZ3dWjtg+6PppIZXguyBe2zfbodG5Tk
         7+SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788199302; x=1788804102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qcH86xjgshAXJpFP6qrb20Jfgu2TTKubE4sb7Xw/UbQ=;
        b=TmgoL+AX+K+1e+0xEF544/bUrWJ3T3a80izkqNfqNAKO898D8dx8I5/igau5wIciZA
         vv5WkZqD5Dy+XtReibK5Ct+B4wsdewKBKTguNt7YWEC3tSvy3LpjsMmN3R6UMFJ9GUNG
         sZawzTAYN7cWNQIAnORI2I6foeE6YDpl9p5NrUv9i/ax+ax/Bi5DIzB2XI4KzlsYc3oN
         VqH1GJB6jHJaMstxshrYgxxFObIJmQgz379rvIFau6q9DbkMblsZrQQ+vH1jjcDYDcKE
         kPspNZqPeAW/1UrrPh0NAxvvWqxEU0Vy2m8QiXn/qphWxO+iARdvnPNB5Ot9aIGIgr4U
         n29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199302; x=1788804102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qcH86xjgshAXJpFP6qrb20Jfgu2TTKubE4sb7Xw/UbQ=;
        b=dnfXMD70zaErBWaA1UylnmYsMJuBgm7/ShMLsOZ68VYHdIBgE7/4Pfa+8J9RmCH4JP
         nNcX58Cox+KA8Y1xFy/+hQONa+jvi3Qq/RTlXycvJAbHXGikqHVxGQmZNGYyBLoR4ACM
         pjrhtscI3+a7C3KTC5qb40RcxBLT4XslYVOzM8trEEbdMPSTbyh90Qxabu9JUkYOJwhU
         kNm37QxvgJxx+Ko0Igpg1O24gXvhKrMlwvPlTfxHFEO6NHjH52D4CuQ4YhmL+z4FjCxe
         C5aiMppLGCv4qdwH1E5dG3O3SafYbge8lru4rfq0FbeSyf3yCeDVxTd4QuyOwS4Mm0qk
         dZcA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2TPRj9tvTyjkQzr13Sh++pOTfb6PWRMKAYLcvZ/3daZg5t0+lRtu+9yphcFUQJXDBx2uxEts4kM/c/6gE@vger.kernel.org
X-Gm-Message-State: AFuF++lI2ONwHVdAoyAMYeDj6fb0UHjC1R/Ag9XoZX9Ry7a+uMmiE8DK
	0wnEVg57L/5IhHkXFXM4s+1Kv+/A6BYjc8IhG5JKRdk2m/6+R76BEdmsG/dAysXomjnHd1a77F7
	YULdjmbSwJq/bsgcVAjRE/clA6op/zgdUCs5aLSe2
X-Gm-Gg: AR+sD13c4Zza1MP1VvvNxjTIMDZHW9tRX7DxbUtw+cr5twrLWp/YI3LBnZVEmSCFUlL
	OtlC4wfn54f5glCXVlhl56eSSRTH5UvbR2c6qpsSTyqWCNb7BMxj+24w80IxGLAs4z2pFvxeRfZ
	Z/Kk+5gbxvOZ3nRZYtlfX/p4p0f0H8hiqSIs/MvO/6L16deCtZ/fvSyKpJ5nH/6o2x3go16c9yf
	E57pyZ4GTJzeFLnhWvY5rFrBvi4+DgBQ+VoYTp0kw1L5JkhMFd00M2U9gf6YUiK/BUYwTUo6wfx
	2SkCtKzQ4g8wEiXVvcV5/rG7+cM4j3C20EaPXnjieHPu
X-Received: by 2002:a05:6a00:802:b0:842:7296:dba with SMTP id
 d2e1a72fcca58-85629064fcamr42578483b3a.7.1788199302293; Mon, 31 Aug 2026
 11:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef5bf18a4b3805ec0fe5fb638963ccbdfc01d6fe.1787077711.git.rgb@redhat.com>
 <65425b98ae226a9d19f89bd66a1defbe@paul-moore.com>
In-Reply-To: <65425b98ae226a9d19f89bd66a1defbe@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 14:01:30 -0400
X-Gm-Features: AcwNN1UjA6EQ0vdTUMZpIzMqbTR5XzQsbvy_jGC-ejOGutXWjivMDB6qbx9VHhc
Message-ID: <CAHC9VhTAe1x5Fzj==SanTP85wxi+XQ5N2-m98fdxWmcAeM105g@mail.gmail.com>
Subject: Re: [PATCH v3] audit: free proctitle in context so it can be re-set
 by fork on exec_binprm
To: Richard Guy Briggs <rgb@redhat.com>, 
	Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, 
	Roman Dolgikh <rmd4work@mail.ru>, Ricardo Robaina <rrobaina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug 18, 2026 Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > Between the actual process startup (fork systemd) and the executable fi=
le
> > replacement (exec), systemd sets a temporary file name (executable file
> > name in parentheses). If an auditable system call occurs at this point,
> > the audit context will latch the temporary process name into the cache.
> > This name will not change again. The patch clears proctitle into the
> > audit cache when the exec call is made, allowing the new process name t=
o
> > be latched.
> >
> > Suggested-by: Roman Dolgikh <rmd4work@mail.ru>
> > Link: https://github.com/user-attachments/files/20751461/fix_audit_proc=
title.txt
>
> I did drop the link above from the commit as it is contained within the
> link below.
>
> > Link: https://github.com/linux-audit/audit-kernel/issues/170
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> > Reviewed-by: Bradley Morgan <include@grrlz.net>
> > ---
> > Changelog:
> > v3: use previously assigned context
> > v2: simplified to call single use directly before need in audit_bimprm
> > ---
> >  kernel/auditsc.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Merged into audit/dev-staging since we're currently in the middle of the
> merge window, this will got to audit/dev once the window closes.

... and now it's in audit/dev, thanks!

--=20
paul-moore.com
