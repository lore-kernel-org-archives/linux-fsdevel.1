Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793284080;
	b=bygycWlgPLRlSFb2MbeLMXZz+kvYeIM2EfBb19VpwtCG9ZjTwPOfVrGm0Ogi/KT904Fh
	 3nYq3+hmZ5R667oleW/cBDhVjsl+L7KvrfDClypyPxj3RUAFK7pBkaZF+iWwQcBtCtmLO
	 W6LqF+U2PMLgBvhMGe6Ltl4ajgnp71lsjSHpEz3ukiDBvf+h2FwsKiZiieKqfmwpkDJMn
	 yOJoavuQZWkX4Pukslwgnzd+7rM8nFwipr6LWjW1xdsazP0Od4N35wazDLanALU2Q+WWE
	 YgGj3frhaKgUj4O4lK7MbuiJuXoP4FyWXChqUx63+Y6mUBk3V9EkvRhsr97huxocxsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gO96Ic3QVCctvLn6OTuZFYeIzqeAoDK7wy79tyihoyk=;
	b=zOJSmhEEThSW9oU+qOhhqRJjykoa1PZ7/xg6Hh50zrpn7wxcQx7AFcElV++X3n8FPzBj
	 SG13VWJOsx0bNz2VEeFMiw4XfoxhM8eGowTpzEg0wM5szMcNk4rGl/ptd82cNktI4eb8r
	 jXTHs5TdiR9C+Dsmp1OwiqonrIoXlG/0foOGRNEkLwRDU4m4qrwJI18jFU+ncCga6XuuT
	 ZMDvwpQPwxlEGCN17DOH9rTAAmrfcISOBRvl0FnTpzk0rp/iIdMyLpHR5WS7N8tm7GbT9
	 qsN5vePb65S5NVwCg/fopF2NuxZeQY13BqHgo1J7msxtnOXC7eI+yutPMYpL34Bgljg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j1TTQur8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6EF606A325
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 14:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F6EF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j1TTQur8
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1308604a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 07:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793284079; cv=none;
        d=google.com; s=arc-20260327;
        b=qXFoGSobrABuvaIKsEoHrA9Bb2NdMjLQFh73yd6w8qaS2aWUXs7VJuAS0sPByEwaoG
         9qC/Qua5uSiojNXX60YXjYH/75M00URHuLIYxsuJIZpEUSfZU709JlBN4SNYysB1q6IO
         XXhIK3x2rjK5J4iQTMuHN/B3PzBMAYWWi20ow9HJ6nzCGbYduAH0C05VY5RorhobkCi4
         vrh667SJMGZRckvowOSEDiKVs3dOHwozneHSHcDqGBdvhrHyUbobmwOfmUbcPk7q3ULb
         gsR8U375m7cFQm2fAJ4doEPP0NwFcisi7U8iGC/d/0bvEQYLPl/w4Omzt5YrVQjgqc09
         2U4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gO96Ic3QVCctvLn6OTuZFYeIzqeAoDK7wy79tyihoyk=;
        fh=Qz9pv0qoRNxQhmIOJvd/Wp3RU9JYVvls0QJZteo3YmA=;
        b=JcunsFAAKBoCRdp5AVmflv4qhVh0xTJI+PUFmPmQkoh0qM+NSz9rdq8haQr/eQMabk
         9ZIpfH90TzehWhJXHCIkq2c3yuDWiJEJfEIQTJYuJrfkH3rQ9hPFBkcbTa47rEKg29n6
         qHQCNDr2AGbVR52EiL4TNbrYaezzSJ+urxDOboXp63CiL/pzRk6+rvJRRuFd29wJNrBL
         Z5y5XyUxH0j+CimrHsZBIPzJl/aP/BDGaqg6DBw4pEYE/Y8aRN7xs50tzQuxfG+33B4M
         8exo14jnbtEdig12oEJR2BXCM2gYg8f84b9QQCuG1XLbWZzdtnq8PkBo16ETTwFz5fDU
         Ie6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284079; x=1793888879; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gO96Ic3QVCctvLn6OTuZFYeIzqeAoDK7wy79tyihoyk=;
        b=j1TTQur8+34cz+xCnLSGj1Q8IezmFsnFL6FNF89kgyeY+SVBe6V5tIbkVoAguCY6d5
         pR6EWRwR98xgOpoLbY0MtYGVivdVn2Dd8BTxAOfY6lwP2ygaejDtVOC6DJyiU0eOvsnL
         7g0i/K+0cdfEhDdEfhjCohSpXG8cUWc8Tl+JQy5a1dhLx+XJFhnEH5y/gfULH5FwgXTV
         b7T06jcHrkPSo2I0Jy3DUGTSRMwcV21XKoW74ckTitbK+NAO/6P5Rtk0pt2zhsTUuy4q
         9ZBT/vYqixv/fCsMfGn4uE7Wz/E9N6oEHXMSAwAJCUVjfiNqjmMAKMffL9GiaH/zlma0
         ieSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284079; x=1793888879;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gO96Ic3QVCctvLn6OTuZFYeIzqeAoDK7wy79tyihoyk=;
        b=I+4H1x7mYgP4bAgab+/jpR17bE97pgWucXd1uh2MQO+Do1xfk8a9LdqcseSR2Oi0ly
         iqW6Ne/5bxFGqhrxODCRz9w4W/SuR7XncHns8i9OxZ+GPiBjp6ORHXt355RwrgN/L1a6
         MrP40fDOl4EFSSqjS9UjQwGxLrpdMzapAmuHVYnBuYxD5feRMWoRtzuOU+N5d1i2RLco
         n4qN2iVV339RjiQ6DQSgGVgqVnCCaT1PJDWj530CyQh+z8i9owxjhdbq22IUEuxGCL3L
         SIDwg/umH6TNU1/wKtuFiq5imlJPqYsOrJlNvnV+t8nNzppSjbNJ0UjyvzpoqrIrs1B6
         kVdw==
X-Forwarded-Encrypted: i=1; AKwUvBwSbFpALHd+g0tvW6uTW9nnzNVoFpPkGye3imroNM4FwvPMNilP6lEuThYvVDD9M84Nl56uieu9+tZpQZjj@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2xoexcSMMV6kp7LJgw7ewth8aXERSyziH0wJVQrz28bEJ+XCt
	Vrk93ZWLff6HNNFy1teOvBWwb//3B8IKLLsC4OdoR84bXeUleKtGlvPqaao98++amdLq/3+/w+H
	S/O78zemWtKemem7YaSmkzLlI18GhZ+8=
X-Gm-Gg: AYBFou3CR1XPxnIb3jfg+yyx1FGOn0F9RdYEOSrgJLxaYoKCMID5esZZ+1jKQa4GdOv
	popjdcCTsOL69iHkVKsLjma5cIfXvTg8pqVENUxrpsmenOgOziKNyvoH0D1Lfa40biBqK58iYMn
	TRZOsEJq4DW0bTVw6tVh+kfKPtvkmwrnUiGz78p7t7xhyTeIDwalEHvkUX4tCN9JhD11wlMOvvY
	nwfozjSs1az6HUt2cUZOtbXSItJHrcnS8k9fRzI9PQnJGRu1epFwKvV4eD5lWeQxkWaFbp6Oljp
	coWr7rQ/hWIZelTKVOGkq2Vtfk3hbKXRCcLcrcyGPGr6FmRCZFq+VOgvfm8sFk9Z6kqahs21iWm
	9K8q+kJFUkTWWHVXeFvaTo07agVw2L78QYqRe+DY/2DUYeTyEEJVi46IHUqEU2avqMHvnnw==
X-Received: by 2002:a05:6402:4508:b0:6b1:bb19:de98 with SMTP id
 4fb4d7f45d1cf-6b4b0b09dcemr2163933a12.1.1793284076799; Thu, 29 Oct 2026
 07:27:56 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com> <20261027154649.91571-12-griffoul@gmail.com>
 <CAEvNRgGn09qrCZjUM5sdqQohPWE62GN4c52iK7ZV_gi5wro_Ww@mail.gmail.com>
In-Reply-To: <CAEvNRgGn09qrCZjUM5sdqQohPWE62GN4c52iK7ZV_gi5wro_Ww@mail.gmail.com>
From: Frederic Griffoul <griffoul@gmail.com>
Date: Thu, 29 Oct 2026 14:27:45 +0000
X-Gm-Features: AclHuK_kIg9XZ2cFnZL0tpsqSJGFt3xKJOd_xbKB2NrNWZ3oy-bCAgu9pf3hZSM
Message-ID: <CAF2vKzOTd=0rmMXvtAE_SzbbZ3C9n9jTcjM+Rj=ovFoYBsXCKA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/14] KVM: guest_memfd: Add kvm_gmem_restore() for
 PFN mode providers
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Alexander Graf <graf@amazon.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Alexey Kardashevskiy <aik@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

On Thu, Oct 29, 2026 at 05:52:40AM -0700, Ackerley Tng wrote:
> Fred Griffoul <griffoul@gmail.com> writes:
>
> > kvm_gmem_revoke() does not fit: it would
> > zap the guest's and the VMM's mappings and reclaim frames that a guest
> > may already use.
> >
>
> I'd drop this paragraph from the commit message, kvm_gmem_revoke() is
> the complete opposite and isn't a candidate at all for the goal, which
> is to notify importers that a page is now available (and they can map it
> in).

Sure, I'll drop it.

> provider --1--> guest_memfd --2--> IOMMU
>
> 2 is definitely required, but why is 1 required?
>
> Between the first .get_pfn() or .lookup_pfn_range() () and
> .put_pfn_range() or kvm_gmem_revoke(), the provider should consider the
> memory in-use by guest_memfd.
>
> When it's in-use by guest_memfd, then guest_memfd should use --2--> to
> map into IOMMU page tables as necessary.
>
> When it's not in-use by guest_memfd, why would the provider force it
> into guest_memfd?
>
> If the guest VM knows that the page is now usable (some other
> communication channel), it would touch the memory and do a .get_pfn(),
> that would be successful this time. Perhaps that's when --2--> needs to
> be performed?

The IOMMU never asks, and the CPU may not touch the page before a
device does. A few cases where only the provider knows:

- The provider gives frames back with no guest involved: a page that
  arrives during post-copy, a range moved back to the VM, memory given
  to an overcommitted VM.

- The guest already gave that IOVA to a device as a DMA buffer. The
  device writes it without any CPU access, so there is no .get_pfn()
  from a stage-2 fault, and most devices cannot fault.

- A read-only frame becomes writable. KVM finds out on the next write
  fault, but a device write to a read-only IOPTE just fails.

kvm_gmem_restore() doesn't push the memory into guest_memfd: guest_memfd
only passes it on to its exports. Stage-2 and userspace mappings stay
lazy, and iommufd looks the range up again and maps it.

I'll make that clear in the kernel-doc and the commit message. Would
that work for you?

Fred
