Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776556;
	b=rc9w9CsNgfUVt1ClvDhEqItaEAJ9yVZ18zly+LaxFy69TlxTKxLth8dVmQHh2h5Ry9cB
	 iZoCACNlHstE8GAPE2iDIxaYYw2AmrBAvZcY6q91yN7O0sq0nDdNjSrlOyFKME47BDfPu
	 Xmb+Mg+OrrQeX7VSQAFEo1oro78oYWN7Q8zw9q9tcUi5ggVzHnX18l26bfQfjqbC03PpO
	 wFowCQqyc43SveBzsOYymwm/QVKATYLE72uSZhpsVaEU+PyUtLlRtNDEuQwRweqoG3n0/
	 UUID3NcC/EEDkEZQ0DKkGT3ZfeWeGGDZVy1xrwCrznzI0ftQOimjcCL8y+W5G39+xyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3Qj0y3/sB7EeSLYwSP8RPCK8AZrmLUoRtMMcxttoCbM=;
	b=IXD8r2g8vF8iUWfN5dHYGWQieYuXVrw4VcupIB+2V37v/3N/Ruo/9GXDUja0ZmlPK1qr
	 0dlwQziNWV4CGhZRdVXRIPtQVpiVDP4tT3S0ViPuPF2Lc9eCG/4lbru/z4OzhL15I9NE7
	 FTf/B0EIqW2DH8TXUb6X9x6A7ogUhlqHdfBvpSD/qjbi1PfUhQCCLkPPEkpA4dhqpIni/
	 O8XVoYEXDEvvhp9LO2IuJIZhtXE4zYxQrELEtBjytJhbtNaAeg4Vz7KJqtrSG+YuEXnOk
	 FgOpvShFidbjwOgmyM8mBioeB3c82LZ9bdCbmV8FTZJ8x7MrDN9rJJHiO/ZADMz/aIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FsXey+P0;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7C606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 17:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AA7C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FsXey+P0
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b042c0728so362503f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792776554; x=1793381354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Qj0y3/sB7EeSLYwSP8RPCK8AZrmLUoRtMMcxttoCbM=;
        b=FsXey+P0eeIEmJhBgBeUCGTebbSsxCz3o6QZLKul+LrAXxI5Iq6haR8I+mfQ26X3rv
         jdictCITfezDnQnCYZ7j4HTg/tTcyUC/Drgp3vmWKgBrr8QxD8Lc9OWWfgyy8NXh/aVp
         FU1i0kULfGHjxWSDkzzHhNYPQMA22NfAV96rytMgupGsdGonuZFqafUHqB4ni9qYpDM0
         pMnX6nPNZmJtDzCa3r+7pjhGX+9lIH4WS1e9IAJRnvCXCHaSmtntU37q/aLnIzJzsrgt
         wez8tRl8q/zWBYrqF7uksh+EHPqd6RxIvPagUfBww3wDRIPgVXt5ZOLUSwxJKgSTrUuS
         E6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792776554; x=1793381354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Qj0y3/sB7EeSLYwSP8RPCK8AZrmLUoRtMMcxttoCbM=;
        b=vs2g5ck+eBFVwIyFPjVdiPYWBeIqrfzN2aLI3KuGbz7UbM4aBJltXJkA/AfSAx1k8W
         R70V5wzGdip3JzIKAaFcFxYDVodDP4iF293kP1RtJop+Iv09fvkCV8BAD++9Kc6Whzh3
         jsk4AymrZzCva4CJiAxQ0K4XBkzOhTusYlXKa9NWjbxEL3m4w2/5+aLg19OgEcgkI0Vn
         zTCa3THSF6ifDt6mbTPBlHPLgq3YmkIhSGcYVdjxEBiigf7DVmg/GsCEG1mtAYNXIkmb
         GM7fBU2QPsOeyCwV2dMYsTuj9phSmTUk5h200V++u5AbzzLXZI7AakS4AdytJunEflHa
         LRGw==
X-Forwarded-Encrypted: i=1; AKwUvBxBV/T/ORg+u1ZdNY42qdzouy/1DsPe0I7W7zxoOwIjePMpzM0BCb1OylfuLlqze/W+YDJBY084YRAjRVcX@vger.kernel.org
X-Gm-Message-State: AFq9FYJgof1dRwG9ubWmuQnK8ccmyQPBrBkylYYdekaiIlAACMs61gq/
	MWBWNBSNjXeDD4jbMI+3MYXiiMzUZxI3PHZMiay/cN6JchjEKHWC64gP
X-Gm-Gg: AYBFou0ZyGqGKofjCL7l3MMpNw2RHKfWGsSNta1yUrbJZ2IqsRNyoVduMi3AfDMMTEk
	RfaEUUFldbHnBv7jswsTNQnEeVGpdirq1WlV63m8lgr5pSEZPt8o8IQ60+VsH1Wt+mV2QAE/xOZ
	YyqbtYWqPgkXSPZAoS2RFrZt50z/yKBhZs4Iks6CI9T252Tzq3eV0/e7pXpopIh93O2UXviJjEm
	SYB/5/UoEbKHTZlbp1JNvg46u3CCe2HRvXbFL6WhS4K6aUeFujRHbAqr7Twbg4JbOIM5+jRpCo3
	Inq4mKL4GmH4oW+0sOMo9bRygHjgFjw/jTBCrC9ZuOA70TH+I/WjiUTz70aTQsZ9ObwYFNnHHhA
	Qkb7OiT0xkl+pvk8+oBwl/w7z7LvgzRUhvAgB7jHfm/jSnvU4dlwp24tc1As2K/sT1RPIYxcEGV
	gU9Mxv6In6t8gt1RpJmRhQu7eRatxkx/gLWw9+uxHE38eSf/L3se2CtMhOmdA0V8jOBwCIgdLbg
	nc2nUN5p9pmzHyBYRYZRcAurGHxzCQmWRsoJ2wuhcG/Gxq2C7XWSGnlvj0YEdZWqOupy6TaS/L/
	9BsgnDOYU2oqu5ENtZ7lTjHqYt95FEnQw7/W3QaVPix0BWxLChSv9aw8BPrvu+MM8N4pRVHv0be
	8p/lDWvull6+savgJ
X-Received: by 2002:a05:6000:2004:b0:486:f9ea:796f with SMTP id ffacd0b85a97d-48e387d65ddmr4932292f8f.41.1792776554351;
        Fri, 23 Oct 2026 10:29:14 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d4144f8sm1120262f8f.41.2026.10.23.10.29.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2026 10:29:13 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Gregory Price <gourry@gourry.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH RFC v2 34/50] KVM: guest_memfd: Skip checking outstanding references in PFN mode
Date: Fri, 23 Oct 2026 17:29:11 +0000
Message-ID: <20261023172911.17557-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022-gmem-alternative-providers-v2-34-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com> <20261022-gmem-alternative-providers-v2-34-5dd1dc6c660a@google.com>
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

> +		if (!kvm_gmem_is_pfn_mode(gi) &&
> +		    kvm_gmem_has_outstanding_references(inode, start, nr_pages,
> 							err_index)) {

In folio mode this check is also what guarantees that a private page
belongs to the guest alone. In PFN mode there is nothing like it: if
the provider also exposes the frame somewhere else, say a ring shared
with a device, the VMM can still make it private.

And it is not only this guest that suffers then. Whoever else uses the
frame breaks: an RMP fault on SEV-SNP, a poisoned page or a machine
check on TDX, a granule protection fault on CCA, or, with
SW_PROTECTED, silent access to "private" memory.

Only the provider knows about such frames. With an attributes output
from get_pfn() (see my reply to 31/50), it could flag them as aliased,
and guest_memfd would keep them shared: refuse the conversion, treat a
private fault as a hole, and refuse populate.

Fred
