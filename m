Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686219;
	b=duJVJGPgJ2zkPfWiuHa+IFV7RHCv2P2cqlpwR0sp8+gcgO/XXYyW1AVxkQWSyk2Tn+Kj
	 V4zBB2uQJFYoMEIOdfqbD7K/cRw8KVharxNoOZxj8eqUtDpjFz66GI0SV5QjQ1dG3AS2L
	 nxeWxiW4tqCM7OPMifVd9bbuMxhGa1aLg6ZQ3mSdoqTul/t4/mZOIOej11MpnhLlapwJk
	 YhjZ/kEZ7epU7P08/6RqkgZ/wAI2kJTJ7dJmWKMYKbsyiISOETjq7OopH0lFuw/0VVRSC
	 nPydE1ufTgzIPutvtoapsmlTQwdroyXcVc9fUb/59Fs3otQ/CxcjlWvXj4ZuYeFpl4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=YJV/kOno9dtsXAkcAOQfE/oQzfJxocwLJi3WPYE6qNI=;
	b=YuDpw0CHJYp3eLYmfY4KKrTRGX/Iya9RgHrv4sVE14M0hAXJtwuBIjFAzSvOm5+0vEnz
	 qhYBRDgnMumJLC4Mb2I48EIJXtB3ynDpIeG7zz6WwJc1V5UFKk3D+R84F3L3XkymXep9l
	 WI7HEmHoXS3NoLyQYuFYmayMo8Vsek3xUkdYb7QoZrCum/krBoIV2bIjYe2Kqbw8kd7YQ
	 A/sG99lJdxvl7YvkiXEe8DA7AzihM4nu9C1YuKLN8zxzOddRRdM4MZS+2kP2V/tWUhGso
	 bzg1aeRs6PpexQR19NBX0elIBXrK1jmg95YL005TPx40dFB9LUHMkEvZsSac15dauUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=vCIej0PX;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9960A2627
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 19:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE9960A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=vCIej0PX
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e987a2ba0cso11747355ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686218; x=1795291018; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YJV/kOno9dtsXAkcAOQfE/oQzfJxocwLJi3WPYE6qNI=;
        b=vCIej0PX9dOhvVI1XQrPg3zB8HDYKWUKJUfIIUezj8rzlKXOq0OMq3pe4wQ6XpdOmS
         NYBcf2KVLtwBMAKAy6dCSHE3G6Ij1MQMaxPUZxuqz0NduffBv7xLdt4vIZKfYghEMKCw
         nsMry00kZ+7KCUIo2gRoP8PU2opDqLwVR/xnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686218; x=1795291018;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YJV/kOno9dtsXAkcAOQfE/oQzfJxocwLJi3WPYE6qNI=;
        b=M0fYs5+8YY8Ex74mSGfebrDsIWF/CFGK8a6qjkRDDR49AAiWKklvZg58pqF9hlV2Gv
         xY3pl1qwd7LXwBFPwdseCzQYj87QUgK9J/X+u0ouJ3WkQb84SiGK+N5v0jxk3thU/JEM
         6hmc0Ec7K9N1GO8pc7z89uWmZhwN/vYxFAu/n0SDF1E4/9OfAonbNP/MMVAxVRiyKDm5
         PaT4zRJjOKp80LylK482tni2YJvvuRjZ+Ykla5bnQun6CFDa7kK4r++uVY+5Ui2Yles2
         jIbRbGmwfhSec0vZXC6OTHCjPKVkyq7Rtal3C6ZjLh1uNeRuf/h4OTuv3NLWfLETNu9j
         ne+Q==
X-Forwarded-Encrypted: i=1; AL+hErHCQ5jGfF6glQWNidZRO26/UEr0crvJnJVKjixzjKhBuqxwGmoj3f140t7w2sIGGUyQXXlCHUKSDjgdC+BI@vger.kernel.org
X-Gm-Message-State: APuU4Z/pV2F/eSbc3Mv+4xgI3PwDnIM/Z168tUtePyavO6x+tjdEuMjB
	i5Zeetenq13ZfS8hdPedcFtRphXUTZtLYiNTZKopjbAhb/UhP/hst48cVzWSoOPudyI=
X-Gm-Gg: AYBFou2L64tMqS/H0rAt941FnSD8slDczyieyFVOR+nguzEqjWIZFsAZ6HC+sjLnQP1
	ygCE9fVoP9aCGMImwN7hRjSZ1JrH6HI4DsNfoTN+F/ORZepAN8r764j6m4B/lnA4R4mR1u8Em4U
	HPjrabmlb6LiDvYC1fl8pbzg7yWcjawlQZIWSiFTlm+kXuHvzPAjDAXuUSC3H757LkW90j+U0AO
	GUVmRbZRyWlsyREh5ipYDFhgoOWowBxXPd3QIP7KG+x6o0t/bpKIp4tzzNDbw4JVzF8kBezs9Dc
	k/BBzdAdG55FgJg1OBKVtAzj5dQJTT5VnOrQfygBSxcCvSPw7W1zICu/bSLeh6IzhA76CcOPt38
	9pNn36rfgiY3HhWm4UqlmSq1E1OGHyZObLx7NSPc/xqGzPri1pBNKGhefPG1JWzOVzXzkbXqEd0
	h6ejAgWiFIj+X+YHwNoooZzmBdPSpPEucer4sqPzmfrPhongDxauoT1tBU4+pgKYDNzT6TApW2i
	zAbgUS69wRz8olbOzi9HKnsG7q7gRpW2zG28qzJuD6lsa/1dY/2e9jRgLjH1EDqfdg+KMihuVvC
	EuFPBoB7a2zgsSguIclDPzNyxzT+Y2y/byJHhJ1sK4F4FhE7zu+m8QoYsKP26ZKZ7ajQmC5mj5q
	siCMqzr/m/SsYZM+XRoIpZQ4X3mXaZ+38m+cBRNvnnRR6P9AvwH5TOIS/ABUFh5awlBemW34Zis
	cKV6NKDECC12BVNMvvkQFd/7vyNAWz3pfS0RJ13wfSzFFHmWOQwTPTgg==
X-Received: by 2002:a17:903:2b04:b0:2e9:4d43:d58a with SMTP id d9443c01a7336-2ee0d65fb59mr62764435ad.1.1794686218088;
        Sat, 14 Nov 2026 11:56:58 -0800 (PST)
Received: from [172.22.0.2] ([4.16.0.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f8dc955sm22202275ad.62.2026.11.14.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:57 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:51 -0800
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
Subject: Re: [PATCH v2 07/13] mm/migrate_device: look up fault folio after a
	split
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-7-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-7-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115651.2b3100f5d9444151@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this along with 06/13 with the HMM selftests that
split the fault folio, and it works well.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
