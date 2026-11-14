Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686207;
	b=fp+J0gzUpr6ueLdc/4TTVvj8lfgzcuHrVMECpfEr0OGtbzkws8ow27oRdkPxdOP3tuk1
	 F1Y9UuoOnhsXL8S7OY11Oqw4XspOsudrf7JGpG1A8kHsEDK0Eo2jEtonnm7d92zc/6cT5
	 iBXEtkW/mAVN313J6P8mAHc5gGbm0DKV9GyAqjO5/XOlk1AZqkzPHFNg8MDbLq7bjjzcc
	 BicclCNcde4kdwyGjWbd/tJAwM3+ZNY0kwwPTXGifmvPg1UxlcToKvo3G89+cbvn0W4Nz
	 HImPawHCLn1UFBkhZP0L925zliOznzd5qzCJMOWbSR+JFMrkvvYsjX7dUeVbr3seAgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=p2FvWA6CWZEDhvwtscmjEDIo0Dx+bIAbYiK0/cRgf1A=;
	b=c+splr++kK2iRelkfQrlvf5bbXOiK2qzHa9h80CcOxHO/y9o55QiRo/bVO0vkh3335fc
	 TJc5MEmhGbq75pDob0KtgtAcUxIDEHiR1JEzzHHQoVv5zOwEKiT27OyCrhWmCocP9QDA1
	 l2TumL4X9XuKLy/DCACCSSfWhUd/kZzU9/INb1loMqgb0m/UQCVj77Qa2hFhbg+wrB6MV
	 Ay9iHDEwJBsLLyAANmkeM8fUw1+DLAMq4BXdaCqCASfBaU49u1Vya3ms0CWxntojinbI3
	 p55ohs1IsZHoFVOEFQfRk5dqus0UdzIUfGtz9ICUe7SHAX/C78QKESOc1xOm98YOq7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="LDM/h6MO";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151F606A8A9
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B151F606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=LDM/h6MO
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so2154614a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686206; x=1795291006; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p2FvWA6CWZEDhvwtscmjEDIo0Dx+bIAbYiK0/cRgf1A=;
        b=LDM/h6MOiHEX7xFKKsejdh1WkOA2YmMpAl3w3H/gpPvZkvUmcKi83r/TD7OH7qRVQx
         t3gQtx4/UqonZxRhdQhnsdqPX0K2Aemih7kxpmpFq4GkeOPU17M2qXE+VkBcrcCYV8fj
         h2A/FJCTmVyu4uzm0xehrNHDwFPjY3taClT3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686206; x=1795291006;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2FvWA6CWZEDhvwtscmjEDIo0Dx+bIAbYiK0/cRgf1A=;
        b=rclYsJBrp/vJ1WfztE1WH4rwkPUhsCTyABBWQiib/Wevvitqg9hFf3gOh1vzbaN2IS
         Xox5v3ToWeWftkdqJuThaPdeonNkuK96vW0PESIFPC6fQQWZSNww+jhfXN001KBBZDqu
         cAjyHK9tZK3kTYJXL2WjGAqFXgawOyYAw6mMkhUmhUy2+BVVuSL55pownxtN2t/L93U5
         Y1VCxBzD9wEaK8QvB18DiQZhoeA6M6o4kikGMR3rAbYoOW56uvqzRMAI8X5nD8M6/FqZ
         FS0FxD1tot2V2O/npXEInyhsaZBMuVYyy6PluzMgaL7A3NMnf1ZrXqGnlmmR4DQaCvjy
         ZzeQ==
X-Forwarded-Encrypted: i=1; AL+hErFonsHy+lyc/vEnSc66GFPmWvtVQZPp2KmTh3/medlCh3n9Y8s6OTwSlSQmcZvVWlmdObr5GT3MpcPyjOva@vger.kernel.org
X-Gm-Message-State: APuU4Z9rZxWlbsQVPaxdg7BnVm6IuIq5VB27IH8DE+WVgYRJZsw1vhgd
	uDxZ0n5ATJyZKAM/M5h93XSCwmXQYoupYJBTZSx8JeARdiq1GMVJ9uL4jeZIOWICHVM=
X-Gm-Gg: AYBFou0qjNkmiooknaJxH3+GhXV47xfb7/GKa02N/79LnzDYp29FuyK52gg8wW14UyE
	wvsjlzSdoC9PQF4cLZG7IUdL19GALSNkOPrgBzEkxRtNAgcWAZ1fq7yUn9hIiZA/bBR6cfC/wG2
	utqR42N6s+iFudOl5u9cXwM3LyOsXxog2DK9DNfef7l8cTlyAl5v416f5oqOk3o28Ahh9WWqLQy
	RluhIdcu1iWCp+YDaJxgAwkSB1GcpyrGo/VD5eBMgYeHPK+BeT9rclJ8P1da/vWO14PXuTETlhJ
	7i4K6ZdAUfqQNVO982uWkPpjdtyeRY5Ub26TzlvIQKwIHF/6K70cV7Q+uZvqdRPZNngMtqaUX5R
	0d3M0i72NNv4PZSbqO20GJ/4Z2EtVmSlM3MoTflCMuwzBTpxHYbe/3Px5rnselLC+hiS0r+VsVN
	Xa0/zceXktBjf7OR5vBgUckoGoqfjaLPJOhLDVX2lkoFkzTYmqgoaJAVGI6hISDfGYVB10vkI9h
	rYet73a/jKG9qr66GqNN5y3RwGw8lYbHUxSdQ2t+RURGgQKUDu2xJkw2PJ5Y70B/OLb80Qa5cb6
	vE/1XKH0dRkvkvm66jRSCiHESe9yKuIf0VeAE2luce4fRXpiHRo3kvQxEfi5Oa7wwetIlXwWvk6
	v/MwdIjHQfwZXuwOKhahaobMYIaIoJfeXyvBZVirAXsqyuvUsWuB0Rt3NKVIJAxaro5X66zb4mz
	VkU3vM0z+MOtNRXQfPebuxMtgt2K1G4VqklglTdWgror1rcNATWneNoqqV
X-Received: by 2002:a17:90b:2803:b0:3ab:be66:ddbe with SMTP id 98e67ed59e1d1-3b1b0ba1693mr6466266a91.28.1794686206120;
        Sat, 14 Nov 2026 11:56:46 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm14613174a91.13.2026.11.14.11.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:45 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:43 -0800
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
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 04/13] mm/migrate_device: allocate THP deferred split
	heads
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-4-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-4-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115643.a6727abe20ff6cd1@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this by migrating into an empty PMD in a new memcg,
faulting the THP back and partially unmapping it, and the warning from
lock_list_lru_of_memcg() is gone.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
