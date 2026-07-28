Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787A3191CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253715; cv=pass; b=pan2fgd0WnbfZPFfkMc0VQ/IpQB65DJJz0UmQhzSY0VyEkUhKvL+fwHr78qHsThJGlWqOksEZS3F9fxUkn5WsyA+nqOt/AmRgbKysfrbro8CisVc/GHIxAy06o7eMFC+M8Wnhyt6iRlkxHPWGJzYiHzEqMIu8ocq66CrARGl+NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253715; c=relaxed/simple;
	bh=6ekmMqEiqA8LTebT7W3nKgWOoJTnvec9dUtjjF95pMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isXUeChYMwGX1kH2i8H3Of2mubFOpa5HT+F8/ySY2SmVZiDqw/nYdtCI32YL7anwvJ/eZNnGjwPFUAt58Z6+4Q/yjCPQQ0O6Db95K5+w52TaQZLNGlezuc8VfNaSJVZ/YwFId1Tjh6/goz9p+h0ZOGd9C3ulUGNnXg6eyQz1YA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJ4pQ8j0; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ4pQ8j0"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f7854678cso16322f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 08:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785253712; cv=none;
        d=google.com; s=arc-20260327;
        b=VQe9qckFZ/Vsyfb+uYd1ekaRuMB2ARXwVgoNTzzv5Cw6dZPQW6ScdVOiHj4lPNZzZo
         NPFhbdeZ3n+IxmlblOft4dsLRD/98ViEt2lxjwHTLNcEb9Y3W3sC8owqZSwnE/1Dx8+U
         Ms56RZmzrYZATbk0di8sb3YsYchnZtdCwqJ7kvo8pOqVqXEMb/0QU2HJZqTY/xHNixVi
         OC3j64H/YdioU0rFleQgz60MyTq69A+xHiokUBSDqLE24H8qc+9zYWdkH7p58GqCWi6Q
         z/EBeF9f925brKR30fF32LMtmaChHiLAik4R8nxt133WnGG1EHot/ICCG+wnjZg7nbYG
         U0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ekmMqEiqA8LTebT7W3nKgWOoJTnvec9dUtjjF95pMs=;
        fh=eDyjaTvN7S+9tvc7g2WknUl8t6dnLY/hab8nm6Ca/cE=;
        b=lda6zee7pBUo/cvySzIAFd030FCHi8mozFdVZSth5unySGBnUatAWBaJ1NetP6w2X+
         QLfkmlD048aluQRwxYQsVU2DuocTR7dLHJ0aM6J8aVUhScsRXEogXyMUEj9qsyVOjc5S
         uGIxe9yqMZYipKObdrGRbKzZwJ65DozLRupPNnt7Ax3g93S7CDF0sD7ONYp0HysgeEpa
         HTlMYDCAHtVr4OD5MA5Y/OXHE7YRA7Ba457mUZmECquAtKAOtpq/3M44ebRgfGJsug+9
         F0FCLyBdF97DVzTr5nK4l1dyTqjODDuwT+6px5SA+OrK2QvLwJOxdrdYsQ6AGQ5eFzyi
         1qJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253712; x=1785858512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ekmMqEiqA8LTebT7W3nKgWOoJTnvec9dUtjjF95pMs=;
        b=GJ4pQ8j0PpHVnxQxer23CYV49mAAABrjYLhjgRYfGGN7vcNW/4dKbmXbEuTAACF/mP
         3yHl+Na56iyY8vNR2A28lYpCnp4VuDjdbnbnavth2sIbvb/trrKAlNwPmozsAnKAyHzD
         Uv0KkeEZVPRRfMDaAbcq8XyaqzOeVrCEfqr81fJebo4kEm9TtbFXTcirGyun9jhaI8Nj
         X7Aga6CdzyH36Jq4fY9MZfgRlXyIQAH6iuTz2lPbx1FDVGhzYn8E34gibvwEITvNDWTK
         0UzxZJGDbPNm+WogNDkh17a17U2JUSzd2/inAB8x4/5HFqezdgJ4KcaznvqDCbCbdafB
         c0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253712; x=1785858512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ekmMqEiqA8LTebT7W3nKgWOoJTnvec9dUtjjF95pMs=;
        b=AK0WXB8ZjG1PwaqicmfQ6axh5f7t1YQMXIMgG5pAwwnUboSMlSUh/orbLk9vQKF/Kj
         oKRS/NKOmOPWoOW+7xRYZF5E5D6i9vGhXo/wtK6+fvQ2isPBoyh1UDL34OxjRYhqVIOk
         TsD3HfaMK/k0w0tzfqc/lgj/sK1pRuO3ZUvAYWVQLhJFyXtKYe87JD6PhnMRUuZz+W0Q
         RvskQFs2APXWFau1tp3IqYDYwG3MkN/0t8PLMyF9JKKsI4jNCS0MOV+/VQGAxBZqXjAB
         crQKZz1Y8OfY3gaZ5tYnOBBx3TNpXSFpBYGSIAWOc+xYSg+bcYg6vbtcVABy/sRXHwF3
         07IQ==
X-Forwarded-Encrypted: i=1; AHgh+RowXI02jYHWcYHTjFLHC4aD9rFjDNZuNQoBdCVr/pz5ErTDPqrIiAlor7SAO8X+Vrfa4IPDV+b0Cwp9WqR2@vger.kernel.org
X-Gm-Message-State: AOJu0YzRR36i/Dw1ztiFSzv0tIPZs3Od4zgMqVI+i+gayL3A39rWATlU
	mFEsYnWa88qSsWULo1pj0Dz1uxq8008pFTbziNo9NFC5AGnRAgPTJ0Xyy9BLs5Ie09L6f68K4jw
	ZRkPIXnEqoeJmSgERi0JSqFaHKHuG3NU=
X-Gm-Gg: AR+sD11JK/BlmbQtU9A5cGoT3yvt6qn2TEQdA1/yUEJ/AUy06F9tq+Ea0zhLso3sBmU
	LsA4wlYtM8Hgq+a5cdWQtOPssZkO4loOt7e68/g41CpPO2smY8lnB+j48cJieng8vswY1dAz+1i
	O3LH5UZSjScvWBclRJiQCUkCqZK9szvEDIQ2Y5P/bi/hYOzIMHFwFCFxEYKrQ5VkOP3UdKBfCSq
	Ch2yTqqphTJ1HGZjBKGPuna05iH1RUTPlqJ9IXwF19ci/vnEyS4W3M1zKtwp1OuODmNIxsyLCGa
	Wf5uLzq4VH8sRWrU4g==
X-Received: by 2002:a05:6000:1889:b0:475:f0d1:eb56 with SMTP id
 ffacd0b85a97d-47fb1eabd10mr3664714f8f.49.1785253711713; Tue, 28 Jul 2026
 08:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727143618.1582318-1-alex@ghiti.fr> <20260727143618.1582318-4-alex@ghiti.fr>
 <CAO9r8zNJ1cfCVgxtpqx4Db380bjZ+Z0P842eAxPXw6Mh4XBrww@mail.gmail.com> <CAEmasaXR5EmGCv3T5AzM_2908R-VjfMcObrACyVGokY2U=+i+Q@mail.gmail.com>
In-Reply-To: <CAEmasaXR5EmGCv3T5AzM_2908R-VjfMcObrACyVGokY2U=+i+Q@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 28 Jul 2026 08:48:20 -0700
X-Gm-Features: AUfX_mzh2_blL1kmUmwix39O8J8fZHoXTWgO9ySYA2Bkw_Iy6nOxbofDDKfyqbU
Message-ID: <CAKEwX=P5G=Ckafy6fm9ws3njWP_Zm_AHRKOFERScB9Pkd_KvGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
To: Alexandre Ghiti <alexghiti@meta.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kairui Song <ryncsn@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 5:58=E2=80=AFAM Alexandre Ghiti <alexghiti@meta.com=
> wrote:
>
> Hi Yosry,
>
> On Mon, Jul 27, 2026 at 7:05=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > >
> > On Mon, Jul 27, 2026 at 7:39=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr>=
 wrote:
> > >
> > > zswap writeback decompresses an entry into a fresh swap cache folio a=
nd
> > > writes it back. The folio is cold by construction, yet it is left on =
the
> > > LRU for reclaim to find and free later, wasting a reclaim scan and ke=
eping
> > > cold memory resident longer than necessary.
> > >
> > > Allocate the folio off the LRU and drop it as soon as writeback compl=
etes:
> > > mark it PG_dropbehind so the swap dropbehind path frees it once write=
back
> > > ends. Synchronous-IO devices complete writeback in this context, so t=
here
> > > the folio is dropped inline instead.
> >
> > Why does this need to be handled in zswap? Doesn't writeback from sync
> > devices still call folio_end_writeaback() and do the dropbehind
> > handling?
>
> That's an optimization rather than a real need: since we know we are
> in a sleepable context, we can safely drop the folio from the swap
> cache here. And since we don't mark the sync folios as dropbehind,
> they never enter the list handled by the dropbehind workqueue.

It's a bit artificial, but you can try testing zswap writeback to
zram? :) Likely you'll see some small tput win there?

(TBH I have not seen sync IO swap backends other than zram though so
idk what's more realistic. We don't have pmem device available for
testing etc.)
