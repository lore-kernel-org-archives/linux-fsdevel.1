Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02104DBD70
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002182; cv=pass; b=iWS2vuZ4kOmqT9vCLF0wuRpr5i2Dx5SwjYwWuV6kUjUGdoxCNIN7saekc9jhYHNkUpS+H6gmF6FC0GvAUjslGlOrlrenU5P6lItQYxy8hOc/EkACniaG2LyHJho0dBNTbMkEcBswp+OVbveRhsrOnwW1rX58pI8biAHZIlvKg8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002182; c=relaxed/simple;
	bh=rlGJmIRph6L87Y/a4YB9PrGgW1WSQ12bPAK7QlxOnOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bN4scfyTdUeQFrBqWbQE/zx2ACFLHPwF3RjhvuH1/SI3ncLSfKFJW3HsHBnyQOUDHzge2AGljdYBbFPUZxNAKpt41E4WZ4D80R5RaU3dQWthzw+dkOBFNRK9NpcSrnSr/cRxIHH48z6ybZLE3kBBlilW+RsP7kLG8fiMQWKjlEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQTEVmPm; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQTEVmPm"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e55b62640so97018685a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 07:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783002181; cv=none;
        d=google.com; s=arc-20260327;
        b=Q2TORRovCwGDMVlMPNnAZt8xU441yllebktE/ydWyWvgmO5cSPWUmKssbJexx5ZiDp
         Ihla78ko5QDl8dZGwsF02cMtfHI0JO1ZqpihBoaQsGQ3ojTbFDZysvgrpBC4sTQIRE7P
         dcG+3l1+pQIQVmZNEguD0NWxKpHrY6d++mUSmyLbTObadgvG8GlxeTc4w4C0pHAexAU3
         l5PzOLmR2T9YbRbI2R9UInP+gZ5xfF2XYRWylB8N/5TsbtWv+r03yXmGksyO2Zl+bPko
         u704hof+cc6cx4iz8UnCP7ive6dOOZgFUL5IbiILF2K3OmMLfIwtJ4cZ4ZBtK18XAb2q
         IZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gbH3YLpoRRRBEQibj7D2qVYcaHe6y8OssH9lEWG5bD8=;
        fh=2lXlf7S2yROCvMY53p+Ml0CMAchcO9ogfGKvDwbuYNc=;
        b=WB8T9OglNAe0RJZnTU9Vp+9yeMbwAcCAsnC86p1ZLA89vjKRfzuSYT+t6m2jfBnh6K
         xfBF//J5BcEX6aIllIVT7LADw8LmPtIfddRlFTdW1pZpkV129Cj4rXXUK2KxRcAKMG9s
         nNm9FO6AVOkurR+1HuBtSsInJziiOW7jT510qdOAgdtei1OVJTwrUofQNyDrlAGSb6Y+
         /DE9aXMk8R/hS3kacUHrSnSSGZcqqppHqwiokiI3pVTDZml7CnvpQHnoesQUtPd2IaiE
         fVAa6RTJPfq+966l3cAqIsn4aD20w2UXsLx3JEQxslflHVte9GOI1uDEraNABHbkAJ1Z
         pP3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783002181; x=1783606981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbH3YLpoRRRBEQibj7D2qVYcaHe6y8OssH9lEWG5bD8=;
        b=aQTEVmPmotywx8fSK+iL5eq5zXuOYB2t5a5ekHuiqEOCiLUVXg4F4/UGvyD75hGvVl
         jHa2WmXYqSpYnbQwLCx91Mh55XKS0O15KpkayNiX9K0bpClBpax39EUr8NFHxXOih4NN
         i65KbWZZy6bvR+7+K2dgc78Zg4o0gv/gFfFg2V0NMYufGHIotts5BuwbquhJbf0zCCoM
         0hKKB71CqO7ihAvWXxKyO/IYKIClHs2/4LsIhvqUxooUzd8NDvaxafqRuZH4qX23TK/y
         BBWXA7ZskUwOG79eLGaKVg8mdNg9cSg35TX7izHzA5PIWtBqpo5dPAH020msIBWjzUMi
         sR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783002181; x=1783606981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gbH3YLpoRRRBEQibj7D2qVYcaHe6y8OssH9lEWG5bD8=;
        b=PNbrq2yj/6gfUx/1zoBnaHbOQQWM0sS1ThJey3dabEQ8dAGU8tAYT1Oh92PObFUGpq
         QJTwNWd/V+99nnf+k3VLKQg8OX0EU1XF7UITOrRttnVctR9pksO7a2an5xQRyIPYumbr
         A9CsFIHiziIe3l8LYTIeu80owcGO5wxMiqKwklGBVH1UljfBFXTNuNYD5gpQ0SZsbAK2
         9B/k1UlL2c3NFMUiSCXLdgSoZEs3tCuU2P8difI5saR6cunxZZL44zuDCZxqTL9FoJ9m
         1DPEipjk6sWPjac+0K6KdwJNNCwkm4A1VzcKN/6/4T8eWYWboAf3wA9J7MCMxrEMwmmJ
         C2lg==
X-Forwarded-Encrypted: i=1; AFNElJ++188WeRNTjqHUF7V9CjfFCYQL9uOsI7+SToYj/ZXdaHd9tVxEu23ZRSWeBgzx3vp8jvn2ewshYbWCQz/T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+rw524nO4xAhesDoUt2H4P1Ly2yHygj5bMFRa7PvCqbEreyR
	gJvpGWpwBzpH7bUg52N8ocIB19z/Svx/cwcemiJ8wtAdq1bK+airuLZCXYYKu0dEy09O4ee+sTc
	V/UGRsGENM4+tQ8YVAl94x/Yl0y3FzUk=
X-Gm-Gg: AfdE7cmd65gcjyalfL7udEJj+u7Kn7Yx9LJTUy9lh+CtD4CENKivl+X6l4RlcY11T7o
	TSOnPXiQqlyyW3opH2Mg8hmhi3UFfrc+oOD4IT/BJvtFkCBzzGUL4CXDW5MO6KAn04dPDEuYi48
	rgNOyzG6fr57NMLZ9ikYcG0iwXDrjEHI46IEaN+I/JQGNX7sz2uBuH8RjbLEF9yf4TUL62K2nSN
	JOLNH+VU3YpEUvomiiy84WkP3wgitApWPMnSwubJ6EYTDuM4D6S8Fe2xSvfEASVdKkcc7u6V1fx
	6TcuVL2hZv3WIAJYh1PdtCCEC2SJBoD2EXPPs1aQ1sPNVRYVfddErH0ih0CXAQSI3KCNB2pKxtK
	hINTaEf+cw9mryfmVRTi0f5/sU7Xpqa7KrHvzYrZJaIER0xBnTqPzHqh3Zr8q+nBgFhAAf0+INf
	S9Crr/o5glh/k=
X-Received: by 2002:a05:620a:4888:b0:92e:5a5c:6582 with SMTP id
 af79cd13be357-92e785220ebmr803616585a.73.1783002180509; Thu, 02 Jul 2026
 07:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <138902.1782980700@warthog.procyon.org.uk> <cfbb3e301d90d034922b945c522813df@manguebit.org>
In-Reply-To: <cfbb3e301d90d034922b945c522813df@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Thu, 2 Jul 2026 09:22:49 -0500
X-Gm-Features: AVVi8Ceh8sRx5L0qP6iLeTvZW8yFWM6AmNERvXoYUkt9pPKOdB4YYq5l691TJOY
Message-ID: <CAH2r5msCwtASOc6c3_pxKF3vPqsowbpYWTWPacetzUAeQB2Z6g@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix missing credit release on failure in cifs_issue_read()
To: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next pending testing

On Thu, Jul 2, 2026 at 7:53=E2=80=AFAM Paulo Alcantara <pc@manguebit.org> w=
rote:
>
> David Howells <dhowells@redhat.com> writes:
>
> > Fix missing release of credits in the failure path in cifs_issue_read()
> > lest retrying the subreq just overwrites the credits value.
> >
> > Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
> > Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%4=
0redhat.com
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.org>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/smb/client/file.c |    1 +
> >  1 file changed, 1 insertion(+)
>
> Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
>


--=20
Thanks,

Steve
