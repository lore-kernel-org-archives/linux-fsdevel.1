Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09935AC10;
	Thu,  7 May 2026 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192033; cv=none; b=OedC+E+2lKOM+UzExFQBCpcJHNs61T4LpfY46HEtq9Ta2XXtGFWSaCRDPcvj6HfsFiUEbrpvcHZVlmr/eLMmwg5N8vcL8an/HS1lXl++mf75z73eCwXAPsgmkEM+uwbq9ejYQ/VRkwo1j6T3jygdL9sjel/TpS6BgH9twrweHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192033; c=relaxed/simple;
	bh=yhs+PCEA/gp2LxKFOP0fg0Ht+NA60yurwQAOOcl3wy8=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=meQMJ/RptxRJ4GpmzYqGKRuROCmK66XjK9DfOaoBGNaX4PVZ+ryY+tYb1gvEkbJJvXsGQh7HXHx8y1PiWG8YZo+qXwHD3HmVjWWojmOeXiOwl5iR+h1EGLtv8C+M78Pm2d/pk6+LIwNIizZP1yx8zqG6nfrsaDUtUAfCgy6Sm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZZBA1XD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZZBA1XD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919FCC2BCB2;
	Thu,  7 May 2026 22:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778192033;
	bh=yhs+PCEA/gp2LxKFOP0fg0Ht+NA60yurwQAOOcl3wy8=;
	h=Date:Subject:From:To:Cc:From;
	b=HZZBA1XDmS8eiL95Un7dJxHL9V/HhWv44iIlQehvPIbuAnwUxJWhg5XbpGWLeNISA
	 8ygwaHnhwsD2N47qwmHFO8SjyDsAAJsENpTPp8eTgNTdug4pDwS+TjrWXGX1KeKAKm
	 uYVOC89r0afvjBvAO9ejMls+yUbMtE7NQ8pDWMfBpMDbs7783dxUnwlxGCnMWazpUd
	 um14D2iSsDSr3LCEcwi65W6GnVkOZopnM9GmopRF/LhcuZ00fr1n1GHPXFlwumyQ+o
	 4FU1xRUvW4+n09GkdSJAT5C6OyXREncVzFd4tgTnevKMF8yEvIVLuIKTtWtyfbiKx3
	 tnYUdXy54HpAQ==
Date: Thu, 07 May 2026 15:13:53 -0700
Subject: [PATCHSET 2/2] libfuse: new mount service container fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org
Message-ID: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This is a collection of bug fixes and cppcheck cleanups for the new fuse
service container code.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * mount_service: use the mount_flags table instead of declaring our own
---
 util/mount_service.c |   51 +++++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

