Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912D476CEC;
	Wed, 22 Jul 2026 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784721024; cv=none; b=PaQfR/0ToCma4+SuQI1VZY7sAzN9YGPlzeg9k3hXeBGJbBMLQngyEzLWeYQ7b0y85uU04FUXKTIkZvyYdf2lRuKUZ1Q5GgD5G6wrJRingJcQl4XIr+NUzc+v4sPpYNW+Ov8ecDEx3TOvqHADJgMtuBi8QWYXR6lVEmipGO1Y2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784721024; c=relaxed/simple;
	bh=gvUhl7BWbJcM0F/s6UylcQ8PRYE9yKRjMAEcO0s8zCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zl/Nzdu0/LuWO0E6xT3Or0DvPPkNUZG4R2y7MyoRYN4rACEIh55I3VA52xXT2x04i7l5wsyMPkBmCJRarXMFrMH319APnVT2yEYIRKflZU+NvcU/INqWXIjn4B1pLpFogfkPhTv7QKe6RjzqZJhZ1uYo13ye2i+EzsC6gqDBHhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgrB5R5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgrB5R5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1C91F000E9;
	Wed, 22 Jul 2026 11:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784721022;
	bh=13owvZ2lTQvHApkWGz8tv0TpQ++yb0gsfQOQCtrvHms=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HgrB5R5tP0OMPMRPuHhbKbzTeTqlOzh/jwuRW+G0J8y7VbbM4RYLmzd54C+bir4EJ
	 VnSYhjUuBsfs5kfdutjH5/lppjXdCn/QQcQqzn4f2h+N0M8S/2AX6yIXYyzSc836g+
	 lfHdWfxgsRs+sGEDWm6r6W4eVyvKYIAI3p914FsUlo92V0CJBCQ1L/APdzPuc+/5gO
	 maZKNqwmJ/3YQpkNF2MzV4GfzaTSTI4CFCuyPRiX/zZo2yLWr2CoviWP//LqIrQ4Kb
	 U6+aKnJtY6iOis+NmNGyjhUWtqeYlzCBSOgmhySRbSquFd0zB+FA2y4z82/dNb7Ggc
	 /nuaoSqXWDKDw==
From: Christian Brauner <brauner@kernel.org>
To: Li Chen <me@linux.beauty>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <20260716052726.1032092-1-me@linux.beauty>
References: <20260716052726.1032092-1-me@linux.beauty>
Subject: Re: [PATCH] pidfs: preserve thread pidfds reopened by file handle
Message-Id: <20260722-liedgut-stadien-mitleid-11b123875647@brauner>
Date: Wed, 22 Jul 2026 13:49:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-9dec3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gvUhl7BWbJcM0F/s6UylcQ8PRYE9yKRjMAEcO0s8zCM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlrKuxWJFa888q0fHx/RlSy+7lrMie6fJ9TqqoU8sK5
 sLXrV83dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk7WeG/xnrkxekOr08GCGt
 6rHFbsH+SbP43M53qa35sXNR0wTh7XUM/2wKrzHs5ezM9r/BdLKoaufW9UpBvk9PpK0P2JRsuqf
 Ogw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 16 Jul 2026 13:27:22 +0800, Li Chen wrote:
> pidfs: preserve thread pidfds reopened by file handle

The patch is correct but I'm likely massing it so a tiny shared helper
is called in both the regular creation and the file handle creation.

---

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] pidfs: preserve thread pidfds reopened by file handle
      https://git.kernel.org/vfs/vfs/c/c8d2d281934c

