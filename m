Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794679726;
	b=06uXk7XM/uWzvUYvUM158HgBAzeUPcO3bgow8OcSh++V7AIiZrpHcaOWcBGisCpvFKa2
	 LX8caXEDm0CIOr9n0iTivMjqoC8GX/83Ac0KUfGH/mw7llQhp7ypNmpJbTWkMmz/iN+WA
	 EouRDBGHuDU0mS2E7cC1imqjriaJ2APzaahb00irxfDMYdzMv2Z0BkJ2Gx0RUkSToyYZR
	 tiuVwzlU2b9ZF61KOHD6NQbPO4ApAImc13Zztev7htGO9oieoaemeO05WQxbWEWfipyTC
	 KkrBNnlqgs+WBYegaBrv5pE2B9xbijjIYFXRiTErvYMn6/09YnrhxaTYgfJj9J0mKhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RvhLrxGhqHACKbn99b5AMFC48BGMEpVYG0nynwtl6E4=;
	b=h89qXJsmxuamvxgczyRtstUY56vbmGCOw9rucJhDRGk5T/t9TEPtxtNLkFEy5XJ57+9G
	 7bUJ4EkS12f8R53rI54ZQSRgXQfM4q2Q63Yg4PIGZfpn+c+AtQyJ+MutOqNN0i34rUrcb
	 9jl/B3mkGp2kn+aRurWfjDPMNDQnsiP+73pCuf7dHDdJyeTAtsTVxS2ZuR+xuGIUSvQ88
	 2Am77rj0VX8//VVQBE1lHU4926CbJ7PLroEfDZgs9M4vpb9xK1b8lhuZwNg92E8kR0g5y
	 1YMDlEos1ij9QJUSadD8XQIb0M/gN0cOl/6nkHphCvn2JhTDFoKyMlltHsgw+ob8aog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCe6MTmG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F21606A330
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 18:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7F21606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCe6MTmG
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so25173095e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 10:08:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794679724; cv=none;
        d=google.com; s=arc-20260327;
        b=AqmksmMpp4jwmzbtA0zca4TTN49c3v2i8UnpCELjYFKBgLd0oXHCzD6oseHTX8uXCg
         v+2HP0K2ZBqJSwSNcnRPE5BH4Ehu/exQHLIyaceTcEehKWepXxW8h2Ew6ux7Jb3ZHL8/
         4bDEGxdelVDwR6svoL99kFCri45YPIISmQmmX+fJIghrCCyCEndLrXASWbDuxaP9bwE7
         zt07LmQEb9ZmUodCC25ZgKn5MLztP3wpDCNpFC+TGEwa3rDwZFVRvYV0WlzNwW2ggykw
         0Hh2QwWxy1F9qz5Yl1DTZsAmcjvuPNl6uvtzHjY9Ty5McahcRyT2B5mO9/ToDW14+cUr
         j7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RvhLrxGhqHACKbn99b5AMFC48BGMEpVYG0nynwtl6E4=;
        fh=qJVO6s3zzP/xpqFDok3vUhMTbfsomgHhorq1y00NrCQ=;
        b=G9YW8GZVv4j+mGgsOM75+TMFUfeBcTamnG+KzG2hPoTRRDohFQzLDidFdIb5DEC13D
         e3Zbyi1FscnoIjtbiDRVi4AkKACrEWp0LPcQtZzBWV0FASuabKDwbZNwohbLkEpHKA3a
         TXFBqjhG42hw+WCfWXz3P71WcfPXykbKjbS/tpppIWkp38foMN9AuPOgkA15lsRuvaO3
         QiYKo522033ypq2H2s5R2b7+XODVcnVTStREOPaiZyYZJC/rqdDQKmpSsQNaABGgCOWr
         4k9NkCdtBZGrw3t3sp8rK+B1GBVxbUrMchq0VXzwx+w8+4kzGrJDXN8YW4w58jjDQJh8
         kfhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794679724; x=1795284524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RvhLrxGhqHACKbn99b5AMFC48BGMEpVYG0nynwtl6E4=;
        b=sCe6MTmG/PTU3oGU7M4EUL95RcZHJUHhAI09lpNccVD9WepyZRp2NA5N5pUSigg/Oz
         cUKixAqonUznmhINZjcuYomHOdycftKzYvGh/71hxyd6qvDnJtBsdtu4bBOPjZu6FpHm
         YnGNBQMSyiMlmgK6h2f0Q5mT68XBdI0yis2GwkoRk+D6gFcDbYohb+T7Q5+jisM43arB
         0JKwbEHXqGwHw8R479k9LIoymNiRVjl4vt7tBby245/HoZyaY8K50PpVzuM56Jgc0Bt6
         S6Xy6VuRYI9TkO4+JNV7fbRbJ3w+qEW1QFE+9hxX6TCzf0pjo9rgmlDPQvHB04dq2Kvk
         kMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794679724; x=1795284524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RvhLrxGhqHACKbn99b5AMFC48BGMEpVYG0nynwtl6E4=;
        b=WFvaIZ2BbtDT/Y49p5aw6/TcVgqtQgi3HYxrpuqHi2I9mGt0V13wPEpPHdD8E+lfZl
         fbe40aRhFy2xyma6OonIn1VydMRDZJELk2eBAMrrdUJDquewTYT6YOAYNiVpiiXRcl8W
         8ZVKwXhh2AvGTQskpCJAfcID1nPSCf5MGJgY4ZEtyoytfERy4rZDaL/owymb5+PexRjj
         QL4Ju8QMvhvM2rjrbZ2DI2+hbrPLnG4phd28fNGwlS1jWiXyQ4EZ3nNoyjrnr3pQQaks
         f0OrQ4pguVYL17Jgb06ISjglnKQRkE7ktuVkWV1LZ3zbkS+01k47FzsODR9lgCum3mOK
         DWYg==
X-Forwarded-Encrypted: i=1; AL+hErEDwgzEToH6xaRhnQY/t3SH9uokf5fwXvCiguQin6Ucw9qbLiJiswEBzrbLFtniNQNsYpAanY3GJjEnu9+T@vger.kernel.org
X-Gm-Message-State: APuU4Z+R+x0bshzIs1P0dRswhBsVbB66BfRInkzgkmbH3LkgH11mwVbu
	LcjRUCTm9jIf8hN5Fcv7/eIQulI4EZDYHwYOnJiSIIJG7auM0a0xp7Y8TOj2XAfM09nWIztSPuh
	NKQPgzv/7Ps59IKTfO5/rtsKLGfq5M14=
X-Gm-Gg: AYBFou2UGp/BBCZN0bEtB05pTrFz12wshea/95+6gD7imR146/zXnWCIHkZlSmRTIA1
	DgOjWwUAlk14QMGYrJKqL5DZBlOx5lToBe1SPE+gH3veC2NFLaC6GaL6BjPV/LM7UCHko/Ha5mw
	zPeGIxjLuBydFxhXiFKEpY8TNOnNDzs1JD7/oeWxT80K/LwHZXn6dvMsJwFhdtGLOYIQI+GPMND
	QSW/XW5+XrJOE96S5UwkuIHMFolgyAVDMi+tAGBoshFYpWthHUyicewCMiIrH6u30rjiyWuax+s
	pKz05Ge/QAzTOpZyy+wq7Cu4wLF3gE29+xK8Jezl4pKNkB7xnlGj9n7c7r9OVTRgMFUlN0GWcyq
	CzSNecOdGoXf3AipF6CSzIFKWzvLF6ikVtHwE21KtCjJCol53SO+pw/j2kqHPq+tM8FefXdl8ub
	3vqlyHJwHxq/Upm23A+GQ4+F+SDVDre8Sjsqqyn3pNxyLo0SOzvgjf
X-Received: by 2002:a05:600c:b99:b0:4a8:cb23:f71b with SMTP id
 5b1f17b1804b1-4bb55a92e7fmr127107305e9.18.1794679723922; Sat, 14 Nov 2026
 10:08:43 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org> <20261113-mason-migrate-et-al-fixes-v2-3-50a2ed382b61@kernel.org>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-3-50a2ed382b61@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 14 Nov 2026 11:08:32 -0700
X-Gm-Features: AclHuK_ELRI1TE67xJqn6AwyBkxgPS__XUAV3eZlpMOL_-YZzAJWxxy4oUoG69c
Message-ID: <CAKEwX=MmKuFwXpH5f8MtfJteqgs_O+xMUCNkNK4hxuAMpFUuVg@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] mm: cachestat: restart the walk after each entry
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, 
	Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:46=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> From: Chris Mason <mason@kernel.org>
>
> cachestat() can leave cached pages out of its counts. This happens if
> the entry that the call has just counted is replaced by a larger folio
> that starts in the same XArray slot.
>
> The issue is that filemap_cachestat() walks the page cache under the RCU
> read lock, so racing concurrent collapse/split is possible.
>
> Thus, an entry can be replaced immediately after the walk has returned
> it. When that happens, the next xas_find() skips the sibling entries that
> point to the slot of that entry, since ordinarily they belong to that
> entry.
>
> However a concurrent collapse_file() or __filemap_add_folio() (when
> replacing a shadow entry) can store a larger folio in the slot, in which
> case the sibling entries belong to the new folio and the walk still skips
> them.
>
> Consider:
>
>     cachestat                         collapse
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D                         =3D=3D=3D=3D=3D=
=3D=3D=3D
>     count a 64-page folio in slot 8
>                                       store a 512-page folio in slot 8,
>                                       with sibling entries in slots 9-15
>     xas_find() starts at slot 8
>     and skips slots 9-15
>       /* 448 pages are never counted */
>
> Also consider:
>
>     filemap_cachestat()                  __filemap_add_folio()
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =
      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     counts the shadow entry in slot 0
>                                          slot 0: a folio of 32 pages
>                                          slots 1-31: siblings of slot 0
>     xas_find() skips slots 1-31
>       /* 31 pages are never counted */
>
> Essentially the fact that large folios might be present means we cannot
> safely continue the XArray walk, and must reset the iterator each time.
>
> Fix this by resetting the walk in each loop. This incurs a performance
> penalty, but given that only the RCU lock is held here, it can't be
> avoided.
>
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: squashed 2 commits, fixed up comment in code, and commit message ]
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Nhat Pham <nphamcs@gmail.com>
