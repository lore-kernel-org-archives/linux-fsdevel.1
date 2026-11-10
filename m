Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319109;
	b=i6gjOMvyl/Gm9ezhHuZptti+sPLdBhvvhmcljyvz+kgxe1GJABe49FUgn9XiAHuRA8QV
	 7FrYZcQ+Tr8cbaGRO4KeMFRDsxAJnJuEH8cjscpBlU2UoC8ZH7Eomsmoyo5OajywJhjkG
	 LKR5yCoSmpZfY0nFHzuTHJ919Xo+wC9+FlXhORADdZsJyWaAz+bZNSLF5sEuEm3ixo3d6
	 +p8CNnQGeBxgQVQkCLAMunGnofnbOHQXRnEq3/hNlyz0yveob5OhEEVOiT+bndFvUFWBg
	 bfakX1674/oCkmql40jHIeDEpyMa8Ot+ABAtLMWnhNEmqpQRG2dzjo1UCa6JnjTQTHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319109;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=orVp3ApNNefs+rNNkVjfyAq6zPjWdcnnxM9afsnR6Aw=;
	b=ZuZsYsPhlBi2emObRThVlm78S6KoKUaMTGkZhbbczcUaGlpBZlgyvWTdN1qjJ9pkwXnq
	 3t+a0+BKG9T/HEM4WLbtmysyT0W71Z6MDZBiFoD+U11FerlGU6t4JI60eKq0gP73YYhzY
	 LudjNxd0uqxXPxz58XyrRHc+SFvGG9RROB2x9rP6M2RzhieHtr99kfRGcQVasKz0yiItV
	 LzOvNNxE+A9yYkUgnPCmArX4KuZGlTLWxf0Pc3eAJ6OOGcMvaRltDZ0LN715JXXeE+9qR
	 KDdQ87Hy1I2YDXoqYDoW1gPnt4L+63se8zH4v9XvtPQzWTxX6Aw4cabSAzTD2yH1KPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AA1vinJI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613E606A321;
	Tue, 10 Nov 2026 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AA1vinJI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A381F00901;
	Tue, 10 Nov 2026 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319109;
	bh=orVp3ApNNefs+rNNkVjfyAq6zPjWdcnnxM9afsnR6Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AA1vinJIhvA/xD1ksnQDVsNbJR0/awVLE6PgYIUd8vQ7vR/oalJ2OIH+fmabHu72b
	 OiTMjEKVxBWJvoU3jNTOFlETxe+OGUA2+aTEQITv2VR7ewDjOxFKCaKAwL0ucuKKkC
	 08PdPzlGPM5YWQbojOAccf/WXkzKqhuxJ5k0BZ++oEUpSOdS+C+SoMzHotjwrdn/4J
	 0dwpLnzAWICuZ4z6FXnOxvEENn1NuBHn2FBX0g8WVqjVpS+KHphJFX5ohApspeSju4
	 7cvgEemo9Sa2SjmzeA/Ed6RmmPgzIukLLLKbUJIFvoIltXDXxmMeeiVxxmg/C1AnTz
	 ZpKglsvUfFQHg==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.ams.internal (Postfix) with ESMTP id ACD30198004A;
	Tue, 10 Nov 2026 08:58:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 10 Nov 2026 08:58:23 -0500
X-ME-Sender: <xms:-CLzagBeJARgeMLf_AG1ZJxLWV7pXJvKtEujKAeHF-qU0ZgZahvXDQ>
    <xme:-CLzasUmXYyQI_4Kzu2urBoZSwhgaeUxAuYaxeZeMTPEPzj40JN7OENU70Yv1QZ9E
    8eVRBGU7vognCqG-HCvaxvKp1snVIVpumK5-aRpazwewn8rv2HvP7Qj>
X-ME-Received: <xmr:-CLzanS21aqSr3PrUHjqcZmw9HJRdMvrLz4f2ydWzqiPf8k28qSVd-UB7KU>
X-ME-Proxy-Cause: dmFkZTFIrSr6WV+Dg7Z+NBxEpMfqoBwddCoGa3uKS9U+WaQ7VCSq3x3/qhdKUI4sicrwe5
    XsU3w+Onhv/HvxlEPQ6YXBYZGU/VhK6rUbihfync9gvp/4ShlTVe0p1/zW8qoCPx3SKgGD
    GO7S+eklzUpLBJRzZgMK34ExeR4OFEJyH2Lkiu8SUiXGft0HwZTGZqyjjpAOwIry/UgW/2
    X2vosI4M9da4dCEEWVXBJisH+CEcZ6UbkZ6D6YgwHV11U1sou1O4FLAgEGApThR6gYJeq+
    Q0RFnb+VFAKg4YMYrUPBpHEjPv+s3c4+bUEHZ3TGaeNYtoabjfi6jx6GFodIz3c+75K3lE
    qb1lJ9VNKgt7KG2ZKMcaRendvZQArzUkKJwKZCR4BLncfR3dL80bH4DLJ92/qSIR78Wwm4
    81Eerg8K/GV30+Iwpf3SgqqkzY21VRAqvxZOa+Q3mLfpfV8am3whC4LiHxE9LZVUGhO/21
    sXQvl5MzPGXZByiEkjADH9y2y/qD/16/IsNVqlfmn0uNJYXFdDONwmbGY4xKumRGqAsXLO
    qC9OAoAqPTQsWg2oRkklIsJtBmWyJ8bGO418N9R9e4aDkTSGyh2lXYNmYckvFaVtdEhGgS
    BlE93cQTmCq+9u0F0PrUzsjQmARFZPyvxRqzL3gWYEiJsFfCIEb1mBbqw3Mg
X-ME-Proxy: <xmx:-CLzahvzYDYfEADC-hvobgDBBptNxmlVWngJHh_7jWtk03nRkGUF5w>
    <xmx:-CLzahOUnXioD5TC7srSG1JGTFybjRskA9JMVZlQgHkqrwLx2yrJ-Q>
    <xmx:-CLzasR3drxSIli0gLY1vjsUTqHZnEirlNgoen0lRMtjEsO-AxnXXw>
    <xmx:-CLzama6nXk8Sqakzv-yXPCIdkodjMzoRRZNqQfvLzq2NMHrC3EPjw>
    <xmx:-CLzaq0r-Kg2fOCTwo5Xh0Dzxhtg0iMd4lJqiwyRQcdljsiHnTAUtDnM>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 08:58:14 -0500 (EST)
Date: Tue, 10 Nov 2026 13:58:13 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, 
	Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Harry Yoo <harry@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, "Liam R. Howlett" <liam@infradead.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Ilya Gladyshev <ilya.gladyshev@linux.dev>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 03/18] fuse: don't move a folio with PG_rcu_free
 into a fuse file
Message-ID: <avMi1E8a7uepqMW9@thinkstation>
References: <20261104130118.2507513-1-kas@kernel.org>
 <20261104130118.2507513-4-kas@kernel.org>
 <f21433af-afc6-4a8f-8d2d-3a377cd3bd6e@kernel.org>
 <CAHk-=whn=xc9J3qApHWRGTaBpwVRtGbvJ0LURGF=dqC9B3swUw@mail.gmail.com>
 <CAHk-=whhp=Q8qR+wPoM9+mxYPQ_OXMOEoKmT7J0JZikFZusuqw@mail.gmail.com>
 <befbf3e1-d25d-42fc-86df-e4b695b017a2@kernel.org>
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
In-Reply-To: <befbf3e1-d25d-42fc-86df-e4b695b017a2@kernel.org>

On Mon, Nov 09, 2026 at 06:48:39PM +0100, David Hildenbrand (Arm) wrote:
> On 11/9/26 17:35, Linus Torvalds wrote:
> > On Mon, 9 Nov 2026 at 08:28, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> On Mon, 9 Nov 2026 at 06:46, David Hildenbrand (Arm) <david@kernel.org> wrote:
> >>>
> >>> Could we get rid of fuse_try_move_folio() entirely?
> >>
> >> Please. That would be great.
> > 
> > .. and in a similar vein, we should get rid of splice doing the same entirely.
> > 
> > Kirly's patch to just remove page_cache_pipe_buf_try_steal() entirely
> > (ok, it was originally mine, but Kiryl took ownership of that series:
> > "Tag, you're it") is worth doing, but I think worth doubling down on.
> > I think we sh ould just get rid of 'try_steal' entirely. I don't think
> > anybody really uses it. I think it exists in fuse and in the virtio
> > console, and neither is worth it.
> > 
> > Removing pipe_buf_try_steal() would basically remove all of
> > fuse_try_move_folio().
> > 
> > Conversely, removing fuse_try_move_folio() would make
> > pipe_buf_try_steal() even less useful than it is now.
> > 
> > Just remove them both. Good riddance.
> 
> Yes, that would be very nice.

Agreed.  I will post a separate series that removes ->try_steal and its
users (fuse_try_move_folio(), virtio_console's pipe_to_sg()), with
SPLICE_F_MOVE, SPLICE_F_GIFT and FUSE_SPLICE_MOVE left as no-ops, and
drop patches 2-3 from this series on top of it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
