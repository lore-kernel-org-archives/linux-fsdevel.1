Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EE43AA1A6
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716193; cv=pass; b=kgAiWrKfo0dW5HkY1uJm4Ujs7kXfAZ8VSPGGHrlj9x0AuyYgrWAz1zHYb7UiopXXkwYjb6X+2gBApzcI1+vO4ruT1gSX7H3cYsEDJDH2p0QeKhh+5K07XGe8fEZTntTEaPvEZhCqcg23gWMiKT+zBckrmLE+fKCXCJcgW3xW4rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716193; c=relaxed/simple;
	bh=AW4FkCD3SUXD8ZrW0GDFymuv20MYfPDUDhkF/gfjkRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0qYL9p1LtqvpviPKnF1H807Laj1+ea66l0erSWSdDght6Yb82/hgFo5k5ya8odKiYn8npYjchPziFG6PEkLZJQRYHnnS/U033Wfisc+D/Kuosq4bkbGANJYidm9if051ifRHdHETZJaytMTGYbav+RZlMF0Cj+GB54DN3k8Gjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f8RZNMRI; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f8RZNMRI"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso16495515ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 13:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783716190; cv=none;
        d=google.com; s=arc-20260327;
        b=L43YHSVmiLkDyjnoYpDok3dEpIBiEneeHKIPDs9hl/rs5tf7joghO5vXSpKlXAIzce
         NXgsQswuqsX77HYXV4eJfni+e6cZswEVwBK+LEVy9fDXgFiOKCNRRGatzOCUSbqOq4s/
         s6tq4djaS7JiImfh6qvA//7kS4FfRkryNBlWV2XbQv8Xl4vS1FnBwg8LIIWsJQdaD9aj
         +4bFrr774uUWlXeAUQ8Du7sGZ5lsBKrP5FCKcdxmD/m0kyMJFgiXnRKK6gK7q8mwsaRp
         UO/mlanK+RPOw4ddX7Sq2WpJeOAqBJ2cV+ZpaCmOGN+zeCXr5Ajb9kg2caPaRZpCHST8
         a9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rij+tAThPG/Dx8x9D29mBGM0V6OzQVOOyrCEOYUJZtQ=;
        fh=dQv5uffdh8s1i4bqqfpUFZvxBIBUiVbj2ysq23b9pLs=;
        b=rcz/H/OTxtS575edKSTxuHcMh7kBCnmpB2gMta6M9EpDFbaCH3JKJliE6q1KMa6myb
         0VEmlq0F/cMu2Npc1xa7j/TslxzrpvGB0/N3vijxedh9XT/azZTKLrke1HjRdyeBz79t
         1k3Slv3qFeMR1B5228WckXOyLloIyHqxb3dgHfS8xcSK2TzL6Zcx8q3dRvNcdVmOkFf2
         0PQ5mWqc5Db9bLR+8iyHQg2yoiSO3ingmLUa+ebpP+SqtfxcN18CzVaBUOsQf01WW9Aw
         6PocZRiFnePNl8vw27LA7I+qLtwkH4LtZgQPxtIkKQLEnlthcqKZzboSPWQagzKtSOCJ
         LIJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783716190; x=1784320990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rij+tAThPG/Dx8x9D29mBGM0V6OzQVOOyrCEOYUJZtQ=;
        b=f8RZNMRIwV8cXYXWMl7FZYx0azi9koz5gL8rCTdmi1yEDtGU3a48yowexrdENIYP80
         djFfJ1hBVHR/TlTdJT3yE7WTkhEQlhYtIN8LIBZJqXP4dLaLksWCKarTEKnp5nzEEvxU
         58NcAFJvwIVNl5imaBIZIYXPxM2swqfxDuhe4Es+YTX8q/LR2fkfcRcxQ1VMEAcadX8G
         lxYU7423gmaK/tixP+DOxEMGQjU/HZecdKhXkrTK9qlMagerGNzQhZgv2T0prCrGxXey
         D9kn6+/M9NzUZins1wWGTlmyVR1Si2F6bkaLFWNqyg63+LQLI5cHXJvRxypfQClwhwdd
         XRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716190; x=1784320990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rij+tAThPG/Dx8x9D29mBGM0V6OzQVOOyrCEOYUJZtQ=;
        b=Re1gbvowQxygCFDYYUVGICJozwURRtzGkHKHBAprfTHMGF6ONssHVtXRrSD1VKdF9N
         xIqtvBi5yc6E02BJixK21LHB3DYJNxwJmvTaZMO72cnDgMVi2V+J3Z5UjDHg7xU/c4Es
         5v/On6cNKVujmFHhuW/5K7KKuZpNLUPumEsj7M+hiqacpi3Fxqq97fTO71ZBvXGn3b+K
         kDWvZMvgh9P4/xD09WxSZ8V7n3efFdIEPBiwYv8C3CI3IDQj9qJUaLJVVgK7GH16we+W
         ey4x3XpMpOjKNLd2SGBao0BEM3iwbaWsUh0+FBYWGqlQLbztpmMTmTVcf4DZY4YDLAUF
         QiLg==
X-Forwarded-Encrypted: i=1; AHgh+Rpi1e1SvXVdvPiNlQItm9Rr90C+MFzD043qblGrghsMy/a467Qi90LHTBziRlC5e9nriTuxjlOGLz6V+02i@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2DYTEytOZ9Vo6XmUUa6n1C2K11bU+lYDIUqeOOEc6aUGlDvpY
	NqxGjlH9hjI8w3pjOgMpUKabqLYB1wBMu4Br4Wyz07u+KIouuqJYzbTWVfIMawpSaUS1Zfn1XlM
	fPF2B4oj3s2QZ9dUPD11UJ6ncNzES/DPRtiQcx7jw
X-Gm-Gg: AfdE7cnKxuDvGY/SEpwxcbLWoyjIKy2WMKZmT3iGyCbsCp9r+tHWAzuQ/UJ1jX0hPOB
	C9rOlqkLdN8sxk1/R4qE69k1rKc8BhmlkyPM4BQx71UFPl1wmoPRnGzFDK3lQPCrUanHDDMWwso
	6g2wh8C9FsT3mdN8bxkDu26wI41L9Luszq+mK+NSj38jOfUWuFshb+BDPOJEO6uYhWjVFk7g1wU
	bwuf6cUhXpSv9CtS1NVd0ZIJPb5Fl6EEVBgdsy+pg1Xw0yQLwrE68lpT1eEKlNwHbM0GrXW
X-Received: by 2002:a17:903:94e:b0:2ca:ecf6:9119 with SMTP id
 d9443c01a7336-2ce9e7a508fmr6594825ad.5.1783716190473; Fri, 10 Jul 2026
 13:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3d4fe99cd1665a1be0b36636aeeaf4ab@paul-moore.com>
 <20260709.kaemaiTia6Li@digikod.net> <CAHC9VhSVQ0MLwU=C90FmohAThwaQj-mfB7L03fvkB5A0-J2jCg@mail.gmail.com>
 <20260709.paitheut7Ief@digikod.net>
In-Reply-To: <20260709.paitheut7Ief@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Jul 2026 16:42:58 -0400
X-Gm-Features: AVVi8CfYFlCh845UyHEVb8Qr54KnQveNcsFxDbygGSFQDOXSJFwUEPgwYvIp3eE
Message-ID: <CAHC9VhSrYUWkt0_kbOdEuoeKdj+oSaFcY0Fg8t2SuUwH-=MJXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] security: add LSM blob and hooks for namespaces
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Daniel Durning <danieldurning.work@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 11:58=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Thu, Jul 09, 2026 at 09:03:58AM -0400, Paul Moore wrote:
> > On Thu, Jul 9, 2026 at 5:12=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > On Wed, Jul 08, 2026 at 11:22:17PM -0400, Paul Moore wrote:
> > > > On May 27, 2026 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=
=3D <mic@digikod.net> wrote:

...

> > I'm aware of the new hook guidance, I was the one who documented it :)
>
> I know.  I guess that means you're ok with that?

Yes.

Just a heads-up, and some of this depends on timing, but as we've got
multiple patchsets (there is a SELinux patchset that depends on these
hooks) I'll want to take this hook additions via the LSM tree.  I can
take the associated Landlock patches too if you like, or you base the
Landlock tree off the LSM branch; no worries either way, we can sort
out the details once the patchset is ready for merging.

--=20
paul-moore.com
