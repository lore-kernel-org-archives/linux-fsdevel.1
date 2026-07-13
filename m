Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753735674D
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970800; cv=pass; b=Y8IC+MhCd7hOlxYQqBcq77arkKg6CVQXEiohH56S1AEoJ4eXpPy+jT0GmES3yZCQgjamkyeimdAg2dTvfU0i7+J8qfbMDGy+rapc8dLMjeM9cOqabdZ6N5esgXBFC45KpO4IOGUgM2oHH9KDLm98h03bkkyqng7yuVatQ3TZoZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970800; c=relaxed/simple;
	bh=OuiP9HvT6UJwbpWJENJHHusdbFMCy5QRChdJM7Jwsv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHP9Zs4oPsJC3mkIUTL7WbZ2qS6xW2cZm0lj2UpBM/DoDkFQexkAYnAKIm4FmIxakfptXgvXjWIHQ84WJM18B77ym83WHv0WOzy4ZPLGSDiy/220byXl/E2130dY4GhXhb+LXv2nCHI7IUR0t08X3yuhgoGphZr9//KqwykipYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZKKgJQf; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZKKgJQf"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-49190e20a0cso1793700b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 12:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783970798; cv=none;
        d=google.com; s=arc-20260327;
        b=fAJ9TOx39Q9M5jfNOuPDWmDY+/HbouDcD5SnKSmXsIvCGbO5Nn0psAHP7aAj0tacDi
         LR0NGzM7DYl2oB/nc7f7G5Fq6w5rdPl6iwhHshHPe+VQaknBepN47hGcge1bGmByJ9bg
         QFUQfGJia0N7XNdVQKu8wnhR7sHqxutjaPw66ZVugMArqDvfbZFfkYrnh3QSRJ9XveTc
         lIaeR8lzLDSg8q9XEdISqd292KteeGM+pCozpNKcO/NgfhSe2WfBFsfnT37Fk0wBq6oX
         tmvnlOuqRhdMPUmkgJpGVHFzsGgG9j/1yrQ6/1FhO4SLWw9+yI0+qFBA6n6dvjZkcRQs
         9cVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2FSH2zFyyZgXJwXjp+sqRDUf0qZ8TzsdIeg6wXJ6Ry4=;
        fh=yOiudSuk+B/rR47n2F7nA/XPr/J7mTeztq57UTMxu4Y=;
        b=Slr1UvfSxTY1m3uszILhDDeaId653pPXON3J336PMTGat2cbpqq+ynE9snVXmgrkcR
         yZqDIA0Z+WlCmNxiFqMN+ItZCaiB3QY6z5XY/sK9hdVJprLWg3aWYVOB+rIwsNBrrCbP
         v3vcedWN6Pq24yvvoN4p9m8x6kcHYclQun6SBy8UAW+S9M6VfnuhsQ78pZ8Vhz7E6jKl
         LgnXLlEZBgV4642Svr1lnTAe0uG2L3ZgxqR+ghfwuPXXK3Eu3Gua4B1YVrUL8IKrpl4b
         bf36JwVtBboVBA+u8oFBdVfJIszR5SogIA3Aw/deVfSNN6vzvaL0Vi0y86CAb9GgCFMF
         jTXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783970798; x=1784575598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2FSH2zFyyZgXJwXjp+sqRDUf0qZ8TzsdIeg6wXJ6Ry4=;
        b=HZKKgJQfJKg0/FDNMbZ1NuivRgIFLghBzmYJn/esBSzycQn4bZq9vRn7rxco/mO2eB
         8QGJAR2Ji5135GyCi8fWn8eztZR+WoftCv/VqjzbRky5SnpdkKx617I3sqeXf8Yzmybm
         h2sE+jVqigUBUGFeUoUxjCFdZdawRiiKYgQpusvI3NZnrpNmx+ul6HYQHGhrAMzOJ0yY
         XJX+r8ZgDJz65Wp0fNWLNyI7pCG2XbxP/2IkY+LtjX+xwvKi8vG40fOuSxzTlkoIR1lV
         9dQeqa1qFjsfX5G8G4xLWiGaoB92NJyzUJMCwiwTUeBOeyW5nqVzIfgo+s9MO1r2OVSL
         vX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970798; x=1784575598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2FSH2zFyyZgXJwXjp+sqRDUf0qZ8TzsdIeg6wXJ6Ry4=;
        b=X2+uRF1jZAFoemPwdSQ0sakvxlXSKTEN0dt53hkZnXg2Ef55wD1f+CaG2iQM7dod2o
         V/ddMSafEbM3+U8e0m92RowGQc/uOURQF3lwWVFJ1QTSfr1xLSu+S9dX3nwsuIZqqPgM
         1lcOJSzywcsTQ7uJY43ETuFkbBpMlaZeF7ALhMXmXmvh4aZSL1jIGdoPFAevsRVdDjTK
         bSZoC2bcCUgFUWJP4+SdWlgzutYX3hyw5FKJBi/A020fwGCQoQ8rVTOv1MzcHb3arvn8
         DH+CL+Tnkol8j9Cos6wcO+CFPgiJ7n8Y/rl9ORAyxagKnnJatljS3cf9KpscKhxCjDAH
         AN9g==
X-Gm-Message-State: AOJu0Yzl1/+KX5+D14SnXsKOSqtU1aeY0mMTG2COdKk91J6l7JJOa7IK
	BkunprB4BTme+CRY8K6VWJv0B5vnSDSnfPju/K2J/d+BE4It1GIOCn67ZFUtyYVyqpDC7t1WuOo
	XB6R/3FV6l7s6nIVb69mZKzIe0uX+7rHOo5Gw
X-Gm-Gg: AfdE7cnilkGwm3XViC5dMHv2CTZC0sYWI4ugtw0dC7LfNJWJjrghNaqJ6vdUtTK0rKh
	2s06XbAp1ZbR/vFcIXp5LvPhyPaQ2eJ20AtIGfhlC6G+WV2jxtT8R51cCA45+kdAX3LO7PDdzBZ
	7sGjq4co22FKOLLo6DFYfsmY28ABsLLamy6t61HEFBRVas+ka7cjfS+zHjRVZ0Ylrm9PmFt5Xmn
	HpohUwi1X1vxiS6iGMsUXrYMrMhaI7M5tZZfR9ie8tgcPZO1Hit0iUaGepYTSq2lGM1ZGAl
X-Received: by 2002:a05:6808:1b2c:b0:495:f79d:b08e with SMTP id
 5614622812f47-4a42ae80d43mr6353940b6e.21.1783970798503; Mon, 13 Jul 2026
 12:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783707063.git.jbingham@gmail.com> <alSwnFoGwVBRVlu0@infradead.org>
In-Reply-To: <alSwnFoGwVBRVlu0@infradead.org>
From: Jeremy Bingham <jbingham@gmail.com>
Date: Mon, 13 Jul 2026 12:26:27 -0700
X-Gm-Features: AVVi8Cd7qcEoaCRtAXMzbgPa3g3h3AfL9IIjkH66QBsZSaiNDfMEGrZrGUj2OWU
Message-ID: <CAMyBmMDj7e0t8J2rYTw4uBe9SMDx0Jyf1iDbbcKYMdq3zzEEHg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] minix: convert to iomap and add direct I/O
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz, djwong@kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 2:32=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sat, Jul 11, 2026 at 01:59:04PM -0700, Jeremy Bingham wrote:
>
> There's no point explaining each patch in the over letter, that's
> what the commit log for each patch are for.

Understood. I've also read your other reply about how the cover letter
and commits need to explain *why* rather than *how* and will fix
them accordingly.

> How did you test this?  How do the xfstests auto group results look
> with an without the series for minix?

I made a script that exercises about 40 different file and directory
operations against each version of the minix filesystem. I tried running
xfstests against minix with and without these patches, but it doesn't
work under either case because mkfs.minix and fsck.minix don't take
the expected arguments. I had backed off using xfstests for this
because of that, but I'll revisit with the next round of changes.

Thank you again for your comments,

-j
