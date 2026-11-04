Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819022;
	b=YWy7t8nfh/gPcXaUfYNWNWDkqpjNY8+03L7nUO47EUROzGmvlT2Fp3NXsz6q1e9qMdme
	 SnJ07MiH9wOghABtSsA4Z6t1Aq05Lhpwv9ZkIQ6Rf8PzWDQQhVAqPPrlme9cLBnLDmMJ6
	 QPmz4zEpJ0UsEcHdA18XgLT8I4eTzhbi0Oh0PTQjhdqpDwJ2TT4Zm4V5x9II79sFVwwvC
	 s3N2WgSUhbXYfTixrcYoLed0RvLdCB8r5RP/er0exbwySYfrAFN3m7q96QAZLOHxmS/xp
	 x2vbHggMmys1XUCq6cfrMS9RI5s6p1OBSF0FFX/pmyV1EcdO0LZlO4qRY2es2LEHWCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=6PvaX4UG4tQqa6Gj0rxkiTMc3qE2squ/dgttboztFLY=;
	b=ds0toKHodUWnS00Pash6gcNEKLV2ChX7kUww9jUTiy1Jll+jrnQkM2zcME0WEHQbA5Vn
	 +UtsOrooSG0/cq/z2878NNHBYsBRcJldX8XxQVoi93gYdQsKUXNfcYmgCMGMDBVHALgvp
	 PfmQtFw9Kc0wsBMLNDb6E9oAi6BnAJB/pwt0/DIN5pdIMh7nsCYe9Tc5ipWNvVg0PD88c
	 623s/cl1BbUo+vaY+yiSqxl53gkM8x2iawFTdFBh42ZUKLEfnJ0lO3VTn1nBxA2WtIXqb
	 CT8hkXguba2t9MFAUe+z9ymhzumu5T4iP5aqDtribEDVl1eChaDXFN0pH3KFvZB+h7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WPHBhcRs;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4E606A326
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 19:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEF4E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WPHBhcRs
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so12711615e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793819020; x=1794423820; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6PvaX4UG4tQqa6Gj0rxkiTMc3qE2squ/dgttboztFLY=;
        b=WPHBhcRsbgJGVIUfO8Xvum1V+GAjb9zX5X5LYaCjDh0XqHEApJkx2QuBtJoyMvEee7
         2UiUUp2mEFuiTq+8WKKoh5N2vyzXSJndbwhkAJZg9n5u6ZgaRGOOr83BF1sL+jcD2aPz
         v5VqbmSCe00U2+A6v6xb7+38/W6J0XlpglrXullKgy1FTPCsN5zhO5uFPiNixISD1lTo
         MEJlupYjL6fWH8Po7Eyzvvg1Ekv4YOuGxZhcbIaMXRQ5Om/24DX7cOOR72MWhhUcmOB8
         /bVDXv63Mw1XwCohFSaHtqqzqcV7eDqTPEsLP+LECQ8IV3AbYkULKxjyN+JH/zehVjGG
         mJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819020; x=1794423820;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PvaX4UG4tQqa6Gj0rxkiTMc3qE2squ/dgttboztFLY=;
        b=KBgNiaELcA7CIUSQzkm3WH+Xgc3ohvOLsl752jD0kklxOPK9Nj0EQhFj1r7m1QLgok
         Ofvcg6j4OBDFYtPlg14CFk7Aw7ywbGzOYR8qR2IGljeT132i6pH0T+yEFBAKiMrpeWVn
         dmzqbPdkOWQgHoppUWmf4piPW4unAobDH4pSyd+EFWsQMkit8tE894n0wXgTUwTFqrp5
         Ny0dHmUznAdGA4XydiuBDsdbpiIMkr2fZi2WlDdkQuUTf7CoC3wuVaftnodkuPgngxcj
         xIpMRWl4PBfhO198wpGNPOgYVNs9tX1+shZIXtWtFXhij2MK0Us3hNTF85QC2nMxmZoU
         E7HQ==
X-Gm-Message-State: APuU4Z9OoC6ZHDk/iWux2HgKcbHjKl3UWjpZeFwvk/ECtoj0pTQ2JQVx
	9Zwm1wb+V/lKkgsPGnFbxzJM0D08w9iFVFMTbLuXVVb9bK1N/MdRzpA=
X-Gm-Gg: AYBFou3P26eBcGGcKDASZqmlekV+X/zikcWY7QiEtcx5mOsGcNx87Vsf3pup0Yk8gbB
	u6v6UM0N50R6q/fE2ACO3um8CkvyrVTTw/k588u10QcQ89U3yAbNbfZbnFK3hqtANyB5735ErJn
	04tcKr20iW01Y+rVUBv4u08cFvKHbx3iH/bY7scNxJ26UCD6a2Dq32enp2GkvoPIGpvr/hW/rpe
	t3C7HyvV4g2A3dmEBgu/oBBYAHmENTe2N99j1qUISkoX17cfzXGlH6zLZa03KDdyaFu0nNXpCPE
	7/Xed+HEjoIH1j8nWLpJraHTkf4aC88Rr9kMWASYKnidJRv+Jlf/oR5L5vQd5j0QW44ROeTMzDo
	RROiQAEv16b+y9n33/VMnT/BLFE5Jt/9FV+FMw2W+Z+Ls/T9UG6Nz8/RU0NhnnmnNot6EeSf6RD
	ggqQpRRwt63DxWydeZp9sPlvU6SLGbcfFYc7fZogfhWUnKFhLloGZ7D3ujM+Q5/ieArSqV3tXlJ
	Wa9HgGdCwp8Jni4pcqtVwga5R3ua/AF92HgyeRXyKzUXqUlVfXr4uZ45dNdPo0eSo+tvzED8PTA
	ojZMLVOg28Llc4U=
X-Received: by 2002:a05:600c:3510:b0:4a1:dec1:4e1 with SMTP id 5b1f17b1804b1-4ac1765d674mr386989725e9.22.1793819020385;
        Wed, 04 Nov 2026 11:03:40 -0800 (PST)
Received: from p183 ([178.172.146.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57317cb8esm4336205e9.13.2026.11.04.11.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:03:39 -0800 (PST)
Date: Wed, 4 Nov 2026 22:03:38 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH RFC 02/16] proc: add pde_pin() and pde_unpin()
Message-ID: <f3511970-2224-4b53-9ae7-478320b1c8ef@p183>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> +/* Pin an entry that can go away around a call into it, see use_pde(). */
> +static bool pde_pin(struct proc_dir_entry *pde)
> +{
> +	return pde_is_permanent(pde) || use_pde(pde);
> +}
> +
> +static void pde_unpin(struct proc_dir_entry *pde)
> +{
> +	if (!pde_is_permanent(pde))
> +		unuse_pde(pde);
> +}

Oh, I didn't sent this before because of theoretical bug.

If someone uses permanent bug by mistake or because of misguided
perfomance optimization...

Permanent flags is set after publishing PDE to the world,
so there is a window where +1 is done but -1 is not done.

And then 2147483647 security researchers arrive and overflow it.

There is no detection of buggy usage: proc_make_permanent on dynamic
PDEs from buggy modules. It's easy to grep but I'm not signing up for
that.

	/proc/alexey
