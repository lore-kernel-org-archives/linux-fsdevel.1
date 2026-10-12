Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E1B4A4841
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820136; cv=none; b=ucrfuKRze5szrR3Aygpl5c91LvYF2FmS/EUb/Pv0NPVgs7QDTHWCTuGj5FVqskq0/Np//FEEHb6JJpTOsTFcaaCushvyMPZmHWkNIhYjmwTUYFFCS9W30JZEQwfmQ12wdkIQqf6rlgJYMPhzrC+ah2EH5HfoG37nDqsxVcN9dvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820136; c=relaxed/simple;
	bh=IBQngc9E6IMptShoUCo5yKbFcmdbP8vVNx4ur1yYVnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwOuBDMR2TsSNxvy4xVJ/YXQXg+B2zKZEbhX6bUCW9WyuHxwKE3bcxoucVwkrzEM0DwK1iYb7XILfqjsbznZEBUxpM+pum/oOlG18adVZ2SjmZx0RIrRn/H3s5QRi55qjJe/VV0sC4PkG5ZJvI+NhLS7dHbNuI4TNTdqy5VF4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTOZbUeL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTOZbUeL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d05d51553so13288675e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791820133; x=1792424933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bz+XxQbQvV9Rkz3jiplflbfyEnwSo6hWkWyEVkUNcs8=;
        b=YTOZbUeLKKbxksGFl3X9SRUSILmTkpQbdG3/S2suV36u4ulO3yQ/CwHt61806PNp5E
         ow1LIvzCLHvBVYVWmAmeQ1RiutgtMpmbxUDWdEjr6PFBU1zADRngD4F+c+O7y6MZhm/3
         OItOxC8zgX+czXK6nwSGzK6l1xcFKyZeSAWPwH8q57IlU999l80A21QlkgPoZSEjYEnn
         NiKCYOISk2rKQl2PIGpBTQvP7cCSXCSckUsWWFfSd9auGOrmLG9yxlXBvUZyDmZcMNOU
         VLDRbI6HZj7h66MzgD/3RF7W5NxrdXdj8IQCBfXNj9fscpFDo3QVJL+Bbcu8DwuKHmVw
         CdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820133; x=1792424933;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bz+XxQbQvV9Rkz3jiplflbfyEnwSo6hWkWyEVkUNcs8=;
        b=slsIHCqDaFIFpG15b+l/Ak7lDZTB7yyN67Q2t5ruPctpJweOVVhL2Y9XDcZ4tkkf/M
         DeUfjGgFEH54TBPABFFY5ZzU46Go6m49A77Z0egORWtR4v/jO5w/VfTPQXaKQoJvuvbQ
         mf6GkK8p7IOo2VJvI5eguPFZ1ACugTkDGNE+E6CbZnv6MopVNsoLILgC4AxVQnaXmRuB
         97uN8U6L6y/HbLOjf2+hy5ikp6kqLV4RY9QeRvuygejLNMgwClsAjmN6147G6eSiiKto
         kCgQPXnZKIU461DMtipRYCOMXNLEfc88UdyUeO/rnFeOzkMg6HeYFr9d+1gIlvxqhnLK
         MVQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzauOFyJ+VAeJd3a1QqyPU2w5WSDlo0YSG8f/mUbmrzy1MEWjgJlwRTQCmx0vwxST6K0JB3Bg4kJFUmiAcu@vger.kernel.org
X-Gm-Message-State: AFq9FYI9V1vD+8YDlnbWbjWucy9x4kLIUa5hjOJU7GChVtqoZvgjUuCd
	BlSyMbqoidXbqXMgAc8DO6htGZGJ4SJjF2D5UoOdwSVBfBT4MfUrfTOP
X-Gm-Gg: AYBFou1ABN9DgbW89/kwCbyDdh8NG3DoMoq4EijnJ3kAXnntzPKLM3bKM93bowJIIm2
	Okcg7EwzdVcttT/2AGr+3A6OGVuH/ANoi9BhdxRhJbilKbtaVpwk3Em2tG9KMYrn4pexxVBaHZ8
	VI0ixc0hHsl6SJI1JtXionqEN1nz+hYWgQGVtt+T6qFgkrMO6tLAhtneyiuimSEKUsO5RDIpA27
	MC4NsTj3ylNT9iIfdHv1R3+5RiX2ergAb+C4NglXNYF56LkJg+JVONBqHC2C/aiPcy9pD6qiNpc
	nvXrBRqPjAVeq7VydqWjihgmo1tatP/5e4qd9VX55RjT2mgPwnF04yxYjIev7yGuu1gVga3wI5b
	MGfX4/o9vQo4jQKlnIhXWR3cGx91SR8ZmGHpzbQ1zryqqHdlpNJm4VQZBbNNdL0iK/K7mHrfwHA
	NqfgjiBs5R/I77dQJd4o9tUT35zadG6cJ42OM//gQDEQXyn6KeNUOkhdYwpKv1iBLMGQRU2w0at
	bxyt8gWXyzByoEcZeO2NfZQnQ+CSx96DV7umG0GRklboU4JM8bqcQzcjbhW8y6Cq9K9/m2+Nquk
	O4ERG3IvTd5jujO8HCXxScGwXq/OYpcPchY=
X-Received: by 2002:a05:600c:699b:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a18e4af334mr195124235e9.33.1791820132890;
        Mon, 12 Oct 2026 08:48:52 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a193f2c992sm210228205e9.5.2026.10.12.08.48.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 08:48:52 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
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
	David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
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
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] mm: Memory providers for guest_memfd and iommufd
Date: Mon, 12 Oct 2026 15:48:50 +0000
Message-ID: <20261012154850.96716-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <0ae3d92ef99c264cfd76d3c1ddef357e96c98d93.camel@infradead.org>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com> <yq5ald8680t2.fsf@kernel.org> <20261012095800.50250-1-griffoul@gmail.com> <CAEvNRgF1hMz+4ivH6WhsEOLTJGOegYO9AYK6OByYysPp_nVJ=g@mail.gmail.com> <20261012150715.25132-1-griffoul@gmail.com> <0ae3d92ef99c264cfd76d3c1ddef357e96c98d93.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 2026-10-12 at 16:13 +0100, David Woodhouse wrote:
> On Mon, 2026-10-12 at 15:07 +0000, Fred Griffoul wrote:
> >  Devices are different, because a device may not support
> > faults. So the provider also revokes the range on the target once it
> > owns the frames, and iommufd maps them right away. In other words, a
> > revoke means that the frames behind a range changed, whether they went
> > away or arrived.
>
> That would map to the IOMMUFD 'REPLACE' operation that hitlessly
> replaces a PTE, but does anyone actually need that?

No, not on the target. Before the move the child has nothing mapped
in that range, so when the frames arrive iommufd just maps them. That
is a plain map, not a REPLACE.

> As I said, assume that the "crappy devices can't take faults and need a
> scratch patch" issue is dealt with *elsewhere* and not relevant to the
> guest_memfd/memprovider work. That's purely a quirk on a given IOAS
> within iommufd.

Agreed. The replace is only needed on the source, where the frames go
away and a device that cannot fault must see the scratch page instead.
With that quirk on the IOAS, iommufd does it, and the provider does not
need to know about it.

Thanks,
Fred
