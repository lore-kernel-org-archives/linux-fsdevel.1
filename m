Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A7395D8E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774312; cv=none; b=ucE74Oke+3l+wfj3a6KeqMJNdy84mLrZWoTbO+4rNAsFY8fAou/9kDniDbiJr32wCbzCskRuwIH5RQO4walC/Vqx9E9eTWu0lS1chsyRhaxswOl0sI0WcVjOtopAw0dLVQHHluFD8fA2cZOcu8qLRLMYr6X3rbdRnMK4NWf3Ycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774312; c=relaxed/simple;
	bh=4xNYaMgsrGst+UGtpewW8fKJVzFO6/Su9kQMgjL8K/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxPUNHvuKjIdOX2S6V4t8To+0Nlc5EWmFi/vz20xSMIDPJIexj5Sf5qx/1e1qEf++r0scx+h1GEY1USx9r9xsOUSnmD8Dmym/aOaJcQ6r4iuygCnyegCBnLZBulYKxQswYbiI2gmbZDNOM7+/NJOb8LyXAvdszzV3CdI30i7bRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTihKM4S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTihKM4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47623C4CEF7;
	Thu,  9 Apr 2026 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775774312;
	bh=4xNYaMgsrGst+UGtpewW8fKJVzFO6/Su9kQMgjL8K/Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KTihKM4SI4pPd6cJ04k2xXCauOzEXVHfI2aAK5sD2P//Pec6tDi2qQDbnQwxZbRPl
	 F4NtkrlcPMXjOusqBPhRVUb1s1dvv3+nLSHZn7i2NJgS/GdqX/cTX6EKblqs4yTlca
	 VNwR8wMUWVvWKnyOjmx8Q5pza9DYPzE+eV6EOrVNj8zwRhlcLoGXjYd0b8bA2gC7T+
	 vC52dH+9mdHPMixqqEfsDRJRZBeq70NDR+KQtVrOaJi8XpY5tGeiTp/TaKeHM7Xkgp
	 /WZ5D9+SBgeJQoA2jOzM0hHi525oUqdkLxEeRVvRJJktS7AuSuSmthl4TOsyEBCnVV
	 dy9xv7jX0Tq/g==
Message-ID: <a8fc5dfa19cf704c3f668f91443fdd1b2e01e612.camel@kernel.org>
Subject: Re: [RFC PATCH v3 0/4] getting rid of busy-wait in
 shrink_dcache_parent()
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan
 Kara	 <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, Max
 Kellermann	 <max.kellermann@ionos.com>, Eric Sandeen <sandeen@redhat.com>,
 Paulo Alcantara	 <pc@manguebit.org>
Date: Thu, 09 Apr 2026 18:38:28 -0400
In-Reply-To: <20260409215733.GS3836593@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
	 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
	 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
	 <20260409190213.GQ3836593@ZenIV>
	 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
	 <20260409215733.GS3836593@ZenIV>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-09 at 22:57 +0100, Al Viro wrote:
> On Thu, Apr 09, 2026 at 04:10:41PM -0400, Jeff Layton wrote:
>=20
> > head_A =E2=86=94 UAF =E2=86=94 mountinfo(1) =E2=86=94 swaps(/) =E2=86=
=94 ... =E2=86=94
> >   head_B(STACK) =E2=86=94 status(5962) =E2=86=94 exe(5962) =E2=86=94 ..=
. =E2=86=94
> >   stat(8808) =E2=86=94 ... =E2=86=94 mountinfo(1) =E2=86=94 UAF =E2=86=
=94 head_A
> > ```
>=20

I think the above is BS. Claude says:

In the earlier analysis I walked the list both forward from=20
head_B (the stack entry) and backward from head_A  That was misleading
=E2=80=94 there's only one mountinfo node. The ring passes through it once.=
 The
duplicate in my listing was an artifact of walking the ring from two
entry points and not  deduplicating.                                 =20


> Wait a bloody minute; *two* UAF and two mountinfo there?  Are the links
> in that cyclic list consistent?  ->next and ->prev, I mean.

No:

The list was NOT a proper ring:

  - FWD (head.next): LOOP at entry 1 =E2=80=94 immediately hits a self-loop=
 (the processed "status" dentry)
  - BWD (head.prev): LOOP at entry 55 =E2=80=94 walks 55 entries then hits =
a cycle


> If I understand the notation correctly... are there two different
> dentries, both with "mountinfo" for name and PROC_I(_->d_inode)->pid
> being PID 1?  What are their ->d_parent pointing to?  Are they hashed?
>=20
> > ### d_walk Escaped Its Starting Dentry
> > `d_walk` was called with `parent =3D /proc/4530/task/5964` (`data.start=
`
> > confirmed in stack frame). It should only traverse descendants of 5964.
> > But the dispose list contains entries from:
> > - `/proc/4530/task/5962/*` (151 children =E2=80=94 sibling of 5964)
> > - `/proc/4530/task/6830`, `/proc/4530/task/8808` =E2=80=94 other task e=
ntries
> > - `/proc/1/mountinfo`, `/proc/1/status`, `/proc/1/net` =E2=80=94 PID 1 =
entries
> > - `/proc/sys/vm/overcommit_memory`, `/proc/sys/fs/*` =E2=80=94 sysctl e=
ntries
> > - `/proc/pressure/{cpu,io,memory}` =E2=80=94 PSI entries
> > - `/proc/swaps`, `/proc/cpuinfo`, `/proc/kcore` =E2=80=94 root proc ent=
ries
>=20
> Not at all obvious; there's a list from another thread mixed into that,
> and we've no idea what had the root been for that one.  For that matter,
> I'd check ->d_flags on the entries, just to verify that those are
> from shrink lists and not from LRU - the fact that these UAF still
> have pointers to plausible dentries does not mean they are from the
> same moment in time; if dentry in question had been on a different
> list before getting freed...  That's why the question about ->prev
> and ->next consistncy.
>
> And seeing that procfs has zero callers of d_splice_alias() or d_move(),
> I would expect ->d_parent on all dentries in there to be constant over
> the entire lifetime; would be rather hard for d_walk() to escape in
> such conditions...

Definitely not legitimately. I suspect some other sort of mem
corruption. /proc/1/mountinfo is on the list though:

mountinfo dentries on dispose list: 1                                =20
                                                                           =
                        =20
    /proc/1/mountinfo (dentry 0xffff88823deef800)                    =20
      d_parent: 0xffff891373c06a80 "1" -> "/" (root)                 =20
      hashed: yes (d_hash.pprev=3D0xffff893d337264d0)                  =20
      PROC_I->pid nr: 3217077                                        =20
      d_inode: 0xffff88ea55a44508                                    =20

Claude's theory (maybe garbage):

PID 1's mountinfo being on the list is actually a strong clue =E2=80=94 it'=
s
a dentry that would be on the global LRU (negative or zero-count
after someone closed /proc/1/mountinfo), and drop_caches would pull
it off the LRU via prune_dcache_sb. That's likely how it ended up on
Thread B's dispose list.

Here's a cursory comparitive analysis across the 3 vmcores I have so
far:

  Comparative analysis across three vmcores                                =
                     =20
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                        =
                             =20
                                                                           =
                     =20
  Kernel                  6.13.2-0_fbk5-hf2   6.13.2-0_fbk12-hf1      6.13.=
2-0_fbk5-hf2         =20
  Date                    Mar 31               Apr 9                    Apr=
 2                   =20
  Process                 SREventBase61        tokio-runtime-w          TTL=
SFWorkerU151         =20
  d_invalidate target     /task/5964           /task/3555587            /ta=
sk/1102              =20
  had_submounts           False                False                    Fal=
se                   =20
  UAF slab                kmalloc-96           kmalloc-64               kma=
lloc-96              =20
  UAF d_flags             0x0                  0x81e73ce0               0x0=
                     =20
  UAF d_sb                0x0                  0x0                      0x0=
                     =20
  UAF d_lockref.count     0                    -14080                   -77=
1573072              =20

  Consistent findings across all three cores:                              =
                     =20
                       =20
    - had_submounts is False in every case.  detach_mounts() and           =
                     =20
      namespace_unlock() are not involved in any of these crashes.         =
                     =20

    - No mounts under /proc/<pid>/... in any mount namespace (checked      =
                     =20
      on the od0103 core across 49 namespaces, zero proc submounts).       =
                     =20

    - All three are in the same call path:                                 =
                     =20
        release_task -> proc_flush_pid -> d_invalidate ->                  =
                     =20
        shrink_dcache_parent -> shrink_dentry_list -> spin_lock (UAF)      =
                     =20
                                               =20
    - The UAF'd dentry is in a non-dentry slab in every case (kmalloc-64   =
                     =20
      or kmalloc-96), confirming the dentry was freed and its page reused  =
                     =20
      by a different slab cache before shrink_dentry_list tried to lock it.=
                     =20
                                                                           =
                     =20
    - Different applications triggered the crash (Rust async runtime,      =
                     =20
      C++ worker, Java-like worker) -- not application-specific.
