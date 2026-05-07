Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8640F351C3D;
	Thu,  7 May 2026 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192039; cv=none; b=UBiqdQbg2wUcv+9NS8W8Jep8pdEJ68w90pFqfdEjDuT/o/7uoU6yQgTthOlXppVAe2PRATcj2ZtQS+qIOgiXoNvnKjcci1PNM4x16wk1aesjMmjr1n5RFOF5wO/wNd1fjYVQxaoen3EFW2+8GBgZuIO+lz7bkCcVJwRoFCfgz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192039; c=relaxed/simple;
	bh=69m7nsrxD8S8ss3fi12RRBYL2boMUr2aj3t+e0p2MPs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwgvTAHgs6HUWjUzwOS89dBoag4IFlrPPKBzFBgnhzx9biGXTw7XmFioiLYmAAxaXZe337IxzD42kM1ENthiYTPm9LnIWq1f1XkiBF+pAALqgreOHEZlDHknR4HEkI3F1ZC1Ux1Pomf5KoKTsGdessjGMfA8qsqthyCu7Bk3PfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDm6yc2R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDm6yc2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B970C2BCB2;
	Thu,  7 May 2026 22:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778192039;
	bh=69m7nsrxD8S8ss3fi12RRBYL2boMUr2aj3t+e0p2MPs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mDm6yc2RQGFJpPWxBvUdApjMCdk8sOfF1YaVn5kUWlp3EHBdTmIjTuyeIqcATQxhc
	 oPU9ppowPIoH6EH/Spcz0XXzhBvE3K4UIW34S4IF5/tb6We95qNWmhHzt4PCWl3Oor
	 R4u+Mbx/8NoyeOy6snzErqVN1c5SlIlIuFeECG+lBF+mVtFZkr7CVbshMQn3e3Pqv9
	 iKt9uC6nar5lGD3iaSWU8hfhwY9JcCv7pqOjh5DJ3ZHl72ymCR5/fM9jTNI2QWorib
	 IZspl7HcxN3J9v75ie1gcVK30abSThgsn5vNqT721bsoNIRFn9cIp6OxhQvwXCIzM0
	 Mvp02Vavw+5fQ==
Date: Thu, 07 May 2026 15:13:58 -0700
Subject: [PATCH 1/1] mount_util: fix mount_flags entries for MS_RDONLY
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org
Message-ID: <177819197899.3490692.5280827494230619038.stgit@frogsfrogsfrogs>
In-Reply-To: <177819197881.3490692.13850589276777261250.stgit@frogsfrogsfrogs>
References: <177819197881.3490692.13850589276777261250.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

MS_RDONLY maps to MOUNT_ATTR_RDONLY in the new fsmount API, but the
table omitted that.  Fix that.

Fixes: 0d7e72541564a5 ("Unify mount flag structures and remove redundant is_mount_attr field")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 lib/mount_util.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


diff --git a/lib/mount_util.c b/lib/mount_util.c
index 1a0aec9bfe1a70..7ab1dba91e28e3 100644
--- a/lib/mount_util.c
+++ b/lib/mount_util.c
@@ -110,8 +110,8 @@
 
 const struct mount_flags mount_flags[] = {
 /* opt            flag             on  safe  mount_attr */
-{"rw",           MS_RDONLY,        0,  1,    0},                      /* fsconfig */
-{"ro",           MS_RDONLY,        1,  1,    0},                      /* fsconfig */
+{"rw",           MS_RDONLY,        0,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
+{"ro",           MS_RDONLY,        1,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
 {"suid",         MS_NOSUID,        0,  0,    MOUNT_ATTR_NOSUID},     /* fsmount  */
 {"nosuid",       MS_NOSUID,        1,  1,    MOUNT_ATTR_NOSUID},     /* fsmount  */
 {"dev",          MS_NODEV,         0,  1,    MOUNT_ATTR_NODEV},      /* fsmount  */

