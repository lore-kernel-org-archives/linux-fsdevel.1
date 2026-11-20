Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185276;
	b=N96ugF7kOVmQBW921j3FIMZquhVNNKmxUuWLTJcRxhWv5wfvhQ1I3gzpNBKNjkAaxazj
	 /lF5Og1+QoPk5bQGc8ukHxEdJLYNYCpoKy3eI/bPpTPG9fwFJtbjzAEIogQ7ftJLAmtFq
	 YdZq8nAgGmUm1/g0zRxDBVKN5Bwavit3Qs9D8CMIcwpYIWyAevV4bdtbErNAS7IkY0Ec2
	 jF8jHdqvy+8cYhI+QIF+khgCrvaPrVe1zfAPwA/Qb1geGZDBn7d85sxoV7z/+CCNQdW6M
	 KRDQqlYPRKndzXWn2iZEa/GlZpj1lZ4vSU/Y7ZcjlY2yjCbRfpYUCgvLx3JTiVKcXWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=TexTSYlANwi+Z3VNOr7rkhMmBTNnuXd95ijh1g8jBbs=;
	b=TtOwsjDbMGIjtU4K2GN5K5/FAwRwXX6zl1Ep8/NwtjtBtbvg6qxLYxndpDgnXqFN82ZT
	 JZvUrDA2XK083wXfnOZCq6j7flRumxg79BQWfsYmtBRemflJt319kQ7hqeR/84w3Im6iT
	 4fgOyfiOTZu7AlkWUgkUIIJX9DtbDcYTjho9URH2S6lKH2r2yJveflZyylXDNV1R4kOh2
	 0obxn/lWFBuv8Im7E48MsEgPmWCgFr7eFk0+WxL++p6dfYCyoHzV7JxNEZ3U11gCnJZpv
	 2N29kC9ARbMrPV+/DBZQUPxQOEgIG5Xat1CIMOZ5W4EZs1OxRojVNcKrV6esoAiqfPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="JtAsT/rK";
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC7606A32A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DFC7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JtAsT/rK
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae19907a31so1078232a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795185275; x=1795790075; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TexTSYlANwi+Z3VNOr7rkhMmBTNnuXd95ijh1g8jBbs=;
        b=JtAsT/rK6zOSNMWwW1o5I7X/fLpjy3EbAQi2mnyA1YHYQk6tJOFzrZLhQi+hHjfZn1
         b20jxPt+RyF5UmK6dTedjTBlkJewRCsInA55bXqsiqTCf0RmTATJfFNToN40ALRUD514
         P642W8VAkF+PieTnXEQALcR85tLmzCckqWY3w6e1JKI1o7RAjCZcY5a3XRW+Z7dWZSDn
         3zlxY9gr0PTrDRtWkyl7sXcnGW8v7BJmSlITWMDQJMmweY2xsWnqSulPyThL8hbkmX1V
         f3tRAlEuubZkfXKEKm5w3llWAncPzVQ5RkWS7hYznLM+gIbGyoW0m3qvye/rAxPxP68Q
         rC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185275; x=1795790075;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TexTSYlANwi+Z3VNOr7rkhMmBTNnuXd95ijh1g8jBbs=;
        b=F+iVcoWqdzuAvZkBBY0PHJ7ifnFsvYkX6FukBzMujf5feRSFDIepNF8ADOJeW9iyIM
         QfXPwhUlaX7oMx+3C6GI4AD5yU8gXVLlKHUnxB2gNRaGYuD3d5J78gc342wItqN/UUFA
         Z+5c9pTr1KQgvcmAO0XSNf6N8gVwskr4RjS1EdLBIlCL6aWhe1SBD8HTXoq3B9FolrZT
         3Umv5YXjuxJ7rUbwkrB0oSBBg8GWN1+Og3bziCbZPR9gyuGwvC1Zngg5GAY7vnsfi13g
         IvOP3tNZrNRetPbvUqetBEyRLeuTnRXXI1/Zlusy37k/Cf6O0jU0n35LE9E3p3dZfC5w
         QoeQ==
X-Forwarded-Encrypted: i=1; AL+hErGlojXXu60dQzmhDZDTZYuBotjWfn01SuD1dMS9pFlzWsGnkcltj7EOBqQjlTaLDMTnq9hLCvevhxRC+yYm@vger.kernel.org
X-Gm-Message-State: APuU4Z8WiGeoMmmcRR9ezRuZwsEKXeX/c4CPWAiyQCsiFvOOXlMnVC2O
	qnZ9FS1krCQ3GsDFe6osC5Qj9XLR3fntRE71cSOt4Lvz6YfbfXuhRXsxnjG7O0fqdTCp1zWJGfL
	XqvNV2A==
X-Received: from pgjk27-n2.prod.google.com ([2002:a05:6a02:81db:20b0:cdd:b3ae:c565])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d87:b0:3b4:68e:1b77
 with SMTP id 98e67ed59e1d1-3b40a5dda03mr3693597a91.20.1795185275224; Fri, 20
 Nov 2026 06:34:35 -0800 (PST)
Date: Fri, 20 Nov 2026 06:34:34 -0800
In-Reply-To: <20261120-provokant-zyklisch-schutt-55d8eddf2ce4@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-3-8484dde66a7e@google.com> <20261120-provokant-zyklisch-schutt-55d8eddf2ce4@brauner>
Message-ID: <awBaeiUw0i-uEQzM@seanjc-mac.roam.internal>
Subject: Re: [PATCH RFC v3 03/88] mm: shmem: Implement guest_memfd provider
 operations for tmpfs
From: Sean Christopherson <seanjc@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: ackerleytng@google.com, Alexey Kardashevskiy <aik@amd.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
	John Starks <John.Starks@microsoft.com>, Michael Roth <michael.roth@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tarun Sahu <tarunsahu@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 20, 2026, Christian Brauner wrote:
> On Fri, Nov 06, 2026 at 04:36:37PM -0800, Ackerley Tng via B4 Relay wrote:
> > I put guest_memfd_provider_operations as a pointer in struct
> > file_operations. Being in file_operations generalizes well to other kinds
> > of providers, like devices, which don't have their own super_operations.
> 
> > @@ -1960,6 +1961,9 @@ struct file_operations {
> >  	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
> >  				unsigned int poll_flags);
> >  	int (*mmap_prepare)(struct vm_area_desc *);
> > +#ifdef CONFIG_KVM_GUEST_MEMFD
> > +	const struct guest_memfd_provider_operations *gmem_provider_ops;
> > +#endif
> >  } __randomize_layout;
> 
> Sorry, no! struct file_operations is not the place to hang KVM specific
> callbacks off of. We didn't let KHO/LUO hang an ops table off of struct
> file either and nobody else is getting one in file_operations.
> 
> LUO registers handlers that recognize their files by f_op instead,
> memfd_luo just uses shmem_file(). And KVM already does the same for
> VFIO: kvm_vfio_file_is_valid() -> vfio_file_is_valid(). Do the same for
> providers and leave struct file_operations alone.

Eww.  I really, really want to avoid having to update KVM just to recognize a
new provider, and I shudder to think of the potential module dependency hell we
could end up in.

That said, I 100% agree that having something explicitly KVM specific in
file_operations is a non-starter.  Would you be open to a more generic interface
for connecting providers and consumers, e.g. something like this?

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 99caef43ff3c..96e4c2547d5e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1934,6 +1934,7 @@ struct file_operations {
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
+	int (*connect) (struct file *, struct memory_consumer *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *, fl_owner_t id);
 	int (*release) (struct inode *, struct file *);
