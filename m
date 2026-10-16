Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF34746B7
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148287; cv=none; b=t8F6/cniX9zWpKUnXgcg8y+57CrSjSmz0NGmuknP+FjGO7C+CjQbVWefYUsVthLVATG10G/wOm2USmG7ST+s2EBO7iNYAN1sOKPEcV7/Zjgq1rDhga85qIkhyLaFDMOFz75VCf4hVarnn35ww0+jtLJr+o0ize+OiGxUVaKawfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148287; c=relaxed/simple;
	bh=Fg04sF4wbeMFqUdM8zmoRfU3uiwkIyCVmr/Efwdeo90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VY8PnA9SRWLF73B9N8cvuURDJhkXxXHkUpLAX69L1cpn4ZnGIa6mj2McfVuRiHT0UTXigZSlDmc3zxfVqv7GH8lqgsI5I9QUQDQmJ7GZhK3zzbmNLhFUs5KhpLBC6a7qZ549ye2WwKo7K9cESZO6OfL//KIAvAYKI/RaU2TixyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7TxFbZ/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7TxFbZ/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49ff680331aso33351705e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 03:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792148275; x=1792753075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JjoY/Y//bNqM95eGJvwXGt/YGARtJeL2jF1lkb5NGWs=;
        b=D7TxFbZ/sReh3v9xlEhDQQupP3G0XuiqfnTAAzEzRg5We8Zmo4u+UYf+BrHQNxoJlB
         0itiCLX2dCbSxl8MMiHEWrRUDTQSK9eAJX+mb9vFx7xZD+WTklf/ZEjZ6And0PB+8Wbz
         mbOoRzZK74MQ4iuuToNhMEe5wBNv2mBmN2j94m/daLFCHNfkVUKD41DRUzSQaaOgecnI
         fYEeaLyca9GqL31hNJ4nvpiI+tGZeQWaIBvQJIucst45Dm7CqdRhPp4AZzcwhxIiVvOE
         9AuCNdwX0HduL80rvl+L2tMQQVG7uaewRcw7rXuvXB+O58LqJ1fEelXrmOC+7WBlnBLU
         8GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792148275; x=1792753075;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JjoY/Y//bNqM95eGJvwXGt/YGARtJeL2jF1lkb5NGWs=;
        b=kUDGchtzElPU5gksLYjx/3UINWujSwmC3m6zYf++GWHz3JzIpi7TEev3QKzjWKu3YS
         gqRC2FFprNvKnF2WyI7z3ZV6d+/PrOH9i35wyaX2/QGJi5r7ZBohYMRIXv3RBLyutVym
         YmUxrDEY8DPessPb1A9MZJ9MJ45TEo03zazMCp+Wv5RKEiA3itZbPkL+d2sy1vp7OBch
         O+oS743o4fHRnJQRp66Jii20HHATnyuo3w3eDOYrVNDGulH79v13LFhGR4vjexVAqtRz
         uAx4AoWReFW3kJSIFNHX0HVcIcAX6TFDB6yiHwa+NnGX99yBKcuOEypIG4gWYRMwzE8Q
         5kCw==
X-Forwarded-Encrypted: i=1; AKwUvBwTlh2oVkmMWfYFSRlSiiXeZLiMTb69Wuj375O6sh6kcu40Xpe7XmIryEnap28WUK6O7zsy7g3rra01Jhf3@vger.kernel.org
X-Gm-Message-State: AFq9FYJyIYVlcVLFUeIeoYChdNqUEjyHiFCK31rYF9b8F9kjPYjlj/cK
	j5A3nX0LCyHSNWQ2l1FBj7tJQwhX1WPe6GErFIbK7fbZQoJiohwGOnTi
X-Gm-Gg: AYBFou1GSltKl5BrTM0ZehtSKkdEnyfgn2dgA7b8zdzGNGdMkqkCX9dUvzZie+RYTfG
	pOTrGAeeD3Y1dUClq/1RRRQ5QP/+oSAVcAZRoWYUAwtXx+GWGYsqeH7lGhZtbTtSvO3OMIhJE/x
	SzVXOy5YHGuI+GXvAuKTmOLZV4QUWZt/Io9ZHZbdlK6rb/0c6zMEYR9uV3jG9UymZJ6DJk6ljej
	DofbK96sS1PhoylFFqpVjLlx5MAA1sOdnHJF06qOuzYhIKT8h+KhcSIpUrHq1ohfmdQBK5a1yWu
	P31L/I0oe2VEAW5SJdUUiL38lAjIq8wOMT7erdthunsFrSuibasSB8JPL0mQmC80p9sfBkiKBi6
	XqpkkBYaAyecjOHXkot6WcAxucR2z6UEUlcYRb1F5mn8Gg7YcvG7jADLFEjXt+Ic6A/z55mEmI9
	HiA45WY1linc8WIqeh3okPTLTb4pFI+zd5ey/8Gk7rBs2KVhTNHGuyg/X31F+qbvIUQrX1wP6Qb
	xZp2v7yT+DCGBiJRWehAWr4zJn1ACQH+orYzJdm6vp1vsB80AoU7Y2se1kGGan/iJYVKSKCRPI5
	OTfREzeEaW8I3wfdVaEMeTOGSBYu5MrI55Y=
X-Received: by 2002:a05:600d:82c8:b0:4a1:cedc:ab51 with SMTP id 5b1f17b1804b1-4a1cedcac09mr30065765e9.35.1792148274917;
        Fri, 16 Oct 2026 03:57:54 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ae6d2esm50003685e9.6.2026.10.16.03.57.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2026 03:57:54 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/11] mm: Memory providers for guest_memfd and iommufd
Date: Fri, 16 Oct 2026 10:57:52 +0000
Message-ID: <20261016105752.68015-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <yq5a4iem57qv.fsf@kernel.org>
References: <20261014093733.90312-1-griffoul@gmail.com> <yq5a4iem57qv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> What confused me was the introduction of memory providers as a subsystem
> in their own. What we really need is the ability to map PFNs from
> other subsystems into KVM stage-2 and into subsystems such as iommufd?.
>
> Restricting the scope to the above, at least initially, would make this
> much easier to reason about.

Thanks for looking at it. I should have explained this better in the
cover letter.

A memory provider is the driver that owns some memory, like a carve-out
or a device BAR. It lends pages to whoever maps them, and it can take
any of them back later. guest_memfd is one user of that memory, and
iommufd is another, but neither depends on the other.

With this series, iommufd can map a provider file without any VM. Today
it cannot map such memory, because memory without struct page cannot be
pinned. For example, a host service that recycles provider memory
between VMs could clear it with a DMA engine driven through VFIO and
iommufd, instead of the CPU. And since such memory can outlive the
process, or a kexec of the host, a network or storage dataplane could
restart or be updated without losing its DMA buffers.

> For my use case, the VFIO fd becomes the backing provider (referred to
> as backend below). We can create a guest_memfd using that
> resource_fd, allowing MMIO BAR ranges to be mapped into KVM stage-2.

That fits well. VFIO could be a provider for its BARs: get_page()
reports the BAR frames with the MMIO type. guest_memfd takes the VFIO fd
as resource_fd, and iommufd can map the same fd. That could also replace
the dma-buf plus symbol_get() path that iommufd uses for vfio-pci today.

> Another feature provided by this series is the ability to map the same
> range into iommufd. We probably want to restrict this to shared ranges.
> It may be simpler for guest_memfd to drive this.

Agreed that guest_memfd must drive shared and private. I replied to
Ackerley on how that could work with the provider interface:

  https://lore.kernel.org/all/20261015171746.51538-1-griffoul@gmail.com/

In short, on a conversion to private, guest_memfd claims the range on
the provider file. The provider code in mm then revokes it for every
other consumer, iommufd included, and hands them holes until guest_memfd
unclaims it. So guest_memfd stays in charge of conversions, and
iommufd only ever maps shared pages, without going through guest_memfd.

> Currently, a private-to-shared conversion causes a VM exit, followed by
> an IOAS_MAP for the newly shared range. Could using guest_memfd with
> IOAS_MAP_FILE avoid this?

Yes, the IOAS_MAP goes away. The conversion itself still comes through
the VMM, but once guest_memfd unclaims the range, iommufd maps the
pages again on its own.

> Perhaps the series could be rearranged as follows:
>
> - Allow a guest_memfd fd to be used with IOAS_MAP_FILE.
> - Add a VFIO or other backend for guest_memfd, without calling it a provider.
> - Add support for guest_memfd to provide guest PFNs to other subsystems
>   through its file descriptor.

I'd rather not make guest_memfd the only way in. With kvm_gmem_ops,
each backend implements a guest_memfd: it binds memslots, invalidates
KVM's mappings, handles the host mapping, and for confidential VMs
prepares the frames and gives them back to the host. That puts KVM
internals in every driver. With a provider, the driver only reports its
frames and revokes them, and guest_memfd does the KVM side once, for
every provider.

Your diagram already uses mem_provider_ops between guest_memfd and
iommufd. It is the same interface: get the frame behind a page, and
revoke a range. So I'd define it once and let drivers use it too. That
also covers the cases above, where there is no VM and no guest_memfd to
go through.

guest_memfd can still provide its own file to iommufd where there is no
provider behind it, for a guest_memfd that allocates folios. That would
use the same interface, and the same iommufd code.

Would that work for your VFIO case?

Thanks,
Fred
