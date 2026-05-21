Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09092401484;
	Thu, 21 May 2026 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390834; cv=none; b=Ltbqw6zJyG0QSAhbcHrofbUNceV5cMH0VksoeIe8gsrnYxI1N0CChQL1SQ1/FsTr7wOF8NzenXGxKZTbGlBgYJpPaP5rbsHigHQsZ389mGsEzDeWs2iz9TcRnY95/YuyyiqgzsYkrOndBl8xsEYiMc4d7b37bs3/YDJsKWSYW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390834; c=relaxed/simple;
	bh=/bQefGB4xpvT18OOXwGAtG0euh4JJNPxtgWTKaVABrM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzuJdqUoN0jqdHRSQHeQ87UefZ1JInk9zbMTfR5i9yLjdsHPqD8GOYke4PpAWq+vovrFCEyqHi8yw0YFucJv9i3KEHIixIjtXOlyYw+eKsOHsIq1A0OfqeM8Ida8b5nF+kxmSoqK4ggS0IKmd8fZeBj5cAmXRrEGWagFkw7U+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhAgLqhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhAgLqhc"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9AA8E1F000E9;
	Thu, 21 May 2026 19:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779390832;
	bh=Jzfp3NRlr0gpJoR0r2C95DNsF0ZWNzEyCSDzemafdeY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=YhAgLqhcB7R20HL9+yLo35GXhzew4S5aHP6NWY564jtyOfdW0m65/mbn4Al7ICgQq
	 +FJccs9v59aYiZlyouzMxLMxHu1HfGp9RsuvHHKH7rFHwYfBXKSN5TIYsssNg/2nM/
	 0iFlYqcXwS8/L2YUnWXLYEFeLWQvKXIAOIruruXLnaXYHzSmJjgYSYYwQWqVs7Nxuw
	 THgochwemWRb4Nb1ruSgln9bhCqYG4k/voRakUIoWOn1FGlyNIEYCuBAL/BkN7phuo
	 ts8kQxEZtbAVe1yAxe3cHV0/WhLQYU89Bii6F+ANf5odTVjyZJz34bc0ITqx2Yo+L8
	 2hMEVbQo3EKMw==
Date: Thu, 21 May 2026 12:13:52 -0700
Subject: [PATCH 3/4] mount_service: fix null pointer deref in
 mount_service_init
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: neal@gompa.dev, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com
Message-ID: <177939069822.35950.8073750556826366509.stgit@frogsfrogsfrogs>
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

In theory, fuservicemount can be called with argv[0] == NULL, so let's
protect ourselves against that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.c |    9 +++++++++
 1 file changed, 9 insertions(+)


diff --git a/util/mount_service.c b/util/mount_service.c
index c74cf257a00203..b062a737e6ca28 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -1833,6 +1833,15 @@ int mount_service_main(int argc, char *argv[])
 		mo.msgtag = argv[0];
 	else
 		mo.msgtag = "mount.service";
+	if (argc > 0) {
+		/* Yes, we can be called with a null argv[0] */
+		if (!argv[0])
+			argv[0] = strdup("mount.service");
+		if (!argv[0]) {
+			fprintf(stderr, "Could not synthesize argv[0]!\n");
+			return EXIT_FAILURE;
+		}
+	}
 
 	drop_privs();
 	read_conf(mo.msgtag);

