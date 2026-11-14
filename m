Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686227;
	b=reyb+3uZNI+Z59g9I+U9RXgqa+UnZCCsN8codvc84Kv4ZxTSTI9jFlgbO5O2zCwMAuut
	 LKpY0gBULvrVG5ZECQVFcLcgiixeUv1fNQgIqxWWpQUrWiQgO+j0QrfvjZ4HCb0aN+lZH
	 yZkfY0AgzZLQlF0s7qEH4aUzpJ5NFnAof1kHKnroGqCykEBGnT2nXEL7j2Fse9C31X9zq
	 vzE7He2xqkYPtgTa6GYAL0otSOVd5H2DT9M0xkI56Yw1FhsBfkut9SacQoak9pPz42Lq0
	 BR3HbORD9/lqMAVmYn8olkm2Dmzn+m8HTSaJn69diCxQkW0RCYQbp91dVckv+X5z/Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=OCVS5zlhrjN9ps/q5PiJQ1tTNBzYlAwbpXMt2B00TDw=;
	b=Wx011YjSMyydSUbHe2jOfixMEWkcPVFM2+CYMclDROCtxwvIWSEJ92PtYTLTgwW2A78D
	 VscebtZWiF6CGC23l/AEFMgyIQXgDp4LjYTFVTjasaTyn8Q58dJNw7Whh6tu90UnXthNK
	 b1DStlIq3tI9QWd/4ye+WRmfJGCenoVOqmozew1s9xLhIm1ZxH6a95opDhiy3+hXysDQC
	 mDZ08NEBu3aRi2Np5Y82dmrrMDrROSmz+0coRYKmQTlBQmzAMtsAsXxWYROx/ilQ3aPs6
	 WMpPz2YiVSQ9Fs8VxQFxT6e13oaDkTss9j41ZOst/qPFfWXOwGNe95Wfq4T3UDRmHtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=tKE5crcb;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165AB60A3830
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 165AB60A3830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=tKE5crcb
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1084914a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686225; x=1795291025; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OCVS5zlhrjN9ps/q5PiJQ1tTNBzYlAwbpXMt2B00TDw=;
        b=tKE5crcbDd+Y66qKVu1Vo3c+QvvnO/kxPzwoZf5v4mpLE2ZSeWaCIBA8P4Ywjwk8LE
         6eAKD0Ql/Z8wrCqplLWn+PPZALQxAhRRDPVpspMArDyx0yyERP6CerQs47nTp/4HbwZT
         CPItrLkJkt1N114ET2W8m0L40PB9j/iiLow4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686225; x=1795291025;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCVS5zlhrjN9ps/q5PiJQ1tTNBzYlAwbpXMt2B00TDw=;
        b=mKOWLK0vkrCssPiht7HdmhPToMWtdz5PFv8FvLIvp8ngfGXASTcqpUZDzW9Kc47a1P
         8L/OZ+UDAmHRk2VYfwo0nvVNLlRKEbNw4g625GgHn4s/GYah68A89QZ5m0s9G/7fFRDv
         1K/rqXyMTHq2s+kyi52U1BVsfH4B7t3/fwCDCnYRiBTdnBqddocBkXPz8Dn4j2yLrXol
         Eq6HJOYaxY+rFesst1FgfjPCyUm7gQOBWsgqLNNXeDgZ36mgXg/HEZEvayjPNIEHmKd7
         LRKWNC1TfhsSr98219wT2lYmb6LxCpBLG40ATskbCt3uer0fnAnYNNDtpC5lo59BeHFI
         YbPg==
X-Forwarded-Encrypted: i=1; AL+hErEBL8ir3Csdd3gAoTAmGO/nGj/X2NmPovR5Tti1Z6zR1ZHeUSLe3yIF6lw6wGN0mJ2WwWFeIzgBYwfS7MJr@vger.kernel.org
X-Gm-Message-State: APuU4Z8tfNZ2CW0yQp8moDb4MTUR9XHXfCMA8b1dl34IA3dLfw9GL/WU
	iU4Q6v/UuuKoq5Q+4bxFbZslTOLzYyGgy7hFUHYWBehAmADIcgd9gQDrEuW3xC1eDAI=
X-Gm-Gg: AYBFou3D1Lo+LEtIbkYbnQ6q8AFMuodkV1wBrkVs/44tuiQORat701vtEK1fSVXYPp+
	xnICFwtX0NFRIYsRMD5Of7URTpfHr7hsCs+b0mp8kTWKbdQzsU1lmD2AF61IoIoSMFO3iaP3jFP
	fT0i1xzudT6BqlusK1mB4BYyslA/X3L54mkhmo2hoVNx8BTuLIakclndcfiMpWBfDg7OZA4Viw3
	WI/1miwKatAAGs3ClDzzYIT73M4fR/rt4lrV9Wj80Gm22gv7u2TDbfTlIl70k/9hgy8oCIMFOGS
	sFyzf2pILtKxfZwDNMj7JsI8lbcvxjBUDm9OGALV/g1VyH9r4JyIxacxEZ8avLaZDSL4zbf4ktB
	qVjPouuJBxcyh47ajdCTIqgDjYokrClRK7H6UdAnamEMZBReqr7MV8YuTCm5+yc92Q/4CzaECHu
	+CzokF8TBTJbz5Me4juph8wQGS2EsGcQtmvQ85bOGwflvUrlXJf5WGIoTfw4LcxPOBt2+vAX2Vw
	Or3NF8yTK/F1EOA+hBR/F6FQGav/ikTedRspVZneNpFyBtxjFZVt5IfiySwiUDwienFggmyZeS/
	j3EsjPlk+devPn4qgZTY9NyMLyr5kqO/1Gm1VegP7B+UoaY6nax5j0fLyh6RN9bBXEEHyKgvTlM
	DFSI9Vfa5eHoFs1h6L6llhFCAQT1tzN1GVKLTAEN8+AY6SNHHYKOKBGev18xyxCE0JapvGqlScj
	I/Gccx+6QQ7Iq1yMl3EclwHcvn3RvtcdzmY4bcs61/1qcbD/4Pj7HaA3k=
X-Received: by 2002:a17:90b:4c8f:b0:3a5:133:ca5f with SMTP id 98e67ed59e1d1-3b1b0b983efmr6301490a91.46.1794686225426;
        Sat, 14 Nov 2026 11:57:05 -0800 (PST)
Received: from [172.22.0.2] ([4.16.0.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec43699sm9589262a91.10.2026.11.14.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:57:03 -0800 (PST)
Date: Sat, 14 Nov 2026 11:57:01 -0800
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
Subject: Re: [PATCH v2 09/13] mm/migrate_device: fix use-after-free of the
	anon rmap
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-9-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-9-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115701.3a5f64e24081d09f@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this with test_hmm evicting its device memory while
the pages are being unmapped, and with this applied KASAN is quiet
again.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
