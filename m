Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FF346AC5
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271944; cv=pass; b=YAzvnm40LDGI5nkfqUEbxhLoKOLVPoPFEISunPuUa7LTFterk/YF4ND4l23oqL/9bM2QqvejXbsWifyJPflHnImWVUXqF+MKLKCZkCtZSWZHRmiJwdnEfMjtBUJsvV8X5J+2PVw3vGmRKgIVlCJoUnHBDKswXYnqZgLhfFqv5as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271944; c=relaxed/simple;
	bh=x0gOLNppm6yCyhg3j79uS80748lJ/2o4AAw4IIheMJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGsypKwM6BvDuXKVv4npieDv+VxYISZUp0OVm0fOXb3b3p4/nqQmEcf8HLrhshrcDt0MJaxnbKTPnEcGUoSWdbNSuVei7Mprsm9TKTY7aKEhpYDr9ZyePPK2XxEUVCmL2dF4aDK1tDO6KA6v+bXqa0AN4Wrd+geLFb1D/lTxw48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUwbFHgr; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUwbFHgr"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so113532f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 13:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785271941; cv=none;
        d=google.com; s=arc-20260327;
        b=AdiGR7F6vb7FYwWXCllRlSGfHBJ2iEsJ4yZE5ztRUHDzLCj5omjkZF4SuncdyFHuWm
         kdT+s/WRp3t6GVnYn5O4cOx0I8DX5uUIqjfZ+Sgs+qIx2EIy00o70aS7ClaKpFCYRCFQ
         R+FwKfp6RDLBJMNb9Z8fJC2ATBFpc9ZJln0zqhIN7OHkscF6/8vlO59tcT3NRUn9KovU
         cD+TMq9pXCFnri05chqV0O0fzbecN3GYtF4a4lJ+761uaFHKHZtCwRI6sH+P3EmnS7L4
         oLZN9gcG3eOU8aKz4YTqEkXI/adlg3hWPyn/Wkn6623cREYvdNb4DVH85Od3D6m+C/o+
         D6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x0gOLNppm6yCyhg3j79uS80748lJ/2o4AAw4IIheMJg=;
        fh=ncb5BzEetvGucww7ZLymflrsnYd+ASX9fwWJ/VRm+UQ=;
        b=P+kuXQnlYC8s8+trdiOokkJSV/p5AXZBDZB2RgxA7xmMTMdq/v6oxd2fz/Glt3xayM
         R//plWF9eX8Rly6OV0Kk/NA0+eAFx/Z4iNGltxCRX5/r6Lej7tcj/kyvrsjeXVyElOqK
         Up0/Z8pMCQV1KycSGQ0szvoh53djOLpj6HQxle1AriCejnfyRB0KWDYqMpzIoj3+D2eA
         pVfm7/mkMWnE0N3BWqqL6n8/bZ0oq0X9Mh5Bn258ixM6A1EKItw/k7BdYTDtdFTTzy7V
         M2jDh7NEKtNfScrcLlknGExf2j8HnawZ/WIdP+J7/6nDF4iHatZyXdbjYMtRlIZ/ErEe
         ZjLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785271941; x=1785876741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x0gOLNppm6yCyhg3j79uS80748lJ/2o4AAw4IIheMJg=;
        b=CUwbFHgrlTBOV7vCWObEuQYbWJUZ/ILkyvylC0+prD60NfsocM/FpkrbMy7GesnKgH
         MSf8L9vy2x7HNHUJVV34WC9Gq8OODE1M6J5PvjFq1Oe/TMIXLRoKlLfCZvbyPY7j0LGs
         opUh66hU4bBSsPzyP1Eit9rCz9QtRsa4uq+x163jzBABLo0aLq4dhbBK5Wc1plrY0qGa
         jdutwwpypaWYwOVRpcMVqfRg1ZiCNfJlDP5/krFSGJIc8SRV2RnSOOWe0UZAkxMkiiZM
         EkBpPaf1FDYE6dyvSmtqXndrpwkp+zHABw0REvA4mksEcDMzr2fZtq95vwvGufZvB3TS
         7p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785271941; x=1785876741;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0gOLNppm6yCyhg3j79uS80748lJ/2o4AAw4IIheMJg=;
        b=jMrOYje526mrI87lWTESy4sx8CqasbBfPKVI/zVnI92zVP10cceLRHj6Rl1bvwOz65
         Fh1D19lbqmbGfZFQ33knToh4T1oYVbn96Hg7L5xN2S55EKS7ZAhKuxp9dFB5o8MDMKjX
         SBrtChDA2A0I25QwxHZfcO6v61qR6fbiEzm6Rh+ouFhJjtWg17kcY0ECJ/zeRW5uX21V
         TG1ap54EQ+Pqd7EIRymLSp5Gj06nqtwG7Z+Uj1Tv+LNa+/WMD2UE3qj0Wqo6DluL2Ybj
         mIIGc91dOLmRxTnRhkaPTeVdd61nm23Lu5nPzd0UNwSN1uMcS3oUmOBpJaquKEzoNyj+
         sFDw==
X-Gm-Message-State: AOJu0Yzp847yqtabFmNRgaz995P8KgbaBqN2lGVvDKaZLhoZUef1WiH7
	UI0vSalNasRL+t3F62c5IuSt4YxpbkYfvV6vWHeZEd5Jj+p3GtCaARpPehr4gLACb8mY0a+O8dK
	Aue4Hzh3JzhQ1/4ClgeXzyjaCisuUth0=
X-Gm-Gg: AR+sD12CoWZA/zGI9hCelPnWUOSBxjeuYA+ViB+BOScMog7MmzA3AenudJk3z4mOkBt
	gVQDwLYdWPSuRPDoLxxoRQ0FlR64Eee0CNgIxOIcfag4SbGulbVes+ulMW3Co9qtxUfEIAJgMyO
	3RcFbZ40PV2BRQFt5DxkPJwUtKZhpxcVpLp5HLYeFoyaj/zmNyAOiLAt/MkFmcmlg4a77SqGpQ9
	ouzsyKXf3vOHa35/cktRS+h6is0UjKUCy0Nxj6Ts5cmFaYyj5M3+GRkDQK/38VOxivIs1G8Xd74
	NoMflxngJp7qIP7OwDSDxQHnEuV49ux2sV4JlqxXqw==
X-Received: by 2002:a5d:588f:0:b0:47f:6fa4:58e0 with SMTP id
 ffacd0b85a97d-47fb1ecd60cmr4789362f8f.35.1785271941075; Tue, 28 Jul 2026
 13:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728183005.92395-1-bfoster@redhat.com> <CAJnrk1Z=qohEjesFFn-YbmU0mqSPkMH_Jy+E6qSCw4pM8niPhw@mail.gmail.com>
 <amj_MJOEzLor4jMW@bfoster>
In-Reply-To: <amj_MJOEzLor4jMW@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 28 Jul 2026 13:52:08 -0700
X-Gm-Features: AUfX_mzrJuhN69emZJWfSa1QnazdLTlnFhnQh-ljjOvvrXWQXoeHTl0KnqVQ1WE
Message-ID: <CAJnrk1YME2vEunO=y6WhqVr0hEO+QXihyrFNa+sisKR4j7-=tw@mail.gmail.com>
Subject: Re: [PATCH] iomap: release the folio batch on iomap callback failures
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de, 
	djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 12:12=E2=80=AFPM Brian Foster <bfoster@redhat.com> =
wrote:
>
> On Tue, Jul 28, 2026 at 12:07:10PM -0700, Joanne Koong wrote:
> > On Tue, Jul 28, 2026 at 11:30=E2=80=AFAM Brian Foster <bfoster@redhat.c=
om> wrote:
> > >
> > > A sashiko review of an unrelated patch points out that the folio
> > > batch mechanism used for iomap zero range fails to release the batch
> > > in a couple error scenarios. If either calls to ->iomap_end() or
> > > ->iomap_begin() fail, the direct return paths bypass the batch
> > > cleanup.
> > >
> > > The ->iomap_end() case is not a practical issue at the moment
> > > because there is no user of the mechanism that returns an error from
> > > this path. The ->iomap_begin() case is theoretically possible
> > > because XFS can invoke the fill helper and error out at various
> > > points thereafter. This subtly complicates things because XFS does
> > > not transfer iomap_flags to the iomap data structure in the error
> > > path.
> > >
> > > To deal with both of these issues, first make sure to invoke the
> > > cleanup helper in the error path for either fs callback. Second,
> > > update the helper to clear the flag unconditionally and release the
> > > batch so long as it is populated. This more clearly delineates the
> > > purpose of the flag to control the I/O path and not necessarily the
> > > status of the fbatch, so add a comment around this as well.
> > >
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Assisted-by: LLM
> > > Fixes: 395ed1ef0012 ("iomap: optional zero range dirty folio processi=
ng")
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >
> > > As noted here[1], I'm aware this conflicts with the outstanding iomap
> > > iter rework. I'm happy to rebase onto that if that is ultimately
> > > preferred. I've got at least one vote to get this in sooner, so this
> > > version is based on 7.2-rc5.
> > >
> >
> > Hi Brian,
> >
> > As I understand your analysis of the bug in [1], given that it's an
> > unlikely / second-order scenario nobody is hitting in reality, maybe
> > it'd be easiest if I fold this patch into the iomap iter rework series
> > as a preparatory patch (keeping your authorship and Fixes: tag), make
> > the needed changes in the iomap iter series to be compatible with your
> > patch, and then submit everything together to the vfs-7.3.iomap branch
> > as v5 of the series? I think that avoids the nontrivial merge conflict
> > Christian/Stephen would have to deal with.
> >
>
> That's perfectly fine with me if you're Ok with doing that and nobody
> otherwise objects.

I'll wait a day for anyone to object, and if no one does, I'll send v5
tomorrow with your patch folded in.

Thanks,
Joanne

>
> Brian
>
> > Alternatively, if you prefer to have this as part of 7.2, I can send a
> > v5 of the series to try minimizing the conflict, and then send
> > Christian or Stephen a diff for how to resolve the merge when they hit
> > it.
> >
> > Thanks,
> > Joanne
> >
> > [1] https://lore.kernel.org/linux-fsdevel/amjztG-DisHYbV9W@bfoster/
> >
>
