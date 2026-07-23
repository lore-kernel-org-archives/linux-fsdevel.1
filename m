Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E258362133
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 03:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778762; cv=none; b=LaX3EXUqlz9MIbHyQCbaaCtNr+j8jDsuEse/ZEAD2L+t12JJ2UdwLUwz31HKsMLPewMCYI0tgCBnFRzKnKAidXal74b+in6SqwohtTl/UTLU+yQOA2J8+fsOfItlOkygHaj1iw6CWskFPYD2KduDgVyGGRo5yHs7ls2NlmwLAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778762; c=relaxed/simple;
	bh=cxZNXOVSqNxENXyKw+Fb/8BWQU/zhWDz5ayqgPPbNXY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=eNAFB2XSESBxJNvQIRf1TF3B8lzOLQ/tyWVIl39DFqVJW5SgFayb7MQt6KI9+PFMuwKbx45E9EmkCpFZPz77tFIu+RpvTt3afTmO2tP8ZmxbQpo+6MZSUNfKKpV8hZZMSW7Pt1h4X9vtsmBj9E6Nd8H89nVnE+2tiyNHuLEZ+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAGfmfCU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAGfmfCU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e347638adso184477a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 20:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784778760; x=1785383560; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tyN4lv/m1nCHBkc/YC4b5dQo4s+xkz63mLX0J0yNeRk=;
        b=EAGfmfCULCKWRLlwDVWJexkhoKtpYLBsVLcggNso67hq1gD7xT3dSTTJiNCrtZ5URx
         wN8o8KpR7hEGsiaNuduKpWu86iWR4vL/faOt0lmqBzkelV6ATrBw9UXXV1XTvS8W4b4v
         AUr2CHxSmaTUf0mnA5glcILEsxIAGxF8ojJOXmh6A8Z3UIrPUr/WekhfsQtuzNIf3GL/
         v2iYCTCC8kfTyQwf4wX7FcEd8puQEr6Mdwb4t5XjEqXX+LZ84M///YgC1//xNJ4QIcUZ
         C+Prbxl4U+7752CbKqCmbOetn2kr532Xr5V24qe/CXN3wB55GBO28zV391EvDJmtoMz2
         AOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778760; x=1785383560;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tyN4lv/m1nCHBkc/YC4b5dQo4s+xkz63mLX0J0yNeRk=;
        b=q9h7XAzKxQLAq8E7+B6fXGvLkgVxjjL5RQTS98groaLvafEz54hBAoNgltQK7oL0WO
         dPPGKilchncGFG3ld1i/ELx/KeVPJIdJkCof3dqE6gWdSmcnZtPse32ngVoaNGXpOyv5
         3OfoXgDFLFi6ArfHfoHGhHegcgFSnd3Bl8D2Byh/5LlMiZpxN1rF3QQ6Aw2d5PhiOO7V
         +S6AkrygEbsflIqgOujtuxCTH50rTG4nGfokahWYxPBNztKcyf1VvptHqO8mk71JH60E
         cCqS2B0tvp7L4QZ73yZeDLuVZmAwNOVfrzuBtyfKNTiK1VZWJSeqzsaplElFotmrmXrR
         uYNw==
X-Forwarded-Encrypted: i=1; AHgh+RqR0Ga0UYmeZsSAusL5pI75Rg8bOen0EUnyhNsIkd8/ialKGbthYmeJfZVZAeePNFTHzjffgxI8TN+472ra@vger.kernel.org
X-Gm-Message-State: AOJu0YwghiZsNrHLsFi2095grryWfxTFNNs/lQUeEsEiBBIi9EdHEFhI
	UMbiF2vnfClYDI41BidZvlthdBoXCwQXw5bbc01z4Ac4lM+B9X41EvLtH3t2QclK
X-Gm-Gg: AR+sD130drFPDBxepGWRSZVSIQP9FNUxDe8KL+JlZHqDCpmPor9o+qVT1Iu2+Tk81HV
	imRft3sKfKLNaNyF9lOVFNfogJ87CDzoN5QjJ/TYEuIrK2Gq+aQiDpFvrbzKW9EePV/SN7RZfvx
	scbcwM25nHcXTsWGOLEZE1msYrwGOEe8+l7Ajks+FZsd2gEQ8omo2Xv4n/8607SATaQy4KuxM9B
	GnrAx5y9YQpLPYqK2lUlg6ztTwg4+LRySAayzWpI+M+hWZhECZwPx7zhn3Hsj76G95uQbmNtgPF
	yH2g+d6am5hWtfPKN0BvJ+EPw/YVkRsgzYwlSYHEyLfacvgxBPisYTr7Xsc+4TyByMjmH7MX79m
	wREQJxc38CE/SG+HdbNEDktKbk1Jo+IbtrD8LV9mwfYvBAA46bnYUIBc8kvkxP5niTgR9CKYuYV
	uQ9vcSzg==
X-Received: by 2002:a17:90b:1d44:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-38ec63e1ed7mr1430578a91.2.1784778760399;
        Wed, 22 Jul 2026 20:52:40 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm11497359c88.0.2026.07.22.20.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 05/21] binfmt_misc: split out
 entry_open_interpreter() and build_interp_argv()
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-5-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-5-e57866e4ae0f@kernel.org>
Date: Wed, 22 Jul 2026 20:52:07 -0700
Message-Id: <178477872731.254289.5616585238630856872.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 21 Jul 2026 16:13:47 +0200, Christian Brauner <brauner@kernel.org> wrote:
> Opening the interpreter is a property of the matched entry: an 'F' entry
> hands out a clone of the file it pre-opened at registration time, any
> other entry opens the selected path. Give that its own helper instead of
> an if/else in the middle of load_misc_binary(), and let it fail early
> rather than carrying an ERR_PTR through the successful branch.
> 
> Building the interpreter's argument vector is the bulk of what remains
> and the one part of load_misc_binary() that is specific to the classic
> dispatch. Move it into its own helper too, so the dispatch reads as what
> it is: pick a handler, pick an interpreter, build the invocation, open
> it.
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
