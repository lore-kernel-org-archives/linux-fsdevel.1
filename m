Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995439;
	b=Q3YbiynHPggIEUDp75piwPzzndjQdou6nbYrpra1HRXlKb7RkFUkUi/J91ykjdFVImqy
	 41ncBm1/X1a0IywGrVdt6RX2GAHIQlBmSDjV/BpEfwOxsntDiwgBOfzoXVdfxTMNad2AR
	 3si26s0ctoppJjpvl/pQ7B65Me2IcBU/jT8XXnJTJcq5Y8Stq+OV1xkrKyEVwzhgU3kXR
	 8JG2bEaU6bDkkW5gPvyRXkqdrnUJSRzIm/lD6IA2QGs9zJVLorz/Lc5R6MxxuaQXfPRgC
	 3xyCby3ekDjOV0XAgTBlC3C3RuIHel0NzCqcOJiaQEtv7GCpKWu6GHpktIm9f4sKkPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SOuZsP/y9xq/TzGg7mOta+j2cGpkuhLYFhFIr9N0YU8=;
	b=j+H6smlO+8F1Z5mm6cYAr6lLM5VjpTlEelyV5FbaTJTcg4tsicklQqWeXzjyRsR3NOvT
	 33C6shU9cIfOhTY1rRhnlDGlWVfz1orNkv6Q3EFDdSSoLK/Afiwi/tF6UMX3zoE4ukrTR
	 4r07A5waReB7Gq9RkrJAepDdCmWREdLuzwazoIEkngExr8jfxDIgrCpfJJ2sOLifeiZJ8
	 bb90XNTzbPrSeShMSvW/4TsfGJbjtYIOcfVO1M4EgELWIFSx2RBg01Ne4tZFhDmWksUwe
	 WEz8szv2KV0jew2XI/oIftVh2+oakEmAK4GVFg3A/iP/mMTx9cs1mubxAooYf7Kf1iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=dmCRAjfq;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3B606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 20:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EB3B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=dmCRAjfq
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4322d310e7so157409166b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 12:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793995436; x=1794600236; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SOuZsP/y9xq/TzGg7mOta+j2cGpkuhLYFhFIr9N0YU8=;
        b=dmCRAjfqJQwsKcX+aHrTgrTRqIJdg+k9SFLsWpGQ+P+41R5j9aS5CEwIXDn+eakTve
         5U+GNQQRXGgCs3E+9Hlk9GIcrKajtHeD726ELCBX8HEEcnLHew0SSiw87gUhLpKrsVcL
         fojGVnEsy+Al734Rbk78gOVWTyojys22Q2oJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995436; x=1794600236;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SOuZsP/y9xq/TzGg7mOta+j2cGpkuhLYFhFIr9N0YU8=;
        b=SiuttgNJHRjFpWT1tYkXAffIWrLwkj/pudopw+VUuushNQBAaH2d5/Sr8bkyDHIHPM
         +YGkCbF2hkKnxla847oYPZQySzhJ7xDClJuMolBg08OaMh79q1kTVRALgxCKoKT+VSlq
         1jwPs09chcVQcLnT9p2KMR1YypfgSY/N/PGD7nWuAlYHNyFZ8uTZp9hJVC6gS0nDw+qN
         EErYqTuz5NB7WbCQO+eKlEofElEmafrX123HUAZTSQCNNWM5pw/lXxb9HbwPCcxr0Tyg
         AMt6vhvjjGOp4P80jTcYHdeqKF0SfJ+E2JwD+6ZSMXM32floD1KkTIGecYG85AmVZucl
         OmlA==
X-Forwarded-Encrypted: i=1; AKwUvBx3H9CyBTChY0aFTXmcwC3jmemOS70yXJjNS9GzpOCt8DPsaFRp4hcZUmJEoTk4q/a+treTdjyhdDDMLwnS@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZKP7Vtj2tWHLSz3goFlNegVPKP7R3ODX/ucWKPo7JXJ4vLAuV
	KJfMqyauC5eTrVOTxnVkWJeaOvesm3QO+2NJVFmLr2Dp6B/Ifh2LzLSqoyYXZtX7qlOc0XFULx+
	zMyRH5xpVNA==
X-Gm-Gg: AYBFou2i0u4Ja3dKHCyyOfnsIdgxYvW8ZQZuVdkcBdp6MivbhIbTu3JBFkSy5JUoeKB
	QyuF1Kb4O91TFK8GLLVsnpxIP0NcH73OrnvFPiAfPx8hoxdAiKNGW+a4MyQBx6bD4T5nRt8QZH2
	/0rISJH4xg716b97tQdnvHvc7JK3Zr8nAaC9MsugzPJlwkXuK1bus0zrcFoWeI9/53HdaJcbM5w
	xcLaS7z1IvoMZ/qxcDHP7cRdogn5xz8MIGEoHlCyLx32EhriyTNpefos5k6xJPvpmMGrzQH9GTl
	b4T/tG6bSr0NIOvIaHBOO1REqaal4AL9JDpwiJEBeFFc0JjHLTkiOXMfFuENUrGdwox+5q1MVla
	0ZoR5w6tTpPqiazMkEn9+EnF7YHmbBTtTzejiWGVR6NkD/j5L7mV27NJgmERP8E/tOZpnoPXZNr
	ZIyPHMMgPChZDC/kK/6+V7zYGkW1bxAL1fkkIz6RqgCQlD2zAjWPQssJzxknZz5zHturNjefw/+
	uh+BxNS3ZjBobqtnmoWp555TvrFlcBvS5/Of/knPVDCQbf+sQrCk/VfRZu69rY4V6+nErh7+VIR
	nyiFt9sJ887ZTjO7EzoymBwu1iVElOqdXomuK/1kjSciVOhJ4//qJVIcqYjQTXibGcSbb+qZ1A3
	/DmOkioG+mlSTdYoKzC+tUdY=
X-Received: by 2002:a17:907:c0a:b0:c2e:5efe:f1cb with SMTP id a640c23a62f3a-c4d34c5a0b4mr312831366b.8.1793995435724;
        Fri, 06 Nov 2026 12:03:55 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d487be8aasm52004266b.15.2026.11.06.12.03.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 12:03:55 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c3fd91337baso191321366b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 12:03:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz+vzlktNzpKcWuI5rkf91mzY2hUlTiJve6f3hHEnVFmafwiOFVcKlh8ayTLt6pWXVnOreHGEw9AERhbIcP@vger.kernel.org
X-Received: by 2002:a17:907:c0a:b0:c2e:5efe:f1cb with SMTP id
 a640c23a62f3a-c4d34c5a0b4mr312829466b.8.1793995435035; Fri, 06 Nov 2026
 12:03:55 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
 <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner> <20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
In-Reply-To: <20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Nov 2026 12:03:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiBsoUD=_V3vQr+sgArezxdk0aVk+_8yTX+gK+JVyNH+w@mail.gmail.com>
X-Gm-Features: AclHuK8ZOQnPnzaiKmUJOJtxse2KcPSfRUhBBgxVSOLQ5inoQjgyGjpXmIAMBaI
Message-ID: <CAHk-=wiBsoUD=_V3vQr+sgArezxdk0aVk+_8yTX+gK+JVyNH+w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
	Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 15:35, Christian Brauner <brauner@kernel.org> wrote:
>
> > I resent once after I cleaned things up post RFC and I don't plan on
> > resending (one failed attempt due to my network dropping).
>
> A git tree with all of the patches can be found at:
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.procfs.cleanup

Thanks. Looking at it again, I now reacted to the PCI
proc_bus_pci_read() patch again, and decided that what I *really* hate
about it is that it uses those "unsigned int" variables in the first
place.

And even worse, proc_bus_pci_write() uses the signed "int" variables.

That's just wrong. It's all garbage. It shouldn't use "int" at all. I
think it's just that all this code is two decades+ old, and 64-bit
issues weren't a thing, and even "loff_t" was a newfangled interface
at the time.

"pos" should just be loff_t, and "size" and "cnt" should be "size_t".
Those are the correct types for those things. Not "unsigned int" and
certainly not "int".

And yeah, cfg_size in "struct pci_dev" really is "int", and that's an
independent issue and likely a bug in the PCI layer.

     int pci_cfg_space_size(struct pci_dev *dev);

doesn't seem able to actually return signed values (I think it returns
either 256 or 4096), but "int" is still not a great type for it - and
the comparisons with proper variables like 'size_t' will then turn the
comparison unsigned anyway.

This is all ancient code that works, but isn't pretty. But I'd rather
fix the types than do things like

        if (*ppos >= size)
                return 0;
        pos = *ppos;

which first does the comparison in the right type before it then
truncates it to the wrong one...

           Linus
