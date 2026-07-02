Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B3338E8DC
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976064; cv=none; b=ceRLyoXEWd5M+1GOZup0W1dtfgEodd1Fbs512YOp3d35GS3eCjz3jHqAycrFdIKQDrg0uzKo/md2tLV3tGPUQc1f1sXu6BNi/LIUBq2dKyUFqdghJiAIoUwGL6v86TBIkL0skKeRISEz/rE1+lUOT5HSBx9hJ0MZZUx7H3ij/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976064; c=relaxed/simple;
	bh=oycaY2o+bas6zVaqjf/psh2TMCQeyAGy1n5bWFCDnGo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rKoNYhBxvMW+97LYS9nHq0FKsfqWaS3c9Hjgne0kGxQ6RRE/6LlMKrlIiqmZyiDvFsZU05p7JpqbAPTc/VR78Hil4dTWMCR1DvOsdr13Ty+R1Q38pYZGHAT0WfxMIHjnyAz5VBM8s3KnBi2kIOzsgKLTYhVgfEAaHDQzzcx4cB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzOmlmT7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzOmlmT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20C31F00A3A;
	Thu,  2 Jul 2026 07:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782976063;
	bh=X11pw+ORtpn4oMpQUVhJ/iYYeUmSvSehqKG4lB5HFEQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KzOmlmT7de0QMKC7oSCt3dLarK+8nP7nXTNmiEqrMcT7rvidCgGIb/rB5GOF5DHZx
	 I+3A4o0QQpo0hV8GHqsAmZBOKS5cMSTyMZgKTJHFu4YsPZ2/okZAGlGJHYK6G1dtHk
	 JsnqONz7+YVWHkgyd/XbGNzli3D+HOR2qic2+V+CmLQcZ58Po6Ghchtcd6g9jQYEH+
	 Tw0026aE9ZcMLh/PC3FiLtkJQ2sjjTY/5lCy3nWJozRI328BYwMW/aDHoJ9SVKMmQ2
	 Q6R/t535qeb1bzBmPRgw41ia+OHjaajPVcSUuoujs4Yc+P790VuMnwG95H4gPSQM3Y
	 a296Udy/TJu8A==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jori Koolstra <jkoolstra@xs4all.nl>, linux-fsdevel@vger.kernel.org
In-Reply-To: <178294577084.27465.9288356265750603629@noble.neil.brown.name>
References: <178294577084.27465.9288356265750603629@noble.neil.brown.name>
Subject: Re: [PATCH] fixup: Remove excl arg to ->create inode_operation
Message-Id: <20260702-verwickeln-authentisch-erbitten-6cd2af74fe7a@brauner>
Date: Thu, 02 Jul 2026 09:07:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oycaY2o+bas6zVaqjf/psh2TMCQeyAGy1n5bWFCDnGo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS58dnaN6Wc/2Z+SjxE7N5tewbVOSJWbtFV8jPCpTf+Z
 4zQMZTrKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIhzAcN/v7dz2h6eU3N99WKt
 a9Ij9tk1b2Q43u1b9yMjO/KGic6Hfob/JUW6Wjw+F1rrUlSC34SEXksoKvm2xHnFwS09226pvNr
 NDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 02 Jul 2026 08:42:50 +1000, NeilBrown wrote:
> fixup: Remove excl arg to ->create inode_operation

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] fixup: Remove excl arg to ->create inode_operation
      (folded)

