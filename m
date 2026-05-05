Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCD3AD538;
	Tue,  5 May 2026 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958647; cv=none; b=bVcSb1LE1/vYRvrgjfVTD09bxFscsLOPFOcLsHaVj0p3/vtcqZY+dRuoiYveseoR2wNDt39B0HAyW3jvlmr5QMmjKYOCo5hjKSLgDmUdsDObN3FqTF2kRfrP6/pYgFNO/p75e3hcXoL2pHJ/SpiwaoieGQzU+1RsvZ/wogFNA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958647; c=relaxed/simple;
	bh=MXtwdIPMyZ5hRW5+7NrF/jvoxk8KPfVA/BOQqYL5B0M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3I4YcFvgYg7TP966sgLilRZZE1kV/AIJaA4ST5Q/1z4BJROcHkiRFms2SgdW4aQBNt0NfFdhGJ3c3x7qbolwqfJSvL+7+d5pHIXgdDSBRB7orzTRR0qZvlahG+OTTeviOhFOMOeB74syAnvTBDg1aqgAax4zMBCp3mPPMSVG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIA6nJQW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIA6nJQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA85C2BCB4;
	Tue,  5 May 2026 05:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958647;
	bh=MXtwdIPMyZ5hRW5+7NrF/jvoxk8KPfVA/BOQqYL5B0M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JIA6nJQWa9VYRwmOoBUYWfx8Pgxf0HHgQaCghLpjlB+77ASoYEERh9OpoFs5pZWD7
	 6x9Rppm0ByIRlSuIS3hx7pbxjOp3JDHlK7aakQIxURn1TvMilDiHCMGJh71G/giMmT
	 aaulzXIwzrRHoZGDg89igea8IDObi3I3ZK1FSmq9TMgcVxzH+LmkjfCaONm+hSRTM5
	 0u2oS/E8x6mc6UemB9pnE5z6nqOlWGL/dWl+4jNaC/as6wAgJ0hE4xhmKKEW4L1bQW
	 JztbEtAs26LzQ4NndFvuCU7oke/5Keu5VL1yGdXI3yR8WBYJ2a518BK+WU2CyD13o9
	 x1yQ5gx4jxXUw==
Date: Mon, 04 May 2026 22:24:06 -0700
Subject: [PATCH 01/10] util/mount.fuse.c: loop in waitpid
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853704.1133612.11214005697938100893.stgit@frogsfrogsfrogs>
In-Reply-To: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
References: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

waitpid can return EINTR if interrupted by a signal; don't abort when
this happens.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount.fuse.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


diff --git a/util/mount.fuse.c b/util/mount.fuse.c
index 085c88835e6c9a..802d7f99fe7815 100644
--- a/util/mount.fuse.c
+++ b/util/mount.fuse.c
@@ -267,7 +267,9 @@ static int mount_service_child(char **argv)
 		return MOUNT_SERVICE_FALLBACK_NEEDED;
 	}
 
-	ret = waitpid(child_pid, &child_status, 0);
+	do {
+		ret = waitpid(child_pid, &child_status, 0);
+	} while (ret < 0 && errno == EINTR);
 	if (ret < 0) {
 		fprintf(stderr, "%s: could not wait for %s helper: %s\n",
 			argv[0], FUSERVICEMOUNT_PROG, strerror(errno));

