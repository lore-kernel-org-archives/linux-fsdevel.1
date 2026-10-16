Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B33E44E4
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143976; cv=none; b=ukJxt0kbdOwfNssOEs3P5eG9cfRDiDNlxsQ1QRXAYiajT4ZcGF9T1owzzxEO82hY3I3tB1tgb5bjBsLQUdDn8x9KLo1xumDODHWG5jT/abaW8y5h6+u/JSpnHUtKiEMqmPxWV3kCd3L0d7x3FAHDew4MjkzMcyYi3L1ZidNo9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143976; c=relaxed/simple;
	bh=WBdGcxWiDrcVKqaT6IjY7dlU/wWj/hMB+CXmv51CihE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaAPH12kN5qsTmWokC2+4BcxlgpTGTP1Yssg3yEACaNFb5bHG3/ii6lJWAgVImvOpXDLXfQxFjeBPIkdr0EarpI9v2Mum6kSrzSyL5B5lNci+PvQtiRYsbgiwBJoG5og8k8bsCWvSR3WDDcLmDxlkpCzlU2QEjjYrnTUOlwluek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEfSOoVj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEfSOoVj"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so38865675e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792143973; x=1792748773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WBdGcxWiDrcVKqaT6IjY7dlU/wWj/hMB+CXmv51CihE=;
        b=NEfSOoVj58mfNWYWD0HBk9CT923PjsiXayk+W4diiizADUl5gWFolKCOmfHSVvTCs1
         +h794OQFcnI4VxGBrjRmYKYNPZZlEJeJKxFuLAdlqzITndINEspIxDSTinaJ79MIWPwm
         ON3UuhlS5KVtsmGhygxfRDhW/CTEVozMxOM2/ArIFPRUt6S4N3wHah3YltILTp3EtwHB
         mEv4ODp7kKJgpkji5pYf735jSa+T46G3W6B5bM/c41OsFSvGAOZQHdOOSgCIIyQUbG+z
         z+JuDj0XUZjZdvHkweJHJcGeAznwfFH7zARrpSGzvyeuSzPMKTvumLA8y8i0QK/Nqu8G
         ON8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143973; x=1792748773;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBdGcxWiDrcVKqaT6IjY7dlU/wWj/hMB+CXmv51CihE=;
        b=eiINPZQ3ut78bHfKF2DcTvcVB8cFLqgxzW+4CdhMFzuZLEXf0+BYjGJ8R0I8KPeeDJ
         Aq9z6X9pBxe6gzfyL8XLv1dINcz8I3gsPPdKlgnXq5uWjsLCY6YLpevXtdKdcBMqffqD
         MAiAYXQLJd9y7LbpuxQaTwemwoclMVScwsq8vmGd6o6yiu//W4I867DYBGFDtKkoTagU
         tK71Ud4P1JBIgsqlfghyYPnNXVkf+N+G9lgJPnMupxX+Oc3zrG3UG/hvZrxSAHeCNPSD
         hc+tM7tA8apb8Zw9MT/c6IPUAHFdK5civq9kDrtZPbrRStBqSSKpRSoZFiiNyPzVHS8S
         BNuw==
X-Forwarded-Encrypted: i=1; AKwUvBwEJhW8eu4OtcvOnrY3YsazLc1z0pytrHg+Ky0Zh4Rd8vOQ7RDv9yVF1lunpWNZT2IXx5FcPVQd8lP4q5bA@vger.kernel.org
X-Gm-Message-State: AFq9FYIRhRoqLpEtNkH1+nBURmWG9FSCWLV62fQkfiiXwKZ+pHDS/Y2u
	xm8xnrLdjdtdgFQ0Etu/8ojiFiAcEdlDGhxieaINoro0BjL5ms47H6Ms
X-Gm-Gg: AYBFou1xPGtigf+zUW2gHtwpgjgykutLwg0LZI0GqCzVSt6dmbLYbLDp4Z/5VjSjioN
	ckDXVpsoxvLIjwxW784Oz5cIREWv4Rscd+V3PpWQTD47ObIKlo7Dw6KzhL3GVipJudyPUkUwmzw
	ncVb5QdS3QO9LU9gO/DQ5Tjo12LMfJNsbX6s62ME/7Qj6MnhkDJIdCJiomCHkMNPf767j9HE7jJ
	zhV6e5c2cdPsxwx8iEnZZ7Of7O6rstk6GRzRQsWxM6cHmU7O2UXeKwJAtcnl4vajHPfVe4yJFpL
	WcdL6Xi/BQ/y8ofRHoEXI3hUshex4xsRgaUWiSOm0a8XKALPHvEDqz//j9vF4Qsuo0zRDI/gL1O
	42SR8+Kl36W1njHsxiSdj2st28e4k6fWLSOfXEotQC9U6hePz2h4HKxQ7H3x/BVqw1Qxu17X9jR
	3A4spgW9O2vXx3P/ZT91cMF7W/ydTNKAu9KX8VRzlVNDE0xhWcq2B9cL3J94Ss88K5alQTPaly/
	yFLOu0Yi+sHPBQKVpYGOEPxCl1m+jEQGUrOsQ6Rx7F7eEuc1GufnKuPNckpvMyniuS3ZfW+tvZa
	bnGqchGE1Ka/FNM8ili2AC6BFohWSDrwxQY=
X-Received: by 2002:a05:600c:83c6:b0:4a1:7093:40c7 with SMTP id 5b1f17b1804b1-4a18e493048mr406737735e9.8.1792143972697;
        Fri, 16 Oct 2026 02:46:12 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca43012sm17041055e9.3.2026.10.16.02.46.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2026 02:46:12 -0700 (PDT)
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
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
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
Subject: Re: [RFC PATCH v2 07/11] iommufd: Use large IOMMU pages for provider mappings
Date: Fri, 16 Oct 2026 09:46:10 +0000
Message-ID: <20261016094610.57849-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016001448.GC14213@ziepe.ca>
References: <20261014093733.90312-1-griffoul@gmail.com> <20261014093733.90312-8-griffoul@gmail.com> <20261016001448.GC14213@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Oct 15, 2026 at 09:14:48PM -0300, Jason Gunthorpe wrote:
> You are going to need to go into generic_pt and implement cut and a
> more suitable unmap to make this stuff work properly. We can't over
> unmap on conversions.

Agreed. I'll drop this patch from v3 for now.

Just to check I understand what you have in mind: a cut operation in
generic_pt that splits a large entry in place into smaller ones, so
that the revoke unmaps exactly its range, and iommufd uses large pages
only on domains that support it?

> Also please don't write commit messages with AI. WTF is this even
> trying to say? The subject is "use large pages" and this text says
> "map each page with its own call"

Sorry about that. It goes away with the patch, and I'll check and
rewrite the other commit messages for v3.

Fred
