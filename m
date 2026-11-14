Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686229;
	b=Tz5dwA89TzPR40Sk1CwQR0XY4r4UtwvT5m78ZkPWLLqu4gNreYzD+w0SAacSYaUW6ypp
	 Opbpwx+z5l1FdXFzqkUhBePCzz5VTsPde3yix4kY8aEwRRFieABYLEAl+x8HK2PNQ/uBe
	 SYONRXiRXDFc+yIBOXzpS5hxQQovJw+lhJ4pXK3llQSjimPi0HARaG9IvP4Hc8cSpBrGP
	 4+zKH9wBOLRe/oQqQuJtLj+/0s7MAc0EpGApz9XrKpDnLqoNFrfSuTAdPbJjjF1R2aKsN
	 c8K7/Hu+M5R8CFPYSVbiIFuof3JkD6+Y/yLkPnO5Bk3RbvriuVx0Rv0u80pSt9MahuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
	b=nxc6UUrIaX/filfoy4wh42DHK/Mff6NbOKRQI536qGHdiH2KnEJrCerMd3krcKte4oPv
	 3hjSRXNJcij36GjWKNSt4gxgxX1BWNOEjXPP1nOqVIqnBsxIq13XQCYaTy6r5McZjrR6r
	 ON3gK3VBqDy232Hbdm8NXqD5DJmL7ZX5OttZFvXYmiGdG6KZckBLPdi1QsYg9VszQauCG
	 AHCeJlcTdruvYscoVdcfJjbiwp6/dFprwWLDYwOAK6YOnVOcB4F7mhe+5hR0uVwtMilEi
	 0CZU1lkOxvAr49paieXxmUXnXwZlLdPg+ITv1UZSHCQsMMlbsSyHBdUESgy/bP+EHLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=DBzXyPrK;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039760A5BC0
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8039760A5BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=DBzXyPrK
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ed2bfe3252so7802875ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686229; x=1795291029; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=DBzXyPrKsDRPTbSaxgSes1jjg4+nqKN96POlblWZ7GlEA4M9Ge4VvxQutRKppkXm9/
         JtjE1SinjwOrcnYUgCDHg4MIs2Z60pDVRm/qt1jTjYTqlliRteCUH0E0AQOuFS9NjmNI
         8UIHSjTNwfrHv19avkLNL5JWrSHqkU2o/qOhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686229; x=1795291029;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=Ke0o5S/GYE/NEZG8wm1COWGKmfKseIUw1kFo7eQQTnObdA7/eF6UofJp64BDUJN2R+
         sxiW7P/WenNphSr7oUgc5EGcOK2elCJYFx2jZBvXMU9WXnaDQ02quQmCJjC5gWFlpiys
         w9i4SfIdUPJUs3z4koejhLbMH6Cfrc7W2fB0zaFh0SNYcoDX2od8HbpB52z3IRs3I7hc
         ORkzgbLt6bGgCoXh7ZNmLpw76q4F9ed/S5vbPL9TJhgyNmCHmJjwmp8wiMYZIvTVoNdq
         twqxUvGIMS5u7nT3SuhhGIImLFeAvjMJFmrAxhxFzwuKjZLzJaa/uGd3D+pDc7tPEIL4
         0R6w==
X-Forwarded-Encrypted: i=1; AL+hErFwpB7li64FGGyac8jFkSyuFOZ6yFIn9s16H0pWEXr4aVPbMD/HrWncWXF5KkxEDo6lwGchWjdb5VYoP41C@vger.kernel.org
X-Gm-Message-State: APuU4Z/IlVpJz5RQ2ghgqpVMXwn7bKCdlb2CZYymIU62jPitgyPJ/i4e
	i0ZHb+pXJeqVquhnJhdAZWoVHrI+8kJircOolINCXn+A+zmc1wrSGNWpm2pLhl/ceY4=
X-Gm-Gg: AYBFou3Qq3MtLFxU5IhpctFYE2FbhsxVLFcnjlUaoT9KFDfMhytTTfrp4vQG/AZAnJr
	goOsaT2yLX3mfemaqBF3aueb8H4z1/ZdXwQsD9OWcZhdJk9CLjhcQpu+AYnDfACPt76JlVkEvrC
	7HN8SZzlvJrkTPSGuWVpV8GvbNnMwo4VAAYkhjHk0WXB5VvcDjczl7G9yiq9wAedqlqCAmpbBB8
	6V12TT1vE9oAtaJFNACNbvGGxyyAe47zGzBoRRyizWcG2aYb5LCQh48gwefMFGS/l2c/aC1YeDt
	AN9aIHx18rSkUunGvIWZzCe6k6sIh4WnYVdJxxsVqMylA42FBIQXdi5nlDXv10SEs9Z855+LC7I
	XTJm3yIil2xx65qDQr9X8XYbcFHAS0fWceeDjzRcET0dDZ3YbSl/dieM0AqzSLoq0uX268H/4sT
	67PVpldXCOTdAiHNLKDPDUvwCcDx91N/jXBe9EmgwQXE720NghBNnlj3+YgtDI40qnsMjZl1PyL
	urGLh8II7UUDK9iS+am/08Byr3dPfQyFKVdesebKVrZ7ygGhf04TCdxFsoRkg6GA6nXZfm9wC9j
	9VoHlTbddYavBtySGt9AoTIfso/pNl99Ez2WeYKtmL6DT+IkXQRNKxohhKJ0bRGdUvEs1g1RCx/
	niRkg5qLHWBNAGwH+kXw62pteKXLg7HhbW/SDF5t5HPPUe+gD2s4FZKYFJQuQYZSXwZGgAkqjd/
	AmcHl8LAW9HklvpGRDLl92dS6ct/piud4FmuRqUEu2ssmCQ96OhFsfPQ==
X-Received: by 2002:a17:902:db04:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2ee0d9eb41fmr60393715ad.5.1794686228885;
        Sat, 14 Nov 2026 11:57:08 -0800 (PST)
Received: from [172.22.0.2] ([4.16.0.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7cf33asm22947505ad.27.2026.11.14.11.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:57:07 -0800 (PST)
Date: Sat, 14 Nov 2026 11:57:04 -0800
From: Chris Down <chris@chrisdown.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>,
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>,
	=?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>,
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 10/13] mm/migrate_device: refuse to migrate shadow
	stacks
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-10-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-10-50a2ed382b61@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114115704.9bc8ba24d73b8bce@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Reviewed-by: Chris Down <chris@chrisdown.name>
