Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792626411;
	b=NXJehFfx0jt1AQX0wzXN80U8VACiUIRnC7hiKBRLwbQ2D6qQNRwnSX76GpCMbS5AFViL
	 q4yBFGarA2sJEYxoTd67fJH+nIX3SmNlwUmLOHH3d6W7DcFcauFWyd//GaOy3ZHhXFsjq
	 McPDzwa+NoU/wsqmM73UBJMlbUhE3LO8XTeGXP1SolZyEFpDB/EpqMGYJ6HIqxG3xV75H
	 JleUEJ4jHRLVt46jdiA1SzkhDL0BuMq6SHn1N15QiMEEYg1jBgY9WUTRz4xhCBVHjFYHb
	 rBYnETPH0usqKedHPGeKvNU5NvGvDDKVqmZrr5V+sfKG9hUN0/S+LSS06QrOVlmthPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=n5hOymfjgaz7xpjT1ssIdHSQ+wD4cuNPKUAfRnejzdg=;
	b=z2ylStZheBufhLgwEOrtEZ1euCfIsNOfll6Ylb3dTxWzXcDc8qVEskhkioGbaMM24+En
	 aPUDnCPXD2gjT8bSQ5irPN/ueiltEuDfOhD09hwLGDGyJC/hncW9ovupuB7yQEXjKW4cs
	 4Ticllu6JZYGbGCsTf8Ekrh1mFQCxecgFnrmhbUZAElF14nJfR6DsWos2IY6/lgFOwZKt
	 bnTeWIZ8HFeL5cZj3SsIMsMdz39UKMg2AikrP5Oq99Jqtufun+nPT8a38tC8DpYoF7X8P
	 MKW3nsWMrSIEF9UFvqUinyoj6tj+iSRLUzaU8ZbjekPoNtAs4Gv/quQib+TxZv0lUIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81250606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 23:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81250606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e4c00d71aso139993985a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792626409; x=1793231209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n5hOymfjgaz7xpjT1ssIdHSQ+wD4cuNPKUAfRnejzdg=;
        b=RWEqARLNhr7kM3UoylUxt0c18uD7BW+nnkV6qlrI9YT9zsHGYUDmS0p2u/OOJbEXRO
         SgtdrfJPP8qwXew2mkzTL5kBpez8YAljokMt8HUv0ST5gnPGdO65tJGybD3uqk3DHnFQ
         VEfyFNtRpndd2xu3NGiNoG2k4NxrYb1vsCefZIqb45l7I9z62Aci6eddaiDR77WnIZoy
         eWMUHuI+2+oIZ9KbTn2PavphoEY3W05B528MicbkGhBUCoiwiAwUvz+JZs0AWZblHyFz
         J4NMmzr4UzXCJ11N9e51QR5awZqclvbU5xHpjVK9003y/gTpC40ys8/YEtw5gSAxngqs
         Ulog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792626409; x=1793231209;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5hOymfjgaz7xpjT1ssIdHSQ+wD4cuNPKUAfRnejzdg=;
        b=uhmt164opflCFptlssic15ObG5r7lRyemhDJuwTUMjigwd2YSFNK3SQZQbxjW23Pom
         WQUYnbSD+93qp2MQCsW6Ibho3YvCEa6pi66HzuqBDfgpGlmMSOsI+bJeClgz+tvXC+Hz
         cjL4Bhs6hmWDeqKME7X8rt+5qiTymrqTl9h9qT+EzWra6q+FYSjQEVX2wwbbhjoo4QU6
         a4ZHGW7ptMW1RE7W/sbJqazdPh9NyA6x2iZ9Uz/vwDa7jvbEhKQjHgIsN35UpFy8KdOg
         qFjEU3B9/f3yF1wu0ypLiJf0pqKMcY3zRunPDZji2cXzUDZSFSVaMLPbQRuHp0N1biTb
         MwPw==
X-Forwarded-Encrypted: i=1; AKwUvBytYL4/C2orTjHcV+2WvXoo6T0Gz+mrRUbBZY9im6STFxFFTF4F8LHobJG6CrWT2cJ9tuJnlmXg1e39hxYS@vger.kernel.org
X-Gm-Message-State: AFq9FYI6+5hCusO/FiqfuKW8n3q0iuhVzGS1ATNfeX8i6tk+33XFw5DX
	QqTWDhFy1SRjx+D5FVPGRN0EOgbiKggO61v3e7vxh78ukoA7B4isovGoLnmdWozzq+c=
X-Gm-Gg: AYBFou2MFT+FvdySEpTgXYgocA5OfvPJeY4H4eU6PnmiR4R7KEUcmFopnG09WC+JKKG
	RTvBA0RLwGtfKfE73K9LOA6aziFicry5nGk3cZJR2y4cRtNpN6N9TEmDmbSNLJVIVlmLSvcaG8D
	8cdg3iIn1OKpGLNHqGU4J8SiBk2jclL/uOt/CaZpWbITmc7zkJ+elRcEoBh3AWwutGCu7UCN/i3
	McTqgGC6rKyhqNrT0jL/lHW6FvbnZQOmQPkjGBgrht76sDCMhFynEbKbqR8Fw9rlarJ7RNECWCF
	7IbSkO6uESK4XF5QmhF93W+HMYk64JDofZAhlS1bHqltzVJjHfeSLpfmK6fww0GbtAXd5XrcZ4o
	oOxPChlaJzi+ggi5DpuipfTFXaFQ6yUtJwP2bhSbYleZMF9mAYjc/eppzEMcNklhcTi70zG6w3t
	ee0nS2aQraePUVt7muecF5bCpTXbjT3nxhFi0vqdYheqLhm03Yi7TkvzYdlnZznRdZI5g5Pekpb
	huWRzoE2P67Jw6sV2k4e4VwCflgmYqfBrTAPi2/fAQafdjPyY3EGG2vLhFVfmb8AqYTgrU/XOju
	gFzBTGmbVtJpQh0nY6pYTVbQefNJ/3Q9PGuG+bwZvrlaeEBYbudWfSyT814=
X-Received: by 2002:a05:620a:17a1:b0:93f:22f1:97be with SMTP id af79cd13be357-93f5800e406mr694136885a.72.1792626409239;
        Wed, 21 Oct 2026 16:46:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2bee2sm373858385a.42.2026.10.21.16.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:46:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJg19-0000000EWG8-3cjA;
	Wed, 21 Oct 2026 20:46:47 -0300
Date: Wed, 21 Oct 2026 20:46:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 06/11] iommufd: Map memory provider files
Message-ID: <20261021234647.GA3381610@ziepe.ca>
References: <20261014093733.90312-1-griffoul@gmail.com>
 <20261014093733.90312-7-griffoul@gmail.com>
 <atkO08eCJzLX6R58@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atkO08eCJzLX6R58@google.com>

On Wed, Oct 21, 2026 at 08:17:05PM +0000, Samiullah Khawaja wrote:

> With this approach, silently skipping holes during IOAS_MAP_FILE means
> iommufd has no tracking of which IOVA ranges in the area are actually
> mapped, which complicates unmap and could also hide a bug if a hole in
> the range was not expected?

I think if we are going to do this it should only work with iommupt
and iommupt should provide an unmap that is compatible with the holes.

There are other places that would like such an operation, IIRC.

This will have to block an access reaching into a guest memfd mapping
as well, so that should be OK.

Jason
