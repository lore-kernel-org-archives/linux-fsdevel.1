Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504173;
	b=cugdZr/n95qQUqEylHTOYqxC0m9ZreHrFfCo6JgiiajdTUgKD0ifw7mS7J5iVdT9UQuk
	 GbrqvbZEtiHqGLTeTBkNoQPJZwtYXJui7Xcdkc20iTdU80MbcvEuc/y/DX666jR1iOZTE
	 rCfMc63pZdDdk9K6u99ouhA38OG9V/R3GvUwpZU0SqZi0cYUQrns399KZonOcw9iiUbL+
	 Yf0xSuEJKseOEB5nBOcjLzjNxWwUw7FZZDJUnew+d052kW7A3gvsvCxUjyJjjG9gWSw/w
	 z3bUI33SZislSvOFfAKHzHqsuapzxAyaHLIqV1XtzjHeWxgqbQBWwmDrND+qhCTFWPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=a/JRN/xbf7qsdPvNLlS8GtXasJ+TiojxhhjDTwn3xLY=;
	b=lN8s4NX+5q8GcBAxYjYz9lOiBFCGIn4bWtz9GZycR+tUcJlutdnUfpIUxIETrhf2qUJD
	 0YySJLg6un2iB1gDxEksPZ6Ytr5MjQ1byV8HTs0tt+9UvxW2llz0y0MlWbfkgRqtBkDv5
	 Fz0bGGdXY7/p0b8/BbwjsvhdHRc7fL/U4YWHhpjcx23GHQGmHRZieS4gOVpZdJBN3rNuM
	 ijNYvZoLg2snI6aStKQ4MtRdsW8xQodp0ntTcyzJC2I2RZCvy8NZckzaY0y1CetTA7KRM
	 GQ2Lt1XRr7rmwM9wQfWphuAh83dBReW6y0T0/tSZ/YkSV68rI3jJvCSHaVdHFSJIsdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vEiLisOe;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F4606A327
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 17:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F5F4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vEiLisOe
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5361e313e63so49322451cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794504171; x=1795108971; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a/JRN/xbf7qsdPvNLlS8GtXasJ+TiojxhhjDTwn3xLY=;
        b=vEiLisOeATJcgaH8HupEr6TgVwYoVfRhOc5WUsJ97Fr/YmUk7miXmTYVniih//0XKg
         QHLJ2ZMK8tqd1Et7ZG+N4Jh0PE0NAP0DMFsTfjohOPnRbNbx5wCi9MJf7GlbX3zGC5bi
         aLUK0quGQJOUi6k1xd8x7SWJKtq9f5WXsAvqMv5Jofuab5LSwieefdRRSscAfGpRNImR
         sbdLr+gv9jGDWpKHzo1kNv1TRF4RDoecODqqKyKYyyViG6EOhcR5hf9KcsCEy5o/DAVl
         SjKv8MglBVhq4lTjIWfDKL+t0qDr6AR+DnZiNsQlHWG3G4GChP1hcSnl0JNtqLZQikII
         00Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504171; x=1795108971;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/JRN/xbf7qsdPvNLlS8GtXasJ+TiojxhhjDTwn3xLY=;
        b=dAvMxskjsIEj6V3NLppcrqkNPXjgmKJTKEoMnGcNl3PPBA2GTqBo/R/cZNieCoyk+I
         iE/RrEtg+Y1D26svseiIhmh71gYszuNAqWWURfRUY5y0Q7bEUOdIwXIl0RqV2FlI4VVz
         a8MjOvjb2JhTJR375ij8vdl/ztJZksaWrWxzOZjtQ+0vrMc5kKmU72/kH/1JqUXlYBKn
         cCHlXAsWnnf4qgeYNNEKAy8VUkx24M0baEUoHPeM4jjlqnoaYRYR3m601AWA6nYTAtAY
         +q4ZxTM3zh0SHk+PmyDBao+KCcEVh2QUE2R/WQa7PDAbPqM21Zu8YLZL8yLJKRubfKik
         bqqw==
X-Forwarded-Encrypted: i=1; AL+hErFEdZUccREhJN7zgHTaMoBBVyN3xVPwTY4h08wXIXpbIv5h7uezk2P6hRu2LairXwsXS1QymwAGQ7iHeJ3y@vger.kernel.org
X-Gm-Message-State: APuU4Z98ntcJiRd9dtTqtppfErQLVEVjz9vkQm6KHqpi/qNb5e1Xx7Vf
	q3uawvqhRH19zBCeu+MKpWjs/G0gmfJXHQsgtnryyHURZDhwejOoZQuhFAVsNG35aZo=
X-Gm-Gg: AYBFou2Ykra8pahjyQawX+W2hx4JEaLRV1Zn74Lj11sKynm5Hqp4q5YJmWsYJ9zA2/O
	u82RDLwpRGkXYfAgRCwkOPt4TGyjaypqMHhP+eh33FtB20S/5INCqCmSx27Ddzp+xujlfAOCueR
	mfJlksE0cahQq0G9Yz0OTxSP7/AyEn/+z7mjPcmRKDOTLouq3bozwxb2nuGrEZMYL198fuhyvis
	N258CbiUL7WQFbl8GfPL8Jmzl+xTQZ+j/oaceb0OwTrsW9vUfH6QBMRaB2n7I9e5rBbODJqO3Zy
	HPvD3D6JDB3ggTI8ftxrWMjyoMQo/C0CYG+hujcggMaTlf35JweQHoGyfSjnRPl/iptNY3MZ0Uu
	SLzb7hcBrn/vRGzv1iU3zFYCbuWJ2BRsbXJFpEv/5gA94ebMykVq1az3o+AVcRtIsblbBhL8CO+
	s1B/ncGDw+2quvr8lP8tPZD6RtXpWfBiXtA1fd7+uaHVVrIz3zvIiL4YVBiR/AlM+00Sz1oop82
	n5eL9WHAltUnL7+FTeLPCqMbg7CrSa71P+2wiDDkRU+BM8Y670QxG+0xFMvWLkweU50AqQSk8sd
	ImhgNTglXsYDzfOBcclQKh85c7m/zGR4HnTQMTb0smw05lEO/pdzY4OFt8MTUuLToNjomFDx5zr
	NEAALjvU=
X-Received: by 2002:a05:622a:180e:b0:536:64a3:aaca with SMTP id d75a77b69052e-55ac8e955b4mr521501cf.62.1794504171329;
        Thu, 12 Nov 2026 09:22:51 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d93f10sm542436d6.30.2026.11.12.09.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:22:50 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/13] mm/migrate_device: fix ksmd oops on a migrated
 KSM page
From: "Gregory Price (Meta)" <gourry@gourry.net>
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
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-8-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-8-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 12:22:49 -0500
Message-Id: <179450416941.482102.7238369347030508170.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> After a KSM page is migrated to device private memory, ksmd can oops,
> and KSM then stops until reboot. A process that maps the page can also
> loop in page faults when it next accesses the page.
> 
> The problem arises because KSM doesn't know not to try to look at device
> private memory that does not exist in the direct map.
> 
> Disallow this from happening by explicitly testing for this scenario in
> __migrate_device_pages().
> 
> Fixes: a5430dda8a3a ("mm/migrate: support un-addressable ZONE_DEVICE page in migration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: tweak commit message, comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reproduced and tested the fix.  I validated in the base kernel that
a migration could succeed and after this patch it cannot.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

