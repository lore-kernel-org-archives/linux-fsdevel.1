Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B52360EF6;
	Thu, 21 May 2026 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332793; cv=none; b=XKawrQFXxwyENgTN8uuNkLAQSYvj8cPilvkkME977RLQIO0zlY2Sf5zlWVprMc2kgtr5CF0dD1TPPWz+tCkVUTTo6bH3IT+juQs81QWueGEWb8N+dlMQVKe0e7ZOxpLeZ/bGUM4vijW/Zj9SoP72MuRs0gSdDpdUDv2Idv9jhjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332793; c=relaxed/simple;
	bh=fZdm59YOIExaSTXLtBhDME6jej6wj/X85WvYBt0VFmA=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=ju2SxdGfE0Qj33mvXm/zl1kP3K4a8+IyfvrMVGDpvmaf/Ek7rdlnP4OvltMzU5d/A5X/TA1r5mf/eamGz60oCpq+x8R3pMAERu7y7LQAGD9EB2kNprrNtonO8zgRacEpcHoOPgcfMCqenp6zb7ihqggaJgd7gP3uZXB+CSozJiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw04pFNY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw04pFNY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 195A61F000E9;
	Thu, 21 May 2026 03:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779332789;
	bh=D/vzb+GNoTqSyzb9zvGcFQr7ULPtjdUraeIy9alBzoU=;
	h=Date:Subject:From:To:Cc;
	b=Dw04pFNYn6s1JJK38X6C/yAPhDE6JlfqqW2bdv7Hs2UB0PaYMN9NG5/9+EBnZK8V4
	 tk4wbAlHrlJeF5brXdQ8IF7OB7z8jRUBBVoG3kJo/HmuS46Fol9WzZ/kcn71MRJ6L8
	 TBvwJ4E07Il//+RLY/SlMUXgdIVIAn+Qm2mGBding74CjaIX0sOksl8/p/CI0pY+O2
	 ZX9WBukXBUC07adawfo6s0NOex7vtbX/2LkBlwN/dpvT1RWuFuQrBU4Ds+zNrxpF2j
	 Q70HRkP+BgW8gW6AVw7vtwFRcScm2magQ3B8TVz0lM+CxWKSGIaqZgGadOVNTx11TI
	 td9OUmkwgEz+w==
Date: Wed, 20 May 2026 20:06:28 -0700
Subject: [PATCHSET] libfuse: new mount service container fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Message-ID: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This is a collection of bug fixes, codechecker, cppcheck cleanups for
the new fuse service container code.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * fuse: use fuse_args in try_service_main instead of opencoding it
 * mount_i_linux.h: fix whitespace error
 * mount_service: fix some pointer handling
 * fuse_service: fix uninitialized variable
---
 lib/mount_i_linux.h  |    2 +
 lib/fuse_service.c   |    2 +
 util/mount.fuse.c    |   71 ++++++++++++++++++++++++--------------------------
 util/mount_service.c |    4 ++-
 4 files changed, 39 insertions(+), 40 deletions(-)

