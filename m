Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C8377A9F
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828904; cv=pass; b=G/HXeyC/FCHX1Pfzam838x1Hw0xSSRlhH4QYcUiiPE5CuzFIj46oVJgwoL3LLuSHM0EMb87d4xnJJEGDuQEILeJqwqGeFdRhw2819iiKngf329VbkwKOv+M93iJLp+Dxtkll3tMEwaq0khdANfVNyDxWKKtcKE3PK4PMSNfpXLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828904; c=relaxed/simple;
	bh=ZhbsUmw5FAdPFmIHWyI2aiI4Es/XdKypRBYIWuAr0u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chWTPrKu2E57qBy3jNg5cdEJG9H6a6ia1m9t25HzbnX+WMNyE0//wbXNeH8H6eYAtUjXLtMdPvebGcsrWiIsAVPU5fPeR5yYIpbSr7bpREXiKVnhOOMLzyU3pwRDSB9WpGG5sEeN5br5iCqdsJ9QdVCqLWV31fEu4YynQekSjWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu5iH9hZ; arc=pass smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu5iH9hZ"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-533342a38ebso56051101cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 21:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790828902; cv=none;
        d=google.com; s=arc-20260327;
        b=W+IkHSHEWfrTqmMwSKKJ1vP2/CarNyhuEC2C4rvW7UYijsjMnWoV70/efKJLi51UTQ
         J/gmDUgwZTAbNd/Sl1cVFp4PCXPYEczFZcLBPck6x1T3aqee+C3MyeWn+fuCoO+AXYWf
         WCR0f5exZLk4r/8g23QdxiPKvupZllkZfXLJJ/rNqX8Wr5ihTSeNMZksRL5s2QgjVOcC
         4G8XF7aPTQtK8riWzzeumJQW7pzx960gf6QOLlWLq1cvwWIYholQpKmXOFoKeuvHEFF6
         kzqkhYM2xLB20JceEPIJq82SO3y4TDwXv8H3+LkU16YRHXWqWzi06/cq/877FwjxkO/A
         gGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4OULaCDmfSMFCasJeEbqNa2xN31uSNqvPEakF50eeTI=;
        fh=cS+OXWQ88djn2RRQxU76zj3te25p/Bc+ac3oL0c/jhE=;
        b=PSA86JO9oExe+f3X4NJB82QNQXzzIoDBpGcZXoWz/nt930f+RI7OIPXAVWuRnwA82Q
         qun0sGPWZmOnHFl1s7VeKOROuATdOSdZhou5SQ2jmSZfRhdGTIEVkIxNQkjOUwwRfeAQ
         szMLJMVChu/qm77JSclZtPDihAmnJ9cmy7M1HJzjFHijOqfn+VLjoy1u0X4R4Usoomkq
         fDH95yH/qyw5SAzZ2tL170yuWRJ0Oj8PUbUqDJCa7r753E+S2OgPrh0pe4m+6xcbQ4TT
         Dho7LDqrSKeqxZWb78WkCS7e0/m/F+49LndAPGOP84HcLo9nAPK8+DBdewtjIYEnqJ0h
         axaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790828902; x=1791433702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4OULaCDmfSMFCasJeEbqNa2xN31uSNqvPEakF50eeTI=;
        b=Qu5iH9hZVrigSxW1AGsFCIgVlUKTE19JDUBzOSS6STRzKBJS6N16UnediwsUsWhz7p
         8Gy4mHUYVTqT0hFXZj5/QtP7YVfyX0RkG97hD4u/EvxUrqXKwLBoOj26Tz5TknhDvz+X
         vMnYxqEGB+ZCeVkXzf8m4Aq3SR6qOyphAo4VtL3KJ3vc8fqAxlXTbnEY5IBmVpz2Vc5T
         HPS9d0pQjyGo4TpRwjpQPjn7zlLa1x/b3edBlGwJIyJ3cON6AuZPQDFCzJ3IUNdcjOfn
         a3JZ93kGI/rppoXXQ01DU/jjY48hWSAJhkRat1vP6YZILTqJSPnVmWLixWpCF24w3JE+
         1qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790828902; x=1791433702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4OULaCDmfSMFCasJeEbqNa2xN31uSNqvPEakF50eeTI=;
        b=Hxlk5Q15zEF+lAtooF2mwm+5oWWCwHi1t2fMU1i1aUgn/9kUQFCOFKTIcKYcBN2IYg
         WHQDcfYxc5/9NEtreA3uwoABDR3QyJk1Hz5K5zuofG8l+UAsd3GgI11C2JfEeUOLrf5G
         Jb/wf0eJLfVjFR3ygk9ARYGCjO9yTY5XD+fR02Lf6FBBLecF0IuWJdwsS3xEICzZwzwh
         YDqnwYNm9632h7+0vws+4hK0YzoAXO5a1i40aqIjea8+/dpdGXYP55IY3hbbci1x37mN
         p+jqy9o3UA0zk19b4axFRaEOqVkguQ4kmJQukw3Rm0+qzVQ+39/XJHM/jhXGf50QSxm/
         s3gA==
X-Forwarded-Encrypted: i=1; AKwUvByx4kaq9hXaRXkQ9+D1YUlgdzaNgFbGytTVaCkOoZ8IFe0T+tg8WShUct9x6mEBMDuZ/PZU0ExHjG+8hkhQ@vger.kernel.org
X-Gm-Message-State: AFuF++mpQpwt7YfiSirRXM0PhpPXLrEQXdDiYzEv+3fVjcgHq6LmHSp9
	sQb4Mx9Ynp0OC8VOANhZKQmoZCz01vUG2xMuOONbTMI9tXcJ6pkUmm9CHOnFqG72T3397tEv13I
	xUcgTkmvxZ9PF5PNEPGEpuPgkYYbBUuw=
X-Gm-Gg: AYBFou2FIMpea4RE3AhZ+OdqrLdDT0vjtge96oVByKBERAjyim4OMoFISiUk1RKejH6
	TNgpIJn4VcpDMp0GcUxzuNcWu05yQ5c7ps5lm7MHQvMsrWlZwQfk2Zdx++MM7jXKKouRNJXoktE
	Y0yojGef1U8iY18FEEPu32wteavy7ldd0NcXyiwmXBgfFocmgxk30dV+pCBPsZM0BWmg61ILfxD
	GdYFlJj8lqpANOzO++eaJIz2kSDq/JBHQK81TRpeVUVJrxsE/Jt9F1DyFebxuh61RIjC7n/Mfnb
	i4pBvcgHILjQjbUqGuaRWg8aZ7kVlXCAb370iIXrzkMVCL8KF5lo6VvmL4BgSxnT9K6k8Ve5tAv
	p6cquaAfL/ObezkWgTBwjw2SJGRv4JRaEFUagXg==
X-Received: by 2002:a05:622a:110a:b0:533:2120:a12b with SMTP id
 d75a77b69052e-53374f2948cmr66026171cf.60.1790828901926; Wed, 30 Sep 2026
 21:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org> <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org> <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
 <arz0auULA33fqoWu@gremlin> <arz8Plu6J4YOTi0a@gremlin> <CAAE3jtcanTUrV3xfofwrvYGCFe5o=Vn7gS66bDzuxzeGg6c5=Q@mail.gmail.com>
 <CAAE3jtdHi7aSsJ62TpEjkxvwA-3TBLvr5i1ohCNg2aupND+_XQ@mail.gmail.com> <xhrorb6wn2j2j57ydnt226khnu6gv4ut3crrmjwjr4iwj7d6yo@43lugxdthgyi>
In-Reply-To: <xhrorb6wn2j2j57ydnt226khnu6gv4ut3crrmjwjr4iwj7d6yo@43lugxdthgyi>
From: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>
Date: Thu, 1 Oct 2026 12:28:07 +0800
X-Gm-Features: AclHuK-hz19KHyF61zbpoHfI5VofTsev0rlhVKfjlD23fuWRs6UMTJBnDT2zXQM
Message-ID: <CAAE3jtexTRdqzAodzCkAy5NtH_s3VhtutXbxMjangf8BtB+-dQ@mail.gmail.com>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file mappings
To: Jan Kara <jack@suse.cz>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

The reasons for requesting this hint are:

1. With buffered I/O, the data already resides in shmem, and writing
it to the regular file allocates another set of page-cache pages. When
both copies are resident, this roughly doubles the memory occupied by
the data. Traditional LSM MemTables are usually small, so duplicating
one is relatively inexpensive (they waste so much elsewhere that they
never even reach the scale where this becomes a concern). Our
MemTables can be very large, making duplication a substantial waste of
memory that significantly undermines the advantages of our design.

2. During the MemTable-to-SST transition, existing readers still
access the data through the MemTable, while new readers access it
through the SST. We therefore cannot immediately release the shmem
copy. Our current ConvertToSST instead renames the existing file and
appends metadata. The inode remains the same, so the existing MemTable
mapping and the new SST mapping share the same page-cache pages
throughout this overlap period.

3. AIO or io_uring with direct I/O avoids allocating the destination
page cache during the write, but it does not turn the source shmem
pages into page-cache pages of the SST file. Subsequent SST mmap reads
populate a separate page cache, while existing MemTable readers still
need the shmem pages. The duplicate memory therefore remains a problem
during the overlap period.

4. Temporary files are a much broader use case. Periodic automatic
writeback is unnecessary for temporary data; writeback for memory
reclaim is what serves a practical purpose. A per-file exemption from
age-based periodic writeback would benefit these workloads as well.

The per-file hint you described would meet our needs: exempting the
inode from periodic writeback based on its dirty age. The kernel would
remain free to write it back for other reasons, and explicit
synchronization would continue to work normally.

Thanks,
Peng

Jan Kara <jack@suse.cz> =E4=BA=8E2026=E5=B9=B410=E6=9C=881=E6=97=A5=E5=91=
=A8=E5=9B=9B 00:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello!
>
> On Wed 30-09-26 23:29:09, =E5=A4=A9=E7=8B=BC wrote:
> > The distinction behind this request is between surviving a process cras=
h
> > and surviving a power failure. After a process crash, the kernel and pa=
ge
> > cache remain alive. A shared file mapping therefore retains the writes
> > already made by the process, even if they have not been written to disk=
.
> >
> > ToplingDB has file-mmap MemTables whose data structures survive a proce=
ss
> > crash. Its crash-safe recovery reuses those MemTables instead of rebuil=
ding
> > them by replaying the entire WAL. A published sequence number aligns th=
e
> > MemTable's per-KV crash-safe boundary with the database's WriteBatch
> > atomicity, so recovery can reuse the published data and replay only the
> > remaining WAL tail.
> >
> > These MemTables also support cheap, millisecond-level ConvertToSST
> > (wrap-up and sync, i.e. LSM flush). The file-mmap path renames the exis=
ting
> > file and appends metadata, preserving the data structure already built =
in
> > it. This avoids copying the contents into a separately constructed SST.
> > Moving construction into shmem would add a transfer to the regular file
> > that this path currently avoids.
>
> So I think I understand your design and the issues you're facing. After a=
ll
> I've seen very similar issues with Berkley DB which was also using
> MAP_SHARED memory for the DB and under some circumstances the workload
> performance was suffering from too frequent writeback.
>
> Now what I miss from your problem description is why "a transfer to the
> regular file" from shmem would matter to you. What is the problem with
> that? Because a lot of databases do it like that and it works for them. I=
f
> you use AIO + direct IO (or io_uring) your performance is going to be eve=
n
> somewhat superior (or at least on par) to current writeback workers in th=
e
> kernel. In terms of data integrity guarantees you are again as good as or
> better than using in-kernel writeback because you are in full control whe=
n
> you write and what you write. So the only reason I can come up with is th=
at
> you want to avoid the complexity of your writeback process in your DB. Bu=
t
> in the same spirit we as kernel people want to keep the complexity out of
> the kernel :) and if we'd add a feature like this we'd have to maintain i=
t
> practically forever so we are very cautious with that.
>
> > Avoiding full WAL replay makes much larger MemTables practical. While a
> > large MemTable is being populated, random updates can repeatedly dirty
> > pages that background writeback has already written out. Those writes o=
f
> > intermediate states consume disk bandwidth without being necessary for
> > process-crash recovery. Deferring them is a performance optimization;
> > correctness does not depend on the kernel honoring the hint.
> >
> > This is a general problem, not something specific to ToplingDB. Topling=
DB
> > explicitly distinguishes process crashes from power failures and has
> > invested heavily in optimizing recovery from process crashes. By contra=
st,
> > LMDB faces the same problem but does not explicitly distinguish process
> > crashes from power failures. If sync is skipped when using LMDB, the
> > remaining writeback problem is the same as in ToplingDB.
> >
> > The global setting and kernel module described in my previous email let=
 us
> > work around this locally. The remaining problem is making the optimizat=
ion
> > available to users of a database library. We cannot reasonably require
> > every deployment to change a system-wide setting or install and maintai=
n
> > an out-of-tree kernel module. The module gets us from no solution to a
> > local solution, but it does not provide a broadly deployable interface.
> >
> > That is why I am asking for kernel support: a supported, best-effort hi=
nt
> > that applications can use directly, while leaving the kernel free to wr=
ite
> > back when necessary. madvise is not the only option, deferring writebac=
k
> > for the entire file would also be acceptable.
> > Per-file deferred writeback would require minimal kernel changes and po=
se
> > a very low risk, while offering enormous benefits.
>
> The problem I see with your per-inode hint is that its semantics is very
> vague (and practically tied to the implementation). And this practically
> always backfires because people start to make assumptions about the
> behavior, then something changes, people's expectations break and people
> complain. Or they come with 100 and 1 ways how to tweak the vague behavio=
r
> to fit their special usecase and it quickly becomes a mess of conflicting
> needs. We've been there many times :-|.
>
> What I could imagine both technically and semantically feasible (but
> haven't decided whether it would be used enough to be worth the hassle) i=
s
> to implement some say fcntl() / ioctl() with which an owner of the inode
> could set / clear a file hint that the inode should be extempt from
> periodic writeback - i.e., the writeback that runs once per 5s and flushe=
s
> inodes that were dirtied longer than 30s ago (by default). I.e., we will
> writeback the inode whenever we see fit but we won't do it just because o=
f
> the file's age.
>
> But again similarly as David or Lorenzo I think that implementing your ow=
n
> writeback worker would be a superior solution for your DB.
>
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
