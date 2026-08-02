Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891233E367
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 23:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785713899; cv=none; b=TW1Be6NmdpZiBZL/1xBBUiePu/Sr6qD7sVca//DEl3RpPABounPJ37dP1nDFSsUuROCqN/InFAY2kmLZLfxgvuDygpH1A0UrovbL0gC9ICvqujC3utN2TkIRamqQggooOLFzccplrLsRXBS4Z2TYVyGwF3rkxJ+jffENkRPBp30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785713899; c=relaxed/simple;
	bh=+C+wAbM1mITAmu2SoMdnGJhuiekScTlWDtdGlyj7mIk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=jaVIolzLxCD/94BSnt6E/re0oGQ5bMm/Qx31i1Tk8uJALevKgtdWqCnhAXzeQq6zYS3JibrYFkWf6j96pMgn4TSTN/nkAYH4axKzUSKk6VBBwBUW/bfEN86nDT5mwKct7a+I9Ii0h67ttPrh0xcTkQ0Zwxo4DJ3neXLMy3X3cho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYlbh9aG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYlbh9aG"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ce7d2adef4so46105445ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 16:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785713898; x=1786318698; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wVC6ZNErkENuKY2q+iSkfidbrSUBAoqUgOYVFs+1qAw=;
        b=YYlbh9aG/5p3MO7w8lG5dTZWl3W20Mf3k8T6t6m62k2OuWpe6W5MWaiEAPN444ilhw
         DwxtTpNELhEb7CAdmXWh+v/ovdmQsnqjdnuZRf+J4zW9hU8/bdNerhldwOIK8llRaDuu
         YnSX7ko3jWJzNJ+KVOkhO73o1f1ZNv9Rke7/Koo5QfqBExT1LNfB0d9kSItbR3vrkoZ8
         oixPN1+dijiYV70x7fic4bMNp1iCtfNpr88Vd6ncX0aQ0KBHYmDAkq8lyGJNt2bP1yj5
         H8/vx5s6Ni2e+DOL23P11zGXrJzXZx2NkOOkAI2bQTS+yTVg4sStJsHW/897c4gssZnF
         q3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785713898; x=1786318698;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVC6ZNErkENuKY2q+iSkfidbrSUBAoqUgOYVFs+1qAw=;
        b=XGN1k/9c+ZycQjZrVHrhrCo9e+iIT2LT3grtlFxvNww6OJKC8wMRF/kfT1KBuk+YYh
         Ixq/aXB7tEBMafQcplRW0l6aJo09O4RsBZI4SVPmPDVgd+qvRjKEXxUrE52Ac9XEIPRT
         zMJ6N1VAoq2UhS8oG9cW/PsGJwABVVkGvgbQQzJCf2/OvhPsHb7G48p6QOAWGYpf7SO3
         nYwwjetsNoTRosYu9EijdBzbVGNryYH2os41XsaqXDIhQmLcU25KODmKnzTvCkDieWjv
         mQDYcLZ3NXWviz+eRsU7Nqr9IonbJ8cpRxfblCHFlTi4bRnYfoYdju9BFaZl7qZrUxn4
         qnOg==
X-Gm-Message-State: AOJu0YxwZzVitYHzKsYWpuFnPf2TaHInzJ4N87qr4xe4yj8mdlZXxJyI
	XgADREdNyQlN86JfpXlphQ+JR9vi5jI8TOjFz+LNdQmqjr09JYnwu9mm
X-Gm-Gg: AR+sD13jo3PtdaJtqRSHd24lDY+PwoeYyRTNF8JFBV06pkUDy9yg1kmfWK3D/cEesTV
	EZOH4uOCiEhXWZPV4Ix1Jh59NWPPKqLZJtwj4WMSsVdOkGNNk6eX1fb2s26I3maGyViGXHB8Z/p
	rGdMUgtt4MeHVaWbpQNHe/s196tOjDsWOlJREXzT3LM3hechLlRug7vI7+uLdG7TRfxpmjMaC5/
	Z595jXtfLsgi9LyZLBIkmMyYlMVk/CzAsNi/qGK9tS1+Q5oyAJ5LvnDZ1k5OJBrgluecsSQHLbC
	vC277JUy49VTben7A2Le/WFSILDrcZGfAo1epirOZPCqZl7jRkKM+MTqD0uiljOOy6z4LuGCCqt
	kh/3iuK8+iTvdlMKq963dGDg5B+wlJlAlMF1/kVSJjT6OKhfqn6350IjJ8JBhyeayC4a+jukA7z
	eiY4+TU9TZqd5xcugH2PG+tIsJ6vURxk03C6KitO93tKjWMiQZZOx0blFaTREUL7HLgg==
X-Received: by 2002:a05:6a21:6b0f:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3c92a5d6d28mr7873983637.21.1785713897970;
        Sun, 02 Aug 2026 16:38:17 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4e44bcsm35070094c88.12.2026.08.02.16.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 16:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] binfmt_misc: let a register string create an entry
 disabled
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260730-work-binfmt_misc-preopen-v1-1-4a0b0da71f16@kernel.org>
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
 <20260730-work-binfmt_misc-preopen-v1-1-4a0b0da71f16@kernel.org>
Date: Sun, 02 Aug 2026 16:37:58 -0700
Message-Id: <178571387898.1880415.17662890925792360904.b4-review@b4>
X-Mailer: b4 0.15.2

On Thu, 30 Jul 2026 15:34:03 +0200, Christian Brauner <brauner@kernel.org> wrote:
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 707f8a14f8a6..ca7840b01a2b 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -75,6 +86,7 @@ static const struct binfmt_misc_flag misc_flags[] = {
>  	{ 'F', MISC_FMT_OPEN_FILE,	0,			"open interpreter file now"	},
>  	{ 'T', MISC_FMT_TRANSPARENT,	MISC_FMT_OPEN_BINARY,	"transparent"			},
>  	{ 'L', MISC_FMT_LOADER,		0,			"loader substitution"		},
> +	{ 'D', MISC_FMT_DISABLED,	0,			"register disabled"		},

AI brought up an interesting point that this now changes the set of
valid delimiters which you might want to call out in the commit message.

For instance 'DnameDMD0DmagicDDinterpD' was allowed before.
It might be a very obscure feature to pick a delimiter because
https://docs.kernel.org/admin-guide/binfmt-misc.html does not even
mention it beyond 'where you can choose the : upon your needs'.

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
