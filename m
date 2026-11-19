Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053894;
	b=rKmVW94TtXobVu3qibA/y816z9Ao0KkONW+Vk50XDYcgeDlC9p/+Mpqy9Ag9AgINAk6t
	 Zs4BQ0BXIr0PldNze9yqPANJvtDbfdF2BQLup/v9mpjTyacbA7po9zKYUxT2ViPbFUsrp
	 qUyziBqRs+uwezoYcIxmkVGkPBAfn9ylx+hbBDAPK6RXXrLt4X5xJZS3X5dOK9VbP4HJh
	 GVFsYpCUwHq5Yzxuha/VyExAMbetdF+AW4vBHTMdvx/iN2qiwTjHdO5M9/1ZU+2r4yp7u
	 XxZNKaI9pk2RCjTsLGYKK1LkKekl1XWbO9LMkgKJ1UQGK3+c4UgNoowpRbzw+TEBl4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kC+uhz3Afjp9Cqz8zh23wNboDVMQQa75pZ1niNRa9cE=;
	b=qj7qYkiAdN0h8ew3g8/i+mYVkOx5GAdZhAsmXMToqUNzFH7zAq3CGAjKnu+tnEkhDdRU
	 OwHlo6cU8cS516P6inkO0Z5xOnYC9bExKTcP8ECHPC7XMQqqqzMaiSFhSrVJkMgzkdAwJ
	 YrKAUgeMyZFlIY/3YuKSKLS38dZUvQpYsPmpv0Vus3AACVuDPPfmW0ggbvqjtAdDD1QAL
	 r1qSXh6IF/7jaaKfoJj+4qmb42z/BKL38EOokW8eu+k1iUQtgqo/HcRaK0tmNq+/CMBCg
	 gIhPkep/gXb05ophBR5oygXjaxReuLrl4hHhvZTSn7V9DqocXyxWBVkhohDV42hOc5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YodJU3G6;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B2606A330
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 02:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E61B2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YodJU3G6
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b3fff0d993so27977a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 18:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795053893; x=1795658693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kC+uhz3Afjp9Cqz8zh23wNboDVMQQa75pZ1niNRa9cE=;
        b=YodJU3G6HOVaHj6WeDt5Y4UHHP2vfW9vVNUgTmANxu80UmKCDlelZ4zcRR33L8Jm2K
         VswI4nIIqlVSIxBF0tdChGfztska8+jRizlCyMVGMW6uzwjEUVtNom2NNrBrrNNu/FsZ
         yQjf+rFOh5JWBC4KwmazJkkyKrtf0xGwBmIEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795053893; x=1795658693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kC+uhz3Afjp9Cqz8zh23wNboDVMQQa75pZ1niNRa9cE=;
        b=wg090Fu8zkyS3DE6x0qu8ZifCMh/3U4qTx1Rnn+baGSo1mGVQzeAIwmaIFdxlSR6sD
         LjjSnrM9FQ60SriqkA3e7+eYHTOWenWvby4VWP3Jka5Iut+QicwL9J6OSLj42Ed2gM70
         zxjNzHnFDEGdknUenyXLgpXs7/V9QQQzzh8+jjYH2DcODflwcdgtT+tLFOuVkC0krmPl
         TY5oeLR83+pNgc+Tkd+sv8xm9Zry3s0d3hC82RwU4Jim7IY0B1lPwYNGzNx9dBPknnkt
         wiIJuWKWt7hGt5HaKWGy3F8KbLu3OqQXAQXNDGrNUX88bNJeC1+kfhv/aSLLqrFa2MCi
         4/jg==
X-Forwarded-Encrypted: i=1; AL+hErHCYm+/iX6BMJlS7O0pTCwxQWDjtRHpeTCN7iLp2O5y/JnQOvHOdLxeKhEc11XVEnOXFPJZlqNEiwYDGSQK@vger.kernel.org
X-Gm-Message-State: APuU4Z9IeUoLi/6lW5cE8AADbtvyhxXMUmSofNkGqdmncDqLVWJRBgkf
	lV+vz1K6Y7t3NR/xeNl67JhBtMcuQsYH+/23wW14LZ5+EvDkqUaqa4AJZaG7zyHkvQ==
X-Gm-Gg: AZFdTZfILejmkyawTfnyClOkBAd9o4R9XYBT8OZK50zPvj0CR0uT6nziPKRMTwUBGHO
	zCRL4kZpgkxH8xg5ZubjVdmgO0L0Cg3UXP0hKd8y4mGb/DARnG7RQ7Cn/yF1pBaHPSXlfvaNPjE
	aDMyLOgUYYL+aAxjkm8l3tKYAD2s9m8wijOZhAyZmgfWZbwmBiHlJQGFcvpMi8lixmOBaHkw/fw
	VKJDqSMHEQKSl6IPwBZo1US0TyAJX0X1dNdSkgLGDMjAuwh+IGHQxJfRP1OgShbCB9M3yqjrkIt
	3skvewTvAKnNfVJQfx5oXZ5BQJTtnv7xqUghysLymH/z5PBGZN6RcpkLw6zUtnI4OSW3W3IeV/3
	XQJGt/YA/H3jau9F4WUT4PGKyZAunRiyhSgt8NdXAFu2AcX6Ni8u5FoXYSEqxgoXZJUhi6RpmUW
	o3rz/n1D42tMKTzpIIY8ASwE8ZlFqcwpc2e8UThRdKKrM7Ptty8eEgbi8DcS+8caZGRSo99QamA
	hQ/EYYQ5wrBNZnrEQyLZO5dR2N4GVJuPrWyPtQdXentuV/ojc/CuHwX2m4GXfJPeggorwy1z8rp
	oHgEoyAxqefb5h9DNLMarR82lV8mhtD7QglL6w7+z/f5+kZTOgnHmoDftohxFKvBQye4/w==
X-Received: by 2002:a17:90b:2805:b0:3b3:c92e:f523 with SMTP id 98e67ed59e1d1-3b3d0764320mr7560562a91.3.1795053893354;
        Wed, 18 Nov 2026 18:04:53 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b3fe0e5bd4sm772079a91.17.2026.11.18.18.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 18:04:52 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: David Hildenbrand <david@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Ian Rickards <ian.rickards@arm.com>,
	Jann Horn <jannh@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	=?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kexec@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] mm: kasan: skip KASAN for GFP_HIGHUSER
Date: Wed, 18 Nov 2026 18:04:45 -0800
Message-ID: <20261119020445.1096831-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <332f315d-ea27-488a-9a3c-28cdfdcd5f27@kernel.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org> <2066d131-f999-4747-beb8-520d5e0ce1db@kernel.org> <CAAFQd5DzTmyeVQxNdhdy8pPi+ts1cCgbztVJiMoNBeJWBzjdQQ@mail.gmail.com> <20261118012858.289236-1-jeffxu@chromium.org> <332f315d-ea27-488a-9a3c-28cdfdcd5f27@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 10:46 AM David Hildenbrand (Arm) <david@kernel.org> wrote:
> > 1) Simply keep those 4 cases under GFP_HIGHUSER (drop patches 1-4 and
> >    7), reducing the series to just the GFP_HIGHUSER change and its KUnit
> >    test.
>
> That's what I would look into first.

Thanks David. I'll wait a few days in case there is more feedback, for
example from the KASAN side, and then send v2 with approach (1).

Jeff
