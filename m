Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771599;
	b=CTIEOKL85BWezVK6fzZdrLZwFRQU3Mrqcr7j39g8ku2MfLh0yOacKCMDVnwadS05Xmz/
	 iID8La7UkoFKN2gnNagIkuTpJ8WgN0N4hr5Ed+X043rgqBtZOXRKj209BwD3TepX0iwaX
	 oB5B48F/SLDXqSMyksI/pVJcwRN/0s3KfmjZHD6UjHh/3X8I7hw/9bg/xqCTrTXkdOza4
	 L0vXvQjK0RKNqa2/RC7MXjj0qdnJDwKOqGzScTeoo3hWSRMzYjw1zMJHY6KsZcejDMK6a
	 MP/SxTFlnCuJ+WaVpGDqFH5jM1jQDj8Yj7oac9095qK6smdK2x10wlgws17p3eynPAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hoxVon0gybDyq4RET65wbSko4AYZRSn5g8mIkbvH3EY=;
	b=iFHB7d9GsxXxn9Mzsxw6ZA0OV4r8gx3jHMl1cYpJoUyV2SJmw3p6chtXpCX6HPFqGxZI
	 gQEtfK+fVi4UPebohAQcGTYcwd0ukMXA6gXSJoZ3DKmmuBUOwX+1HCVle0qIypfds3eb4
	 laYjX4DxNwiYZFGxjvLWaP80dlVFhl0XJ7vtl0dVcQ4Qx1n0o70R3IcreUwmsnpV2qFPA
	 DyACkjn24cNW5RiAOIJfNMEwwkMAgFA4QHWo3KzzNaDGD5EyOZDAqObJ22eGHjSE51T6F
	 ELnSppF+q5UaD1pYK4WdhvXe5IVoWMmKfQVuoGng9VcLYurYq3FeJJH0X8Ub3HI4S/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Vir8602Q;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718BF606A323
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 09:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 718BF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Vir8602Q
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so83360225e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 01:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795771598; x=1796376398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hoxVon0gybDyq4RET65wbSko4AYZRSn5g8mIkbvH3EY=;
        b=Vir8602QHCY48d/5HTYyW2E758IaVdN7MLnibn3ir1cJWZggbX2KVToMsfPGsh7pGH
         uVifU8phq/aN6ngKAepiCcDCApwHqptT+9947BVDpB9JDCGrNUO5roI3BaFwvFJPLZMb
         AQyrYQpnFsdckYnvvhPZW8ZXtQhubCiYIHiKhNnp/NFIYhqiDPhGX87HyiYxlODjBJOD
         S1kGzSpdaDYnu7u8c2WCKaiHj31BSDwUli7/seZyzP/JEG1PoeJPVJ7FzD1bU7J51N7H
         t9FQ+k3RLVI0qUN2/qRN3wFxmAMjVS9p0a9IBtakY94L4RiiL2dGtevWcQWAVe212VLE
         JBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795771598; x=1796376398;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoxVon0gybDyq4RET65wbSko4AYZRSn5g8mIkbvH3EY=;
        b=jsGKcybOLO8XGW8dZEFwyLgNPrzPePmm5E8xvn6010RdT9105WHSGBnX/mLYKITWL1
         lz6U2nZvG9EDtyn0qQJ58cazXUUarcgCWw4kNU8nJyRDAitld5Yjt/GQs9vzJQlRS6bM
         sRpyX3UPxr2qOma+At+0wgklnZ9sL9k97AgspnzRG9z2H0ZAZo1PRrOAlynWX9X8Mey8
         f2NLWM0mU+N9Xnje2xUcr7h99+eJiSxfR2T6idrQw5oVFQnTMPT6XLSH/NtHb2AC0hbR
         0VHiJ1xIcmIjHxU4L4PeUBNoN05Ui3WJ17FzIWDbCX/WMBrmjPvbIyXQwXt/0Qyxlb+U
         e5YQ==
X-Forwarded-Encrypted: i=1; AL+hErH1IB49SbjSLAI+gw2rl1yIWaY5jYjF9qtYjoy7eQB4xCOtXKWTsWhG9Wyu7VHEVzUwAfLDg/qec5RXjMIs@vger.kernel.org
X-Gm-Message-State: APuU4Z8dUIDX4fIN67oB0g/BbfjGYguX+d9ejCcFLEo1WVPP12yQsnNq
	6sy8u0IZisSW4ACIF5ifZxdrtkwiiYUOmV7pH3W6K6JaFaUd5QjoetGfo/R6JNlU+lM=
X-Gm-Gg: AZFdTZdUeGmGhdbW2EVilVGhpPAZyKA5BlKS9KHQYLBDhfNBg9y2WZN12MG+GJL4AEG
	iRcwNq/do6ktptCoxkgpwZsfkez6lyZgI183vgYWbxT1C9Q0b72zHqt0z8NL8Tl68AuLHokSugu
	i0w5MDwvxAeM3k2ravc0Tf/ydupXgvno2pgUY3n4hfswuqkwyBA1aFjJcQ9HA9UBpZfJ6fmM1tv
	blBBTSTCT1G9vODxZQnAgxs+gRhgDx5BjU5LdH/pvQJEmDJuW61t6s1b/glTZjawp3Mn5GiwwJa
	cTENNz9jXK83jvkkVr9gn4Z50kOrKh71SaYsTxWX8vPEM8ECYja1sJ8ITqBEuC9taBJtNJyeQoE
	OZsUFDPe7MDX1sKmn+RI9OTAUbShONVVoJS4fzPlKpj6HP8GfLn0PFii9djPHT5ZG+7vAwL/NnM
	Zc+cv5nCixQNwykaISGEVrwEPSsoQz+z0J0ov/AHx1xJFlvLktUsdA6CPMUVmjoBIAf26qrHXKk
	skSUYjbpa48J3iUs0orSyiTnoadtWFhO6THtdqkLg9bZjOEZ40IF0xEt8NWhlgR7/mEcsV37461
	qMhH39j9tn2MXPEoXX4Ab18CBiTRWGHI+qblb2N+
X-Received: by 2002:a05:600c:3ba5:b0:4b0:a307:46f8 with SMTP id 5b1f17b1804b1-4bb8880f29bmr537393335e9.10.1795771597616;
        Fri, 27 Nov 2026 01:26:37 -0800 (PST)
Received: from localhost (109-81-21-11.rct.o2.cz. [109.81.21.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2e6dsm44430440f8f.6.2026.11.27.01.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:26:37 -0800 (PST)
Date: Fri, 27 Nov 2026 10:26:36 +0100
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Greg Thelen <gthelen@google.com>, Greg KH <greg@kroah.com>,
	Ming Lei <tom.leiming@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mm/vmscan: Fix legacy memcg reclaim deadlock
 against filesystem freeze
Message-ID: <awlMzHMo6_Vj7gmq@tiehlicka>
References: <17d0d1395c0237d201a1abb2473d51f5@kernel.org>
 <f188775aea9580f9ab2b477788503434@kernel.org>
 <20261126180228.9b672a945d480e3d3f301985@linux-foundation.org>
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
In-Reply-To: <20261126180228.9b672a945d480e3d3f301985@linux-foundation.org>

On Thu 26-11-26 18:02:28, Andrew Morton wrote:
> On Thu, 26 Nov 2026 02:17:38 -1000 Tejun Heo <tj@kernel.org> wrote:
> 
> > Hello, Andrew.
> > 
> > Your follow-up, "mm/vmscan: scope freeze writeback skip to the reclaim
> > target", applies on top of this patch and tests fine here.
> 
> Cool, thanks.  I'd forgotten about that ;) It was a hastily slop-coded
> "maybe you'd like to include something like this in your patch" thing.
> 
> Can people please take a look and suggest whether it should be a
> standalone patch, or just fold it into this patch, "mm/vmscan: Fix
> legacy memcg reclaim deadlock against filesystem freeze"?

standalone patch. And quite honestly I am not convinced we need this.
Let's see what other memcg maintainers think but I would keep the global
thing as this is a global situation.

-- 
Michal Hocko
SUSE Labs
