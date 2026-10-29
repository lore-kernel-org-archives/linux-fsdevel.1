Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793278364;
	b=NOVTrn6yHMH6hldrq505g9shG0ZMhe9Oef92ILXSH6Mn7Rc3PEcddc8rvB4gdH8ZzexW
	 FgCXPU4MQ5Re8KQWZiij0waVIdLN2a+aG/AMWwih/E9XjyFq6bovbvKVb44v2SBmKP5mG
	 9nOuVapKw/TCzf7RqnUK0jqTZQvjpi6OPPlKf1GZfoAqJkkuqkEvVkDZyPzyplgVT9UmN
	 a6RINjHlLHbs9kr/u3yUW26EHFqWQa46A1KhR95hy+vRumxptietCSn0neKDXHKandfXc
	 4LnEIZaey5jzzoNfGkl78dTbzEPnl5W4C0NyEDeYxeKnn2lY48Le/1+ujuqA3ufPMEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
	b=dDdsm3swFCbthAhG2KJkoAg+4NSJ0/KaW2ikp8I6ihs7bs/Uv1SQTKPszHH7GqLupIBz
	 mozIJPr5czLFe+ckYpRDIHG5rpmsS2KKEO48UAirto1ojZG1H7Ba3F7T4k59be7oFbEzP
	 G0aS1NvsQvXpKQYgjJYtwSpT3ThEi9YapPZuiUXf1TzQmvkyClIKac/HgNgAz8sr4p9e6
	 mLbT2I1eN1IV/lBhORxV0umZkg6UOxFQY47VMKY8MbiqdltTqqIHiqXZgCpKjmFybyQm9
	 014RlpW9/LadukFs7f89oAF4hvOb/WNeYHNejx+zBecciVUeiXjiA9IF/T+DkwmkN+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ilBWZNJq;
	arc=fail smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14CA606A320
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 12:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C14CA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ilBWZNJq
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917a707f37eso20303186d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 05:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793278363; cv=none;
        d=google.com; s=arc-20260327;
        b=KiL6uTMWBdWK3P4qT/rN5g6RmEDttUKq8TPU2W6+D2kFBAITJG6MrUxByVyXGop41L
         VocKjSQB7y5dXIL320pLdJUP+KDhupNAU9ulx/gyy0mlcMNvKbajswa+Ues2azkaFVCf
         v4mkZYFimMcjNx3sVBvV5ydNOTmg7yXlD8ekgAKdFHfTWQaxhLUOKGIlDL85IWiyKn6z
         PqLE0wtrHPWcgdjRZHqvRmH2xNjVMMQZIBpRx3m36XCKg9GDHXjHZYDTNDYOzAX/UH3O
         zw21H2eDdHtQjSAt8Yf0nnXd9Iiv001MhhuUtf6JXBtKA4AiHy/3Ofts7L6QzB7wVeMa
         c6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
        fh=tc81ARj5pjN+ZZ8AIT24Fmkbr6hM207URaIpORxEZ50=;
        b=mtOwylA4Qmj1ySNVDU8+1cj4qlBZnZFYu8ELlLfhP2Pd+zkRnKa/VeYNiU9LnasVqi
         KoXAkGUdz3bM8oV8lJDBAg5XpCTLswI68WYTHbddPuHNi2G+I0tRgWpkdCXc0/OF1Cq8
         OGBPoEr2aiOWI+VYufmpQl7zUB+gnJCGXQPTG0PWUbgwov42rFq33KFxfjRtbp8QkG4J
         csGz4pXloOBv3t7QGF0kSgLz/Wc+J3/XocHw3q/XwFPbVIB9keiJiQ/rpLV4LLC732VR
         RlScQgM+tsbWKGogpkvPnjyYqf/1gdBoVxozvF5ubVw6zlJzJ4JBTYpgn/BMPwS7KuHy
         UwoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793278363; x=1793883163; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
        b=ilBWZNJqMKptZvwkKrs2r7FR0ELwbpG7leCsdx7jfQxCDTv/k93OwjEufXvhCe0XID
         xibNckbWfyQTFPGne38psJQsKKrvMTJJdUQrdanZeOz0uHUNeBTeawL4MNhJjblH9PIZ
         fZlKI4CivX5tJ8PkFacttPvf+wR4llu5ZYaPk9JEPGxEXQ3BR/ekFNZPTLVjPTxSfuhU
         s5joSjQqJptEs99jZvbC2wWxLLtLFk1R7Zc5/St+4erii1a/eVPJ1zmACPUgBAS6QKjF
         g5vMM7efqUOyZxMUXtpdO36TgIHqhKOpKi0VWbuiV3m0U/xsOFgC0QRTl1rLSFYijegC
         ufWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793278363; x=1793883163;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zf2xViTkAeLxB49iEkeFNan7sx9Snfm1yj/XBegFK/Q=;
        b=zCoOG/J8X2u+PfPIDwnuBadxKIX2HV5a4/r7O2Lnp5nn2P2vWq4/z/et/JFlaaS9Av
         5g/dau/oUpdIV+XhtzNvZMZpXr04bknpEiPDKnT2tcfWeE7XCjMLTnK/nWk5CdACYhL3
         Nk8d/dZYb1x+hhoYsl7mgXdOTVmqtzDr9F2qTEX0iT8lRdh3ZRrtHNj93nb3FNpPWdtT
         vtTbE+hf7RooLu49pvN+SiB1J5Ng3OJMSzdVx8uOYpJT3a8SXaH0WIw3gpjUKeYG8nF+
         uscm9Ui+drLkDHy+8H6kvhoERwM1O1d3wmccWBz6ghXq2zmWcUrPkrnWpoa2kY1ZN2Jz
         dU0g==
X-Forwarded-Encrypted: i=1; AKwUvBx5JFpUnRHvJUxqFO4NlTdRu6nYMYaJQaIFfazxX2EWPPSyKF/udvYzrZIFFPuWsAeMOU3Wkiw4RNkN4tis@vger.kernel.org
X-Gm-Message-State: AFq9FYJmd4pwAMTkmCAJTna6HWrce6JFJTLmWl9k6hV16Vy7EM3pwATT
	X9Lxir01zBbKxlpeMW/7104qYnZpisIGbfuYl145XeL8c3dWeP6f1eUOj2Way/9cS8kKypCDIas
	wbrzpzx58GG029jv3JNztZGsBrExB3yv//mU4gMQe
X-Gm-Gg: AYBFou08Mvwh+Z2jxz73uwDlEYS0jibUw4J50zscnNwk0PmgiAsc//Hbu+pYUEZzNDP
	eIW5gj3Mra8zhMIRTiG2bANnvGzGqB1PmcnUOwX5yhppj+ldm8Tuwl9KArw2U7+YyM+hn7XrIF/
	JSJrykj9Zma3XKRDgrdHzosS9A1V2sbKaCGJ1il1W7SfVAVHP19N2wzFxPYxVQH5sSiN2HILtGG
	ChhZyfHpEOy6uupmnqjTa1fwlnOyRUFM66SOsot2pvg8AxKkIMelsVv9Ngr+wPT9ct7+HiqqaTL
	EzHVHuG8YpP2V3oWnnZqIw1CFqXh8SjMDtlC86ka+5o7dWE0yValme7TR9Ka7VlFSDSNcOjB0VS
	hOPScXD/lMPNMkt3IJg+yscSywuVl4tLoDx2rOgmKb36T594IdxKSOQhd4+RpqBezbA==
X-Received: by 2002:ad4:5747:0:b0:91b:9496:6a18 with SMTP id
 6a1803df08f44-91c7d1ae53bmr83041376d6.37.1793278361370; Thu, 29 Oct 2026
 05:52:41 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 05:52:40 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261027154649.91571-12-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com> <20261027154649.91571-12-griffoul@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 05:52:40 -0700
X-Gm-Features: AclHuK85LBuCmtDdaaOWg4OEyIMQUVa8mDtLyPY6JdCBNPTut6N07RXjZEiRQWQ
Message-ID: <CAEvNRgGn09qrCZjUM5sdqQohPWE62GN4c52iK7ZV_gi5wro_Ww@mail.gmail.com>
Subject: Re: [RFC PATCH 11/14] KVM: guest_memfd: Add kvm_gmem_restore() for
 PFN mode providers
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
> A device cannot fault, so when a PFN mode provider gives frames to pages
> that had none, or makes a read-only frame writable, a subsystem that
> maps the file must be told.

Totally makes sense that guest_memfd needs a way to actively map pages
into the IOMMU page tables, rather than passively like for userspace
page tables and stage 2 page tables.

When the memory is owned by guest_memfd, on a to-shared conversion,
guest_memfd would do the mapping for IOMMU, which can't handle faults
like Stage 2 or userspace page tables.

> kvm_gmem_revoke() does not fit: it would
> zap the guest's and the VMM's mappings and reclaim frames that a guest
> may already use.
>

I'd drop this paragraph from the commit message, kvm_gmem_revoke() is
the complete opposite and isn't a candidate at all for the goal, which
is to notify importers that a page is now available (and they can map it
in).

> Add kvm_gmem_restore(), the counterpart to kvm_gmem_revoke() that the
> sample provider leaves for users that cannot fault. It only updates the
> exports, under the shared invalidate lock.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
> ---
>  arch/x86/kvm/Makefile       |  1 +
>  include/linux/guest_memfd.h | 37 ++++++++++++++++++++++---------------
>  virt/kvm/guest_memfd.c      | 35 +++++++++++++++++++++++++++++++++--
>  3 files changed, 56 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 25fb3d6e2032..3255280884b5 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -63,6 +63,7 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
>  				-e kvm_write_track_remove_gfn \
>  				-e kvm_file_to_kvm_fn \
>  				-e kvm_gmem_revoke \
> +				-e kvm_gmem_restore \

provider --1--> guest_memfd --2--> IOMMU

2 is definitely required, but why is 1 required?

Between the first .get_pfn() or .lookup_pfn_range() () and
.put_pfn_range() or kvm_gmem_revoke(), the provider should consider the
memory in-use by guest_memfd.

When it's in-use by guest_memfd, then guest_memfd should use --2--> to
map into IOMMU page tables as necessary.

When it's not in-use by guest_memfd, why would the provider force it
into guest_memfd?

If the guest VM knows that the page is now usable (some other
communication channel), it would touch the memory and do a .get_pfn(),
that would be successful this time. Perhaps that's when --2--> needs to
be performed?

>  				-e kvm_gmem_export
>
>  # Force grep to emit a goofy group separator that can in turn be replaced with
>
> [...snip...]
>
