Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793633499;
	b=F3nneGeGCGucbbzxel1DxhoXo8j/DjJYKWshU/nGN6Ruj3hjQPEo+DjZAasyWHzseBxT
	 bMWc57JzuyTwP6SZQwwuV0Ai/9FFmwzCLrEACm8MEhIAkjDHtXRiXd9PNY+HJM1uGN1Vq
	 z/t1K3ZVHBgjINf3TW3GtgBu7IeymxYzMnWi8SO7DaJW+tis2lpuMdGlILhY+LqcO3HT/
	 lTG42ZeaIYbV2HI1AeH754YRi1gX1yIPokpP3qV64vliQHnTMT7YMmvVJrabWPX1fir7T
	 qNhvDgsmRQ6G+8yi+DyQDeQ6wHRHXdY/879+Nd4JYfEjo0/hRkeLm9KlmiRyA+nLvRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TeCP4ZpYTq9SpZp3YEhJ5WlDwv4/mZ+EDEcMFOS7pT8=;
	b=eB60/7br1KnlE79UhTwi7OdMHIjT7/bPAIKAPW68HMGrgqPcjGwGi3Nba8JxTH3z9+L+
	 TdcrTUHlxKAnsTmNC9TV0MpOCmW7CZ80IgSNc6xwzLWsRX9gCnCSkT7pfnwrqD9S9aqyO
	 iUXsv0BG5tDo+Tp1NjzxEtOytNVpuI9/itue4FUphoMqEWPdjzmJcTt4BvlKlmOhdWYZK
	 MgAbYU19YOefzjRBmG4mbg0EMgHzTwiXX6Kww3iSsNf+UnCqaLLmuOSCq2VfSBA7mj7Gy
	 WS064i/f0yRwaakYXM76JJsTMf2yrMJycoFDOlVn/GM6UdLZ2MyTQBFbSMJIOXCPpjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JzE5DHuT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E504607221F
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 15:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E504607221F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JzE5DHuT
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-533202fe429so515861cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 07:31:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793633498; cv=none;
        d=google.com; s=arc-20260327;
        b=hb1qZGEoTUsWfCa3cwgNxTa0XswNIGSdRMNPA6gaLKn6rcfYMGjm1CWNKo3Yx6icKb
         Yd4NQKgMySmaStqXax40npa8pBEAU+CYNaay896KVxCfbB0Ioj4mhH6XCPT8hqHqIxGi
         0QsGWSnJToVHWFnjBht78NG/HhRPIV6Os6jqPKjhbRwtqpnhO1JhMlzEceP2pR+e05Cu
         ++AOxJn6feBQ4VPRb//1/DjifbK+RDbY4Yu7PiOf8gcx3zxrf1FlAwB6D3S/k5HRkx/H
         0r8LShUSyeNM4sQlwv3StMHEOUsSjBw6ULRWKm8enARvTvELYubrn5pzL/gpQ0th5vPe
         9jbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TeCP4ZpYTq9SpZp3YEhJ5WlDwv4/mZ+EDEcMFOS7pT8=;
        fh=LQ1E9Xl4L40mxsAb2hJz2NptPUmzGNK9Q3aNHruvwrk=;
        b=MUUzYqeNTOjpP1K6qky/EkqKHVaQ5Y4q/w17usstlRgH+296rKB07jr/8XFDaRmOrH
         vudUiNtWAB/MCQsd1t5woig2eLW7M8Wu/ZJp4WWmLhH+QN+1D6A+xdY7NyqTu6eeq/Dg
         tPxO5JBwdcaYPbpGSuhxi/Q3dLJtiJv35gtuk0l6BePUAaIfIEjrSnc0UYfApOuuagaB
         mVLucrglFtduL8orDefjRZB3sYb+iBBVealSuEe6Ef8F8qHxcHeVIyEGXbltp204hdwJ
         RIZd0txAFloTAng/FVEo+D8Mf/cMBc9EXBAYhykNhPKN7Foby1lb2Mggjo/IHBResgOJ
         DOYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633498; x=1794238298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TeCP4ZpYTq9SpZp3YEhJ5WlDwv4/mZ+EDEcMFOS7pT8=;
        b=JzE5DHuT5aaq22JXaK1iUqMuzYfAzGdmYBwWBh6J7gvE08Qvbo6Un7yrOaupbCyHSt
         I6fPKC+93UXcSHPPMQmZp5sbVfe8IhtZ21qujbFBGn1tVWc99641ki+KATmNiht89sSB
         bbQXCalC7axyCIseaVwJ6r7303sSBcKDrLkrJW5EAiDkMeKMtwbI+mg1pjQFgqRI9Phz
         VEj3wMJ+t+4YAl7qiRybJ/3KVNmqFpYf4TidS/u1HAch403zmsn2xOmwM0ZCYKxSgARi
         ayDwMFWPfNzHSpZ592ls1cVqzjcNUSgr5lOuqwY6jOkd8D5YQDyWmgJaj3j1KhfTs9/Q
         jguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633498; x=1794238298;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TeCP4ZpYTq9SpZp3YEhJ5WlDwv4/mZ+EDEcMFOS7pT8=;
        b=qv/S0J6U+yVkYw4AdtAFRSTwwAaATbXHXV0kVhdN4CikpcIZkIi4pNmQOvtPlZG8BE
         W/AmWrxxv/tJgog7VBWl76r3z87+9LQiJEhHW2BgEzKMOhXDCwsUff36YQy1jOmhVJfb
         zFCX89JSm24BVuO/xPogQ6NE9JqJTioOWSu/suCvP/CN1oIw3WLDCVNjQhY7eWcMPaFl
         OH2AZkkCOkCiEwySUTNMy/FCUJ4FdG0kI8Zr/A7uSSPIGY/ZW/+YQ0p+TLfBQb4es9hq
         a+Qd5nPnaryhXLhtnG/Z5cFgKMuhDu30RdlUBzT4E4vnx4HvljMPylTjlcYI31tmPCHE
         /jAg==
X-Forwarded-Encrypted: i=1; AKwUvBzZJyJG/wd9il+ouEsBSH5/qIqewdnW5QYnO7TjA4oMTwnllPbReGOwkpgAaGQCj6K9+TOmtXqqNI72KVvi@vger.kernel.org
X-Gm-Message-State: APuU4Z8jPb53J8rgimE03IRS1319crRHGzQMC2Q7STkzOcac/mP81gAF
	4MfP58fo89YG7ytXjgZtjNpdzGkXYatSAiuux7BKRJEZnP2BeFPNGeTM0l+sbDRs/yyyxYJ5arA
	UbytEPmGYzM1FuH1ZsAvol3GbyeG65cd7pC75tiSR
X-Gm-Gg: AYBFou3qlPANPCc/tgWsS4fvbmnkF0AMm7/U95Yw/QGQxPlKUBSHo7dLBHFHdAGVjlj
	PGxq8cFFf8cTsWMrpWrJenl1Y/Mfl/i6mohCQ280aoIFuMv6vgMbW4weOq0UXw0yfM+iECi1GSj
	2KXMD5YHYEhMFX8xedgHzj7BQ2vb/HU8qGrikHJyNFzLmKa/8iQZ3QotTtI5/S9a++7PhJ3mlwc
	LkXGTnhadwlKV/OC8ATYSvKyQ3RAGN6DN78N8wDIn3V7fecBA/BIhQUoLSzwAvY4XUhUiy2fsI9
	EIXVzCvTdQRjMjtxrlEE767lBDYToEg1GIpsrC3m95cAtLT5I7zbP1gmoMNMTwwf8fLNHD0noxL
	YVt1zfWoyiUdK12JKkMvCv5/r2hmrPPrQmlr0D8fYRHjjh/V8MHKEShg8
X-Received: by 2002:a05:622a:4886:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-54125fa7a8dmr88444051cf.0.1793633497692; Mon, 02 Nov 2026
 07:31:37 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101154503.3203036-1-surenb@google.com> <20261101110100.90796bf33ef50307a7698dca@linux-foundation.org>
 <auiKq8zbQTMyY2tG@pedro-suse.tail5790ac.ts.net>
In-Reply-To: <auiKq8zbQTMyY2tG@pedro-suse.tail5790ac.ts.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 2 Nov 2026 07:31:24 -0800
X-Gm-Features: AclHuK9TnI7YVwGqKzYt9UR1HPgu0Gc7xrmAN4U7UIU0R4mvvXL1rE30jKEZSis
Message-ID: <CAJuCfpEcpYxEcje_f17bZ08ngMsDxtDUqNr9p5W+V_PRWOE6-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, ljs@kernel.org, 
	jannh@google.com, liam@infradead.org, willy@infradead.org, paulmck@kernel.org, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 5:08=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wro=
te:
>
> On Sun, Nov 01, 2026 at 11:01:00AM -0800, Andrew Morton wrote:
> > On Sun,  1 Nov 2026 07:45:03 -0800 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > Pss metrics can be affected by map count even if VMA tree stays uncha=
nged,
> > > therefore tests checking VMA tree integrity can't use them. Use Rss i=
nstead
> > > and pre-populate the VMAs so that Rss changes if a VMA gets skipped o=
r
> > > double-counted.
> > >
> > > To ensure all test VMAs are populated with anonymous pages, remain
> > > mergeable across VMA operations, and do not have their Rss changed by
> > > memory reclaim:
> > > - Toggle PROT_EXEC instead of PROT_WRITE between adjacent test VMAs s=
o
> > >   all test VMAs remain writable and MAP_POPULATE faults in anonymous =
pages
> > >   (rather than the shared zero page, which is not accounted in Rss).
> > > - Use mprotect() instead of mmap(..., MAP_FIXED) in split_vma() and
> > >   merge_vma() so the first page of the split VMA stays resident.
> > >   mprotect(..., PROT_NONE) splits the VMA without unmapping the first=
 page
> > >   (pte_present() remains true for PAGE_NONE PTEs), and
> > >   mprotect(..., self->mod_info->prot) merges it back. Both parts of t=
he
> > >   split VMA retain their non-zero Rss.
> > > - Lock all present pages in the child with mlockall(MCL_CURRENT |
> > >   MCL_FUTURE | MCL_ONFAULT) so memory pressure cannot reclaim pages a=
nd
> > >   alter Rss during the test.
> > > - In remap_vma(), unlock next_addr before mremap(..., MREMAP_DONTUNMA=
P)
> > >   so next_addr is not split, use mmap(..., MAP_FIXED) in patch_vma() =
to
> > >   merge the middle VMA back into addr, and exclude smaps_rollup tests
> > >   from test_maps_tearing_from_remap since remapping moves and unmaps =
the
> > >   page from next_addr.
> >
> > Thanks.  This is proving tricky.
> >
> > My evolving reviewbot still isn't happy:
> >
> > : This fixes the v1 RSS issues, but two things remain.
> > :
> > : Alternating PROT_EXEC breaks with READ_IMPLIES_EXEC: both mappings
>
> This is nonsense btw. Not sure we'll ever support random personality()
> flags being set on selftests.

Yeah, handling different personality() cases on a selftest sounds like
a stretch. Is this case realistic and do we need to handle it?

>
> --
> Pedro
