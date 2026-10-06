Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF23E1201
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295307; cv=pass; b=sYVDceUj9EQLgeZrEyjNOUGfmFC5HIpxoQrn92vkA31HDi6l2WK+Im5dYqfqjQtNmS1eqZ5qOCXVvGY7LqH/s9ukAZEv2jzIi43AlZjfXucr3cPypM4xeRIuEl4DxgPujxhLXyStO0wvJJOxAleJO0qDsYv9Nlwyn5/p8xsUdwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295307; c=relaxed/simple;
	bh=oCs0mgI297Gumxn0H28rJk//pzs+ChJtFm0kHSySLBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxY/aWy1oTcfmFYURxQsCXYj4Zdk6sV4IBCfqg3BLs4gSRcDYm1OWXLLT6r6+dBJ+09/Dmskvke1O3NuRobAvvE5421rMoojHkaFFPj8gOwXrzUbfQUZ/GNixMiqoXQYeAdw84g37qlHwDhp85xpkoFgWt0g82RiQGn3rbN5Oo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekKQN2UJ; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekKQN2UJ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8ab38a051aaso6337117b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 07:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791295304; cv=none;
        d=google.com; s=arc-20260327;
        b=s4td73U0C0OS3M2OP05+jAajJ3TMLwnm03HoRQ9w8O4CRCn7OZoqAJOEEIQjxPp+Vc
         Nw06tUl0k2O2ZRMXNujlOgfymFErGngFjtWKQcrQ/kAwXvDN23R3ckFWhBG6LZLvqWR1
         qNW4myzB8b7Sj91jm2Mc7MTN9Ay4WP+i+4OI1HXD1yTo4T5Uu9USr6IXv0vPHWLhqILu
         jCrFh/RTxdgynlJqAADAq68Ib5VPxB7BX0FLiw6jg8AmBZpna6DfT1fSAEFBLscsMox8
         ES9ODpwMfZbW/OG4PLFT3oUdV8KMH6s9vd7MEiSjDEcxBd3JSF69k515pLtGnNKOHzQ7
         iUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H80LEoa+Ed4z/bo92vNwYanr8Bxl+IJiscZmWaNEy4s=;
        fh=poMeZZ0hV4LfK+KClJ3mQtJAHxrmIp3Uf2k9TfiBMvo=;
        b=AsoPUYzmSctN0tNdfZu1/dCtEea1tdBqA9JG0VW+SgKqgVWY0Wiz80JDEC/cRvQbcO
         hOXxAN+2l6V6fp2oDUgHEr7Y0kqE1DdvoZ/64J36S+R6VWNYiyonuei+r+1gwRZuikz+
         sH+JlnkhesJ3VKAFcEtsShb5wKv+bRV+1ZXmXMb8y+WAiVFy6/8HmhYRubwwU+spoRrj
         YTGg0fRRlYjaN+aWyyp5Ar51UP8IERzwWPIkmCAw+2/enEKL2t4SwGKI8bHkWH8jNq+f
         rAzDT7/6ZFewhQb21as5C+pKhIHT0/g9rrMQCedcGSA9IgpOvtHGQetmgnQqZcoBD8A+
         FXpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791295304; x=1791900104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H80LEoa+Ed4z/bo92vNwYanr8Bxl+IJiscZmWaNEy4s=;
        b=ekKQN2UJN0CJgx2vxQzSPhDtGLdkbMsjSMC2YjZIUPuICIZo6a7+m/UF81XHA5haBi
         dK3esK0OieoizzpIUeLGxw2/ySMXdJZlspsl8bKafwDrStfkJk/MgDiAKND61ec/SyAg
         tOm4w2W+4ObKtCGPw0qGbe9X5HNgENqyCAMwjBjZm4SyKHdBDySgHovYdBT6PozafiEP
         2IFGCJF+9vSRn6iPDVusPJh6S5AJYr8B2GdJNNIWIxKSASAU5llnTRvjqXyZ67lGt9yH
         z/Wxt0yA0nT/BA6J7+bcSF7Z8bdpxQhRcLI+j/SAuFJYZ8u+2WH6s3kOc3oGm3tuMqFG
         /7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791295304; x=1791900104;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H80LEoa+Ed4z/bo92vNwYanr8Bxl+IJiscZmWaNEy4s=;
        b=k/05ZEbLUHV9RZa7mWBF1orb8iTfpvuMMcDifZsxFPy/JR7cVWuwNZXV+qgm1WCeYj
         1oL5rlZkc9qpmjd5aiTtQKJWhmYpO7+15/R2sAKpiqMy7zdF95TAovBAbeG8kK32ZBty
         OD41kgDSB3ixirED4uDtfbwaICJLFto9tGYzuYAHHms9qxGKTtMIzSKcE/DZ2n7q6w/K
         HpXOJVW5VzseFDLYYOyQlioTAzv6ggJtZ6tV+wLa9veha/k+FiPQhZYIczPsPgo75esE
         YHttgjBYNvg1E0M3tJdg5TYvZ/5E0pReS64BtQYoz786bRv7nb26JfIVywvigVL96CMP
         +DrA==
X-Forwarded-Encrypted: i=1; AKwUvBz4DutO1yHXEufH+Phx8FPNunplJvAURUDPNHaVvHZQkX8YUf3z6y4hj5Fn0kG/mUqkLpOhZbOd+qzTOVFd@vger.kernel.org
X-Gm-Message-State: AFq9FYLos2LcTSzX3FT8bGgQowK/+GWfqe+KL+5r/ldfUee86ofgboNT
	28YEhj0W8SpMQaUsTmu57xmulbJuNAqkRzelcFGbF0R7611WAS/9coe70wizndI8zk+A6ztWorf
	Mxiyg/keiCIBDxunJdOPX9WoorAp5AHQ=
X-Gm-Gg: AYBFou3j3LslXesSnAShSL5s4O0lj4vcUVaOMyptJEpbEZ+P1TKzfOdZzHlkyNUhpnl
	Ai7Eb18KbJBtnbbR+MfqbbBQZLy8orgMV3BuWx1e9MjDS2zo1GYxgtxEwueDNXwdpryz/US8OUo
	DrqKZlMEhL/m/6+WvKld4OW/4SK988xOM9v2Aanbgr928VuJZlpOXvAjZskVwPvDUvM4pcDQbi8
	PbvdUhSIwOy0hR9v6gRgltCoI6EBR2od9YOCXvV9OrsPE875Bs2fmnDJOqb3AVRFjsKfUfpSpmT
	qybHfXTUiDWZuqbyQL5hGihe1eBd4vb8k8pBEMaM7Im+rY0t9vIBhJqKwxCBxEA37+DJNPOwQud
	hfkQFJCb+tzdB0B3k0R8kVZ0DQSUbA6WUXbH9iChwg1VWx9jXzHaB
X-Received: by 2002:a05:690c:88f:b0:873:5c7b:c0f5 with SMTP id
 00721157ae682-8b04f49907fmr7810607b3.45.1791295304055; Tue, 06 Oct 2026
 07:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003001555.3498357-1-joannelkoong@gmail.com> <gz7cxhldkfkinbzpx4goa6rhdqpzldpaenzhtfoxcztpzj5avw@hkzo4fbdbck3>
In-Reply-To: <gz7cxhldkfkinbzpx4goa6rhdqpzldpaenzhtfoxcztpzj5avw@hkzo4fbdbck3>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 6 Oct 2026 16:01:28 +0200
X-Gm-Features: AclHuK_uZOogQkMdxz27vAGUCfidPFeie1EwYBw8NyEpTx7XUT6D_HjCrQZ5F8w
Message-ID: <CAJnrk1ZaYAy_81OVxZ74wF1EXF8j13giGdu_CD7Q3XLzX-XThQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mm/readahead: avoid per-folio memcg reclaim
To: Jan Kara <jack@suse.cz>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	roman.gushchin@linux.dev, willy@infradead.org, mhocko@suse.com, 
	muchun.song@linux.dev, david@kernel.org, ljs@kernel.org, vbabka@kernel.org, 
	liam@infradead.org, rppt@kernel.org, surenb@google.com, riel@surriel.com, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan!

Thanks for taking a look at this.

On Mon, Oct 5, 2026 at 2:27=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hello Joanne!
>
> On Fri 02-10-26 17:15:52, Joanne Koong wrote:
> > Readahead adds the folios in its window to the page cache one at a time=
. Each
> > folio is charged separately. When the memcg is at its limit, each one o=
f those
> > charges triggers reclaim. With many tasks faulting in the same cgroup, =
the
> > margin one reclaim pass frees gets consumed by the others, so the fault=
ing
> > tasks keep reclaiming, all to make room for speculative folios, and in =
the
> > worst case, reclaim livelocks.
> >
> > On Meta's fleet, this per-folio reclaim is a large cost. From fleet-wid=
e CPU
> > profiles at Meta:
> >
> >  - Page cache insertion (filemap_add_folio()) triggers about half of al=
l
> >    memcg limit reclaim CPU, more than anonymous faults, swap-in and
> >    memory.high combined.
> >
> >  - 93% of that comes from mmap fault readahead: filemap_fault() ->
> >    do_sync_mmap_readahead() -> page_cache_ra_unbounded() ->
> >    filemap_add_folio() -> mem_cgroup_charge() -> try_charge_memcg() ->
> >    try_to_free_mem_cgroup_pages().
> >
> >  - In filemap_add_folio(), 83% of the CPU is memcg reclaim while the pa=
ge
> >    cache insertion itself is 6%.
> >
> > Most of it comes from services whose worker cgroups run at their limit =
while
> > many threads fault in mmapped files, mostly on btrfs, which our hosts m=
ount
> > with compress-force=3Dzstd:3.
> >
> > This series adds readahead folios to the page cache without direct
> > reclaim. When the memcg is at its limit, readahead reclaims for the res=
t of
> > its window all at once instead of once per folio, and tries a second ti=
me if
> > the window runs out of room again. Please note that this only applies t=
o
> > speculative readahead folios. For the folio a fault or read actually ne=
eds to
> > read in, it is still charged with the mapping's normal gfp mask (with t=
he
> > reclaim flag set), like before.
>
> I cannot really comment on how much sense this makes from memcg POV (I'll
> defer to people understanding that area better). When I'm reading your
> problem description I'm wondering about one thing: Are the folios we are
> faulting around really used in your workloads before they get reclaimed?

I ran some traces on two production hosts and am roughly seeing:
* of the readahead folios that reclaim dropped during runs, ~66-78%
had never been mapped
* running a 60 second sample: mmap read-around accounts for ~86% of
readahead on both hosts. 77% of the folios it adds are never mapped.
Around 10-15% are faulted on directly and the rest are mapped by
fault-around. mmap_miss skipped read-around for only ~2-4% of major
faults. For faults that triggered read-around, mmap_miss was below 10
for 74%-96% of them.

This looks specific to mmap-readaround though. On these same hosts,
I'm seeing much better utilization by buffered read readaheads (only
~30% never accessed).

I think a big part of what's causing this is that btrfs by default
sets ra_pages to at least 4M (in open_ctree() in fs/btrfs/disk-io.c).
In do_sync_mmap_readahead(), I see "ra->size =3D ra->ra_pages;". So it
looks like mmap uses this same value directly for how many pages to
read-around (with 4M ra_pages, this is 1024 pages), even if the faults
are random accesses. I think this also accounts for why mmap_miss is
so low too, since with the readaround windows that large, most faults
land on pages that are already in the page cache, and each of those
minor faults count as up to 16 hits, while each major fault only adds
one miss and happens a lot less frequently. With many processes
mapping the same file, I think it makes the problem worse (eg each
process has minor faults to map it to its page tables, but there was
only 1 major fault to load it into the cache).
(Adding the btrfs list to cc. Apologies for not doing this from the
beginning. The full thread is at
https://lore.kernel.org/linux-fsdevel/20261003001555.3498357-1-joannelkoong=
@gmail.com/).

Instead of having the mmap readaround size coupled 1:1 with ra_pages,
do you think it makes sense to compute it differently? Like either
having some sort of fixed cap (readaround never bigger than
VM_READAHEAD_PAGES) or dynamically adapting the window where it starts
small and grows if/when readaround folios get used and shrinking when
they don't? I don't think this would degrade sequential mmap access
(eg async readahead would ramp the window back up to ra_pages in a few
steps once the fault hits the PG_readahead marker) and I think it
could be beneficial in general too, as less pages need to get read in
speculatively that wouldn't be used, which would also lead to less
reclaim.

> Because what I'd expect to happen in cases under heavy memory pressure is
> that ra->mmap_miss would quickly grow over the limit (100) and we'd just
> stop doing mmap readahead for the files. If the read-around pages aren't
> getting used before being evicted, then the first natural thing would be =
to
> actually stop reading them in the first place :) The mmap_miss logic is
> actually rather dumb so I wouldn't be surprised if it doesn't work in you=
r
> case...

Do you think it'd be better to have mmap_miss count pages read vs
pages used instead of counting misses and hits seen at fault time? I
think the problem we're running into here at Meta which mmap_miss is
not detecting is that there's lots of wasted pages that never reach a
fault. It also seems to overcount hits, eg a single fault can subtract
mmap_miss by up to 16 if there are nearby cached pages (which might
have been cached by buffered reads, not mmap), even if those cached
pages never actually get touched. And the same cached page can be
counted as a hit several times, once for each process that minor
faults it in. Or maybe there's some simple way to get the info from
reclaim instead? Where if reclaim is evicting a readahead page that
was never accessed, that's counted as a miss? imo that seems a lot
more accurate as a signal though that also seems a lot more invasive,
like needing a new page flag.

As I understand it, both these improvements (detangling mmap
readaround size from ra_pages and improving mmap_miss heuristics)
would be complementary to this series rather than a replacement for
the per-folio reclaim fix. Does this match your view?

>
> The experiments you have conducted below indicate that if you effectively
> disable readahead you get more page faults & smaller IO requests (expecte=
d)
> but for your realistic loads under memory pressure is that really an
> overall performance loss?

I haven't measured end-to-end performance for that on production loads
but my suspicion is that losing read-around at the memcg limit
wouldn't affect random-access workloads like these much, while it
would for sequential readers.

Thanks,
Joanne

>
>                                                                 Honza
