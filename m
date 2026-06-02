Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62B33D6D5;
	Tue,  2 Jun 2026 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365170; cv=none; b=hiGbA8DM6fI1gu6cIiJeU0VHKrxtI977Muveb0S8HzgChKiqaqB1HDUlgVcN890G671mmtDhu/DSv0Sy+mVTjeQFhNPwAFfcpvsGlXSPfRiVnalYXOuZZbFkDtfFyXfLdmvlIbw4W0/wL3r5/hW6zZICCqT99pI//loIjntWhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365170; c=relaxed/simple;
	bh=3qhNAScQCdir0sKo2odoD5hJeguey5gpG6BAiF7M7dQ=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=L4Rid43ZPzm0u082sJIKXRmog5sfo0gG526QPzjryDotALdqm3Asm5A9bBvvLCUF8Jc5e+CcKiBzUt8CC+WCnI0wnd9KlMU3pffPhs5rErOxdoxDK0lWK/Or87WzQL1HP+n0RFYrepBA3bZGMA4dVi8s1U07O0FekuNPaT8qEWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8IX9vOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8IX9vOn"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B1BD81F00893;
	Tue,  2 Jun 2026 01:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365168;
	bh=K2hQ8Gh67WcS2i8bFxuLpkFaxUyDpvJSJmFatqgIatI=;
	h=Date:Subject:From:To:Cc;
	b=k8IX9vOnb7LUuPGf8m2jkYVh9F4Xiw69pgmdYd0Usv0037NSOOwfT1FcprSARungC
	 Icr+k4SZxYqxo85RDv8tSQCxW2XuL6LJnqwB9THbA9/zgWLissdkFSzo15+aRG/wZ5
	 Ex54PAbyoLt4HetXd8mEtZkVQ6UySIRpIzGPCOTN9PBXvJCpg0SWhgMa3sxST17mvh
	 fEwXir+NrT/kmnUv9zGIl9Ne7TuKjaGSuJfor/RWq5rWdFowsMrdcTpK9DKRhNA7Z5
	 uc2fhchqGo47u8UdLoEZ0aZBY8/Ru182wknnH6v5pqLx6ZJ6MX24ulQv4De8Nfi2LQ
	 7z5txtQOsjeZQ==
Date: Mon, 01 Jun 2026 18:52:48 -0700
Subject: [PATCHSET] libfuse: more random fixes for fuse service containers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178036512130.432362.7597373245082703669.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here are some miscellaneous fixes for libfuse.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * fsmount: don't truncate ms_flags in set_fsconfig_ms_flags
 * mount_service: don't pass the chopped buffer to apply_fsconfig_mount_opts
 * mount_service: call the new fsmount ms_flags helpers in the right order
---
 lib/mount_fsmount.c  |    4 +++-
 util/mount_service.c |   14 ++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

