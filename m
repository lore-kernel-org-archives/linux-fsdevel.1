Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E71CDFCA
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663571; cv=pass; b=F3+Bk4ORwjoVnn1s/X4dhXTe95POwy1kYgyHjNio1TFESitoGugxcpYXkWD1rc6v1KpqWztD2E5vNvVUmZpnMJJe5kIlzZL/gyj2hq+p9171WMmBzsrEZJnbrGhRlrG1eB2DiW1RJE2t+9+VvXGX/OhAeVhDRyZxfzPzVqB00wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663571; c=relaxed/simple;
	bh=xG2DgqZGuUaGU3ywEUgEkhOK3PRTvPd+4WM++5gnIv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTVok9sp20J3r7VDmS3EQDRTKj7KCYSbkpg7lYyb39qIy6NC829wwSH1WQhF5lD+TNpbjbtcSMuDu8Eh6IwNT6gZ2EO6ifs/9sS4KbErsXkkx7jFPcn9jHXBwF1dCe+QJI9AwlZzU8w9JHld75+VLNB2c64kmhCH/KCRkRH5df4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G8eftUyS; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G8eftUyS"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c85d8615b09so3107929a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 19:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781663570; cv=none;
        d=google.com; s=arc-20240605;
        b=QseiUeEeqe6tL4pWyWj8xXZzYNvAG9Gi9I4WaqojXKazJw3BmauMhtkniyRezkEx0U
         cK5g0CUK9TTScyBYc26D193YhuGQB36qzvFjiOJg9tXjTY+EvCtnXRIP1u4BbAiJUpz4
         veBBBOUTQxN9uNNzvuZMa6LSykrRvs7h8ZeGL35rV1juqVkFq09jDHBl4k3l/mYof0pj
         9qKz3ZVYPiIAgRukZ/Zr6HdMsJyPILwe5JswgCXlGJWiuDwAjgqO/rV1exNaS9O6jB4T
         mPODnCUoZgXD4GlZ5F9YaBu8bSnWXubUI71uo2nT19444HF0L9avXiPMjL837GFG5nbk
         iauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZTdV3B/ZTo07f/R002Ay7yCKDKVa4MK34m0NvQKlnk=;
        fh=mqOdxVr1v94kjRTt1aTh9dyBWcQzmfdt8cEDxnA4yEk=;
        b=dxQjQsWDD1WxMQ3TFpAivm7XFXd4fZutJNP5YrKDgo33pBwA1JEiaf5jrcm8ngY6GR
         k9f3z2094XJMcXPp8NDm4j8UXWYUA0Q3m3u6RKEcU36AurxTBRyb+Eihtr/FZIDHMKPY
         rxv3lcjpY3zugKRwPgQTuB+c3DDj9vYIOkJELknrLJBgn6aQ5/T7x8PxM+oyfDqJjR7q
         ITFTraRnn6S1zZgx8c1UGIKrE/2IbjOjXlrBBDxWvDdhTiX01OnVgpD1P33bvBf/dGBM
         c57Xzulm8hU7xcGlMxOS4Kcl/UjpVB1VJsNiFiA15Wtb9am3Xa1M8CceAA1N1xeimDae
         cUkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781663570; x=1782268370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZTdV3B/ZTo07f/R002Ay7yCKDKVa4MK34m0NvQKlnk=;
        b=G8eftUySTGq/7XgDcNG8jomNAP6G2ktSJTTM6LC3CvdfdyXja4VGH+md1BO5BKAsld
         AX8t8F0SeFiPeCV9O3YQXeFtGqju8GHthCl/fbioQdYXtvLyDZClq1IoJdMS6bvnQljP
         3zsVyzxrRtUcwkWrqEcY7gPE1K2lngppCJL5T5wx52iAG4hbStVZaHR/RTMcZaJVkjBN
         MYHY3E3RohPlLttTKdqlqr5yuzWXcyEDK009qMYJcL1e7cjTq+0aFcCFjFC23EfxV03S
         RlEif/Pe08Hm7aHxboHsEGm03/82ozBV/ZbuPoreuDhjQeCs2VVdNp5N2BUuLULtfg61
         ZnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781663570; x=1782268370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZTdV3B/ZTo07f/R002Ay7yCKDKVa4MK34m0NvQKlnk=;
        b=gLqVPv+x8r6vfqyET2O0uIfWLb+i8Ak5LdALlXRJdh8WsGaRmCKIdhrRbya+iTo4b1
         oJ/urx7CMljaD/cGEtY13P6V4g7fhEYCg5LmNDj3UMxZK+Bzpr7Qihw38XO3+olO9m7+
         yr7MxN4Vy/554fnxDI+9woY7J5GZkGZxFSFRT1VKDFglH6UT3gXyJM3wtLTgL0YvOH9J
         P6B85ru9x4cL2gg98BAQdT1scBAmZom6vEXznBGemDW3A+1WIBANkuD1AtYvR2Fo5LWE
         AQvX1XUIvWyVVlxunqQhzm1zmgarfhrvP7P4YQtrUFoDQJPKGYJGgAmw9kjr7vvtG+hv
         19gg==
X-Forwarded-Encrypted: i=1; AFNElJ9E1Q8RJK3/rBCkqplzJ3NpjgPh+94gcuAVTRo2F8Dscl9eISRTbZh96iCvlHQYocyLOn4wUFXGTXqu9uhp@vger.kernel.org
X-Gm-Message-State: AOJu0YwgbyWO8akUXKldkY0VO/8WA9L+O1D5A/88L8K9NMQWL8HrXJyB
	hh1g/6Q/zEId0e2MLEjQQhKQXXIuXYhkkQcqc6mTIX7Cq0rFvGn1fCADNB0ThPuoLwKHzqE8Hzl
	AabqUv8AmLLkDATy4oFgKf6H9zQ+vBymTOJpibHfp
X-Gm-Gg: Acq92OEakJE9O8sMVSPaJESRllD5LzD8ZxFHfycuuGs5GXLANpj8haFYm/AH/EWXm24
	i174Y8kHatix5B5/a04Xhwm0qwsVlAMrtkUMlLufjds/vorfbNLxAXaaTHa6jiswwKU2O/2UMgt
	6amjqiyGhJpM23PPe5jJpQ+uWjbw+YnDvebMzViKQDgXj8vQvjmsyT8aru5K/dQ0pFarwmp5opj
	k9We8Dy1gc/QfC+BczM1O0Uxzw5plPfB6g8bpGxXRJQfUFrLOh4fgvyoQ1iJVoxP8HRi0kL
X-Received: by 2002:a05:6a20:2d23:b0:3b3:fdb0:2295 with SMTP id
 adf61e73a8af0-3b8b5b28234mr2192226637.6.1781663569701; Tue, 16 Jun 2026
 19:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl> <20260614164438.2980769-5-jkoolstra@xs4all.nl>
 <526417482.1849950.1781559782000@kpc.webmail.kpnmail.nl>
In-Reply-To: <526417482.1849950.1781559782000@kpc.webmail.kpnmail.nl>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Jun 2026 22:32:37 -0400
X-Gm-Features: AVVi8CeBzQPsndw9BAmE-isUeqXVnMvX0g_IsdGEMSwro9rl0HZmb4E-x0wn-Ws
Message-ID: <CAHC9VhSBOQqjQ6A+f4YEJZmWVxVqOrRbtj7hF2qL_-vCCBc2Fg@mail.gmail.com>
Subject: Re: [PATCH 04/12] fs/namei.c: lookup_open(): move audit_inode_child() up
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "audit@vger.kernel.org" <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 5:43=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
> > Op 14-06-2026 18:44 CEST schreef Jori Koolstra <jkoolstra@xs4all.nl>:
> >
> > In the mknod(2) path of calling vfs_create() we call audit_inode_child(=
)
> > before permission checks in may_create_dentry() (but after path-based
> > LSM check). Copy this behaviour to lookup_open() and move
> > audit_inode_child() to may_o_create().
> >
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/namei.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)

...

> CC, audit@vger.kernel.org
>
> Went too quick with this one... audit_inode_child() probably shouldn't be=
 called
> if we are in the lookup case. So there isn't really a way to do this exac=
tly
> symmetrical to the vfs_create()/vfs_mkdir() paths.
>
> But certainly the current implementation is also wrong. In the atomic_ope=
n case
> audit_inode_child() is called only once (in the final fsnotify call in
> open_last_lookups()), but in the regular ->create case audit_inode_child(=
) is
> called twice.
>
> What behavior is actually wanted here?

I haven't looked at the VFS open/create code in a while, and I'm kinda
swamped with other things at the moment so a few pointers would go a
long way towards helping get the right context for your question.

We shouldn't *need* multiple calls into audit_inode_child() for a
given filesystem object as long as all of the information audit needs
can be captured in the single call site.

--=20
paul-moore.com
