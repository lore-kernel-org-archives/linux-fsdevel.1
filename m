Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0449DBB3
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166503; cv=none; b=scKMKFetzifPI4aCk5KFEW/dh9pUJVggMxG/A8eeO7RYNmWpNuVoX6bDVcZD6Ml9b1xtSC2sGyEQI/8BtX99p0v+yS4YLNE5qt6hiJ9ORILNN3tV9XyWLOkqE42alXvxeaobPkmuuO97af0e3dX+/ZNzI7ozZqcqE/UaO1afS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166503; c=relaxed/simple;
	bh=rs3jrC6jsI/FMNFFeDD80Y6bYmwbNGT1eC1NH7jb5YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJ+f92l+xuExT8mIFTXTkflzTaRvhPtsr55WIDmNGjlAOyc3fRux7CUzYdy1CJtB/9FeSa4/sU6VA2NQLMWVXJHt80G86Wpf1ayFNZKGlu/xTzMnw+hsrfqEPKNbItCUDKNsHnRLDY+K/dpk0YNCEnwYsAMkGGvEhp1csf048I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0llBzRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0llBzRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A42C1F00893;
	Wed, 23 Sep 2026 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166501;
	bh=3DN/mIb4uELpSRNTLZxtqPJ55l785G3dF2E3KgbmVjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q0llBzRQ9+s/lKBojOBi25a6zZZJMMLPEyR0L0HvYxOcQON55SmU07M8FZeGzDPpa
	 jGUPeM2W7tWrG93afdMZsJ/hcUyztC9mQr0rSyeUXVoM1hCcqC4YxU1gzscGEJTRyN
	 Y4lpDEMeBxFiEm3ORk4YUrCUkJcb1sCmSSKGpvVArEOL5NGnEKxTjGSylLlDXLovK3
	 LayHxRF0Fcwv4sfuxn5lOBlslp0hZ+RzvNrjdzwlQwle5MDgc755cIJ43hyRgPAuwU
	 Beb0OYbAKJ1sq5ElhX8zoX8uF5nA2EBixgzn8HOf6hhv65jFRvtaPV3PxmkkXbNoqy
	 gWpGtXHiyFMrg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 23 Sep 2026 14:27:55 +0200
Subject: [PATCH 3/8] mount: refuse MOVE_MOUNT_SET_GROUP on an unbindable
 mount
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-work-mount-fixes-v1-3-f424cf8d3242@kernel.org>
References: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
In-Reply-To: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rs3jrC6jsI/FMNFFeDD80Y6bYmwbNGT1eC1NH7jb5YE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPnpnYsA1DuOVjBN9f7PZfp9xraMp5f6DLWtjDCdOk
 3W2Nlf83FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRe3cZ/tm9bHzb/6H4xybb
 RZKbhe8ffKA893DAivUJh7fe31XtfoWdkeHDPEG9V7dOqFzkSdz66aWvbMSVuAub2cUbAmtdBd4
 mFfIDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

do_set_group() only accepts mounts as targets that are neither shared
nor a slave. That encompasses undindable mounts.

If the source mount is a slave mount the target mount will end up with
source's master as its master. It keeps T_UNBINDABLE. That means we get
a mount that is both unbindable and a slave:

  mount --bind /tmp/src /tmp/src
  mount --make-shared /tmp/src
  mount --bind /tmp/src /tmp/b
  mount --make-slave /tmp/b
  mount --bind /tmp/src /tmp/c
  mount --make-unbindable /tmp/c
  move_mount(b, "", c, "", MOVE_MOUNT_SET_GROUP)
  grep /tmp/c /proc/self/mountinfo
  ... /tmp/c ... master:646 unbindable ...

This property cannot be produced any other way. change_mnt_propagation()
drops the master when it makes a mount unbindable (iow, it becomes
private) and doesn't touch an unbindable mount when it is supposed to
turned into a slave mount.

End-result is that the unbindable-slave mount receives everything
propagated from its master's peer group while it can't be bind mounted
itself. Not sure what that's supposed to do.

On the other side: if the source mount is shared, the target mount drops
T_UNBINDABLE because because set_mnt_shared() clears T_SHARED_MASK.

So teach do_set_group() to refuse an unbindable target mount the same
way a shared or slave target mount is refused.

The main user of MOVE_MOUNT_SET_GROUP is CRIU which restores sharing
first and applies MS_UNBINDABLE afterwards. It never hits this.

Fixes: 9ffb14ef61ba ("move_mount: allow to add a mount into an existing group")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a052f847c5df..d842fc1f1f1a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3468,7 +3468,7 @@ static int do_set_group(const struct path *from_path, const struct path *to_path
 		return -EINVAL;
 
 	/* Setting sharing groups is only allowed on private mounts */
-	if (IS_MNT_SHARED(to) || IS_MNT_SLAVE(to))
+	if (IS_MNT_SHARED(to) || IS_MNT_SLAVE(to) || IS_MNT_UNBINDABLE(to))
 		return -EINVAL;
 
 	/* From should not be private */

-- 
2.53.0

