Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776231;
	b=J87Z9bN83Crq+oBr48aTNiZhJRsgTiESDed6nePxwUaoMNJFbJBWE7sjUQFQUYc9r9xz
	 RbAv+SgWtMT8bkfRNU48L4vACqcIJ2nQFkCG/Ol8EdY3xMD4kY0U5Xx0FtvFCR9PFx0nJ
	 Pz/T5084Wj0VnToC2ib6kg2Nm/KvE4s4ic+z53wXn2oSOL+VLp70L11NhVq7b8m3ib7/n
	 dE4ByP+By7EIBwIbp9E3xyqrme1VqdndOK7qZ0dbNlWcqhrt/21yekR0BS+kBZ0w/PGEe
	 oZH3WZftjuYOFxZwPb7k6YLi0WuKyCs2qAZYu0o/8f3ntuo7HrcM4o7J1j5LLf4HaTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b9U8BJjnSyQLu8vlmMN8CV+h3S1yPSnSBNwOLGcNxzs=;
	b=iP5jjkPvvxOrEV+AYga1zKxeimIlb+/LfhMtSCOe4nYJhqYg/AWGePQExvA9D89Q9erz
	 iFmE80ArdSkEXFrSZ7u5M7erB0dVDhNlkbCyxPxTbOsvz8CZz6S9oVAXponMHZyrgBV3g
	 jtjvSSdu0wr3IIrtNAvCUQEf7s4yUTaG6b53sz2TegWbE58COSJsFchFYtxagmhCIOLrg
	 tAurxXqSCMrTBQPC6eisWgYMiiFTvJEcJoQSrBY8/Osv5yiIKm9ACI5UGztAqOZvBYhQP
	 xTUIxEbM3TgaoVSS380M+MYgUtbX4m9n8JDGTnbAVc2Fg6x/rfSr5p0IOGJ4uDT5Wdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="m/lj/Off";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77B606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 17:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E77B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m/lj/Off
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so8163005e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792776230; x=1793381030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9U8BJjnSyQLu8vlmMN8CV+h3S1yPSnSBNwOLGcNxzs=;
        b=m/lj/OffyrqASJ7/+k2ndy3ARnMmZ4ngzDDHOfoxfIyRpwQk+KAsWUQg3rrdg+qaNN
         3TFoyZ+aewF8WQz7pGfyEVXk5pHwaqut5XJ5xuFHCeBh7vAoOzdEgwybgifqnIAZykIF
         avAi8vIkMrmNGJPtKRcrpQfo9ODQv0n4tbspV4EXY1DvEzOb+OeH8TwDdedQ8F/jexXy
         rs4p9x1faefX53U5CkJj3x29eWfVs5Ga8NTm2vD010Jv9UP2rh6zuzJFkWQHRz18S/te
         y0hZ3bPqJeoOiYzcQCyxNZqytGu/jC/a9iGP3pmR3VmnMEoNj2iCNmhJDNd8HzM1Ilsh
         GG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792776230; x=1793381030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b9U8BJjnSyQLu8vlmMN8CV+h3S1yPSnSBNwOLGcNxzs=;
        b=09+uZ7ztwz9RmfViV/HAaaULAGDB19E2j0hQvUJaGIiKOih1yn+auAdV3fnUwPOnTk
         gg8BW/k+IHR+YObH2WomZkxKmresbSuxIAsGpUfoSVu9jSyvOSrEZcKOYdLK9mpxpNFb
         66Zm2gUUfUxA0ZF5rukukw6OUBOjMCC8C6wsdJdjIiNFXqtsAdC6rofAP+Yp+v7H4X8X
         FF2Ffua2izRXX1JuNaTWSKUIDfw+rvrTM9V1BI1iZsWdlna3Kh0i3ZOUAy5LVX7N7eq3
         E36bAhIQTJV3kh7diAjF5Ys2beueys8xbUbUSBt2YaCy9IQxnCWqMh44Y8A15oKCaw2v
         78Jw==
X-Forwarded-Encrypted: i=1; AKwUvBxhz+QqenLPNmAkpB61lo+CDjInDE/WFs763QaDuB4zQh2GYTToVOQzFwocod+SqyT+bJLfylVt9Zoxrr4S@vger.kernel.org
X-Gm-Message-State: AFq9FYIBOgEpdgN5XdVwDkX+KJScoUMxR7CS4UoTgZ5v4DcztmIZYzi0
	oQJ+0mWccAO61RMfj3r0tkIEOpp+tvPRHNNv3ut24v4wFL/qextuPJGy
X-Gm-Gg: AYBFou0SfERAytmV/MGAKDYchiBaUqU9mhvGdCbZDjSNIZjMWAgBxLeeNYnNv7NFiQ4
	aKOFdqYczTo/4mQBf4iQ/ksVCRueXQCq6Nd2xgPlq43c5zsyNWjPYdI9ufsS7WXkJvCcLpnmDF+
	n3r66sq8tTDyo6oq2d8+CxvQ/iZbFwP/vLTIKiWjm+jmG10AKSBFph9TIj2dRYQroO/4dWZIypG
	O/uuAAvAwbuv2Kg9G/iK+9sz7A+h3mNkJaOh5e3pdIqWjVBBG4+IlySbZqwPWJ1PybhzvSBhGWG
	69Q5b5Zw/DFizi5OTvIKiLPkWL8oKRb70gH6C78DA5jWUz5f2dVvUUVB7k6+PbQr8P6oMDMrEOe
	gv+GH1ol9M2YSRt5cqgf6Bh35t8pBoSYNCQA0Te7bimO0RRPI9O0HknWeSz5vTmscUUN+PIrNoq
	oGD6OUEXKuFwoB0e8wNoTI9RYFNbUjCoCCpB48coJWQAoYFgKbuiIQYbknATqGB+i1yLEDqq7hf
	kzIeLejqrm2I6U08JZAXaYQvmyJo6dWwCb3IAB+d2NNzgdOBi8tVeyRRf1g4EeFATrlus59CBUV
	MuWeGbYUkaEIl68Wt14lR+4Hsb9ZuhypTJlFl7tNAjzGSMFnDY3aaxeEW3C/MPtb9IQQjLihc2Z
	ybxNoQxIX1bKMb7iW
X-Received: by 2002:a05:600c:354c:b0:4a2:1197:1de0 with SMTP id 5b1f17b1804b1-4a211cb23f3mr50233895e9.19.1792776229374;
        Fri, 23 Oct 2026 10:23:49 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a30764e9e7sm17932475e9.2.2026.10.23.10.23.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2026 10:23:48 -0700 (PDT)
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
Subject: Re: [PATCH RFC v2 31/50] KVM: guest_memfd: Support getting PFNs for stage 2 from providers
Date: Fri, 23 Oct 2026 17:23:47 +0000
Message-ID: <20261023172347.88443-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022-gmem-alternative-providers-v2-31-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com> <20261022-gmem-alternative-providers-v2-31-5dd1dc6c660a@google.com>
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

> +	int (*get_pfn)(void *provider, pgoff_t index, unsigned long *pfn,
> +		       int *max_order);

Should get_pfn() also return attributes of the frame? Only the provider
knows them, and every mapping of the frame has to follow them. Two
examples:

- Read only. A provider may lend a page that the guest can read but not
  write. I know you dropped this from the sample to keep things simple,
  but without it guest_memfd maps every frame writable, and there is no
  other way to make a guest_memfd page read only.

- Aliased. The frame is also reachable somewhere else, e.g. a ring
  shared with a device. Such a frame must not become private; see my
  reply to 34/50.

A u32 of flags, with 0 for today's behaviour, would cover both and
leave room for more later.

Fred
