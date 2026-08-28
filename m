Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00AD3E1D13
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787923278; cv=pass; b=rwOImt1JUuBp1hZXkpBQIX19+3yFoid2Hm3jJ/AE+BnOfVzilcgWpeMtQRosFInOAvkhrNTcLChDzeWVsOPt118eudjJ/OuVm0hf2pAdVEJQmq7b46QxSkDhltf4MPyvXeubYWqN3Tx5qrK+rodbvTKGwmWhpTD6xvqVrUEyhMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787923278; c=relaxed/simple;
	bh=5BzWTvTEODadIF56TEz3lyokV3iJPu75tta+h2QbYzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kksQJBfXRmdLUzfwKOFS74lq2CWel3n7PC2OzwZtI0C4ZKj1yFUMu3sw2cp++eSr2CWFDmuAAK9ThrT8nENMYpMeSmHYkUCQ31AnpnSGTYkOiRc3cEe7q9Zk18GxzsR+qz6PKOQuLc6zah1hdaG3lNTE/p8/dWQ12pjs8jI7LYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t40N7rN8; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t40N7rN8"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cede6375caso116815ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 06:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787923276; cv=none;
        d=google.com; s=arc-20260327;
        b=EtXI4D4q47NFLSMhmHws+zXINWldY52vrwdp7sx8Tpfi/UJH7DdLx8c7vFoCQkfTTe
         RGvezdJvh1DSA5+ij3ODrzOzl5qbUyKYBAYPoAltw2zWPGajhbLvepSYEdJmCA/Zx25H
         jbxc20P87VJ0ifGaIlkuF3MAb+kAJSizZsANzFBqcSiN/Z974Axefh5Nte+yfr7xmfuS
         ymY2FAjPc56LyqFKKwOXiBW5jZ0yy01dsStqEwTsP9hFpZpXa7bKip0VYZ23Ax7ZZocM
         OTnnCCkMAjbbxd3326WIoW74o/ww8+i2O3flQLCb7u53fVOsC8kBejTQE60GHnj/dWaF
         NpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TmuJ8XeoPh26H2sa3OfduzNJbG5iPyqGukTAzRwDvaw=;
        fh=3i1TewWJ1SOvMJ/UU6YvEqOXxncOnU+3Eu7ueb+JoNE=;
        b=fAHGwCDoeGWPAqOvkAgkVx5VHYh8/KvlSq7/d5M9mmJnNpnusxTSFDY9KbS604qbZa
         r7DzANfhaaEpX4dNJ+6vukGTVMHtWx9wWjTw2CvrvM+9Mtl12zHNRpB9GHworvCEjhvL
         IUWIyBplRgeHSHRNcNPB6Xdh+Op1BfJxo7vzxEitWjy3dHBIk+k1ipQ5D6P3kXD59PYl
         UH14JwXS5K+LJNIKXE1/EcVNpVdTBqwVYU+kx7eIXRI+h2SmvgYw05GeGZuHrjihGwZb
         8mSnse/jKGK8pe7Nv46rBGp3vSYZFuEknq3AE7Nk4pSbGJtJI1CRO8u9dTJYPs4orpvF
         qP4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787923276; x=1788528076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TmuJ8XeoPh26H2sa3OfduzNJbG5iPyqGukTAzRwDvaw=;
        b=t40N7rN8XJSRScvkqe0e98xgccDBcGcUWgc7Cj4HBKEL44sPdsOFqJ8qPbUkP4/uo9
         IsyLSVx8mkN8ChMd0M72M6PfFDkEVBkD82/+Pfmv/auq7qjv8GNk1MR5K8DGE8bd7hoh
         JH48/8IQL8oUHvDiWs3q2tNzIHo50KblaVvpaXZ/0eew8cl8d8c85FOH3fOu8qgfFvaV
         4IBzLUxYnnY9cq46Y++W5GnuR+FxFD8MYtKN0T8EDRJAgaz9jTD7wWRljOutCRpjkj+v
         2D6X8x1F4WujtWCnuCaYXotHT+mSGXlbiLdvEtakky7KzJH+9OcLatIAo1qEGacnAOdi
         kJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787923276; x=1788528076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TmuJ8XeoPh26H2sa3OfduzNJbG5iPyqGukTAzRwDvaw=;
        b=V6KbLitcbpZdjh2gBd8djAy7ULYKnsYWZ7zKuJ7hBN/xJf6H+9wAarsYRU7TamPfdl
         OY1378rla/j3+tbRCI/KWseyRtW0d0nMCQ1+PxAE2/Ig70dpIZ1jbwsVunV81Z/oVYOS
         bhxALrwRAZQgCe6OSorjSMaIQwHUc3jwHST3PWoG4eUclntbPxem0gDG4vHvIP+bSXTJ
         UHUHVzungnH6twBNmNRKPENhfIcisnrUsi7jdm7/LbskPq/u8kX6aDOVY2adk15YbdWq
         e1pYI+H4VYrUkQjpppon7MIiUJEbDs8ut8P+fJ/LJQM1rbYXaSPpqJMFh8nhbN4f4jtf
         YEIg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5frTDHWP1UU76DkQHXCB4jHfcYddaSmlCudqOECX5BCtEgd0LyB04g8VmQY3QoJRsbamMVEkKG1WJQRMm@vger.kernel.org
X-Gm-Message-State: AFuF++lNUrKJf3J3/sxIF+SCVlSuIKdtRAVOQ8GWEIVPjsXxfnkO0cH4
	2IWtyrHzeASXd6NaDG44R8gCkLmWyzFBsnijrY2LZZlZg90GZzifvJT8TABe1x3IZJ3y0MVb3AQ
	QMzSRLRJ+qV3hisWfq+6QpARmP6Cr9Am/T+cpQltn
X-Gm-Gg: AR+sD13NyJqb9CX00sq5GE9up9Di1iClP+rkT9rMHDJwRJwFB/e5xYu1cqyn7QoNLw7
	1BZ6FYBnJiFiUR9ke154w/6DXO7gBJnaP9cYZfCPiLB0ReXYQm2usPEI5u7ze4q4U+TDIJZeimc
	v+b0lJ0mXLDJ/MkX1WR66bTaX7RAimLaw9ZPV9l0cmjnLAB8rsjtD7AABUvYkMPt0FavFg+enyb
	uXMN2MfmOvdQnu5LFDDokAbnBdeqtGlCT0g1nufwEy961uRtjEyDp6I7qmJFUu0Z5hL0sLZCBVD
	caSFjnhA6aBt01ZuJbkSlt0ws61rBL6vv1xHiP5jZe1vStCHNEE6pRlVCL4dO7PyMVHtLOeDPbH
	FJUem1Z/9UF1ASE69RvV7AH8CefHuZA==
X-Received: by 2002:a17:903:b48:b0:2c9:bd54:cf with SMTP id
 d9443c01a7336-2d74f403213mr6682285ad.4.1787923275276; Fri, 28 Aug 2026
 06:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
 <82929c994076d95f99560ecc67f6cfce@paul-moore.com> <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
In-Reply-To: <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 28 Aug 2026 15:20:37 +0200
X-Gm-Features: AcwNN1X1_-cZAxs-C_zVg9dDOHf5DCa4yCAEiND1xrtOkQ0sGqfzpyFhp0b8haE
Message-ID: <CAG48ez2jgJHewZYK1SVccJmBa=bjoMW80SPNcbgW2XCtZaWhjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:03=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Fri, Aug 28, 2026 at 3:10=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > Beyond that, we really try to avoid making LSM hook calls conditional. =
 It
> > can limit what an LSM can enforce, it tends to be a bit more fragile, a=
nd
> > it adds some unnecessary work in the case where CONFIG_SECURITY is
> > disabled.  I would suggest passing 'opened_by_owner' flag as a second
> > parameter to the LSM hook and calling the hook unconditionally in the
> > default switch case as a replacement for the 'return true;' statement. =
 I
> > understand it may seem a bit odd, but we try to make the LSM interface =
as
> > generic as possible with respect to different models and this is one wa=
y
>
> I guess I can do that, but then the question becomes, what other modes
> of using the LSM hook that don't currently exist in the kernel should
> I be supporting with this? I can make this a parameter, but any LSM
> policy that actually uses the parameter in a different way would
> probably be buggy/inconsistent, unless other new LSM hooks are added.
>
> If your intent is to make the hook work for any /proc/$pid/mem access,
> including when the caller is ptrace-attached, then I guess I have to
> move around the security hook call in proc_mem_foll_force() a little
> bit. I guess I'll do that in v3, though I really don't like trying to
> come up with a reasonable in-kernel API contract for a scenario that
> currently has zero users.

I started thinking about how to implement this, and an annoying aspect
about this is:

Currently, I only have to look at the credentials of the opener of the
file - that is both the subject and object of the access. But if I
want to provide a hook that works for any /proc/$pid/mem access, and
want the hook to know what the object of the access is, and do it
race-free, then I would need to grab the creds of the target task in
mm_access(), bubble them up into proc_mem_open() and mem_open() (which
will require touching all the callers of mm_access() and
proc_mem_open()), store them into mem_private there, then let
proc_mem_foll_force() extract the creds from there. All that would be
unused code.

Do you think I should just not provide credentials for the target, and
document "if opened_by_owner is true, the subject credentials are also
the object credentials; if opened_by_owner is false, you don't get to
know what the object is"?
