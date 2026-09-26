Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70095351C22
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790407267; cv=pass; b=ObtFuZvCrRqDRxVajQMHhSqVbTES4inzBemuLMPvHe7+mLkT2gOrlk+x3UWyyPbK+G65ZKZx3FwX0HqjBQXGF3uE3vymnhCWfhaaBZaD4r7nwFnqiCH7kBd4C/NeBV3ghWK7QxS/gOehVfKelkaUwjKx6KlJep1m7SpJFyogZyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790407267; c=relaxed/simple;
	bh=JSaZbVji5Ea0/OPC5PqKZgfN3e3cz3ZXBga9A0C+uKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1SHXcqIyfTQK6RmL7P4A5Fj8mBTNmSNhPQkHFZvEXdNymc93QImBlxbraPkOe1MAJzWAy06loAen8WrwVFviYB82iZqohUall0KZ4edynUYgccMlsWTa9msCErStap46yyXJiJUuOJl+hwaA6yfjbuuwQREQJrVQFV/Ks4JklM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiFKN0jM; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiFKN0jM"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8804b59404aso620189b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 00:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790407266; cv=none;
        d=google.com; s=arc-20260327;
        b=LQM8FmgfCs25ff1MD1h01nc8BU+ektx9661Ysc2bu7Xkf5U+v3Ie5g4UMtBgIqMh0T
         ptsmJr2LqgFUtRQBXte2zy1LKIISp+435MrC2ArD3zKSONPFgNLHxCWvO9sWsmXwTR1r
         iKLuEvISaG+27+kHcyPf8zQaluIrox3koT+o0voxPUI2JvDdqWaFKBWVjb9uWdbDhCmi
         gXF4o8XbCDMafsjeRbYvT255uyBgDJFthjtPs+Z4D891iVK5Eu6kkAvN2oMrMkLjYx9A
         1B9a0H8Z5zBl2Sef/QnHWX7NFLzCyjU8TmWL8l7qPD0wAS+N96UjTwWuaxBl3LGnItij
         mPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1fxaPqNTjN/pMftWjOpORDKiV+ubgNTjPPityCn5HVI=;
        fh=mwYnS+F86GUs6NJLQqJKHGT8/5DucwuE3AT34wnxSCc=;
        b=n3O5exREWdzaIK2dI4VCILAei6grQhrf8MndZQL3uvuiL/tc8mnRplNkwHMmdPotUF
         y9CceYncaIw5vppp/j1pKQe8o3FOap/s6imkynxhAo5bGp/hmM9X9tI4WAOlOIwpb+nA
         WMNk4OqyzdS+IiY8k509TFiiFMpvbmuH/uotZC8N6ptanP9X2kRqACl7gB7mnu7koyFQ
         bvmDWD+JgzQTy1UjsH6zXlqcn/dTIRi/Yn7U/9NCUFA80zGCwpeiRyO9YVe0Ao8D5WRF
         nTNgKMaTh9pCGTjM7109BwY96fDpUIIbXt2X86KCcyrTpBSvlipWJSFtkh21CneZksgr
         GMlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790407266; x=1791012066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fxaPqNTjN/pMftWjOpORDKiV+ubgNTjPPityCn5HVI=;
        b=UiFKN0jMrvECP/uSEfD3uEzWB/mgENKtlUlqBAspgFoegQ00d62sHE6Q6ggA60ftk8
         epA8RuPOvmXFTzAcxhugyXkhrxeZBSFWo4dfkaUggmdZ/Kfr1QIHno+qiLZaqNH4jyqW
         KgtjPoK+1FkQd0Xg2ou0pSriUKwUN6l9ymxub4oVhorJhoExSRQNLYGBNzfkiq50sME8
         S3bDbbYgXUsbdZgLiOyErwjO98SC3iz2YmjVVlht8n5pruVeXvnhlmUGZUbxLY+QEQSN
         xlXgAV49GRLCtPuazuqGgPxPy+YZiYJZjDVOr2jCsWlCTc4wSJBcyC5XJQMZdWCtVQSd
         0YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790407266; x=1791012066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fxaPqNTjN/pMftWjOpORDKiV+ubgNTjPPityCn5HVI=;
        b=FuFQqH3wywoun/aYO1ILRpTrlO7OywjCz4jpsnCbt0YyZTi6bwT2yUmDn9pAWUROU9
         oHS9ynAMLvPAbUh27M9n9lihPDgZP+4qIhjFybDUdjSxB8lHYgHTGkfKaPpnE7tqmJUT
         209CVtWqWj6E5lRACKp33SdPEQyVbnmpjuvIvl9E8i1fSRvbdqSAaD9twXGZW1YaS+sl
         IW+K/hFvIeTOIwSofXsxX1etPCxPHuO0EWGk+XHtkzNDqaHsRRr23FwoTjraix8yIt2v
         wCrRy45tcC9BXavGuhwOk79uM7IinzqdolcsIxa9Qj/ytpLQFJkOh1JhiPnd46uG+n6t
         CfMA==
X-Forwarded-Encrypted: i=1; AKwUvBzWUewZ2HkJVD3G2kI2MCZhZf/mOHKmQ7LQq0IZJmNMO4VNLYgwme44IGiHYaRoqtvtcLfuhlUkgdT9wQlX@vger.kernel.org
X-Gm-Message-State: AFuF++kAKX2A5gB7tCUEJQ9Dw4ZPuk0AkxLyrhRSc3QANCClKmbzo0kT
	ejQ5qOdPXlN3f+TK7qeMNjVNw44Ahk7xuu76YvV8vxm8kPd6x9zB5t6Zpke4t+r8iXIxxRrGN4X
	CDV1I0I9w91SxuGM6G4G9gr/zN6tRBS0=
X-Gm-Gg: AYBFou1GGzPkPR02iLaX8CfACQTvENxxVBGBey7XPh1GVAob2h8xgwDx+clM3kAq+iJ
	A4BSWRbG5QbFnRlicgaJJQTC4/08+qZBXNNRfmc8wVj3MVuxT1+UJbnU/YQsxtFMFiKCST69cFF
	B+K+3wB3tw80wHpr7sVm1ASdCGANxrfnVshiVrZZM+RPYvvo/+Ss/sJww/6wxiOWZO+X1JEBjgu
	AaROkDAMGbuuVny8v46KB6Mclg6xPC+2ZS3nfrdNJVYzR2+OQGlNCGvus1fA0tYwlW6r6VeUl2A
	ZpggBsCOHO9jNMWHCWKGH754WG95rfFsR3jYJiWMUdyw7zuNtPATiKo=
X-Received: by 2002:a05:6a20:a11d:b0:3d7:dfbf:7435 with SMTP id
 adf61e73a8af0-3de0e6cda41mr7552780637.25.1790407265676; Sat, 26 Sep 2026
 00:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923205028.711077-1-kolyshkin@gmail.com> <20260925-zugnummer-intolerant-unwahr-2cddd52e435c@brauner>
In-Reply-To: <20260925-zugnummer-intolerant-unwahr-2cddd52e435c@brauner>
From: Kirill Kolyshkin <kolyshkin@gmail.com>
Date: Sat, 26 Sep 2026 00:20:54 -0700
X-Gm-Features: AclHuK8CjebxrGLaeQF03zgqQYXxG7Ana61oRaZrCBoCqp-gd9qKzgfSLqEq9J4
Message-ID: <CAGmPdryJ32KFtJiX3X+3X_9Fkesj=9GHjPN2qm3H_ctd4Z0bdg@mail.gmail.com>
Subject: Re: [RFC PATCH] mount: add OPEN_TREE_SKIP_MNTNS
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	David Howells <dhowells@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	Andrei Vagin <avagin@google.com>, Shuah Khan <shuah@kernel.org>, 
	Giuseppe Scrivano <giuseppe@scrivano.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	containers@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 6:45=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Sep 23, 2026 at 01:50:25PM -0700, Kir Kolyshkin wrote:
> > crun, a container runtime, recently started using OPEN_TREE_NAMESPACE t=
o
> > set up the container's mount namespace, and open_tree(OPEN_TREE_CLONE)
> > for the sources of its bind mounts.  This turns out not to work on host=
s
> > that have a mount namespace pinned anywhere below such a source: the
> > recursive clone picks the pinned namespace up, and move_mount(2) then
> > refuses to attach the tree with ELOOP from check_for_nsfs_mounts().
> > This was reported to crun in [1].
>
> Yeah, I think that makes sense. Please split this into two patches
> though: semantic changes separate from test changes. Maybe call it
> OPEN_TREE_DROP_MNTNS_MOUNTS instead?

Thanks! Done in v2:
https://lore.kernel.org/r/20260926-nsfs-prune-rfc-v2-0-53509260e4e7@gmail.c=
om
