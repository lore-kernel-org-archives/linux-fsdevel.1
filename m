Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1314A619;
	Thu, 21 May 2026 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332827; cv=none; b=Msr5vOLiFKU9MX0Fj6ewv5t4oAF5DUcQovOWeYYW46AqyOpANb7kkjuNfCvfTNn0iMAooy3rliDIfKgIt8Hc+xUT0hZFVM62/jjoudEBKxeUkuOkJz+nZv20I3anUJGith2ymBemKtv/r9usarJg2pOlcVfI4NFLSyvLdJ715aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332827; c=relaxed/simple;
	bh=uAuu9uWlnmLgOJIIGwblRMleinLL9oNzYzE0DBcxOYI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJvz5UTLClEQxNcAz6RGOKeafpC4shHwop63jojcfZUn+x+l0agjcJjJHVy+qubQf9+U3SBI+kdMa+qcB9EnLP8DFavXrT9KaXRl2qerKhElYHudV86zExFojcwHDRhX/BaQIpXKogyu42KR60hUfd8w5gcJQ36tiXloRWPoAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuCOnoKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuCOnoKM"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9DD4D1F000E9;
	Thu, 21 May 2026 03:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779332825;
	bh=41YE+GFoJt+CHIoa2n9oljYcEuI+p3otOE/Fs0Y29+s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=PuCOnoKMZhEYxRJNol3OR9fNtHftO+dOhA3+pPSy91MZRHSlWutStdJAbMA0ZQ7ky
	 +2yff6Z5c9ZTttCF9XNNYIWD9/Q0Kci1qo66UEPbXILiO7kIU9qIeWGdJeyxnP6S2Y
	 RCl/YzgcmumSHoiqYUBsS7L0sOn2+dJpE9Iwm8waeVvAoVaE7VTFfOTAwqBIU62Rxk
	 SkRUXIIclUY1bvAC1iYcKBWcxNLeBUFfS64/PfsPVwwfx9UYexSG9z4u67FwNSCGqr
	 e4eYtRtNTXk2nfV/20IjVz/fnrMDtFXUs0KnVz4mtjr3xd4jDT46z7qn+P06qvSyR7
	 P7O+G9stt2vpQ==
Date: Wed, 20 May 2026 20:07:05 -0700
Subject: [PATCH 3/4] mount_service: fix some pointer handling
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Message-ID: <177933241501.3536631.17487472051183408289.stgit@frogsfrogsfrogs>
In-Reply-To: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
References: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Don't leak memory or try to free static data.  Pointed out by
clang-check.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


diff --git a/util/mount_service.c b/util/mount_service.c
index 8b0eecf5b00ab2..a86a53c6fff40e 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -974,6 +974,7 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
 				fprintf(stderr,
 	"%s: option %s only allowed if 'user_allow_other' is set in %s\n",
 					mo->msgtag, tok, FUSE_CONF);
+				free(mntopts);
 				return mount_service_send_reply(mo, EPERM);
 			}
 
@@ -1036,7 +1037,8 @@ static int mount_service_handle_mtabopts_cmd(struct mount_service *mo,
 	/* strtok_r mutates tokstr aka oc->value */
 	while ((tok = strtok_r(tokstr, ",", &savetok)) != NULL) {
 		if (!strcmp(tok, "-n")) {
-			free(mo->mtabopts);
+			if (mo->mtabopts != &IGNORE_MTAB)
+				free(mo->mtabopts);
 			mo->mtabopts = &IGNORE_MTAB;
 		}
 

