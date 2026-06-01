Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159B72EC0A6
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331371; cv=none; b=F4bPFZolXU6BowEkNHiEfxchC0bf3OzQ5vL/MNBWafym46BI6zw/17qHeVpTJbMRL97QuIhtErLHr0boFc8+2w30D81a9zWXyqMy3iaKXiyxatiaonpDoyxaEgY00y8VACn0eDPAF8KNH9AdaMsxT+jLnIdA/LnDIkxi08IM2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331371; c=relaxed/simple;
	bh=JHA8A2LqDoxqFwpttDeYSscr29A5V44SjxGPurj2m8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOEJxWrajAQCc1S0kP5IqytbDRXH/5cR/8MqLavoq9vllww+zqLtO/o9PDTvQOg4BW6jF2rFX+b0nycbT7iuwccvMHDxEM7rw40jVJF7SS9dGkX/oxJFqzSSyuq90ooWHjnsCTSy5iVxzGVPRHoR02dU3Tflu9GV6Jr4G4BEKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gfhSkiCO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gfhSkiCO"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bec423a5265so295384666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780331368; x=1780936168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K5aZ4vAk82i6DVnbVmOCwCzllylMU3ucK3p4smWm5Ow=;
        b=gfhSkiCOgsXXzedBQgyhrxVG4ffrB8IS6ZQTKCw6WsuX2B2FE7nHs08gmZjEFdNrxr
         PEsAAPyknfxh7E95H5BPoM6fKJw1UIhaE3fc4c5IYXEcqwiYZFw0DiOsCICG30zFIUQh
         zbiXMal2Gcv5sZzrtdQJfsjzeUhb8vKQ0je3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780331368; x=1780936168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5aZ4vAk82i6DVnbVmOCwCzllylMU3ucK3p4smWm5Ow=;
        b=kKZP7AiyLHJIzc4c6kpWknxH8glVAHPy9uH3qTcC94YogOKyQy2ptdndh8/ZXmmas6
         huia3A2T3LW0veGIhz41Kn4YeQFH/PHTwUr6uNCgm6ZkUcl+yhXyhoemrE6qzWQdnvd1
         Je/bv5g50eQ3qcZjZaUmUWa2ht0UiDPqoVizUAERqEMFuwDEt165NGeYung+kbt4uITu
         64lxsLBd1GrHrdWnb1OJKC8cwbjcxZ7WylAvp/kdt4601GURaDyJzKTOvjlyg9tYPZII
         y8DhikBXpAun+uI+m34XqlIJTnfrlqGku6rWqccNwwXNAouhsr7m/PDCCMTomTAPCu4i
         FWaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3or3OUyOmqzwe9cHNLofPA8/OG8b+d7w7dvxyHxSIIexeWo+gsJb50D6h3D2s+vHt3eye3uesIvivvoM+@vger.kernel.org
X-Gm-Message-State: AOJu0YygBdT2CdIjtUPbmBE9qJAaNZChBCoIiJjHJZV4Y9z/P0O4G851
	SSXKjMdP25bbtKa+ougZlbg8T+9Rsv0Ql+UznpE9GlB3VfWE2YT8ncxh/Ds/71eUSlPAXjRp375
	l07cMR1M=
X-Gm-Gg: Acq92OHkjZoOgp3o7r6XlqXAGwYnR1c2whs/EtCSzHrfEnJw2dJZPilP+mx8VB8MLu6
	ey+QnT3y64HPtAR8MyH2kGpqae34GeKafKekYdU4IvZBsTibwHBYnMZ/VE1ItafTQNCSR1t8jXU
	NrsZjC8GW/vWGGvHO4kGRy5icbWJ8BKkPMrN4v3NudCfqQRHT0+cb0GqHCRjmHHKmK1Oiw6dg5q
	UxRLLVQ1vtKd0Oj1Receoun8IBdMHS4fsV2yd9q9RfsHDO39XLGIMROlgCtFsDrHrWlouYYhrqH
	D+7Cz24b9zBxjYUziNcW5Snaf+rpSVpz/aAgzQqDAL/fEMMQannntwOFABsrQFJsueL4JFE+oH5
	rI4Gh9r5QMJb9YvBI8320UZFUzkzxPgv0sqe0b5wAO8s+pbta4DW5AXNoW1QwFf0gMHVVhm1Iuy
	Tt+gQAZFRZG2+57e9OwH7MWfuS4xNh2K5mLEiC09icz3opspojxtRiVfIQyheY3ez6HZBAhFzYO
	XlOpq2LNC5X0gnEFnyyIA==
X-Received: by 2002:a17:907:7284:b0:bec:7066:8439 with SMTP id a640c23a62f3a-bec70668badmr429479866b.18.1780331368311;
        Mon, 01 Jun 2026 09:29:28 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d27f4782sm362028666b.5.2026.06.01.09.29.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 09:29:28 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd8d0e4e341so2395550266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 09:29:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+UnE+gRRKRekTUtFwe8TxhB61fvuX5v8s/yjGDd3dYwLWnErnGQDL02F6lWszjxpWcPDr6mDrtbRFVRHiT@vger.kernel.org
X-Received: by 2002:a17:907:3d45:b0:be3:b3fb:e2 with SMTP id
 a640c23a62f3a-beab207a691mr724400066b.32.1780330992765; Mon, 01 Jun 2026
 09:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <CALCETrW__=8mSusayfXG7UFCfue5BGbx+vqESj1d9wqOfX4s8w@mail.gmail.com>
 <ah2nBAdsE5vVJ2PL@casper.infradead.org> <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
 <20260601-aufweichen-dissens-ausrechnen-0d9b84728113@brauner>
In-Reply-To: <20260601-aufweichen-dissens-ausrechnen-0d9b84728113@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jun 2026 09:22:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1dSKpF=NMJmm9d-7kJY=BEVkchTaxsL1LGL3n89KtBg@mail.gmail.com>
X-Gm-Features: AVHnY4Kn-EiKMLw7r2InJ00RsvMx_ZNQz4aALUAoaty1wqi8l1c2ToY4hj4PgVo
Message-ID: <CAHk-=wj1dSKpF=NMJmm9d-7kJY=BEVkchTaxsL1LGL3n89KtBg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andy Lutomirski <luto@amacapital.net>, 
	Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 at 09:17, Christian Brauner <brauner@kernel.org> wrote:
>
> As usual I would argue to accept it and revert in case we get actual
> regression reports...

Yes, likely the only way we'd ever find out ..

          Linus
