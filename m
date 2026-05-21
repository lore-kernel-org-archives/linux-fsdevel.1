Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912C286417;
	Thu, 21 May 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390818; cv=none; b=r7pTaS3BUawBwHzefsTvVdsepUuFGc9uUftGmyfuGc44Q+qJPZew0/dtXDWVOoxFdFsofi9rDiCsPFwY1wjbNstE6wtAJC7AP1glo8DNEfOE56hUmAQ734fc8WXGld4KrJ4Qu0ShRTt5K8NAF0DjvWsaXHkd36gPrGTtN356boA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390818; c=relaxed/simple;
	bh=US3mncSgTIcGXUiSGhrHLMk+12yUoWkvzL7x9lTGGvQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ea+calErchyRjYiukF3q/5IbzTMYibdmWJGCLSUwvYhSoKqdYJTK/xPv6gPzIZmY0r3N7XzfR/X1fJ8t2xQHhTqKfCSJLLfHbxVLI5dRUb18iz29awKhShyqeVisMrDGX9dLOdnKp0cBQ1k0vunwE0luJqXxI0+Oxjp5Vf2DZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp5YR6zi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp5YR6zi"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2696F1F000E9;
	Thu, 21 May 2026 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779390817;
	bh=KeiHI8ewAJWlLPBnueHbkRD/eM2OqITfWimPOUxBWuA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=Vp5YR6ziLuSmzQY0lZOQ/VWIuxtM+mtgAcbw5n1wFKvxWqD+4+hUxp0b8C1TUd9wz
	 JfhmE3gws9RqwA08Y/TOtiFVZ35kojJOVotFtMSHi4HebVMrej8UglCFwZDmaXqdic
	 WXj/wOdsDME2OuLZIFGz7x2xjFQnNSM+NQiJnAZRlnEVkhFb2Uo67KvZ46KveJLZkj
	 9XS46fW5diz5+rocNKEOyND7B0esqTHd4q7xXkWzIMR90ehwExn1A6uASqJbmcFgl4
	 2IGsWE7ecRMgW5lEj9zM8m19slwtPWFQKRTuja1Rm98rFZiBJJQeMKOP7LENtIWKwE
	 GDlz3JRhQ5iNA==
Date: Thu, 21 May 2026 12:13:36 -0700
Subject: [PATCH 2/4] mount.fuse: constify arguments to try_service_main
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: neal@gompa.dev, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com
Message-ID: <177939069804.35950.896440949059851027.stgit@frogsfrogsfrogs>
In-Reply-To: <177939069755.35950.14423543819684584527.stgit@frogsfrogsfrogs>
References: <177939069755.35950.14423543819684584527.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

This function no longer alters its arguments.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount.fuse.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


diff --git a/util/mount.fuse.c b/util/mount.fuse.c
index bbfd8355dc7f48..ca90cb85334067 100644
--- a/util/mount.fuse.c
+++ b/util/mount.fuse.c
@@ -283,8 +283,9 @@ static int mount_service_child(char **argv)
 	return EXIT_FAILURE;
 }
 
-static int try_service_main(char *argv0, char *fstype, char *source,
-			    const char *mountpoint, char *options)
+static int try_service_main(const char *argv0, const char *fstype,
+			    const char *source, const char *mountpoint,
+			    const char *options)
 {
 	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
 	int ret;

