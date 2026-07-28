Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014EF3ACA77
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273747; cv=pass; b=umO7LjKDyF53L8ANd91bRBIo+JHHEB4ZdUDalL8ruWgfXLDE6SlCDMXbshGU2zHQwvmyiCMKoj6w6miE+f6+HkoiJhEAeGllmN8WrqN3QZOJqyUVCS7WVTxR81IBIRwSgErlZVBtueBJnIonh7uRDV7vbttFkpUvVRW6uWx8mg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273747; c=relaxed/simple;
	bh=5fTXdN1mX7adeOd7FMDDm4McY+PRzjyh6UglHUKVqMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ibmovtn1JM1yuE9CS6MhrzrAWxLdRvRiibVayhUUnunlTeMYnDrYfXwNN53Q8ah0goT2JmrzvUg1rcdkdMQY/9GQ6/E1G8tffEpj4ig9mmosZJgyxUb/bhnVCkEw/AJUoG4Zok6/2u7pLQxtzsNtCzN5qr72vsk9JfI+bRePSug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LsEi22MN; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LsEi22MN"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso42485966b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 14:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785273744; cv=none;
        d=google.com; s=arc-20260327;
        b=pkLYsV2zQHtdCg9kxjSMmo3ktcVBfFX7vuG/2/vYymb7lMfx+H4eWCjUpbuZopTm2j
         WIBWZFxrXPlb1RcnEPAVp9A97VlLrExfcll3kIdH8MVz++fcTp0IJ1XHdit82uQW2KpW
         FzwEvjdn8xGaIzmXCthZImjHCHb8gz2AElBYTIxxyaMfXsmNYwfB29ZIRg7yYkfqCDaW
         bhpuyEwRJRlfBJcFXZBaimh7EhowPuqlzsExtLWWqStt0X2k9DWwIV7ZNf6hl1uajj49
         CG+wgPXFd9aKmByRRJ0kf8ph/x/HPx7ZrDolItvkqdaLeBilslpyvzZxJKXdPflQqzLL
         I3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZH40PYN23Pf+U51sBh/CXmRrpHRReC5q1ku/I3CzrI8=;
        fh=pnAuFLhQqy0j7dZSf0LSNkDhwJTm6+Efi3xrsrAR5Bo=;
        b=oQuWUN91O9KKewNgeexUUK43fH/TZO/nssmxmC+29CMA91+wSxt5CTaAG2zsQSo8P6
         ICv5atSuVa+kCEtXfWcRqXc16ZUeb8ClvmQHkj9eMct375dSJvj7R6d1VittOZSHHSK1
         WMXMoB8kFYXyZ3DAL0ZzVh+GI9iHDLvKB5FljbXRBCxiZx8SAO4TM/Iqp8cArk5xHE1I
         iTQ3+NjlCZpWMHAQRWURsLOatIKtspTUoD3YvkgdnvJf1Q2suXmGbPvEEgHWSs7JK7YR
         vaZA3hw4gE4i5KEldpCSHvezlIQx1pHJfzxlSp0SCofoEny3iukoUxR0m8XUMbmxZogB
         MNNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785273744; x=1785878544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZH40PYN23Pf+U51sBh/CXmRrpHRReC5q1ku/I3CzrI8=;
        b=LsEi22MNfzA9HetuujZYAO9T8AzOtppPIWkHuhkIoiKioDDouc1b8lpWZtJaCj4WsK
         RGnO0aCxyxPot78MfabQJ/FbEt2zsdM877EWm1SGfHjXXdAlECGJEqZUN3SQtptE2W2E
         Xe8OvWVn64qjGjqxgVz123NovV0wFh8UjPXGxTiuq2I+1z8NmcbsD+5rokFbkthCSFNM
         SgOQEcUkCkBkCrYJ8ssxE4JShJlFC6GdDNYghl7z2n6xa/WT4hpScckiBzt5qAPuNbGs
         HuPawQnNav43yxFCmyEkFARe/ckeWt/UkLOIXolmbbiKqqTTR57V4O333f2YaxSOOQJN
         ihFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273744; x=1785878544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZH40PYN23Pf+U51sBh/CXmRrpHRReC5q1ku/I3CzrI8=;
        b=fzeewnnbcnYzWliIeWB4PkxzctTVMO1uQnAXaIWpsombKPhFLg172wxbItp8hkZdWZ
         8HwzVNxOsNKx4ga+z47aLqI7smf5Fuft23tQRKZJHU3BaLX+uHiQ05cOM6WZzhTY8l8R
         ru9K57uqQ0PcsuM5XlQh4F1QY8a6U6W4JeAlX6sexkro5kjuUsCuoQyrUgTIvZGGfpjC
         Z7rYSqKXlnnAyfImrshUiLul0OpW4jCO2uXSVfH7XGJ0gPhi3G6AhWSGv/QmmORtYB4O
         O59zw3v4mbJ0+UcbZjNhs2NygZVVIBOlwf3Zz4UzcbqoP5G+NL5eywIPnylRxxpu9xt8
         KwLA==
X-Forwarded-Encrypted: i=1; AHgh+Rran9lldtVIYaFb22xuLeLt3vpfgUW5te4UGo7Nbtih6HT2uPi7Zb0N3DU1H8tYdE9lAYJcYpIOhY495rMt@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzapwj/Ai6ZkafVhhoG+CSLlrq5STKFLgCpW9tSx6fCvPSEr5
	AxNg4vxCnChQq5NuzyZa9hEzmUY8B624o05AiMldE2RqeWeQN4K7tp4LqNYssmNv7XW4DNH+EgQ
	XZCZH4gKoGNgadfvxi1dOUltoH83DoiYR5RJRf8ZRnek9hIbRaylo9g==
X-Gm-Gg: AR+sD10G79py0LTU+eAhGSzr9Z8caEiagxFEmZ/H6Tw9ZrW2RAqS+mLoOLBVA77TB2b
	JZW2P2wwM25gjp1nMCLM6ocacX1FaKTam4pSao9LQgz47egiMo8duKRvajSudwmm+rVWW1qf84g
	QNvYkdO1U2n09CoXmOHa/g1DDUHY0CI95VTVlcJyqnoZFhqCbDKxjYi+w8mBHd+NauEvDLwcnKu
	sqm2RutBBE5eO5wBGRZaQbc2VocX5wNReXpK+fPTYgRE6HXKE48u7ZuM6PoH07+FGob44rWoWLI
	c8Y7yqPKxMcD/uVRVEEHj1yFL6zT5fH8N0e8uwu059FC
X-Received: by 2002:a17:907:c714:b0:c1f:18b0:9fc7 with SMTP id
 a640c23a62f3a-c1f7251b18dmr228237466b.33.1785273744157; Tue, 28 Jul 2026
 14:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170035.4073532-1-rrobaina@redhat.com>
In-Reply-To: <20260713170035.4073532-1-rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Jul 2026 17:22:09 -0400
X-Gm-Features: AUfX_mz3953sZBGG9YDBsY6XXIERNvU__-3G_ikQi-r51njdNtLFekvwb37zwOU
Message-ID: <CAHC9VhTR-qaU-WFiuWZLfxhNisTtKXahLMHrH7-Ts5o09VMYcw@mail.gmail.com>
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> syscall. The generic SYSCALL audit record logs the move_mount syscall
> but does not capture the flags argument, creating an audit gap for
> mount relocation operations.
>
> Add a MOVE_MOUNT auxiliary record that logs the flags argument passed
> to move_mount(2). Pathnames and file descriptors are captured through
> existing PATH records and SYSCALL record arguments.
>
>  ----
>  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:41 ...
>  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
>  type=3DMOVE_MOUNT : fs_flags=3D0x4
>  ----
>  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=3Dfc:00=
 ...
>  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
>  type=3DMOVE_MOUNT : fs_flags=3D0x4
>
> Link: https://github.com/linux-audit/audit-kernel/issues/152
> Link: https://github.com/linux-audit/audit-kernel/issues/153
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  fs/namespace.c             |  3 +++
>  include/linux/audit.h      | 10 ++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/auditsc.c           | 13 +++++++++++++
>  4 files changed, 27 insertions(+)

This is because we only log the first four syscall parameters,
correct?  To put this another way, if we logged all six syscall
parameters this wouldn't be an issue, yes?

I'm aware of the argument for only logging the first four parameters,
but I've always thought it was a rather foolish decision.  Perhaps now
is the time to spend to investigate adding those two missing
parameters to the SYSCALL record so we don't have to worry about hacky
workarounds like this (to be clear, I know this hacky workaround isn't
your fault, you are just trying to make the best of a kludgy thing
<g>).

--=20
paul-moore.com
