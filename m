Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602343033DE
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791229559; cv=pass; b=h0vVE+ftHb9FnddG4CFcqSoh56pyAIT1bSzen3pcWkEhcGBk3j8RUy8O6G3CG7me6MwQDmNscYcun6oIkJTKT6lWsq8UA8jnlHl3Qfj+Ype4A/H1lhZCzPJ0s+93kwEGQ6rra7F1LIh4r8UNf6WQLDFSdx8erAsIFCll6zQ2O4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791229559; c=relaxed/simple;
	bh=YbYeAAPLr81n7CnKFq3+4NoTXD4yO0Ifbs0Ig3aYVPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2beVwX33wbvuwX45HMIw6lAt48/HXPzOC0TIA0cvl701/2ODGbcEN/oSmHTPMKrUPCQcw9Yz3x+bGv71YXwvhg4Ldsu7g06MhyHqNp7eE3lRuUguS4wRkmu+GJeX9g0kNnkas9hlN/KlsTjEJs576Z4b75hN+i/or2SgyeNoes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAiLIYoe; arc=pass smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAiLIYoe"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-8231c185333so1405729a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 12:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791229556; cv=none;
        d=google.com; s=arc-20260327;
        b=nCntzLz0xiRLOBV3xlcSlhj2XEFp96i93UFnkViuQROndKn7kzbaMdnd6Jbo2JEDyA
         UoMLx6JCB+ih4wjqJDac9MFT8i9X9zye+p3jJB7WPlQqhX6E8lQ6d9C/rJiJI7duLha8
         2hce+vNraKSL3aZg/lqLnn+vRFYkp4T/IpP4XuuNFutAepT2K1Fg/YORAxGnxo9qas53
         fY+GQxq39ePFRxtq8YpjjtBAr1naZUaoMgf4xsACabfu7oDrcbVdX6lIgzrNzemjLpCj
         nIV4vS/MV/uihpn4SmnWp6vsuqo30Jrs+RAkuofJzhyeGNuuM8ruiKa+6/efxIXLAMgR
         NDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YbYeAAPLr81n7CnKFq3+4NoTXD4yO0Ifbs0Ig3aYVPo=;
        fh=yOiudSuk+B/rR47n2F7nA/XPr/J7mTeztq57UTMxu4Y=;
        b=fVogumf+xLiT4jChHFgbSzZNOSPRqs1aMqg0j3M+OBxlSxYFdppX89mszO4+nXqnYf
         3kNnTKFEzhPeEpLdavP5F5/Ecg5sr5lyrCdqAwYIeq6iVKoLWXsfjK0HraIndbtsvgHG
         +cJVYLKNxWe/+9oOxqtFLbF2xNpoDa4R5hbm2Oa4Jyry2IJHJa3XbCJumUZIgE04Fkk3
         pHbcWMeQwt3Z91fqCFFDj3Ag7vHg4KcSDUEaKxF4gMILfWsa0S2500UOFFKXh0lsV6i3
         Hb3M6mkgaL6YhQvgp/Ce87xjFGwBpkovrkPn6WDSPXq9PjMZET0LvHV4Qxp88YJrAllC
         GujQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791229556; x=1791834356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YbYeAAPLr81n7CnKFq3+4NoTXD4yO0Ifbs0Ig3aYVPo=;
        b=lAiLIYoe5m4p658n3T4QTXhvFOgrndbrU5e8xh9zY5eCs+AB0lODeWw6v2YnR6bTBD
         uXBSGoLR6lFuxxGE7vWOkT+vhLn7W3GlGpJyHfVyYPxPAEhDaF0dsLnP2J5e28OZTwxZ
         HES9L18p3CskrWre7t0M0jp2FZEXpmynYeJzyLrIRhaDiDwCZKnp2bqvrig6UBru7i36
         Ruh9EEsP35aAVEOdVKA5ZeMh3zqXsvGbewo2pcH2KXCPRjaj6Vi8Mr8Bs32OD0RjHlYh
         UJSpk3KIouGMi09OF8F6WJC/Kr5yzYuAM6L1pVVderf+bAp5qee4d5NuevlMttiH7sXB
         313A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791229556; x=1791834356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbYeAAPLr81n7CnKFq3+4NoTXD4yO0Ifbs0Ig3aYVPo=;
        b=gt9fdDA6WCq7/jcBrL1WyYeePiJIyqIHSSplB16PZaIJAhQkUolsWNUm2QFyP9+RE5
         VtnPlvhwg/uwCV8eL/Z09wI9+pJl82IxEnaNebpbNPke5NvedJNHKIMcTpQzF6vMaXa+
         ODE8O34t7WWfiFik4se+K/guAqPwWfGf8TXjLKtooxb4htNDjCjOKnEgKyQmJ4Bk/Og1
         MkxUHA+uTpBcpUGLg7yQwF8lSNipytnxZzp/eheIMIY9PTjGLDSYOGYOkehKBQqf4Mnw
         ipVzHZbWgbRacVjlijTznCPufLHeLXMUnXVPb34EhQBckUW9npgCGAMxcEobf92hlMJB
         SCXA==
X-Gm-Message-State: AFuF++kuUTuHn38fUWwc0CChWs+XyVBv5qVcg/RXD1Ifr3pTetY1sRE/
	HSSDWw03x1vlVynlMThz9CK7MrV+IsoJ5d+1VhbLFd7GYPlK5lMEsf8Ao+1bh+jYlKPNuvAyilk
	/dZ8q/kaEcsktJJSVsDZRVVUs6zmmCbA=
X-Gm-Gg: AYBFou2xqHInbqwuUwD3D2Nb9EzTQ/fXojWmTluCzBHA623T1E34Bl89hdnwkd2CbA9
	8sbyRTmZiPc69Hap0iRosnU1lqGZRWMU1Sek3KnBvSwrtKhXtUed3eafQ3D95IGeb91DiC9v21H
	NAFxNXbvREOSv0PD+uEViWAqd6UWpGkQaRt8vXBFmL/zAPbXjH5czygBJQSmV9YoH/11NonIqFQ
	WL7lrBJy7sHUl5DLTxdo39xn6EPvkrKpxhSqblua5FnaefHc5308WcSqOtq3rdi0zdHdup6qga3
	WS2SLq3CW56TaGoFXcGRYfMUrS3vaif4JjR0RvuQWd3YCRbVPPGTQQjeXoyITGU1VC6tmS8wqwV
	DnvOqGkIlNUvl5N4vZVidzcJzSHjG6IW1RN6Kuasr
X-Received: by 2002:a05:6808:670d:b0:4cb:f21b:6f8a with SMTP id
 5614622812f47-4f529c14cb4mr8766254b6e.29.1791229556230; Mon, 05 Oct 2026
 12:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790359547.git.jbingham@gmail.com> <29e5bed16cef4904e9649a9b77d42ec10cd33051.1790359547.git.jbingham@gmail.com>
 <asNdbGAe7XGL3iBI@infradead.org>
In-Reply-To: <asNdbGAe7XGL3iBI@infradead.org>
From: Jeremy Bingham <jbingham@gmail.com>
Date: Mon, 5 Oct 2026 12:45:45 -0700
X-Gm-Features: AclHuK9sBR_JMbEJ17GZhtcFZl-KxwJ_VGnMPOWB_hH_tu9odnndxY0jemoRyWM
Message-ID: <CAMyBmMDqnjR-XFTp4JENa6qTYDXZ6MRP7=7gYTzTwaN=bws9nQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] minix: consolidate itree* files into one itree.c file
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz, djwong@kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 1:18=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> Looks good from the high-level perspective:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> I assume you've run xfstests and checked nothing regresse=D1=95?

Of course. I covered the xfstests suite run for this in the cover
letter rather than the patch (so I apologize if that was a mistake,
but it seemed like the logical place for it), but it was the same
branch I've used in the past for the iomap runs. It ran with no
regressions compared to the baseline.

Thanks,

-j
