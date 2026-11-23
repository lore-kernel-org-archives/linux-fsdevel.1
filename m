Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442547;
	b=2gxHsEwYaOn82mtqAAGZfhdLWi4GCKY3KbyPp8601w8hMVwLHql0owMBQempebqMjpoK
	 sxOwQslYQ1qfL5zEA0c8AvLJD8Tk2wUIRZC4VGTOJqOFztyiMzpm+8eSLujp7Z9lFjRY1
	 XKkukxQA6wYl48UF0gDK9bBbsxERkmhaotS6EWNqwYJvRweUwENJqd+dxBk/JCXqNJ3VX
	 W21iTX8Nza3fhzoHxZR+dL5jzfsGfMYo5MTztWYdHjTPBkHr5IX3NJYU+56Uq9SrtPRPL
	 gCwqC1dXk8Fc7rvSH4B59mS3qFe094lzC1RzwhIjS/k0y/n1B5/nt2QYZptSaH9ZERw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=K3PKiWxJL5rA78k4RAfL19Ict6G9pZhcXRFYMUNqZcE=;
	b=XgUweoj2UTDVqAP8QMEZ8t+g5OfF/rsz6x5eBEI7eRNOXMTgk/Ge58GLTuHhRNGl9rlo
	 ummdOpi2csvWadBmUINJrwPhbkJAxgW2c+Hn/IK7hhdDJpYNCBCm+6Vi9DpWwrevIeRg8
	 RaeoqC1UFNSgReUKp0XE8yQFBFoD2SBWwA52WRMuHjvv1YE10l2jEUn2TGq+SaC12J7l4
	 RPqo+xJHiqGU4hxfrVbxF/v9thNt6hsR3mX7gYcGZdBwJsy9N2ExUgMt7LDfA+sJ81rEL
	 62HGxjvROpWRJJQMPUD0GfPwrZZyw0JOK0+GaNDO64Rnx/XHBvC5L5++CMgXJy/s6EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VljreHg9;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA1606A681
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BA1606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VljreHg9
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b502b9b702so36112697b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795442545; x=1796047345; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K3PKiWxJL5rA78k4RAfL19Ict6G9pZhcXRFYMUNqZcE=;
        b=VljreHg9fqduoNCuhUvYdI6zY5hBHSeYwhiI7vf7summ4dEKYq9hFOCCfR6aYF0/2P
         L2riCG2gI435GeC7ZNsfR6fHTud24o8gBnAqDt7qJDsirWdVpATYePJDvcAuDTpix9n4
         LGwyZSTUtozFudCUJyvSw4q4iZ39AoKFu/CZ9iyFv+g5+PfiwXHcWW/55SiIwIHTxq95
         +D/FF6JCGPVqldEw7rHVuKYVNkvZaIANpP3McjVm/7nMaF69sLbbfoPbYTj1aNHccjUA
         BzZMskVSpQ48oEk7/U4zjyTsdufPf56rPR+BY3dYNsiQKYzFM3LIFVLAYoI1XW3G3WoN
         vQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442545; x=1796047345;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K3PKiWxJL5rA78k4RAfL19Ict6G9pZhcXRFYMUNqZcE=;
        b=I/GRnUNmA3UOZIqtelinDJbgVmW3koMlHTVrSCMRBA0iAdATzd/sa6DQ3E/m/ItgHR
         ubPVoFWrjC25mQGdT6XemgS/WXLV5Pj6MwM6Df4FmX2uSnprczaVFO/UYU8so7nMo01O
         pu0+yDyMdvUOzn6U6sdlfFYFzJIbhAUWxIFL2vdsv3r2pT6aJZKiKWGbb7H1BrLrEHbn
         MSNtNiUKry4kRrXV4yBXSpmHABeUW2yF5pkNfJ1EXaPZomUhE5a49jo1no7U2UBdEKuC
         HcXZufrk3GWAVsbxC9kkbQ4z8i2pQv71ZBBGNIBmw498YsRlw2y4EVoYzbkXv0AaCe2/
         YjMw==
X-Forwarded-Encrypted: i=1; AL+hErHkWxik5uTpVBM11Rb7tBC9QeNYm8tvoV41KUD9PIutKgZTEomYlbKkskxkt25vHdJXYvmKGbYu90IoJJck@vger.kernel.org
X-Gm-Message-State: APuU4Z9vlPm1aKuWEPKmVhjtBL2tzERgLdDFH1zmTJvJBOlTvFvF/pgt
	0yXoIlPsGxh9c7rTF9ekv1Bk8db4j3LYjOVCoQFM/OerOCUwEbj2Pa8lF0975ippzDQ=
X-Gm-Gg: AZFdTZfB93t1+Ed8lkm49tM+Ku5vO3nvsx6DWFl5che0IOD7YevVW+Ib+MIMAzFUpN2
	d+pl4CaTHYspr0lrZh+9WS85wn9Ms8RIRM5DWsmhng/IpWAr3bYXTz1Y5Mz3SpnpFnBqsh6VN29
	p1z/DjAGxAnmZgQCp4l71Sdlt9HmYT3JsCo5olSRRcFF2czPBt2GP8MpEqVJ61s4LiYwfqWwY8w
	U9Wx+yRHLH4mylYI1F7cMalljAfDKlzBk3yLxzXiphNHR4b3Qa1cet/qyzWvYj0KmuDDwgokXIv
	5m41z01MK3SjX8d7hmvKhtteFGkS9WbcTn0oDB/bjRTnr/e4YECSY6S34OqMNtwwmNHJe2ZfJ+R
	/4V51vzGw90i1L4j6rbj4JUs8Wr+KWg//4VUP4rKUUfWXxOlhKtKHhzZUjf0rPwewaBSlPJFHvs
	o8/BmJMEqeIuorchqKXq8LLFK39VjUV5MfMh2kP/kTGwjP3krb2mNWAlKH1U4wSYnbKmjVCsnuY
	R94CfTvcbf+q8ZYmzkT0xC/0YHUjNNTrgEa0Lob9c92jMJTOPUAJWTWqw/ahhhCSTO5Q3iwYrXU
	Iurr+cw1q9Qo7djG5JO+tieGSZavzMp29luaAyF8fYdTk7npJrtCBRq9XaF76teRBuE2VuahG6J
	mlx2x61c=
X-Received: by 2002:a05:690e:1449:b0:67c:b95:6753 with SMTP id 956f58d0204a3-67df451a476mr4209002d50.146.1795442545280;
        Mon, 23 Nov 2026 06:02:25 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213515f467sm104854846d6.41.2026.11.23.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:02:24 -0800 (PST)
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
Subject: Re: [PATCH 18/60] mm/khugepaged: base the recommended
 min_free_kbytes on common memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: gourry@gourry.net, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, SJ Park <sj@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 Jann Horn <jannh@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Youngjun Park <youngjun.park@lge.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>, 
 Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 driver-core@lists.linux.dev, damon@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <awMbTMt2M876rTy9@yury>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-18-74f5f9a115c2@gourry.net>
 <awMbTMt2M876rTy9@yury>
Date: Mon, 23 Nov 2026 09:02:22 -0500
Message-Id: <179544254257.412063.6102711886866280853.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 11:41 -0500, Yury Norov wrote:
> On Fri, Nov 20, 2026 at 01:09:09PM -0500, Gregory Price via B4 Relay wrote:
> > From: "Gregory Price (Meta)" <gourry@gourry.net>
> > 
> > set_recommended_min_free_kbytes() reserves two pageblocks per populated
> > zone to help THP allocations avoid fragmentation. The reserve serves
> > ordinary allocations, which use only common memory, so count only the
> > zones on N_MEMORY_COMMON nodes.
> > 
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> > ---
> >  mm/khugepaged.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 2dc4245814df..a930d99f89da 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -3151,6 +3151,9 @@ void set_recommended_min_free_kbytes(void)
> >  	}
> >  
> >  	for_each_populated_zone(zone) {
> > +		if (!node_state(zone_to_nid(zone), N_MEMORY_COMMON))
> > +			continue;
> 
> This is the 2nd time you add this check. Maybe fold it into the
> for_each()? Assuming, you keep N_MEMORY meaning unchanged, that would
> look like:
> 
>  #define for_each_populated_zone_state(zone, state)            \
>          for (zone = (first_online_pgdat())->node_zones;       \
>               zone;                                            \
>               zone = next_zone(zone))                          \
>                  if (!populated_zone(zone) ||                  \
>                      !node_state(zone_to_nid(zone), state))    \
>                          ; /* do nothing */                    \
>                  else 
>  
>  #define for_each_populated_n_memory_zone(zone)                \
>             for_each_populated_zone_state(zone, N_MEMORY)
> 
> 

thats reasonable, thanks!

-- 
~Gregory

