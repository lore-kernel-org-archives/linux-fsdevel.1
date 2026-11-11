Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425669;
	b=hvPefY+uxMt1VRcUTVrXNbhxdk3uUPncv7bA2kQe6/Qzw3WL5TeGX2RkpHm6481oY8lr
	 vsmNnVD/IV/V5a/lqkVA0qOW2viBQf7WBZeLa8MvYJlo4ujBjbHTg991mSTUvQ9e0N674
	 Y8RtSGJk2OVQEHfDbd7DLoch1Qjqb9OGr0JtVuIkV0IY6l5s3QMUXRqVGWuZjNQT7HIq6
	 97k4i1rlHB99bAiHSDgwGsF3WS61LfajPioQBtZ9yAz88T1ftuRnV9YRWr5RO0ZMMRjT1
	 PAxcl1NP13Yt0PnNUKb4rUyqM72AUhsVAY5wZXBCAMauF8/KtTdOtazcmhoFxoR3w8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=wd2WluVLwj4r2VIyBQDufDpYxaAOyEu9BCBLHFr84dA=;
	b=C0ZQ+AF8UO0Fr5nsCvHHXYsf0YhOyAFsfy7m92eUa9vcc9NJVgE+vhpvVCAZv4KkpPsh
	 BJc32kkM9CzIK+KO2LY4DCtM5aJNdsuYk+se34aMuMMr8PnE0eFjJfkgk0foYNOoYqVdH
	 j+t0Bxj6aSSNjbL2LS8Fr80Q+VHuJ++MPNTygpnEPE/0tAbdYhaOd1OtSpld8MJwszhZU
	 ylTz2YiPGJB8XvRlxBqlEt2D4JkH5oqH1k1xH6UY9muVPMpz2Tv622Y4/iE80VUy4NL5+
	 9g3mSHRnPDyGdecsuuop8gPm8kQ7Bp50nzRuU0C1AVPYpJqGQgw4/e9NGN9hLIdHe+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=GLNhLag4;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02B606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 19:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C02B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=GLNhLag4
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c506a231b88so123001066b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 11:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794425667; x=1795030467; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wd2WluVLwj4r2VIyBQDufDpYxaAOyEu9BCBLHFr84dA=;
        b=GLNhLag4eKmLQg1GgnlDNt758RxIkggSGYO37ac7ufZIoaR0eXNtaotjTQjj2R/sYG
         sKlpvmgrm4ovXpSqwvoiQ4jF+eukNeg2TMGwrZTzchL1ubpCYdaUecbgjKHekGKNCp0g
         7s2BliFfDn7ZcBXOvW5V/8sKvI2lVfEtt9ib0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425667; x=1795030467;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wd2WluVLwj4r2VIyBQDufDpYxaAOyEu9BCBLHFr84dA=;
        b=YCxSAQ/Vg2eERKeSiKAYTIuXBSww86iAqfNr2nnmWetqTmztB+mH28htA1tF1M0pUL
         J3NIfVmIEXUInl+GyDwTzynGmgPKiguIu4LiyTOIC3ftZDcJAKmzXr5uND7MGiiGtN0J
         NiuqN0Yk2aBiEryMhxq/egDRiY0BLD4NzSAxKZJ80DvUewRVVPNMlV2V175ltF+7Rztj
         8EhvOkYnrmUrggPlH89GHi6vQjHq1F2NIXDtE4tKeDSMLtP4Brd6pEAH+PRBowJW+wRv
         C5ie2JZwpCrLsGdy2sms0CxU/C7bSSOVuVqdvYYJEzrLbhV1ikMmwuDvETqq7Bv8jEYJ
         Ob9Q==
X-Forwarded-Encrypted: i=1; AL+hErEkqAELRiGjhpC19Uv2s2oHUHg+jmDdVVUP6mSPrbNZQOqz2ovVQv1Gfna7zT8ze0OYCg4eaYlFf1wO3dJ2@vger.kernel.org
X-Gm-Message-State: APuU4Z8MCBu1hkJMtRcniLzl89/rrqxnEP96hlgDMONjqFHmjpot5tXi
	NLW1ehvs97OsVsrGuU1N6IHGbvDItfSc1Ox0sSgLTAmLG6tXv4xC0RuLPan+aYRrgB9zgjTev8+
	avGHUJD9feg==
X-Gm-Gg: AYBFou0cp/Y6V6v+Bp95bitTPLBqGKqiQACWd7ZvUkMhJQyEKMOfWdlt9Oen9WoRu4T
	iXP/3cPxRzL4tvIksfdJRZ8L3v6Qt/C6mzYebj5N6YFf9Qt1bOxyI2dTYp5EVwtLHCGVZ/9UFy+
	lz4nG5KdQ94AoGv0nOId1Ty5ayKfypGSLh7mJgp3Ylp1FTux/9LXylNYj0GrD3D2Twr4QyCJ+Gt
	6B3fIcYLSFYKuqUMyQvZPSEwrZI7wBKolKxgShzCxjG53+KkJ8X56RF6Dy6PK7HeSRiPuYLQVyM
	IgFiAXqaYolPmsxlDPuUmPVrVDxhdD24XTENS1rLah9NyYY8jdUiezb6BUZNi38O/4Tl+qHCYrj
	SFfkaDTwiSHjwU/+E1bbQJ1LqRDDldp4N8RKI9/cwVpf4neUj9XcFg1EoGWtAgaoRAY2gR+SzP4
	lOad5/+6RKk+aZwE85sGb0mOFJqe3/+hTN8hCkiCcJaFRNGe/Ssx9cuBcwMog7H7kML9QD36Z+T
	SghdRgR56SLhBU5k2O1fn29qK8J+w+9K7CTcv/3imTVlkX8xJZwJbvjG1ylCZBid8kPUgMRtMMJ
	/5Pq0UUB1JSwFD3RRt1on7rZlnYurqbmc/LNuA572Dy3Ks9aI2VsbjenYiV0+opGJZw2ngoax2y
	i8y9JwmZx9hQ9RRGWnjzFbLHt
X-Received: by 2002:a17:907:3f8a:b0:c50:5bba:3462 with SMTP id a640c23a62f3a-c5066b304dfmr257189366b.20.1794425667189;
        Wed, 11 Nov 2026 11:34:27 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5704cfsm264056966b.15.2026.11.11.11.34.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:34:27 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a215e64962so39376165e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 11:34:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGjKSnqynraj3u6cPOY8rDUvdTcgtyKibGLTG7nWz4GBrvgZwrObx0R6jsdxqw96/xW6EE+nBHCF0MX651g@vger.kernel.org
X-Received: by 2002:aa7:d1ca:0:b0:6b5:6478:a9a5 with SMTP id
 4fb4d7f45d1cf-6b7773edf34mr1838418a12.10.1794425186528; Wed, 11 Nov 2026
 11:26:26 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org> <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner> <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
 <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner>
In-Reply-To: <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Nov 2026 11:26:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
X-Gm-Features: AclHuK8LZq7-9ajWCZDJwTRjmLDnovqaiY30E_XKr8U-iLvj6BsIi-SShy4XPgk
Message-ID: <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, 
	Jan Kara <jack@suse.cz>, "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 10:53, Christian Brauner <brauner@kernel.org> wrote:
>
> If that's the official new stance than I'm very happy.

I definitely want to remove HIGHMEM entirely in the not too distant
future. And before we remove it, we can most definitely document the
fact that we will not be worried about insane users.

And things like security issues count as "insane user": if you use
HIGHMEM outside of controlled embedded setups or museum pieces you get
to keep both pieces when it breaks.

IOW, it's legacy. We should aim to not introduce *new* bugs to it, but
if there are pre-existing bugs they very much count as "don't care",
this will be removed soon.

I think the only reason it wasn't removed a couple of years ago
already is basically a few old 32-bit ARM platforms that still used
it.

Those platforms still exist, and I predict that they'll still exist
next year, but if those users have to stay at the current LTS kernel,
that's fine.

                  Linus
