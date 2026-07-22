Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F130C164;
	Wed, 22 Jul 2026 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709744; cv=none; b=kUfYe8gaGUdVbVpdSKRiomZ+W/rXWuiWArvtx81N+N40aMvbWqShzhqi7VGtssldnP41I1ezMHABda11mBx8EW4tUxc/Ru2HknzRX9riSjsXe7V6ff+mqM/sDJUgD0+R6cRDgpLufwUa+woVwWrazdu4nkOB2eMoLXAxHzDO+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709744; c=relaxed/simple;
	bh=9pTA1Ysr36RHMPS3fGpfsQwQSeSp1XZOvdGad3+ksLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkJTJ/sNzFuEzjEHKT16sXWkUTRggwrlvE9UE+lEXEzofCIK2yxBbWTrcJVpdIdpud44IIWX8iLr/PkhL3auFDEd0jQWzwVJdUhR55QWzdhFJfU0QEmnNuOLXc2DSXPpIyQca/Ui06duQLfEAhuKlLQ4f/zyAUI60l1arYmVYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QmNKhK/f; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QmNKhK/f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=/YxQyjgA/fdfqnw5SWvH6cP4fGv+BzKuyW/E0Com4U4=; b=QmNKhK/fj6UlGx2tFafCxDwshD
	BA36EPaUUV/5hpCbd2Krj53Q4rNeJjb9sxzgRRRJd+HaNrQShEIIUPQ2rlB8DcxIWEynlnBlWrmbb
	r7/NYfBwJZUVd0Ehjh5UTOrAUMajYTVrgD32c+n7eLc/PIELqhNMrjIKMqOxC9RwP4lxSkyWFw54E
	S5v9LDJkJn1CQYWZHd23b+qAiveKj1ZyGMNqUAUWT3Gi7T4G14mhtmesgi/uKipW8U93BjCH4oba3
	NJ3ayc7pfxg9QdowEdT9G15y0jODpsCKVhHGijGYQ3wxMcJVztXtn9F4yLOzmyJTl7CBsEhCYEiwm
	1qx8wrOg==;
Received: from bl21-120-122.dsl.telepac.pt ([2.82.120.122] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wmSWt-002uun-1V; Wed, 22 Jul 2026 10:42:15 +0200
From: Luis Henriques <luis@igalia.com>
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 0/2] Fix for unintended FUSE ACL cache
In-Reply-To: <20260721-windig-probieren-neben-887a66d13db4@brauner>
References: <20260713220932.413004-1-amir73il@gmail.com>
 <20260721-windig-probieren-neben-887a66d13db4@brauner>
Date: Wed, 22 Jul 2026 09:42:16 +0100
Message-ID: <87tsprqutz.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21 2026, Christian Brauner wrote:

> On Tue, 14 Jul 2026 00:09:30 +0200, Amir Goldstein wrote:
>> Fix for unintended FUSE ACL cache
>>=20
>> Christian,
>>=20
>> I bet you did not miss fuse acls...
>> Ghosts from the past have come back to haunt me now.
>>=20
>> [...]
>
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.

Maybe I'm just being too eager, but I don't see these patches in that
tree.  Is there a delay between this email and the actual branch update,
or did this patch got dropped somehow?

Cheers,
--=20
Lu=C3=ADs

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
>
> [1/2] fs: preserve ACL_DONT_CACHE state in forget_cached_acl()
>       https://git.kernel.org/vfs/vfs/c/85f9e659787f
> [2/2] selftests/fuse: add ACL_DONT_CACHE regression test
>       https://git.kernel.org/vfs/vfs/c/67eca5c355be
