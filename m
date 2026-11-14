Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686205;
	b=C0dPByVM1H3U4P3aj0gvjsT2xHp7mTTCaO0ZF8PmT9O1GzdIg1rjA0IOIbewmX/TDUkj
	 URRKAmH2MJTol5s4AyjH9sP1tfenR2CG6/WF9J221aDs23l5ltdV9QjNxogNP0blinIEN
	 zuUKIu7XdP1qIVpweN0ceuc/Mx3wWU6fGCJJbdMEGAzglNtnaaoiAyiilTBmMpU4mprO1
	 JqgODeNi/1qQW5F7DLLC7dyJwos7cOXgTBPKrreQwjuTHyFEpvJbxkELoNnlgNHwqF3uE
	 mvIOtHjb8crBXZ72EdR+lvH/FNwJkYek0m4BeVHZoN/fZVlFTCz8cb8NoORuL4JxIRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=h8tQe57OZTUGccU/0PYe2wABwR56zJWhJyWxH7qncio=;
	b=TDnFNW2ZHVeje/8SDbvokN4cAVRLK/XFlgBnYYskzSaZcqGcHyt0vfsUckTfPaNXgxOf
	 DIpYxKcTMKXUKxw4i+zZU0myr4vWhX6E2uhO7PhP7OBrOQfefbyjgp1z6gfESfdDXnFFQ
	 +hDAgAY5biYnTwcKxJknPMkd+vCs6JOd59WePfpJ1uUfSas+EqozyNAKqYNkRXEi/g20r
	 cSsnJYBKI5i5ZslVPQXRIlQQRkvv/fxVckolfT1DNUZLMBkZUtPupp6VvU6j81kzO//ah
	 310vyZbc5F2S8SPNzVREcLJDVInxucCM9EPeWgq7t/Vm3xbqXXSFbJzAq+NwL7Gd/KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ES5qf4Sv;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063D606A89E
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6063D606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ES5qf4Sv
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1145888a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686204; x=1795291004; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h8tQe57OZTUGccU/0PYe2wABwR56zJWhJyWxH7qncio=;
        b=ES5qf4SvSOASRHgqYUg6JId6P9TDYc5Bg6Hb4naf2ka2X9xIJvqrVPHE3vSKV3O0QT
         eQRZUbPM4zB8mXvpO15pvZqMsT9zT0Mp6L1LiFDDzyz1gVMsePZLCRn+VcQtAbR8Rmyv
         nFXqFCTWyxNSh4lLmuRMoxyMGAM9PA+L9Myvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686204; x=1795291004;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8tQe57OZTUGccU/0PYe2wABwR56zJWhJyWxH7qncio=;
        b=19c3ER61TYgrbRS6YgbpemE06EgFLOnWwaL1EuDg/UmeFcUn96e8YLiJl1fARnYpDp
         aVlQks7oNYAwE+BwCDRstpG4xs5/+cw9jScPHCTPrqz9LQN29pOahDHyrupci+yyi3EO
         R+9LbrjswVmc8HR8Gb5ecR301q6ixqqneb5WI8P+uwCjd2YMEyLxBqteLtsygU01sGsE
         TM0RNW4hkMZpbzapKxLGcOtcIStxx62m8TwrQLb0/C5tvkL/AaqKA7TUiKKKlqi9q88w
         vW+VKuWOini7E7S/LhokcdyhY/IInxdW/Al1/nfGwplk8PrDT1wekjvUlNc3YqQOeSlr
         K7uA==
X-Forwarded-Encrypted: i=1; AL+hErF9KEOaJfXzveF0VaYXukGdZMKtFOgbyODnX0iAEO+OaLM44UxP81rmFL8Pcgn0X/O9tdktsTlbPScRDdKz@vger.kernel.org
X-Gm-Message-State: APuU4Z+GkhJ3ebl3G9w1vGmlCNRqfUid2PmPchLEFKQDakkWrgP8UaYH
	m1lrCSMpCiz9GNoSGUV1aziBbnWIthFhjqWsk8CNNUxDQd+LVY4HPWe8ATfAEudRMLw=
X-Gm-Gg: AYBFou2Z2M3nGh51dIwJTvUQjJrng08KSaTSAvteXnFhgPRHhZgwStY7jbsMJCDON8x
	r+IDMizKXou7bjHZJKDrG/k8h4aiiX0oG0efJA7t+m2Ncfw/omrUONHkMpJR75x2eqXUQQAb5WW
	ZyKl8+aUMBJx8ix73knrly9X6TuJDDfloNeR0eMFKolgBUY115AcKyktb64QrEWv8D09av86DcI
	EvAFayYeaFEORqjIubwIGZ992euXHZxy8qqtpPmaH621m8bayJhzilYo+rt7sw1PlzHMGIF4zXx
	q8z8i1OzkE1CVG9wi2ml6pwTLhWIwWq+uT9vXhwjsCAUOS8UggcD7SNPuWNWm06U8Hfe928JUta
	FKDCJhC01u4l5lfshVNLA7Ve6q2I0ev1w1mQb6g1Dr3E0HGWs6OwE3p5paxW/agZgHA7YaqbQhc
	+NFv5y9S/hzpErdBZx9/YHEqvwoNdfvyDWvc+X3QYOg/1IsLxzXTFSEturdfsF2VQDKs9dfPniw
	ec19X18eqzLAfXlIFvXPRn8sdwG91gMa2T+EOmX2lmx/5vr8dGkN+25ItxpuHYWq9KBZGK5P95I
	QeWLR5QP0VOGve2dyxYwpjRNCQOw1weP2x+A0aePBx2z2gY1oUpMuiLRdZQTEHFYtSCOVdWYZlk
	xAPvkjbKaOuUSm1Z6p1bR/YmvDKE6HeT//aG65pIluRbai9SKuqu+j2o9CwALmDYMzvCesN6uWf
	G/dZa3NiMLvkw6EYbf65cX1+9dZDcIAjW7+n220+Me4QHmc8fmgTQjX+Vi
X-Received: by 2002:a17:90b:4a48:b0:3b0:a970:caad with SMTP id 98e67ed59e1d1-3b1b0a44a42mr5984883a91.28.1794686203709;
        Sat, 14 Nov 2026 11:56:43 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b21c609esm4089149a91.0.2026.11.14.11.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:43 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:40 -0800
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
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2 03/13] mm: cachestat: restart the walk after each entry
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-3-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-3-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115640.c707f5c9496fcea4@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this with cachestat() racing against splits and
collapses of a tmpfs file, and with this on top of 02/13 the counts no
longer come out too low either.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
