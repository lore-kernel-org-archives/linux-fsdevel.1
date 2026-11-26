Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795653217;
	b=TX0SorjDTyI4USZUAzx5BXF+BnZXqv3WVI1ks3vpkvoenm+x0r89CAk8Lysn21UUwzRv
	 nbZtHYo9DZOYFTCfwv05lE7LKNztQzUmza7G8tvH8CCboM1AYbm6zaZtBuNH6gJdGEXbS
	 oAgeyd9w1dO3hwJ/KxZ7tZM9RHdKonChOqpRd1fZLRkvwRVLALcCpncwHgQeO23gnT6Ql
	 1+/U6O4TiGGqMJtcagX/bKuvS5V6UcAlp43bn3ZSZXo8t+MRGuph3xz6E7z3lEUl+uOZO
	 D4CkirZH+tvujqW2vUmgCtFzHKXbP3eTS4ke0zpDBKjUgXJ8+2y6KmiN9Exth0smHrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795653217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=n7CSRRc6wmlgTahpgsaeBRSOFvVKDVf8gI4nOytFKB4=;
	b=RWLQebbFGo3pkMlEET88VwllEVpWYhjzC2cTxtfnXxSsRVRstjSLotI1pLU5ktnAYEMA
	 HVneewQ5G4VIFZNE5hNcLecqDP46lfucTpFXUf+Zds7V6tPurZML0ohMIJxyNVK5jJ4fD
	 Tb1prUBqXQhl60bMTyrySjp7qQQSUNowJCYKQa/JGEnDBC3QzjGlsyysAd0D3IUof/yqy
	 ldfdtUxIosBtRAmx0a0QVgXGZaIQqFWebpDejlP07VZf95TYAXFg17jdiqrQ2/rQ4ciY0
	 IuOI0Ub98yy5tyUluvOBWt7jQiIvVuR+7Z8AROa6NKgHEBVBgP0fOYJZV1//qc5CPRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jWsCuCyo;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB418606A327
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 00:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB418606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jWsCuCyo
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f0414c1062so39455155ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 16:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795653216; x=1796258016; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7CSRRc6wmlgTahpgsaeBRSOFvVKDVf8gI4nOytFKB4=;
        b=jWsCuCyowIb2n9Rv7XdeLBoSHT+n7g0YGWhHrYh/G0RdYbTbF+56gGVgtVisdc7T89
         MKawGtG9pHO6Ft+ybk3kmMsiPH+MQDGsejbWohGWmgG8aVaZe7iIhfp6RsC/JOpFiaON
         MO0rbPj305k5dwkqPK3ddivXEQMTBWTTiu/DbNXI4wP+pZo0lH2TNoTTSF/7iFb+fmBz
         uaEItEXoD1gh+4J4eUm9FIUIMZh/n3it6jjwxxUyGY7v5bohC0TRCdpjc1kI90Gv0toj
         q2JHXP9sgeZkxyJDuT5shgUMemp7awDDz3sc8WrT2PFHVCGJZbhYRSPXy2dq7T3bZ8rR
         r1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795653216; x=1796258016;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7CSRRc6wmlgTahpgsaeBRSOFvVKDVf8gI4nOytFKB4=;
        b=2TNSpZIzhOcNnMv8mAQTiaqR8o0kZ373aA6EDTzQQ52b56Zol9r1yDrMbfZwD+Rwne
         cPe6UJcygPtEdnI1KFgHF20NZ06Tgu50bINWGSAbJE0alxyAPBh0UxMTV/nnW8Kopi8C
         kRkkiK39rQ2Nh5/c0cVh9dGhazlGSZj2FRpMwV1zmqJ6tUF/OO2SFj5z7Ijq8Rfngy3y
         ioJTNCJuthtwRo6uig1YI+zSowOwEAgy5DITNlCQ5RXJlm+5646SOnpfQFeEcN3W0mVv
         KsVBxcdw2xOQ7s/JBCAuNrKOfjwQcXILD7/0FBKV3tsO6VU4iqXbb9xTkJRfUJZyTC2z
         erdA==
X-Forwarded-Encrypted: i=1; AL+hErEdlwjyXDNfgrXt3XJZl2QtlBQyRp81w8VSz+og/xaqhEBp6OcMT0DbWL1ZUa2UjmcwF7Y4k/EEVoxG3+oR@vger.kernel.org
X-Gm-Message-State: APuU4Z+n4KbuAY14dLaFnmMVGk6ZIkZTKArMboIJ0Qe0IJf9euQIsfxJ
	DQCE07Y+ACE2y3fv5q6IbF1tb6L2YN6s/RUMlP4VPF9narwclKs/8IMZbDpqnOo3ZA==
X-Gm-Gg: AZFdTZdKyZ1L/gQE1yUXQE3h7XN9oh5aRi8Bvc/cIXxFJgVg8/tiavfVT3hUE5Qw7BZ
	1cbU3lacSilJapYe+EwXqm1lekjGGbdX0Qj1QXf6+fHGMK0zkin6EWds+rgBR5g3T8Zp39cHz4V
	/3xDSfUaSGRw1DSRprx84uzz5rWvTNfcr7cTV3oFYtYpz6UPGeQuZ2svV720b/4Yo06t+PIdwIJ
	gaIrYW5oRnOmaKnZsp91E4puecLpIhyADlN5uZBxo5OP5X9RX6zmspFSoF1Cd+REoHQDd40tDsU
	asc6cX62AtcdzIx8gZc2CsDtevGPCYVxT1Eafp58OhMgDZT2wL7vVJBTHCSlcdRV5JfsUs2H/SX
	6uNZc4/IOCWNLpOvPOigtP3OUZEGNp4WRCDRZn9uTvYLKL6QYeUQMJlDVxTVxocf69NE3rn0dhA
	Jj9GlBPI3CMSjsZxTyIQSJ2iHMNpx9asqlXev6arNyWPtgPkhrAV/exWeUDFUEAzqk+KA7mBBXI
	RIj3HvzEDT3jw8H72Q/k0/ZqC41lSjY+K95L0Xj4qEg4vLRwWIOEfIlkcyw5Nr9/gBfzKoBC6mE
	Y462ciJJlHnSsW25kHmIDxIysCKDPgoEVq33RoAu51zjoJtUSP9I9DBGeZxYRWjH
X-Received: by 2002:a17:902:e80b:b0:2e9:9a19:c43 with SMTP id d9443c01a7336-2f03f118277mr192264515ad.15.1795653215229;
        Wed, 25 Nov 2026 16:33:35 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14a432sm95165955ad.75.2026.11.25.16.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 16:33:33 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 16:33:32 -0800
Message-Id: <DN4PXTY768YS.3I99BQYLC8VXI@google.com>
Cc: "Mostafa Saleh" <smostafa@google.com>, "Daniel Mentz"
 <danielmentz@google.com>, "Samiullah Khawaja" <skhawaja@google.com>,
 <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>, "Logan
 Odell" <loganodell@google.com>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 7/7] vfio/selftests: Add observability test for IO
 page table usage
From: "David Matlack" <dmatlack@google.com>
To: "Pranjal Shrivastava" <praan@google.com>, "Joerg Roedel"
 <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, "Robin Murphy"
 <robin.murphy@arm.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Kevin Tian"
 <kevin.tian@intel.com>, "Alex Williamson" <alex@shazbot.org>, "David
 Matlack" <dmatlack@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>
X-Mailer: aerc 0.21.0
References: <20261001224531.765278-1-praan@google.com>
 <20261001224531.765278-8-praan@google.com>
In-Reply-To: <20261001224531.765278-8-praan@google.com>

On Thu Oct 1, 2026 at 3:45 PM PDT, Pranjal Shrivastava wrote:
> Add a new selftest, vfio_nr_pages_test, to validate the iommu-nr-pages
> fdinfo metric across all IOMMU backends (Type 1 and IOMMUFD native/compat=
).

What's the status of this series? Should we expect another version
(e.g. after the discussion on the shrinker RFC and at LPC)?

nit: Please use "vfio: selftests:" as the shortlog prefix for VFIO
selftests (see Documentation/driver-api/vfio-selftests.rst).

I gave this a try in QEMU with an emulated Intel IOMMU (which uses
generic_pt, so it reports iommu-nr-pages), on top of this series. It
fails in every mode except iommufd, which skips. Details below.

[...]

> +static long read_nr_pages(struct iommu *iommu)
> +{
> +	char path[256];
> +	char line[128];
> +	FILE *f;
> +	long val =3D -1;
> +	int fd =3D iommu->container_fd !=3D -1 ? iommu->container_fd : iommu->i=
ommufd;

In iommufd mode container_fd is 0, not -1, so this reads the fdinfo for
stdin, never finds the key, and the test skips with "iommu-nr-pages not
reported by this IOMMU". libvfio uses a non-zero iommufd to mean
iommufd mode, so:

	int fd =3D iommu->iommufd ? iommu->iommufd : iommu->container_fd;

Also, consider moving this into the VFIO selftests library (lib/iommu.c
and libvfio/iommu.h), e.g. as iommu_nr_pages(), so other tests can use
it and the library can hide which fd to read.

[...]

> +FIXTURE_SETUP(vfio_nr_pages_test)
> +{
> +	self->iommu =3D iommu_init(variant->iommu_mode);
> +	if (!self->iommu)
> +		SKIP(return, "IOMMU mode %s not supported", variant->iommu_mode);
> +
> +	self->device =3D vfio_pci_device_init(device_bdf, self->iommu);
> +	if (!self->device) {
> +		iommu_cleanup(self->iommu);
> +		SKIP(return, "Failed to initialize VFIO device");
> +	}
> +}

iommu_init() and vfio_pci_device_init() assert on failure and never
return NULL, so these checks (and the matching ones in the teardown) can
be dropped. Please follow the setup in the other VFIO selftests, e.g.
vfio_dma_mapping_test.c.

[...]

> +	if (!self->iommu || !self->device)
> +		SKIP(return, "Fixture setup failed");

This can be dropped too. On top of the above, the harness doesn't run
the test body at all if FIXTURE_SETUP() skips or fails.

[...]

> +	/* Map a page at start */
> +	region1.size =3D SZ_4K;
> +	region1.vaddr =3D mmap_reserve(region1.size, region1.size, 0);
> +	ASSERT_NE(MAP_FAILED, region1.vaddr);
> +	region1.iova =3D 0x100000;
> +	iommu_map(self->iommu, &region1);

mmap_reserve() returns a PROT_NONE reservation (it's meant for reserving
aligned virtual address space, e.g. for mapping BARs), so there's
nothing for VFIO or iommufd to pin, and iommu_map() fails with -EFAULT:

  #  RUN           vfio_nr_pages_test.vfio_type1_iommu.sparse_mapping_stick=
y_reclamation ...
  # .../libvfio/iommu.h:42: Assertion Failure
  #   Expression: __iommu_map(iommu, region) =3D=3D 0
  #   Observed: 0xfffffffffffffff2 =3D=3D 0
  #   [errno: 14 - Bad address]

Please mmap() real anonymous memory instead (PROT_READ | PROT_WRITE,
MAP_PRIVATE | MAP_ANONYMOUS). With that and the fd fix above, the test
passes in all 5 modes.

Also, please allocate the IOVAs with iova_allocator rather than
hardcoding them, so the test doesn't trip over reserved IOVA ranges on
other platforms. e.g. allocate SZ_2G and use the start and start +
SZ_1G.

[...]

> +	nr_pages_final =3D read_nr_pages(self->iommu);
> +
> +	/* Page tables should remain allocated */
> +	ASSERT_EQ(nr_pages_final, nr_pages_mapped);

This asserts the behavior that the cover letter describes as the
problem, and that the IO page table shrinker (or the clean(gap) approach
Jason suggested on that thread) is meant to change. The test will break
as soon as empty tables get freed.

I think it would be more useful to check that the accounting tracks the
page table in both directions. e.g. also map and unmap a range that
covers an entire table with a single unmap, which generic_pt frees
today, and check that iommu-nr-pages goes back down. For the sparse
case, ASSERT_GE(nr_pages_final, nr_pages_initial) would still catch
underflow without depending on when tables get freed.
