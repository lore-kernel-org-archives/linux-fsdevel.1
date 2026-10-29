Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793281789;
	b=Cd0eBjXZMCBKASnypAyGZF1SuJ17EIhY1jkecclBKIRaNAcDW9ovbSDV+1gqixFHSUaI
	 +5o0p3lPBChTenpC0jwX0mcpGrEwvvOXET5fprvOYV2F1wwWFJVBTYttZbe+qKKGimZ01
	 fz+wS6ABuZS7H5dTEU+8mala9Ooe0TbXXi/11eXcji5QhRON1S8C7Mk2Cn7tdY2U0ud/5
	 l04jG90Zt83OcMGB6HBmLznnKtRNnCWTyyOQaqYKFd1/OGMFPxRkyklXgCSeUj85gm4vj
	 5RGfn7tIzhy/XOZJIhGYo4e387Itwj/371wSQFe5KVO35Zijo3dLjifXnGsnn9K90TQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jdEzrVvS7er6a3IlsJnCTgJPsgC3VSLy9Xk054XJvXM=;
	b=20xGyEZ6ZY33w15shqU5E1MZgYBmgXLIYCvdIxLJrryi50/7lcy8QcpvdIIm9z3RkGRW
	 KhTZsmYOuQ2QVM2pdYa+Yg3tHRl5Lb80xid6QFXWmwGE3rfKIjJP5jB5JEEtSJe6obIeM
	 u6PGHHFtBEBIBH+JRa6aQ/Xxc8G4ECuDQtNZwfirvldhzpTm1sPx32LUA4g9EX7WKwBas
	 //WGHAGv2gw0qktj3F56dlfKp4d+0jE+IIX3ulgM80LHV7S71ZEN096U7Ccdc+EROv2df
	 00nj+REOOBcjzX7YzYBmSPMMrNm6M94EOolHRGMgg+BmNRiqNDI7g4hDKzJ3Zjefk9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CWV5z5FO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685A606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 13:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D685A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CWV5z5FO
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53644ab1f7bso21356731cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 06:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793281788; cv=none;
        d=google.com; s=arc-20260327;
        b=q//jMjSEn6gM6C/86vaWZqwSkSzTuLK2Iw/S9KbGJ6vPODq5ff5N25MW92gIFy1fNx
         xzRtVFANJSikdfGNCgCYHG1v0SiZY3EwBGkqHss4bnDDRR/OSwc3sJsKiBq7ZqzJvVwU
         5eP7PJgmhG33sJtrGh+Pd4jxluvfsXoteckLJVt7GmDUAiFJPEHmATbVq5mDaprbi6PQ
         OFy63pIuUBKYzFKwveaWDTRpN54EiRyvgfuYEXdeRhnpyYXY4kzDuoga/cujX9j/tjUO
         P1KqOy+c3JmgV/qs9WarBn2ip3RJivdOeA8XOt8bb8iJfNCo+8gjIBLvpoI4iKm3bZbf
         j2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jdEzrVvS7er6a3IlsJnCTgJPsgC3VSLy9Xk054XJvXM=;
        fh=PjsV2ekDvf8o7TzKINF9ZZgG8sc1O1sWRvKnd6RbjoU=;
        b=jxW0JMPqB4YuYJf6aVm9nSulbS7SE30EOnFD5BgHCMbFk6GifnVmZx4MbgRoyIlE3P
         j1mMK+mQc4pT4N5fLbJIuMT6Akwt2w4QPmkv7bYQJEGBlteFAMGGPp49RsBdet+3bZHs
         l5HITSqQbfp62o4CXDwVLlAcsZeF3j4Yv/IrBp8t+TMiALoIZAuLpJNy288dSreMKrR5
         WgEi4010afQt/eyhZ8E/l2kqCdrHkFqmZSgms80T8w5T2RybeACTS1COcDKlHs9lNlsh
         bRuVMihSKdJVlgUVnCvjPV6crVYW4gHC+ctKLXOw/w+yj3OObUjnLYYbsODfRzignjqj
         D2fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793281788; x=1793886588; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jdEzrVvS7er6a3IlsJnCTgJPsgC3VSLy9Xk054XJvXM=;
        b=CWV5z5FOFmpz4/rZ0iBri3mEORYKdK5sUx0gxqPpGl+YHGOu40V1Z38jQpOQUFOts/
         82omxjEaspaZos0w8KXHBORshZZby/eQ15qwX4XUUo66p7blyjSzhhfz6J61T8K8VFAp
         PYRwll0MS5PwVyzP9oBWRU8WWQfwwEZkwyXv2Q438LrNcnBfYfrmIIZRblAU8FxYFNi2
         eWf0wonUPZQrsS66KS0Ir3jpxQAVDQvZjtLYUgsfqO0un1Zn8EPDfO+qfsiqW7W03PbE
         ZGmqVlOk3J0X4W2qO+ho79HwxDtxeXBlee43H9SrG7LH6UlqmWkRzQxJBwqN4ry/WXzF
         KTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281788; x=1793886588;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jdEzrVvS7er6a3IlsJnCTgJPsgC3VSLy9Xk054XJvXM=;
        b=rlg94EfxdrfmVjmemsQVJ3iCBnOqDvCJK9vqdbc08x643qE2LUrxS1uiQoxpD77E00
         IyMAzIHTEsxpfgXKAk5rJ7A6TiAc1GJefBgJ7ymEADsVeFcry4oDHSH6/4q87j99dL/T
         trTiFRdY09M0YqPBjA8vuJ5b61pZZp8HpTxeQTcueoDHG7ZYkB4o5KEdDRJMIfwUaCmR
         ik+Z7I2W0C52gqSc/V0cM6sJwlqSpUWOHcsmDbndluzsp6FW6uEqjlAMZQUJM8B7n/AN
         1hk2hBPf7JDQ7vrUId5lvhmVX5BzvaxPRLd1o4fUCzriM6j9dmGpeBhID1VxOkNYVEZu
         +SGA==
X-Forwarded-Encrypted: i=1; AKwUvBwhkpjyj8I9Z5tk495e3XmZSRApAEf/fi8qA3r9lkKj6/U2Sl2x25QTbfyJZ8WAACAuD+KKXkdDLk6OU33I@vger.kernel.org
X-Gm-Message-State: AFq9FYLputdanOAb4qEZh/dG6axtcJnWyMJgHYVjrPHJfiMder323M6s
	JLiwd84tI2QBbF+l2g9l+oAziKSnNge98bnsdGdC7TS7m2JQbtR1M8MMyVnLIXoe3vkVJJC5tE7
	ZuyMblEfcZjsozepqRCWuCpBxkRHl0s3q2YVJKsIi
X-Gm-Gg: AYBFou25jVJW2neXOnD+rgkrzjMb37ss0e4Nb1QEc4tGlKR9PC4l3w4oNXkwGrqSATW
	NDdrFJ8uN+kyW9zS/s0IjcwtyUvgNX1gpXjUYW/CEZNcFIWe30vDvXH8Uj2knq1BNOMDHxq/jxu
	PqyJlXCssKwoQfDf2iIVz1+lLxhsOnojUfWlzwN3vbnrjq+bINRSDJSV0QBn/uNdIzWt8gEpnQM
	7l0sQUx6tp7VA4szupQWM9H2u4AsHb37y6bgEoRvr+/vO3S2wsDha5oUKmtnjQB826k+T8f6lB+
	zS31tn8mZgXZKQ1mOiYenUVNFZ3vYh1rwUutq44Q/wEPYHKUSRbrEo+agfE9amYeiKf2FBWw/9x
	mLsttjU4w9xgdF+5pFtdOGvE0bdjEwFTtd9P8zCrWqsAtyoIZRbY5OkXXBepVOKhdoA==
X-Received: by 2002:a05:622a:394:b0:536:702c:f8e4 with SMTP id
 d75a77b69052e-53fcc9c38e1mr83446311cf.49.1793281786016; Thu, 29 Oct 2026
 06:49:46 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 06:49:45 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261023172347.88443-1-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261022-gmem-alternative-providers-v2-31-5dd1dc6c660a@google.com> <20261023172347.88443-1-griffoul@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 06:49:44 -0700
X-Gm-Features: AclHuK98-PJmC38q62LJKPyoT2Xn1t02jBqXVrJ0iSGV7iV-HBBvt2AVL4ugH5Y
Message-ID: <CAEvNRgEsGrhrRk2DcbrMNY3zWko_eXP3-FA1dGRSGYphQtBpXQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 31/50] KVM: guest_memfd: Support getting PFNs for
 stage 2 from providers
To: Fred Griffoul <griffoul@gmail.com>
Cc: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexey Kardashevskiy <aik@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Ashish Kalra <ashish.kalra@amd.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Connor Williamson <connordw@amazon.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
	David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
	Gregory Price <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jianxiong Gao <jxgao@google.com>, Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
	John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, Michael Roth <michael.roth@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tarun Sahu <tarunsahu@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Tycho Andersen <tycho@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

>> +	int (*get_pfn)(void *provider, pgoff_t index, unsigned long *pfn,
>> +		       int *max_order);
>
> Should get_pfn() also return attributes of the frame? Only the provider
> knows them, and every mapping of the frame has to follow them. Two
> examples:
>

I agree with you on this, we need to let the provider tell guest_memfd
(and IOMMU) more about the PFN being returned.

> - Read only. A provider may lend a page that the guest can read but not
>   write. I know you dropped this from the sample to keep things simple,
>   but without it guest_memfd maps every frame writable, and there is no
>   other way to make a guest_memfd page read only.
>

I guess read-only would be the equivalent of !VM_WRITE in the VMA world,
yes I think that should be supported.

Other than read-only VFIO would need something like "cacheable" so KVM
knows to map MMIO as uncacheable.

> - Aliased. The frame is also reachable somewhere else, e.g. a ring
>   shared with a device. Such a frame must not become private; see my
>   reply to 34/50.
>

Are we defining "aliased" as something that will never change once
the provider considers the memory in-use by guest_memfd?

Actually, I guess the question applies to read-only-ness as well.

I hope we can say these attributes will never change once the memory is
considered in-use by guest_memfd. Otherwise, I think we'd need

+ Some equivalent for folio_lock() to at least hold these attributes
  constant until the mapping happens
+ Perhaps some other callback like .can_convert_private() for the
  provider to dynamically query.

I'd rather aliased be something along the lines of
"cannot_convert_private" (a concept closer to how guest_memfd should
handle the information).


Glad that we're converging, thank you for doing the rebase!

> A u32 of flags, with 0 for today's behaviour, would cover both and
> leave room for more later.
>
> Fred
