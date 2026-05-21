Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7C286417;
	Thu, 21 May 2026 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390803; cv=none; b=m0fOE7UAN84ehbb+2qmkwWR02XI4AtTudwd87BKDRZZaUA6Xer7fgxZ83ArjZgcxdxKssIOnYJE7ZXJ0vf/iv1RmULhdRTUN5j+Lg39L5syTrwPvf4GsLxhL5nS6kD2T/ZF0Y/hX8rW0yprZG6MPKcWkkFK7AIeu9zylU+Y+d/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390803; c=relaxed/simple;
	bh=mTauhgv0lcJqYPd3ziJoJRCUqosZwBPGDmFqtd9QzVE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfeW3Y0qKEokQo2RAuRSSIPG3xBhKWcl0WAxv6V8FwYZ7bI+2To6yxNlBRfwcBXQ3GW/Odxbs1as6WRK0P84fqNfTxTVLSuW6tZCFICBFhlQDz3VA1eaxZliinduGFRf2cKPOA+0ZGHWhYbqEI9JcSso5ix6oK3gGNHcCtkaG4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+O3XhXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+O3XhXj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 98E891F000E9;
	Thu, 21 May 2026 19:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779390801;
	bh=PTi+jJJvHrBHEW7z3uGI/oHtd9Eu6OqS/N5COCOkjXo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=i+O3XhXj8RqGJ+r8NBYvmEl2Lp3nOJXzTtwY4XL4Mdwn0G0+B1mgh5Ok/5FAhi6ru
	 t0D5NZERtlukxKGdVdJ9ZqCk3rIIauFy8n30B2dF9703OjfqCYoY3xenOmasyAU1eU
	 bf7GVP4I/7txKE6chqUBqjSwkLB/v/WHCYbvC7rBWn3Ij1WMGgjncVCq03Gr6k5xpj
	 wJafT1SsTJvOFBGp7LzCWaP+yAiHw0SzrgrE60rXX1LzwNxGQ2oMHmWgpTgrjyv+nI
	 NlHcBkfjM1z1X/fYBO6GywApcMGZGyfvzqsCaSE5PSDk/vnbjikEFGiKDIzac2o5Fa
	 Qc/qtmPIYyJ/A==
Date: Thu, 21 May 2026 12:13:21 -0700
Subject: [PATCH 1/4] mount_service: rename IGNORE_MTAB and constify it
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: neal@gompa.dev, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com
Message-ID: <177939069787.35950.970949980562302231.stgit@frogsfrogsfrogs>
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

IGNORE_MTAB is already a preprocessor define, so don't use it as a
global variable name in mount_service.c.  Fix that by lowercasing the
name, and make the variable const to catch stray accesses.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)


diff --git a/util/mount_service.c b/util/mount_service.c
index a86a53c6fff40e..c74cf257a00203 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -66,7 +66,7 @@ struct mount_service {
 	char *mntopts;
 
 	/* mtab options */
-	char *mtabopts;
+	const char *mtabopts;
 
 	/* socket fd */
 	int sockfd;
@@ -93,11 +93,19 @@ struct mount_service {
 	bool fuseblk;
 };
 
-static char IGNORE_MTAB;
+static const char ignore_mtab;
 
 static inline bool have_real_mtabopts(const struct mount_service *mo)
 {
-	return mo->mtabopts && mo->mtabopts != &IGNORE_MTAB;
+	return mo->mtabopts && mo->mtabopts != &ignore_mtab;
+}
+
+static inline void free_mtabopts(struct mount_service *mo)
+{
+	if (have_real_mtabopts(mo)) {
+		free((void *)mo->mtabopts);
+		mo->mtabopts = NULL;
+	}
 }
 
 static ssize_t __send_fd(const struct mount_service *mo,
@@ -1037,9 +1045,8 @@ static int mount_service_handle_mtabopts_cmd(struct mount_service *mo,
 	/* strtok_r mutates tokstr aka oc->value */
 	while ((tok = strtok_r(tokstr, ",", &savetok)) != NULL) {
 		if (!strcmp(tok, "-n")) {
-			if (mo->mtabopts != &IGNORE_MTAB)
-				free(mo->mtabopts);
-			mo->mtabopts = &IGNORE_MTAB;
+			free_mtabopts(mo);
+			mo->mtabopts = &ignore_mtab;
 		}
 
 		tokstr = NULL;
@@ -1797,8 +1804,7 @@ static void mount_service_destroy(struct mount_service *mo)
 	free(mo->mountpoint);
 	free(mo->real_mountpoint);
 	free(mo->resv_mountpoint);
-	if (have_real_mtabopts(mo))
-		free(mo->mtabopts);
+	free_mtabopts(mo);
 	free(mo->mntopts);
 	free(mo->subtype);
 

