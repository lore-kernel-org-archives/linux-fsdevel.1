Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102A74C14;
	Thu, 11 Jun 2026 01:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140373; cv=none; b=h02+U9U1eHm445Zs2OSruN93f47svAjrSY5bW8yFnqSCYBlo2DcpN/t2F265842Y1v7iToy+lABXmJ5kFfVTVFQC8NtJpHJZtsZrjKEMQGxgds3KjmmCuvZd97/1b9mTBJnt6vFmOWhjp2YT9aL3gQ6cYofKIeNhe2r3sTLLLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140373; c=relaxed/simple;
	bh=10CbSTCQDBWKJNmzd1JjSrmuf4EOmLHN4AyMZ7eyKng=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VifuB7kSegxP3N3SgnHy61fHfU6NJHewi5YN09SDYkFBn3L3vUMy5IcdHktorlRvWn7a0/JA9x1T3/TdQS5dBLsat26IiK8ZNLDjwvBpHoONsxs83PSDnC1s5IMeSUkLc9Gw1tP3zhrsiKbWh8fj/S4XRrH5BJ9mXTt2gGeq6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD9u95Gu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD9u95Gu"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9051F1F00893;
	Thu, 11 Jun 2026 01:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781140372;
	bh=+TjC/FT4bgtivKcQK7C1qgC0IXis/2arP3Q94BASnIY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=PD9u95GuTGO83vb1+moQZdloW0sNx2m73Z6F+7aqXdbAojqC5J2681h/psoP5jG3y
	 lUNTsiuH91163sqPCW8jvtDoCEsAPrh2Lll7fUtsVEBIpK6HUrdWHtsaFXxW4al+tK
	 zvbzEsM/JLxmmA3do1WdGm67xme+FuxPbVOx7e0hxFiPW5Gvs7vdmle4VsrexdPUA7
	 qRjAT4LpPfMhy0eg3vIF2J+tojZpMIkysQX++489fAlvau08+QbIW5bU5WWhCRSQGE
	 4jZi+owy/KU4LmNOBYfwQAoML+mRB4HZn2LgbXhPfObpnOdkI3Z6j77awkPBngJ8pR
	 H2VF2xEM0CF4A==
Date: Wed, 10 Jun 2026 18:12:52 -0700
Subject: [PATCH 2/7] mount_service: don't pass the chopped buffer to
 apply_fsconfig_mount_opts
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178114032608.139936.8046912963384923143.stgit@frogsfrogsfrogs>
In-Reply-To: <178114032546.139936.4052263259025005657.stgit@frogsfrogsfrogs>
References: <178114032546.139936.4052263259025005657.stgit@frogsfrogsfrogs>
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

