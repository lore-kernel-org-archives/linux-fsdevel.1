Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A672264A9;
	Wed,  3 Jun 2026 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445713; cv=none; b=K3st+BhKpZH57TsSoNijsAZM3VrRMG1DNMuU8VI+Z+njPYfj6mzgsbzM3dFK1XjJb439AOY4LFtBV9hq06LoqUxdqbEVpssHnKmxOZ8+lGOqNte1Xn+/sfmMtN6b5K+JmjbGupmBBEq+74AMiCE197EPjHrwIpiS7GpedNa6Xs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445713; c=relaxed/simple;
	bh=10CbSTCQDBWKJNmzd1JjSrmuf4EOmLHN4AyMZ7eyKng=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5coxzcZ1B7g0jXvhxcDPNDmM1RlyIQBJGvo0wn5Or0GCkze16vrKWsUqTqgS2g36OPU4HvOvGDHGtFkfV3DASS7eyuloNeEivzyVpuZnmHJLchiFqC5QLRjS7C7pRi8WpDkdeLyInj6ZQ5IeB6XCRHt53Jxn1A/UFJFtWz866M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFmqK+d8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFmqK+d8"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CA2931F00893;
	Wed,  3 Jun 2026 00:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780445711;
	bh=+TjC/FT4bgtivKcQK7C1qgC0IXis/2arP3Q94BASnIY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=NFmqK+d82u+9j1USo6jvDyihJVb254ZVyzyw43T1MsedU2vHb26w1k8vcNCn13BF3
	 pqpRxJ/RMMR4uNQj3lSZU58OBa5M/GJjFZuAg5HRvMG7zzsjJ+UvlWf2n2z2+A5/52
	 YYDn8RTaUnx+T55maw28TIbL+gPx5ygcfouFzRetQfjTAGkXTwnF/X9kkt3J9DFJOc
	 KLhxzu1GRZ9BON87T810JnjlWtZXTWgK9WyAFnDEgk5y0dZYnWojlKzZxAFA8JUDAh
	 1KT8Ls3uzJ+8L5DdliXjmMZPDCrGcRLnVnlzCC5rHJTo82OQNehukVDuat9KiraEDH
	 5QwPsABU0Fgfg==
Date: Tue, 02 Jun 2026 17:15:11 -0700
Subject: [PATCH 2/6] mount_service: don't pass the chopped buffer to
 apply_fsconfig_mount_opts
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Message-ID: <178044567862.1435997.14889132979032394431.stgit@frogsfrogsfrogs>
In-Reply-To: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
References: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If mount_service_handle_mntopts_cmd previously looked at the mount
options to screen for allow_{other,root}, then tokstr (aka oc->value)
has been modified and not put back.  This causes truncation of the mount
options passed to fsconfig, so let's use the snapshot that we took
previously.  Codex noticed this.

Fixes: 7211953256526f ("mount_service: use the fsmount API helpers from mount_fsmount.c")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/util/mount_service.c b/util/mount_service.c
index adcc7a296645ff..360a78bab3bd3d 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -994,7 +994,7 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
 
 #ifdef HAVE_NEW_MOUNT_API
 	if (mo->fsopenfd >= 0) {
-		int ret = apply_fsconfig_mount_opts(mo->fsopenfd, oc->value);
+		int ret = apply_fsconfig_mount_opts(mo->fsopenfd, mntopts);
 
 		if (ret < 0) {
 			free(mntopts);

