Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516E22425B
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2026 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077022; cv=pass; b=NgjLNEIdpemqDDyea9Dusmc2PxPe3R3kcehV58kPdr6iwVlH11tywPdVA/H2I0G7FYebrEOpbU6EdBXIc0U2eifr2vu/9hah8i1NcZKcnn1QshrGoBq4fTP5jihKXeO5Cbst26kM+y2QJiEv9miAXRJ7VhSR8igkZnvIjNNneFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077022; c=relaxed/simple;
	bh=tHgZr3gyiZh13iPSlNqTtP25vEOOVH6Nr5jP2OWgNBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fU3wjtUzECapljcz9pdm2NpAfE9y2uYLiTzyMYuR8v45EDdGPKE/MXjqEJZ1ercxRTkeU4KtM93ZO5Ilq54g521MA1Pq9A0QgFSa/ZwIcP/tQQyOFOoes2ZicwNLYkhJZMVihWZM2p7xjlqVmUPX36mlxFEjP70KnHhZCsXgnAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb3bwpCO; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb3bwpCO"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-662ccb916c5so3815282d50.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2026 14:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782077020; cv=none;
        d=google.com; s=arc-20240605;
        b=WV/v3QeV3Qgs08oCDNpTyFhk01/Js+VnYlmx+1eELsAXi/JDrXfn4GCL9/52Su4VCq
         0E1m64S9y4UW+oTm7vPLkZc6NBWOKGAi6QhMnVSVvsOU/2v7/eA+6ughhnaIl9S5ItTo
         sD7YLM+OLBEZoXveS9/zXdaBkAX67ehXhQcHuYcEY96tspLai2de2rqRjzr9nj/DTcj+
         +HFCSFikSUFC+Aa6UdPQQwGhuu9wMKeoZcMB2gQCORAJ+QclWvX3kMR9LczXjS+h+Ufy
         MQUVqMVtMWkg5AJxiUICYyMd6sIPkE3/13Q4n08d9yhu6g/S7u1c/LDhHB+ROO4PEngW
         oZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tHgZr3gyiZh13iPSlNqTtP25vEOOVH6Nr5jP2OWgNBo=;
        fh=6I/qKjuafGXDEFeDuOtjcrrNF8UUtEPxJ35BnoKV/Xk=;
        b=X0A+39h2HngdvZ9lrPR79x8U1BrJCsRVDupsNvShXIsjJTKzdu1szRM3mx9GgjD69W
         pOQUGybtDa27zfS2teDOch7shVUTEx+3wbtCuoKMm5X5T4w//scj8xBsV/GAD+IdwN4q
         /K4zubVNf9zq7IrkmCVTVLqAr1FzZhz5BD4wg+rLOWp3DVu88yZ2L/xFnw0eYqLpqNCI
         d4owzFgKoFVZ0z7ybrzYgb2x0Jz54FHw8yr3Jxwnvt1ooNtpFGByEE789NFr2X8zfrrZ
         ahQPcQ21YiY0SB/s9EIRn3ptpbZ/jXCGvkvBO1LMVLwlBroJ729rLDfYzKi8HX85Vtoi
         GhYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782077020; x=1782681820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHgZr3gyiZh13iPSlNqTtP25vEOOVH6Nr5jP2OWgNBo=;
        b=Qb3bwpCOLuyFR92w+QbfA5dsOvsf51wBQR5AHPljEuMisG9BuLsIKzEXsrArtyvy/y
         FPv3Hfpo9PGsZyY00mEsQOXXvyoxbIgmYEahUGtvIXvkwAxfbVMBZwH4pPSJ5AOh4Jtm
         pUNaA2IujJZb/nBZw5fdj4hcbsCo0USxpZ859j9efz6HRPbQ78DwlbIKVt9USmwNB6di
         jQ929T1UIBFQyw1vCQ7vaWcA35hHMJKeOHRbPOGOoshnXZswy2d1sfPWAvu+Q6iJSl0K
         9WN0/9B0AUZS/pG0pbDT8WSdU7ONqPAe7X9gkj8BIK7cvyWkCiaSGUd0lF7PikxxbR2j
         9n/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782077020; x=1782681820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tHgZr3gyiZh13iPSlNqTtP25vEOOVH6Nr5jP2OWgNBo=;
        b=FPikFfabGREO62m4Vm8NfkpLSh1bSi8Fs/vhKw54ls8v9GyqyK/m2ThDZQrJ96/FGK
         CaAuVCdk0WLhOC+C9ahiVTiHU6QObUrhMp+px0Hd7JRsXphHDwh4qLCLVe8QSRH59NVe
         vOif/pTwPUacwybtFE59Yy21cpO/RMHCQTRsi6ehXqh/uDUNSB78mXGZXSKhZDpx51qr
         e3AxFaSdthIuPB/F4aWNVypvzDyXDnM8ng7h48l04tZzpnENQ/oRlQSQeKO7TPYJneU6
         yylbI6G5JoeavBkXlYYpTQ2b9BIODDjKMrCFDvo0cRwUB5zB9XZx5+pNuuu49LsxghYf
         9BQA==
X-Forwarded-Encrypted: i=1; AHgh+Rrvn5R5SNBegyVjrB66a94tw2chRiNmlayyadQR5UCZbAgkXdDwg6axDYeOobVG+d2jtbAd6LEcnyzbeSMb@vger.kernel.org
X-Gm-Message-State: AOJu0YxjsctOLKIbbWSIjmHMxWx2wM7vB7TKMWpuICeULu+jBBeazGRt
	ZNeJ3rhtVNa+qr7viOEJ8qvurtm0iKEEtzkQZfYt/2JbYmXwx38QEzchjVLtowj24H/I3UmbjaJ
	TZdhTCEwhZPAXChQ3bPHTUVtJmTyXOyg=
X-Gm-Gg: AfdE7clPzqXYW51PEaym34IFC8BSeLE8L7a0Ux24YzXF4qO4gfMNT25Fuc3ogvEQYPP
	8pd9RMhv46tykJ4y9PsoE6ZhSKmDslU97Ggn4U0prF9jAD8wJ86AOxYAvYeFGq69oG/kHFV7dsb
	byBHlnVbaxfkaIWVU1BO0gVlJRGcinkzbQot04e+zzTwFd1f1/671UpKRgRAtGxhm7p8mvFDtbO
	f1OFOckcTWggqdSsnKlbNe9B5qfcObFDkJGo0FPCcw0bEmUI/cnZnZ700FWKGMmgGO51w==
X-Received: by 2002:a05:690e:bc6:b0:662:fcfb:9279 with SMTP id
 956f58d0204a3-662fcfb9ac8mr11998389d50.53.1782077019827; Sun, 21 Jun 2026
 14:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
 <aiOXiumEOIPOQm93@casper.infradead.org> <CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
 <20260606042112.GA6060@frogsfrogsfrogs> <20260610-chaoten-ringen-bauer-516e17aff523@brauner>
 <CAKqfh0GqLNmui=BU1Xw7Xk0StWGueq=k5KN9uN0v6Y-DMWAwYg@mail.gmail.com> <ajhT-rHpo-r1k-Li@casper.infradead.org>
In-Reply-To: <ajhT-rHpo-r1k-Li@casper.infradead.org>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 21 Jun 2026 16:23:27 -0500
X-Gm-Features: AVVi8Ccx14EBDPjbpmV9W3u_C5SuSznVcE9sC64C0-5-A1KX9amQ3wnI3s8R1T8
Message-ID: <CAKqfh0HveK3+JeZ+kpbR_rRAftQivMEZ9Vz8h1gsNuiFjcJU0g@mail.gmail.com>
Subject: Re: [RFC] Maintainership of the EFS filesystem
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 4:13=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Jun 21, 2026 at 03:50:07PM -0500, Maxwell Doose wrote:
> > Well it seems that the general consensus is to remove it and at this
> > point, I agree (I suppose I was a bit ignorant :( ). Should we send
> > the patch now or give it some time?
>
> https://lore.kernel.org/linux-fsdevel/20260618211822.3599089-1-willy@infr=
adead.org/

I see. Well then I ought to go back to iio and do what I do best.
