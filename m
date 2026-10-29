Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793279032;
	b=Vh9KsIG/lL8XUF6vExv/YVWk13wbFYkPnPDndlYnY2RDu8LWbe8eHq82L0phz2xNv/T0
	 7XyZjpBGaIc0nObVcAJb1McSQcsCOJU126OiLgQJ/mAUgOCdez+rJ0oX6H+FuIoUdjgAK
	 4PaHs2SsXr6BzBURu+F6qqgtcDfuCXwgRZvT99o6jeRgR631hfYMNQtC9ZKw4DDHmgqcY
	 z1UJnkY7Ts3oEeBd2UsLF8+IW3ynmS6fr8+ENQfZlwSe4LiIUNbndFc3pmtWugCxxgP37
	 UwDLpnnjDtB+7kedCg1BMpQ49aDoiagQ9YpsNMT9MT0GnAsEXBJl9oN9CxkAGB4IaRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
	b=vk1z+X4W7RS69mhzVZRJ/O4Okwf1SFEnC7mKgLvsLUi25rKGPsp5/BIN+ATMBk57ONSK
	 hnxJboLe9dH7JdajS55hRPrXWPbHjo1sQuEmNKXGV/be9bk6+IZkEkxBf+1IXsGG1ZXjx
	 6JIbWsTfA8W0Mc7gtmk9IHaJfXbxUEUZYOglvUjAu8fyBCkppo3vPcHJ+vi1wO/0T5oXF
	 2TEGFF0J4ag5UdVkgHyEpqMF8Lz3jHPEc9ld/6hIFRzXbdO2ZylTJodrNGAYNgOihQylC
	 EAFsFnSLdaH/k4IhKtM/Xbd6R5WIjwR5GBZJi+K7cn6kulo66M0RnXSXSTw5yXAHaqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C50p55VE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E1606A322
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 13:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A39E1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C50p55VE
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53653e30353so31942011cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 06:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793279030; cv=none;
        d=google.com; s=arc-20260327;
        b=eHTEOv6DANaWG8MEmlmCb1Yc7hWiQGmk1OcrUMs3slZufD2TMMUNRlRySVgqOElfJ7
         EKmNTNixEnknfI/ghavSyCWE74bj9u78bTmwEEr06OkpdpqlKUNYpyeYU3mcir2k+Nx7
         Q2/uanX0MWeRdDSJkxJWoeg9mHcCf1HpInjcSjnSqTZt3M/lHPc6HKOvpVkMoJ7XjqA8
         Ef1x1QAPNlmvwVXzB9fmfyz1MFNv3k3AQ2almONcPzR8e9UbpWJRWfAxc3sbrPaJv2YX
         ixQNyyiN4cp8jo7hVPgYUyyiJVsYtX7de57mx7yYgzM2ns1WLE9pyFtY+6A4f2g2gnAa
         877Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
        fh=C8QulZkBSPiMAkCYJZ9NL4v2WOAmoA1v9XVBfBr1Abg=;
        b=TVsSiI+5wqRgECUMqnyEYWObRmYQIEBKmii44u9PIjAsEHiH4GdeZKEjed5eP1/SAl
         5BTzfmuK9emyHCt6mUR04ssaACwV3jiVhSWEY+OAfEVd/PYWBILv4EzWt4urMVd6lzzt
         RFiqa75A6Bbb1sSHDcf3+gXNQdt+s2YqriV2LhQQiTomeATgsQTLbp+2tfiY/e/Y1MjM
         otkBbygoSns48a9R7u5c56lLiS1W/pWk3MhBC4fO2VlWeN855B6FKSZsUHqOVCy8qNwv
         m3Pz8FXrNIUEIaj4Kzzbh5nkoVdeD3tJjxveOX8XVfhZ84oc1aNTN/6Ls4oj+8lJu/ML
         bjVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793279030; x=1793883830; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
        b=C50p55VE6UDgdJKjElhLNYeFnq2Z4W8Od9eebfXsNR9VAhMbuaucrBe3v34nD049Xh
         yXm9F3TtGHSCUfiyL84unodeE/D/DA4pXmQUqEyGn/jbzwUXL1qz7UhjKg7x/77SkPix
         fsjUQTeybn8SfOvtOZp7Ze23YYniYqtLT1UwOhsEzcphyyhlfKEtsn4tdZBRLgc6VGnn
         khGCfASslvGnrRTfZsJpLUafVUjMR4da5X1aPxkPViKfkQjA5KDrJs0J0Eq/vsUuWr/y
         tjS3p/M+jkqfdwuGB0zuj39WLEgzFkDffjSEsV+2WjPvf4qzkU/p2d+HMbeijeMHkNP0
         cH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279030; x=1793883830;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
        b=19YIWwehK/xbeBs7GndLGw+P7ZqaGOwXHrjx/SEGqqYcxeraGIaAoqTkRaAwPYJ3rs
         6ZQcjJwmBXtys7S58TwlrPfNgQzNWpjKjVXUUw9RDplxNPmBBoRc9kCR57o3h8bORZ+2
         kusXdbZeYMtpcq+4MJoME68cr0Syn+tIrvLgyG+Qin3AS6n56k0l5DpeyACL8E6J1iC2
         ob/TWAy0R58dlR6lN+MtZaC9AtwlohW/I4bBAQXUtzmlr5OuK0neIDCMs3VYRV+E3onq
         jFxPOvsK6FgRb3Q9X2V8FpnU0iWYRFnPROlsOQDcdTyc2ixO6Tf5773KXqiZ5mbe5HKe
         vR6A==
X-Forwarded-Encrypted: i=1; AKwUvBxd2kWv+TYESpGYG69vyj5c2UfW3LmPzBp+tksDUQF+oIDTWoGnMWrDLRd0HoBBGPVDPxTqTz0w/ZMRHvzo@vger.kernel.org
X-Gm-Message-State: AFq9FYJIXuNtKUIOA8BeueTi16D4jafBmVHdLPzYcAfBNl9hTg0G7cbS
	zTuSw6rdWiMnaQ9dCbJt5yJWtoTKFn9Ss0UNuIk69UiCEFWlyfvft2nqzsMVKWF02dO2nT/tsLT
	qC7vK12npDKYL88hsRTU+zPuko1EsEgILehkLy+9P
X-Gm-Gg: AYBFou3enDd/gIfc07xFk3YTBDiOqzN/t/ODXItxhKgac/xG75EVzVQdHalTW/QYoAh
	v7Je3e9xkC8xokTqzEtl0kIUz9I7RBFEWdW6KrvTSJG4IgbGbcqfho4P600uQUJ3ysba+iddJWi
	KqAGpX3u8u9BWlZ/ClcYWPfHqt1Qfy2N3wYlMX6AmYjJzl1t72PT6ZuRmY5+zGqBwUuRzdnf16f
	H3UtaJcOvDGtgHSRAZT3cCRJ287K6YLKLObg1b8fsn2UE1lPDUHGBzTID8uxRijJ2LZals1nLd1
	fUIO81Js4knHMKu9MelVKWKdsuHdDf7o8qd6hk4joa1tnBfPnwDg2Iod6D8Fh0moc0F4Zjo9wR+
	f3SZBfRy0C1JN3j4Q0yxSMTn3klbeU1bQ+giw3ZNDPJtaV0Q3SrA=
X-Received: by 2002:a05:622a:528f:b0:537:b9f5:e05 with SMTP id
 d75a77b69052e-53fcc7cc0camr87903901cf.69.1793279029444; Thu, 29 Oct 2026
 06:03:49 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 06:03:47 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261027154649.91571-14-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com> <20261027154649.91571-14-griffoul@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 06:03:47 -0700
X-Gm-Features: AclHuK_J4_B8WHMj3lc3Bqk_zMBRzyMWVypxyBk9aFiFYwwISWnD_-KRrJmOcto
Message-ID: <CAEvNRgFYecSKycFLkxwyK7gWZqKTXTPJVetSZm8YBbo0kg9tTA@mail.gmail.com>
Subject: Re: [RFC PATCH 13/14] samples/kvm: Back absent pages on demand in the
 sample provider
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexey Kardashevskiy <aik@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Ashish Kalra <ashish.kalra@amd.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Connor Williamson <connordw@amazon.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
	David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
	Gregory Price <gourry@gourry.net>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, Jianxiong Gao <jxgao@google.com>, 
	Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
	John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <shuah@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>, 
	Steven Price <steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

> From: Fred Griffoul <fgriffo@amazon.co.uk>
>
> The sample provider fails get_pfn() for an absent page and keeps its
> frames on a punch hole, so tests cannot exercise a provider that backs
> a hole when it is asked for a frame, one that backs more than the page
> asked for, or one that frees the frames that a punch hole gives back.
>
> Add MPS_NEW_FILE_FILL: get_pfn() then backs an absent page with the
> whole 2 MiB block around it, and put_pfn_range() makes the pages absent
> again.
>

Can what MPS_NEW_FILE_FILL is meant to illustrate be illustrated with
the ioctl that sets memory present?

> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
>
> [...snip...]
>
