Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE312EA749
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765444; cv=none; b=c0ifqBVwYf2+X3MS+ogiBgcl1HJrqPF6Oaf+riT9PV7ntHOt3RJvtQejobFfaLbX+RnTAj+f8J9VPn84puSBNO6+2z01arg6B7cFFVoDX6JurmK/CB2dak1kl82PYR2w1eQDIwpm6wlrGwZKiZ52dgDVFCVEntqKTrLW/IL4O5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765444; c=relaxed/simple;
	bh=eg6USMUwKMGcmo4SxhxiHpEO7qtj99Hcbo8wLwy+XHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ksHpYKKIgFC7K/zVDI0dUm9xppAqFAf3l/Qed8WQLxy4O7+I1ZqyJuG5bzH9H7oGesdzQwA5N1o3PeRufFGVZ/jCSlijBst5PGll8i7KrQSHYFsJnrR9um0rU26AUVJwid/Bv6LH9XVy+iNcm218roKzwd9tOAKWg3ydvLLmxUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyU25tcH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyU25tcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C851C4CEF7;
	Thu,  9 Apr 2026 20:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775765444;
	bh=eg6USMUwKMGcmo4SxhxiHpEO7qtj99Hcbo8wLwy+XHU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RyU25tcHAPnyzMiCrBTAEuI1LjM2HxwYmlrPVVL2oSqOxgpFWVhpvuXS5Co4zBijg
	 yVl6JTN4AqcptXvtmPywPKcpbb3X29AKb7eSj1YnAUHC5N2n8ipXFPpF6C6p1CZZJd
	 VNIQ2UFBuvgFKMDMLOnA84JQpJh97wzAZT2zTSvf7LbVn1sKGaKb36kTPGTVpj6Il6
	 /5YCBUojguBR1ABeX1bLE25RGUjdF+N7qw+apILmvBCIwS0YyrIGofVs0UZ7TSi3Yg
	 mQW5Pf0C0uuGkNOZlMJ6ZLw1SjDigwee2CKjfBmiD0lS+SMWVtJSGtolTnpWzdHR4m
	 CkHPdL/pn1i0A==
Message-ID: <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
Subject: Re: [RFC PATCH v3 0/4] getting rid of busy-wait in
 shrink_dcache_parent()
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan
 Kara	 <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, Max
 Kellermann	 <max.kellermann@ionos.com>, Eric Sandeen <sandeen@redhat.com>,
 Paulo Alcantara	 <pc@manguebit.org>
Date: Thu, 09 Apr 2026 16:10:41 -0400
In-Reply-To: <20260409190213.GQ3836593@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
	 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
	 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
	 <20260409190213.GQ3836593@ZenIV>
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

On Thu, 2026-04-09 at 20:02 +0100, Al Viro wrote:
> On Thu, Apr 09, 2026 at 12:51:38PM -0400, Jeff Layton wrote:
>=20
> > I can also confirm that this fixes the livelock we were seeing as a
> > precursor to this UAF [1]. I'm still not 100% sure how that livelock
> > leads to a UAF. Claude thinks is has to do with the livelock making the
> > loop outlive an RCU grace period.
>=20
> Claude is full of substance likely to cause CoC complaints when mentioned=
,
> film at 11.  I agree with the "livelock opens up some window" part,
> what with the stack traces there, but I very much doubt that mechanism
> has anything to do with the stuff on a shrink list staying around from
> one iteration to another.  The thing is, *nothing* is held between the
> iterations of loop in there; data.dispose is empty at the end of the loop
> body in all cases and reference in data.victim is not retained either
> across the iterations either.  We do have a weird RCU use pattern there,
> all right (unbalanced acquire in select_collect2() paired with drop in
> the caller of caller of select_collect2()), but the scope is neither
> long nor extended by the livelock - in that case the function between
> shrink_dentry_tree() and select_collect2() (d_walk()) is told to drop
> the locks and return to its caller immediately.
>=20
> What I suspect might be getting opened up is the possibility
> of d_invalidate() (e.g. from pathname resolution trying
> to walk into /proc/<pid>/...) hitting in the middle of
> proc_invalidate_siblings_dcache().
>=20
> Incidentally, one thing to check would be whether anything on affected
> boxen had things mounted under /proc/<pid>/... - that would give
> some idea whether detach_mounts() (and namespace_unlock() with its
> handling of the list of mountpoints) might be needed in the mix.
>=20

=E2=97=8F had_submounts =3D false. The d_invalidate code never found submou=
nts, so
   detach_mounts() was never called for this dentry. The find_submount /
   namespace_unlock path was not involved in this crash.

  Summary for Al: On this crashed machine, there were no mounts under
  /proc/<pid>/... in any of the 49 mount namespaces checked (from
  surviving tasks). The d_invalidate stack frame shows had_submounts =3D
  false, confirming that detach_mounts() and namespace_unlock() were not
   in the mix for this crash. The code path was purely
  shrink_dcache_parent =E2=86=92 shrink_dentry_list =E2=86=92 lock_for_kill=
, without any
   mount detachment involved.


> > I did eventually find a vmcore and was able to confirm some things:
> >=20
> > - in the freed/reallocated dentry, most of the fields are clobbered,
> > but the d_lru list pointers seemed to be intact. That tells me that the
> > sucker was added to the shrink list after being freed and reallocated.
> > That means that the WARN_ON_ONCE() wouldn't have caught this anyway.
> >=20
> > - there was some list corruption too: it looked like there were two
> > different (on-stack) list heads in the list. There were also some
> > dentries in there that were outside the=20

...directories being shrunk from processes exiting. Here's what it
found when I told it to validate the integrity of the d_lru that the
realloc'ed entry was on.

More claude slop from the earlier vmcore analysis:

------------------8<------------------
### Dispose List: Two Merged Lists
The dispose list contains **55 unique entries** and **two stack-based
list heads** forming a single ring:
1. **head_A** at `0xffffc900c0e8fcc0` =E2=80=94 crashed thread's `data.disp=
ose`
2. **head_B** at `0xffffc900c0e7fcc0` =E2=80=94 another thread's `data.disp=
ose`
(exited, stack freed, exactly 0x10000 bytes apart)
```
head_A =E2=86=94 UAF =E2=86=94 mountinfo(1) =E2=86=94 swaps(/) =E2=86=94 ..=
. =E2=86=94
  head_B(STACK) =E2=86=94 status(5962) =E2=86=94 exe(5962) =E2=86=94 ... =
=E2=86=94
  stat(8808) =E2=86=94 ... =E2=86=94 mountinfo(1) =E2=86=94 UAF =E2=86=94 h=
ead_A
```
### d_walk Escaped Its Starting Dentry
`d_walk` was called with `parent =3D /proc/4530/task/5964` (`data.start`
confirmed in stack frame). It should only traverse descendants of 5964.
But the dispose list contains entries from:
- `/proc/4530/task/5962/*` (151 children =E2=80=94 sibling of 5964)
- `/proc/4530/task/6830`, `/proc/4530/task/8808` =E2=80=94 other task entri=
es
- `/proc/1/mountinfo`, `/proc/1/status`, `/proc/1/net` =E2=80=94 PID 1 entr=
ies
- `/proc/sys/vm/overcommit_memory`, `/proc/sys/fs/*` =E2=80=94 sysctl entri=
es
- `/proc/pressure/{cpu,io,memory}` =E2=80=94 PSI entries
- `/proc/swaps`, `/proc/cpuinfo`, `/proc/kcore` =E2=80=94 root proc entries
------------------8<------------------

>=20
> =20
> > Note that this was an older (v6.13-based) kernel though, and it's
> > possible there are other unfixed bugs in here.
> >=20
> > I'm currently trying to reproduce the UAF using that mdelay() based
> > fault injection patch on something closer to mainline.

...and so far it's not trivially reproducible. I can reproduce the
stalls on a recent kernel without your patches, but whatever causes
this UAF is not easily triggerable by just stalling things out.

I think I'm going to have to hunt for more vmcores...
--=20
Jeff Layton <jlayton@kernel.org>
