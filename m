Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79433B6FB;
	Tue,  2 Jun 2026 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365191; cv=none; b=CsZ2/KOYKQysu1UpfO38R3+nicNucTStJIIeOcnpm2GEpW+kNgYbXEBIMNrYh9h3QNPfVo+IVFVNHz1IVpO3moYPNgWH6D3ENeRSoOU0IQZn4lxJc2U2+RBkIml4LNylDf7wAuNqvg3GUYzNs7O5lbojjpWUGdm6iahIOcJ3RJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365191; c=relaxed/simple;
	bh=10CbSTCQDBWKJNmzd1JjSrmuf4EOmLHN4AyMZ7eyKng=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRpGKRFgRh31sEeICFJXlbTr+91VSkMJ5sGfPHkSwo9jA2YCwzeKJBWSZGt0ncZV0GqJsGlKuay4NAilV+D8nMOJfnKRztG8H3+R5dWqc369uM5DVOiFunFOS4OhalKN/pUDzLdw1Gu3jukoegF6Trjzj7QwwWfcOr4AMmDNTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTbM6Sjw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTbM6Sjw"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 05CD31F00893;
	Tue,  2 Jun 2026 01:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365190;
	bh=+TjC/FT4bgtivKcQK7C1qgC0IXis/2arP3Q94BASnIY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=RTbM6SjwFfa4hNMrNsRbhYfhg2p3S1JVmPyBwKcM7LIZ0t+XDDt2EWnmL7ULg4k5c
	 fv80Sr5L4/6BZUv7K5idbX0jgIhiIJy3niMg00ecXR6VGwTT1pStvy/Lm/un8jqM+K
	 xCp7tpd3VlwzXSRVMqSS6y2QebcAf6yJRr9h8Cf1348HrDr04BrzF+72d869xW/Z4W
	 CtUFiQMoTFmZg5/ZiGrnrUfm9vr2E4u52fgEaHge2VhTuV+UvQupLGkWqvmtf0DjX9
	 f6GqnQdW8rRgl8L3XD2a3ShYPA4BvRUlsgPbIAdNScDYb9orzqtqWwzl44Pxi8er86
	 vJKUY0P/8Wqgg==
Date: Mon, 01 Jun 2026 18:53:09 -0700
Subject: [PATCH 2/3] mount_service: don't pass the chopped buffer to
 apply_fsconfig_mount_opts
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178036512176.432362.2592474111268409149.stgit@frogsfrogsfrogs>
In-Reply-To: <178036512130.432362.7597373245082703669.stgit@frogsfrogsfrogs>
References: <178036512130.432362.7597373245082703669.stgit@frogsfrogsfrogs>
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

