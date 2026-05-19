Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB058372EE3;
	Tue, 19 May 2026 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230569; cv=none; b=tPM1Hc82hST1leoU7i720bXHOmvu05bA+v5UCTDIzKXNRMwbim03z5mhTIm62VW7GxKmrQtN7ecz3wJUwX8qXKsWdDBQIIW8QVyNaes6NKFwANSAcRGLS96iTVYNGHiebiPfVLFPsV8CHJs/fLX6IicPkFgsvSTmjq2vQep2gKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230569; c=relaxed/simple;
	bh=92Z2KQZNMxQjkoGeChAaj5TLY7geqGbfWyzHAMnftVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MpSbUQUy0o/N2d3+JZhIRKIgMYKdN/GrE6KhS4uT4vqIF2r8JQsvOyQ8MByWebMO/Q4MZSmEmCS9pKM1HLpnHaeLr1HAuYrDXaycMAdojm1xhGa4J+H53wCF7ksuNMacPcFzeEhALzqOpyNFIJ+4Gx1UizERoDHATHEZwX+dUDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0S9I5/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0S9I5/J"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7ED0A1F000E9;
	Tue, 19 May 2026 22:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779230567;
	bh=MuFRKRc6T6nkge9ZU6jD9F0z77s0s4kLag7ah/XwJCw=;
	h=Date:From:To:Cc:Subject;
	b=N0S9I5/J961ExApcTtATbxwGHLQ60lujiBA3TksaagyMixi5rOWmwAA537PVM/sTW
	 5TSkDzbuuL8ork+YJQ7LDeR/ve2Qu4knbXCsRT3jywWJbJn/4KVsBK8URfN0nJU+dN
	 ITUVoJxPPVFyHLANm6fcpBep3UK9XycdTC9Z13VgVOs4h31cZMh2LjJLC8+P4zjY0T
	 z/pdbl0Iu+04aOnczl5QIPFvs5tRUEipSCL23RJx8te/Dicx/HX3lbYZLBtakIIfOs
	 IwvH/fZjX74OH24jR4hnUwz0J8J04IokjhJMUrKMG/xIa/7GqEc/nyzS2T1SZ32Oa0
	 doAJdX9jztd3A==
Date: Tue, 19 May 2026 15:42:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: fuse-devel <fuse-devel@lists.linux.dev>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] libfuse: fix cppcheck warnings in the new mount service code
Message-ID: <20260519224247.GC9544@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

Fix some cppcheck warnings.  No functional changes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
Hopefully this clears up the last of the static checker errors with the
fuse service container branch?
---
 util/mount_service.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/util/mount_service.c b/util/mount_service.c
index afb345e8b91dfc..8b0eecf5b00ab2 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -882,7 +882,7 @@ static int mount_service_handle_source_cmd(struct mount_service *mo,
 					   const struct fuse_service_packet *p,
 					   size_t psz)
 {
-	struct fuse_service_string_command *oc =
+	const struct fuse_service_string_command *oc =
 			container_of(p, struct fuse_service_string_command, p);
 	char *source;
 
@@ -935,7 +935,8 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
 	struct fuse_service_string_command *oc =
 			container_of(p, struct fuse_service_string_command, p);
 	char *tokstr = oc->value;
-	char *tok, *savetok;
+	const char *tok;
+	char *savetok;
 	char *mntopts;
 
 	if (psz < sizeof_fuse_service_string_command(1)) {
